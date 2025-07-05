<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Ajout de Tâches</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
    <!-- Polices -->
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    
    <!-- CSS -->
    <link href="${pageContext.request.contextPath}/resources/css/app.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/ajout_taches.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css" rel="stylesheet">
    
    <!-- Font Awesome pour les icônes -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div style="font-family: Arial, sans-serif; margin: 20px; max-width: 1200px; margin: 0 auto; padding: 20px;">
        <h1 style="text-align: center; color: #333;">
            <i class="fas fa-plus-circle"></i> Velonkan - Ajout de Tâches
        </h1>
        
        <!-- Messages -->
        <c:if test="${not empty message}">
            <div style="padding: 10px; margin: 10px 0; border-radius: 4px; background: #d4edda; color: #155724; border: 1px solid #c3e6cb;">
                ${message}
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div style="padding: 10px; margin: 10px 0; border-radius: 4px; background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb;">
                ${error}
            </div>
        </c:if>
        
        <!-- Formulaire d'ajout -->
        <div style="background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); margin-bottom: 30px;">
            <h2 style="margin-top: 0; color: #333;">
                <i class="fas fa-utensils"></i> Ajouter des tâches à un plat
            </h2>
            
            <!-- Sélection du plat -->
            <div style="margin-bottom: 20px;">
                <label style="display: block; margin-bottom: 5px; font-weight: bold; color: #555;">Sélectionner un plat :</label>
                <select id="platSelector" onchange="selectPlat(this.value)" style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 4px; font-size: 16px; background: white;">
                    <option value="">Choisir un plat...</option>
                    <c:forEach var="plat" items="${plats}">
                        <option value="${plat.id}" ${selectedPlatId == plat.id ? 'selected' : ''}>${plat.intitule}</option>
                    </c:forEach>
                </select>
            </div>
            
            <!-- Plat sélectionné (affiché en permanence) -->
            <div id="selectedPlatDisplay" style="display: ${not empty selectedPlatId ? 'block' : 'none'}; background: #e3f2fd; padding: 15px; border-radius: 4px; margin-bottom: 20px; border-left: 4px solid #2196f3;">
                <strong style="color: #1976d2;">
                    <i class="fas fa-utensils"></i> Plat sélectionné : 
                    <span id="selectedPlatName">
                        <c:forEach var="plat" items="${plats}">
                            <c:if test="${plat.id == selectedPlatId}">${plat.intitule}</c:if>
                        </c:forEach>
                    </span>
                </strong>
            </div>
            
            <!-- Formulaire d'ajout de tâche -->
            <form id="tacheForm" action="ajout/save" method="POST" style="display: ${not empty selectedPlatId ? 'flex' : 'none'}; gap: 15px; align-items: end; flex-wrap: wrap;">
                <div style="flex: 1; min-width: 200px;">
                    <label style="display: block; margin-bottom: 5px; font-weight: bold; color: #555;">Nom de la tâche :</label>
                    <input type="text" name="nom" required 
                           style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px;"
                           placeholder="Ex: Laver les légumes...">
                </div>
                
                <div style="min-width: 100px;">
                    <label style="display: block; margin-bottom: 5px; font-weight: bold; color: #555;">Ordre :</label>
                    <input type="number" name="order" required min="1" value="1"
                           style="width: 100%; padding: 8px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px;"
                           placeholder="1">
                </div>
                
                <input type="hidden" name="platId" id="hiddenPlatId" value="${selectedPlatId}">
                
                <button type="submit" style="padding: 10px 20px; background: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 14px;">
                    <i class="fas fa-plus"></i> Ajouter Tâche
                </button>
            </form>
        </div>
        
        <!-- Zone de message de succès -->
        <div id="successMessage" style="display: none; padding: 15px; margin: 10px 0; border-radius: 4px; background: #d4edda; color: #155724; border: 1px solid #c3e6cb; text-align: center; font-weight: bold;">
            <i class="fas fa-check-circle"></i> Les tâches sont enregistrées avec succès !
        </div>
        
        <!-- Boutons d'actions -->
        <div style="margin-bottom: 20px; text-align: center;">
            <button onclick="showSuccessMessage()" style="padding: 10px 20px; background: #28a745; color: white; border: none; border-radius: 4px; cursor: pointer; margin-right: 10px;">
                <i class="fas fa-check"></i> Enregistrer
            </button>
            <a href="${pageContext.request.contextPath}/taches_plat/" style="padding: 10px 20px; background: #17a2b8; color: white; border: none; border-radius: 4px; cursor: pointer; text-decoration: none; display: inline-block;">
                <i class="fas fa-list"></i> Voir liste des tâches
            </a>
        </div>
        
        <!-- Liste des tâches du plat sélectionné -->
        <div id="tachesSection" style="display: ${not empty selectedPlatId ? 'block' : 'none'};">
            <div style="background: white; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
                <div style="padding: 20px; border-bottom: 1px solid #eee;">
                    <h3 style="margin: 0; color: #333;">
                        <i class="fas fa-tasks"></i> Tâches du plat sélectionné
                    </h3>
                </div>
                
                <c:choose>
                    <c:when test="${empty tachesPlat}">
                        <div style="text-align: center; padding: 40px; color: #666;">
                            <i class="fas fa-clipboard-list" style="font-size: 48px; color: #ccc; margin-bottom: 10px;"></i>
                            <h4>Aucune tâche pour ce plat</h4>
                            <p>Commencez par ajouter des tâches pour les voir apparaître ici.</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <table style="width: 100%; border-collapse: collapse;">
                            <thead>
                                <tr style="background: #f8f9fa;">
                                    <th style="padding: 12px; text-align: left; border-bottom: 1px solid #eee; font-weight: 600; color: #555;">Nom de la tâche</th>
                                    <th style="padding: 12px; text-align: left; border-bottom: 1px solid #eee; font-weight: 600; color: #555;">Ordre</th>
                                    <th style="padding: 12px; text-align: left; border-bottom: 1px solid #eee; font-weight: 600; color: #555;">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="tache" items="${tachesPlat}" varStatus="status">
                                    <tr data-task-id="${tache.id}" style="border-bottom: 1px solid #eee;">
                                        <td style="padding: 12px;">
                                            <div contenteditable="true" 
                                                 data-field="nom" 
                                                 data-id="${tache.id}"
                                                 data-plat-id="${tache.plat.id}"
                                                 onblur="saveField(this)" 
                                                 onkeypress="handleKeyPress(event, this)"
                                                 style="cursor: text; padding: 8px; border: 1px solid transparent; border-radius: 3px; min-height: 20px;"
                                                 onmouseover="this.style.borderColor='#ddd'; this.style.background='#f9f9f9';"
                                                 onmouseout="this.style.borderColor='transparent'; this.style.background='transparent';"
                                                 onfocus="this.style.borderColor='#007bff'; this.style.background='white';">${tache.nom}</div>
                                        </td>
                                        <td style="padding: 12px;">
                                            <input type="number" 
                                                   value="${tache.ordre}" 
                                                   data-field="order"
                                                   data-id="${tache.id}"
                                                   data-plat-id="${tache.plat.id}"
                                                   onblur="saveField(this)" 
                                                   onkeypress="handleKeyPress(event, this)" 
                                                   min="1"
                                                   style="width: 80px; border: 1px solid #ddd; padding: 4px; font-size: 14px; border-radius: 3px;">
                                        </td>
                                        <td style="padding: 12px;">
                                            <a href="ajout/delete/${tache.id}" 
                                               onclick="return confirm('⚠️ Êtes-vous sûr de vouloir supprimer la tâche \"${tache.nom}\" ?\\n\\nCette action est définitive et ne peut pas être annulée.')"
                                               style="color: #dc3545; text-decoration: none; padding: 6px 8px; border-radius: 3px; display: inline-flex; align-items: center; font-size: 14px;"
                                               onmouseover="this.style.background='#f8d7da'; this.style.color='#721c24';"
                                               onmouseout="this.style.background='transparent'; this.style.color='#dc3545';">
                                                <i class="fas fa-times"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <script>
        // Fonction pour sélectionner un plat
        function selectPlat(platId) {
            if (platId) {
                // Rediriger vers la page avec le plat sélectionné
                window.location.href = 'ajout?platId=' + platId;
            } else {
                // Masquer les sections
                document.getElementById('selectedPlatDisplay').style.display = 'none';
                document.getElementById('tacheForm').style.display = 'none';
                document.getElementById('tachesSection').style.display = 'none';
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
            form.action = 'ajout/save';
            form.style.display = 'none';
            
            // Récupérer les valeurs actuelles
            const row = element.closest('tr');
            const nomElement = row.querySelector('[data-field="nom"]');
            const orderElement = row.querySelector('[data-field="order"]');
            
            const fields = {
                id: id,
                platId: platId,
                nom: field === 'nom' ? value : nomElement.textContent,
                order: field === 'order' ? value : orderElement.value
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
        
        // Fonction pour afficher le message de succès
        function showSuccessMessage() {
            const successMessage = document.getElementById('successMessage');
            const tachesSection = document.getElementById('tachesSection');
            
            successMessage.style.display = 'block';
            tachesSection.style.display = 'none';
            
            // Faire disparaître le message après 3 secondes et réafficher la liste
            setTimeout(() => {
                successMessage.style.display = 'none';
                tachesSection.style.display = 'block';
            }, 3000);
        }
        
        // Initialisation
        document.addEventListener('DOMContentLoaded', function() {
            // Auto-focus sur le champ nom si un plat est sélectionné
            const platSelector = document.getElementById('platSelector');
            if (platSelector.value) {
                const nomInput = document.querySelector('input[name="nom"]');
                if (nomInput) {
                    nomInput.focus();
                }
            }
        });
    </script>
    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>