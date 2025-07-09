<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Page Header -->
<div class="page-header">
    <h1 class="page-title">Calendrier - Planification des plats</h1>
    <p class="page-subtitle">Planifiez vos menus avec des recommandations intelligentes</p>
</div>

<!-- Export Section -->
<div class="export-section">
    <div class="export-header">
        <h3 class="export-title">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                <path d="M14 2H6a2 2 0 00-2 2v16a2 2 0 002 2h12a2 2 0 002-2V8l-6-6z"/>
                <path d="M14 2v6h6"/>
                <path d="M16 13H8"/>
                <path d="M16 17H8"/>
                <path d="M10 9H8"/>
            </svg>
            Exporter les publications
        </h3>
    </div>
    
    <form class="export-form">
        <div class="form-group">
            <label class="form-label">Date de début</label>
            <input type="date" id="exportStart" class="form-input">
        </div>
        
        <div class="form-group">
            <label class="form-label">Date de fin</label>
            <input type="date" id="exportEnd" class="form-input">
        </div>
        
        <div class="form-group">
            <button type="button" class="btn btn-primary" id="btnExportPDF">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                    <path d="M14 2H6a2 2 0 00-2 2v16a2 2 0 002 2h12a2 2 0 002-2V8l-6-6z"/>
                    <path d="M14 2v6h6"/>
                    <path d="M16 13H8"/>
                    <path d="M16 17H8"/>
                    <path d="M10 9H8"/>
                </svg>
                Exporter PDF
            </button>
        </div>
    </form>
</div>

<!-- Calendar Container -->
<div class="card">
    <div class="card-header">
        <h3 class="card-title">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                <path d="M19 3h-1V1h-2v2H8V1H6v2H5c-1.11 0-1.99.9-1.99 2L3 19c0 1.1.89 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm0 16H5V8h14v11zM7 10h5v5H7z"/>
            </svg>
            Calendrier des plats
        </h3>
        <div class="calendar-legend">
            <div class="legend-item">
                <div class="legend-color" style="background-color: #4CAF50;"></div>
                <span>Plats publiés</span>
            </div>
        </div>
    </div>
    
    <div class="calendar-container">
        <div id='calendar'></div>
    </div>
</div>

<!-- Modal Popup -->
<div id="recoModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h2 class="modal-title">Recommandations du jour</h2>
            <button class="close" id="closeModal">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                    <path d="M6 18L18 6M6 6l12 12"/>
                </svg>
            </button>
        </div>
        
        <div id="recoContent" class="reco-content">
            <div class="loading">
                <div class="spinner"></div>
                Chargement des recommandations...
            </div>
        </div>
        
        <div class="modal-actions">
            <button class="btn btn-primary" id="btnValider">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">
                    <path d="M5 13l4 4L19 7"/>
                </svg>
                Valider
            </button>
        </div>
    </div>
</div>

<!-- FullCalendar CSS and JS -->
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.css' rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>

<!-- Calendar JavaScript -->
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
        },
        eventClick: function(info) {
            // Optionnel : afficher les détails d'un événement
            console.log('Event clicked:', info.event.title);
        }
    });
    calendar.render();

    // Initialiser la limitation de sélection pour la modale
    limiterSelectionRecommandations();
});

// Modal logic
var modal = document.getElementById('recoModal');
var closeModalBtn = document.getElementById('closeModal');
var btnValider = document.getElementById('btnValider');
var recoContent = document.getElementById('recoContent');
var selectedDate = null;
var platsRecommandes = [];
var platsRecommandesIds = [];

// Fonction pour limiter la sélection à 2 plats recommandés
function limiterSelectionRecommandations() {
    const checkboxes = document.querySelectorAll('.reco-checkbox');
    checkboxes.forEach(cb => {
        cb.addEventListener('change', function() {
            const checked = document.querySelectorAll('.reco-checkbox:checked');
            if (checked.length > 2) {
                this.checked = false;
                alert('Vous ne pouvez sélectionner que 2 recommandations maximum.');
            }
        });
    });
}

function openRecoModal(dateStr) {
    selectedDate = dateStr;
    modal.style.display = 'block';
    recoContent.innerHTML = `
        <div class="loading">
            <div class="spinner"></div>
            Chargement des recommandations...
        </div>
    `;
    platsRecommandes = [];
    platsRecommandesIds = [];
    
    var contextPath = '/' + window.location.pathname.split('/')[1];
    
    // 1. Charger les publications déjà faites pour ce jour
    fetch(contextPath + '/api/publications?start=' + dateStr + '&end=' + dateStr)
        .then(response => response.json())
        .then(pubs => {
            var pubsHtml = '';
            var dejaPubliesIds = pubs.map(function(pub) { return pub.id; });
            
            if (pubs && pubs.length > 0) {
                console.log('Publications trouvées:', pubs);
                pubsHtml = '<div class="pubs-list">' +
                    '<h4>' +
                        '<svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor">' +
                            '<path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>' +
                        '</svg>' +
                        'Déjà publiés ce jour' +
                    '</h4>' +
                    '<ul>';
                
                pubs.forEach(function(pub) {
                    console.log('Publication:', pub);
                    var pubPlat = pub.plat || 'Sans nom';
                    pubsHtml += '<li>' +
                        '<span style="color: var(--secondary);">✔</span>' +
                        pubPlat +
                    '</li>';
                });
                pubsHtml += '</ul></div>';
            }
            
            // 2. Charger les recommandations
            console.log('Chargement des recommandations pour:', dateStr);
            fetch(contextPath + '/api/recommandation?date=' + dateStr)
                .then(response => {
                    console.log('Response status:', response.status);
                    return response.json();
                })
                .then(data => {
                    console.log('Données reçues:', data);
                    var html = pubsHtml;
                    
                    if (data && data.plats && data.plats.length > 0) {
                        console.log('Affichage de', data.plats.length, 'plats recommandés');
                        // Ajouter un titre pour les recommandations
                        html += '<h4>Recommandations</h4>';

                        // Trier les plats : d'abord ceux déjà publiés, puis les autres, chacun trié par score décroissant
                        var platsPublies = data.plats.filter(function(plat) { return dejaPubliesIds.includes(plat.id); });
                        var platsNonPublies = data.plats.filter(function(plat) { return !dejaPubliesIds.includes(plat.id); });
                        platsPublies.sort(function(a, b) { return b.score - a.score; });
                        platsNonPublies.sort(function(a, b) { return b.score - a.score; });
                        var platsTries = platsPublies.concat(platsNonPublies);

                        platsTries.forEach(function(plat, idx) {
                            console.log('Traitement du plat:', plat);
                            console.log('plat.intitule:', plat.intitule);
                            console.log('plat.id:', plat.id);
                            console.log('plat.score:', plat.score);
                            platsRecommandes.push(plat);
                            platsRecommandesIds.push(plat.id);
                            var dejaPublie = dejaPubliesIds.includes(plat.id);
                            
                            var platId = plat.id || '';
                            var platIntitule = plat.intitule || 'Sans nom';
                            var platScore = plat.score ? plat.score.toFixed(2) : '-';
                            
                            var checkedAttr = dejaPublie ? ' checked' : '';
                            // Les plats déjà publiés sont cochés mais non désactivés (modifiable)
                            var platHtml = '<div class="reco-plat" style="border: 1px solid #ccc; padding: 10px; margin: 5px 0;">' +
                                '<input type="checkbox" class="reco-checkbox" id="reco-plat-' + idx + '" data-plat-id="' + platId + '"' + checkedAttr + '>' +
                                '<div class="reco-plat-info">' +
                                    '<div class="reco-plat-title" style="font-weight: bold;">' + platIntitule + '</div>' +
                                    '<div class="reco-plat-score">' +
                                        'Score: <span class="score-badge">' + platScore + '</span>' +
                                    '</div>' +
                                '</div>' +
                            '</div>';
                            html += platHtml;
                        });
                        console.log('HTML généré complet:', html);
                    } else {
                        html += `
                            <div class="empty-state">
                                <svg viewBox="0 0 24 24" fill="currentColor">
                                    <path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                </svg>
                                <h4>Aucune recommandation</h4>
                                <p>Aucune recommandation disponible pour ce jour.</p>
                            </div>
                        `;
                    }
                    console.log('Assignation du HTML au contenu');
                    recoContent.innerHTML = html;
                    console.log('Contenu final:', recoContent.innerHTML);
                    // Ajout de la limitation après le rendu du HTML
                    limiterSelectionRecommandations();
                })
                .catch(() => {
                    recoContent.innerHTML = pubsHtml + `
                        <div class="empty-state">
                            <svg viewBox="0 0 24 24" fill="currentColor">
                                <path d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                            <h4>Erreur de chargement</h4>
                            <p>Erreur lors du chargement des recommandations.</p>
                        </div>
                    `;
                });
        })
        .catch(() => {
            recoContent.innerHTML = `
                <div class="empty-state">
                    <svg viewBox="0 0 24 24" fill="currentColor">
                        <path d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                    </svg>
                    <h4>Erreur de chargement</h4>
                    <p>Erreur lors du chargement des publications déjà faites.</p>
                </div>
            `;
        });
}

closeModalBtn.onclick = function() { 
    modal.style.display = 'none'; 
};

window.onclick = function(event) { 
    if (event.target == modal) modal.style.display = 'none'; 
};

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
            // Afficher une notification de succès
            showNotification('Recommandation validée pour le ' + selectedDate, 'success');
        } else {
            showNotification('Erreur lors de la validation.', 'error');
        }
        modal.style.display = 'none';
        // Recharger le calendrier
        calendar.refetchEvents();
    })
    .catch(() => {
        showNotification('Erreur lors de la validation.', 'error');
        modal.style.display = 'none';
    });
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
                    color: '#4CAF50',
                    extendedProps: { image: pub.image }
                };
            });
            calendar.removeAllEvents();
            calendar.addEventSource(events);
        });
}

// Export PDF
document.getElementById('btnExportPDF').onclick = function() {
    var start = document.getElementById('exportStart').value;
    var end = document.getElementById('exportEnd').value;
    
    if (!start || !end) {
        showNotification('Veuillez sélectionner une période.', 'error');
        return;
    }
    
    var contextPath = '/' + window.location.pathname.split('/')[1];
    window.open(contextPath + '/api/publications/pdf?start=' + start + '&end=' + end, '_blank');
};

// Notification system
function showNotification(message, type) {
    const notification = document.createElement('div');
    notification.className = `alert alert-${type}`;
    notification.style.position = 'fixed';
    notification.style.top = '20px';
    notification.style.right = '20px';
    notification.style.zIndex = '9999';
    notification.style.minWidth = '300px';
            const iconPath = type === 'success' ? 
            '<path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>' : 
            '<path d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"/>';
        
        notification.innerHTML = `
            <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                ${iconPath}
            </svg>
            ${message}
        `;
    
    document.body.appendChild(notification);
    
    setTimeout(() => {
        notification.remove();
    }, 5000);
}
</script>

<style>
/* Calendar Container */
.calendar-container {
    padding: var(--spacing-md);
}

.calendar-legend {
    display: flex;
    gap: var(--spacing-md);
}

.legend-item {
    display: flex;
    align-items: center;
    gap: var(--spacing-xs);
    font-size: 0.875rem;
    color: var(--text-secondary);
}

.legend-color {
    width: 12px;
    height: 12px;
    border-radius: 2px;
}

/* Additional Calendar Styles */
.fc-daygrid-day-number {
    font-weight: 500;
    color: var(--text-primary);
}

.fc-col-header-cell {
    background-color: var(--surface);
    font-weight: 600;
    color: var(--text-primary);
}

.fc-daygrid-day.fc-day-other {
    background-color: rgba(0, 0, 0, 0.02);
}

.fc-daygrid-day.fc-day-other .fc-daygrid-day-number {
    color: var(--text-muted);
}
</style> 