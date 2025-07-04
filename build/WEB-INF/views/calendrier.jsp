<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Calendrier des recommandations</title>
    <link href='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.css' rel='stylesheet' />
    <style>
        body { font-family: Arial, sans-serif; background: #f7f7f7; margin: 0; padding: 0; }
        #calendar { max-width: 900px; margin: 40px auto; background: #fff; border-radius: 8px; box-shadow: 0 2px 8px #ccc; padding: 20px; }
        /* Popup styles */
        .modal {
            display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%;
            overflow: auto; background-color: rgba(0,0,0,0.4);
        }
        .modal-content {
            background-color: #fff; margin: 10% auto; padding: 20px; border: 1px solid #888;
            width: 90%; max-width: 400px; border-radius: 8px; box-shadow: 0 2px 8px #888;
        }
        .close { color: #aaa; float: right; font-size: 28px; font-weight: bold; cursor: pointer; }
        .close:hover, .close:focus { color: #000; text-decoration: none; cursor: pointer; }
        .reco-plat { margin: 10px 0; padding: 10px; border-radius: 6px; background: #f0f8ff; }
        .reco-plat img { max-width: 60px; max-height: 60px; margin-right: 10px; vertical-align: middle; border-radius: 4px; }
        .reco-plat-title { font-weight: bold; }
        .modal-actions { text-align: right; margin-top: 20px; }
        .btn { background: #1976d2; color: #fff; border: none; padding: 8px 16px; border-radius: 4px; cursor: pointer; margin-left: 8px; }
        .btn:hover { background: #125ea2; }
    </style>
</head>
<body>
<div id='calendar'></div>

<!-- Modal Popup -->
<div id="recoModal" class="modal">
    <div class="modal-content">
        <span class="close" id="closeModal">&times;</span>
        <h2>Recommandations du jour</h2>
        <div id="recoContent">
            <!-- Les plats recommandés s'afficheront ici -->
            <p>Chargement des recommandations...</p>
        </div>
        <div class="modal-actions">
            <button class="btn" id="btnValider">Valider</button>
            <button class="btn" id="btnAutre">Autres suggestions</button>
        </div>
    </div>
</div>

<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');
        var calendar = new FullCalendar.Calendar(calendarEl, {
            locale: 'fr',
            initialView: 'dayGridMonth',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: ''
            },
            dateClick: function(info) {
                openRecoModal(info.dateStr);
            },
            datesSet: function(info) {
                // Charger les publications pour la période affichée
                chargerPublications(info.startStr, info.endStr);
            }
        });
        calendar.render();
    });

    // Modal logic
    var modal = document.getElementById('recoModal');
    var closeModalBtn = document.getElementById('closeModal');
    var btnValider = document.getElementById('btnValider');
    var btnAutre = document.getElementById('btnAutre');
    var recoContent = document.getElementById('recoContent');
    var selectedDate = null;
    var platsRecommandes = [];
    var platsRecommandesIds = [];

    function openRecoModal(dateStr) {
        selectedDate = dateStr;
        modal.style.display = 'block';
        recoContent.innerHTML = '<p>Chargement des recommandations...</p>';
        platsRecommandes = [];
        platsRecommandesIds = [];
        var contextPath = '/' + window.location.pathname.split('/')[1];
        fetch(contextPath + '/api/recommandation?date=' + dateStr)
            .then(response => response.json())
            .then(data => {
                if (data && data.plats && data.plats.length > 0) {
                    recoContent.innerHTML = '';
                    data.plats.forEach(function(plat, idx) {
                        platsRecommandes.push(plat);
                        platsRecommandesIds.push(plat.id);
                        recoContent.innerHTML +=
                            '<div class="reco-plat">' +
                            '<input type="checkbox" class="reco-checkbox" id="reco-plat-' + idx + '" data-plat-id="' + plat.id + '" checked>' +
                            (plat.image ? '<img src="' + plat.image + '" alt="' + plat.intitule + '">' : '') +
                            '<span class="reco-plat-title">' + plat.intitule + '</span><br>' +
                            '<small>Score : ' + (plat.score ? plat.score.toFixed(2) : '-') + '</small>' +
                            '</div>';
                    });
                } else {
                    recoContent.innerHTML = '<p>Aucune recommandation disponible pour ce jour.</p>';
                }
            })
            .catch(() => {
                recoContent.innerHTML = '<p>Erreur lors du chargement des recommandations.</p>';
            });
    }

    closeModalBtn.onclick = function() { modal.style.display = 'none'; };
    window.onclick = function(event) { if (event.target == modal) modal.style.display = 'none'; };

    btnValider.onclick = function() {
        var contextPath = '/' + window.location.pathname.split('/')[1];
        // Récupère les IDs des plats cochés
        var platsCoches = [];
        document.querySelectorAll('.reco-checkbox').forEach(function(cb) {
            if (cb.checked) platsCoches.push(parseInt(cb.getAttribute('data-plat-id')));
        });
        fetch(contextPath + '/api/publication_plat', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({date: selectedDate, plats: platsCoches})
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert('Recommandation validée pour le ' + selectedDate);
            } else {
                alert('Erreur lors de la validation.');
            }
            modal.style.display = 'none';
        })
        .catch(() => {
            alert('Erreur lors de la validation.');
            modal.style.display = 'none';
        });
    };
    btnAutre.onclick = function() {
        // Relancer la recherche de suggestions (ex: recharger l'appel AJAX)
        openRecoModal(selectedDate);
    };

    function chargerPublications(start, end) {
        var contextPath = '/' + window.location.pathname.split('/')[1];
        fetch(contextPath + '/api/publications?start=' + start + '&end=' + end)
            .then(response => response.json())
            .then(data => {
                var events = data.map(function(pub) {
                    return {
                        title: pub.plat,
                        start: pub.date,
                        allDay: true,
                        color: '#81c784',
                        extendedProps: { image: pub.image }
                    };
                });
                calendar.removeAllEvents();
                calendar.addEventSource(events);
            });
    }
</script>
</body>
</html> 