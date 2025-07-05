<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Velonkan - Gestion des Tâches Plat</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <!-- Polices -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    
    <!-- CSS -->
    <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/taches_plat.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
    
    .taches-container {
        display: none;  /* Masqué par défaut */
        background: white;
    }

    .taches-container.expanded {
        display: block;  /* Visible quand la classe 'expanded' est ajoutée */
    }

    .plat-toggle {
    transition: transform 0.3s ease;  /* Animation fluide */
    color: #6c757d;
    }

    .plat-toggle.expanded {
        transform: rotate(180deg);  /* Rotation de 180° quand expanded */
    }
    
    .plat-header {
        cursor: pointer;
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 10px;
        background-color: #f8f9fa;
        border-bottom: 1px solid #dee2e6;
    }
    
    </style>

    <!-- Font Awesome pour les icônes -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1><i class="fas fa-tasks"></i> Gestion des Tâches Plat</h1>
        
        <!-- Messages -->
        <c:if test="${not empty message}">
            <div class="message">${message}</div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="message error">${error}</div>
        </c:if>
        
        <!-- Recherche -->
        <div class="search-container">
            <input type="text" class="search-input" id="searchInput" placeholder="🔍 Rechercher par nom de plat ou tâche...">
        </div>
        
        <!-- Contenu principal -->
        <div id="mainContent">
            <c:choose>
                <c:when test="${empty tachesGroupeesParPlat}">
                    <div class="empty-state">
                        <i class="fas fa-clipboard-list"></i>
                        <h3>Aucune tâche trouvée</h3>
                        <p>Commencez par ajouter des tâches à vos plats pour les voir apparaître ici.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div id="platsContainer">
                        <c:forEach var="platEntry" items="${tachesGroupeesParPlat}">
                            <c:set var="platId" value="${platEntry.key}" />
                            <c:set var="tachesPlat" value="${platEntry.value}" />
                            <c:set var="premiereTache" value="${tachesPlat[0]}" />
                            <c:set var="platNom" value="${premiereTache.plat.intitule}" />
                            
                            <div class="plat-group" data-plat-id="${platId}">
                                <div class="plat-header" onclick="togglePlat(${platId})">
                                    <div class="plat-name">
                                        ${platNom}
                                        <span class="task-count">${fn:length(tachesPlat)} tâche(s)</span>
                                    </div>
                                    <i class="fas fa-chevron-down plat-toggle" id="toggle-${platId}"></i>
                                </div>
                                <div class="taches-container" id="taches-${platId}">
                                    <table class="taches-table">
                                        <thead>
                                            <tr>
                                                <th>Nom de la tâche</th>
                                                <th>Ordre</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="tache" items="${tachesPlat}">
                                                <tr data-task-id="${tache.id}">
                                                    <td>
                                                        <div class="editable-cell" 
                                                             contenteditable="true" 
                                                             data-field="nom" 
                                                             data-id="${tache.id}"
                                                             data-plat-id="${tache.plat.id}"
                                                             onblur="saveField(this)" 
                                                             onkeypress="handleKeyPress(event, this)">${tache.nom}</div>
                                                    </td>
                                                    <td>
                                                        <input type="number" 
                                                               class="editable-input" 
                                                               value="${tache.ordre}" 
                                                               data-field="order"
                                                               data-id="${tache.id}"
                                                               data-plat-id="${tache.plat.id}"
                                                               onblur="saveField(this)" 
                                                               onkeypress="handleKeyPress(event, this)" 
                                                               min="1">
                                                    </td>
                                                    <td>
                                                        <a href="delete/${tache.id}" 
                                                           class="action-delete" 
                                                           onclick="return confirm('⚠️ Êtes-vous sûr de vouloir supprimer la tâche \"${tache.nom}\" ?\n\nCette action est définitive et ne peut pas être annulée.')">
                                                            <i class="fas fa-trash"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <a href="${pageContext.request.contextPath}/taches_plat/ajout" class="btn">
            <i class="fas fa-plus"></i> Ajouter une tâche
        </a>

        <a href="${pageContext.request.contextPath}" class="btn">
            Acceuil
        </a>
    </div>

    <script>
        // Variables globales
        let isSearching = false;
        
        // Fonction pour basculer l'affichage des tâches d'un plat
        function togglePlat(platId) {
            const container = document.getElementById('taches-' + platId);
            const toggle = document.getElementById('toggle-' + platId);
            
            if (container.classList.contains('expanded')) {
                container.classList.remove('expanded');
                toggle.classList.remove('expanded');
            } else {
                container.classList.add('expanded');
                toggle.classList.add('expanded');
            }
        }
        
        // Fonction pour sauvegarder un champ modifié
        function saveField(element) {
            const id = element.dataset.id;
            const field = element.dataset.field;
            const platId = element.dataset.platId;
            let value = element.textContent || element.value;
            
            // Créer et soumettre un formulaire caché
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = 'save';
            form.style.display = 'none';
            
            // Ajouter les champs nécessaires
            const fields = {
                id: id,
                platId: platId,
                nom: field === 'nom' ? value : element.closest('tr').querySelector('[data-field="nom"]').textContent,
                order: field === 'order' ? value : element.closest('tr').querySelector('[data-field="order"]').value
            };
            
            Object.keys(fields).forEach(key => {
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = key;
                input.value = fields[key];
                form.appendChild(input);
            });
            
            document.body.appendChild(form);
            
            // Effet visuel de sauvegarde
            element.style.background = '#d4edda';
            setTimeout(() => {
                element.style.background = '';
                form.submit();
            }, 200);
        }
        
        // Fonction pour gérer la touche Entrée
        function handleKeyPress(event, element) {
            if (event.key === 'Enter') {
                event.preventDefault();
                element.blur();
            }
        }
        
        // Fonction de recherche dynamique
        function initSearch() {
            const searchInput = document.getElementById('searchInput');
            const platsContainer = document.getElementById('platsContainer');
            
            searchInput.addEventListener('input', function() {
                const query = this.value.toLowerCase().trim();
                const platGroups = platsContainer.querySelectorAll('.plat-group');
                
                if (query === '') {
                    // Afficher tous les groupes
                    platGroups.forEach(group => {
                        group.style.display = 'block';
                        const rows = group.querySelectorAll('tbody tr');
                        rows.forEach(row => row.style.display = '');
                    });
                    isSearching = false;
                } else {
                    isSearching = true;
                    
                    platGroups.forEach(group => {
                        const platName = group.querySelector('.plat-name').textContent.toLowerCase();
                        const rows = group.querySelectorAll('tbody tr');
                        let hasVisibleRows = false;
                        
                        // Filtrer les tâches
                        rows.forEach(row => {
                            const taskName = row.querySelector('[data-field="nom"]').textContent.toLowerCase();
                            if (platName.includes(query) || taskName.includes(query)) {
                                row.style.display = '';
                                hasVisibleRows = true;
                            } else {
                                row.style.display = 'none';
                            }
                        });
                        
                        // Afficher/masquer le groupe et l'ouvrir si nécessaire
                        if (hasVisibleRows) {
                            group.style.display = 'block';
                            const platId = group.dataset.platId;
                            const container = document.getElementById('taches-' + platId);
                            const toggle = document.getElementById('toggle-' + platId);
                            if (!container.classList.contains('expanded')) {
                                container.classList.add('expanded');
                                toggle.classList.add('expanded');
                            }
                        } else {
                            group.style.display = 'none';
                        }
                    });
                }
            });
        }
        
        // Initialisation
        document.addEventListener('DOMContentLoaded', function() {
            initSearch();
        });
    </script>
    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>