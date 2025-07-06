<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Page Header -->
<div class="page-header">
    <h1 class="page-title">Dashboard</h1>
    <p class="page-subtitle">Vue d'ensemble de votre restaurant</p>
</div>

<!-- Stats Cards -->
<div class="grid grid-4 mb-4">
    <div class="card">
        <div class="card-header">
            <h3 class="card-title">Commandes Aujourd'hui</h3>
            <span class="badge badge-success">+12%</span>
        </div>
        <div class="text-center">
            <div class="font-bold" style="font-size: 2.5rem; color: var(--primary);">24</div>
            <p class="text-secondary">vs 21 hier</p>
        </div>
    </div>
    
    <div class="card">
        <div class="card-header">
            <h3 class="card-title">Chiffre d'Affaires</h3>
            <span class="badge badge-success">+8%</span>
        </div>
        <div class="text-center">
            <div class="font-bold" style="font-size: 2.5rem; color: var(--secondary);">€1,247</div>
            <p class="text-secondary">vs €1,154 hier</p>
        </div>
    </div>
    
    <div class="card">
        <div class="card-header">
            <h3 class="card-title">Plats Populaires</h3>
            <span class="badge badge-warning">Top 3</span>
        </div>
        <div class="text-center">
            <div class="font-bold" style="font-size: 2.5rem; color: var(--primary);">15</div>
            <p class="text-secondary">plats recommandés</p>
        </div>
    </div>
    
    <div class="card">
        <div class="card-header">
            <h3 class="card-title">Stock Critique</h3>
            <span class="badge badge-muted">Attention</span>
        </div>
        <div class="text-center">
            <div class="font-bold" style="font-size: 2.5rem; color: #ff6b6b;">3</div>
            <p class="text-secondary">ingrédients à commander</p>
        </div>
    </div>
</div>

<!-- Main Content Grid -->
<div class="grid grid-2">
    <!-- Recent Orders -->
    <div class="card">
        <div class="card-header">
            <h3 class="card-title">Commandes Récentes</h3>
            <a href="${pageContext.request.contextPath}/commande" class="btn btn-outline">Voir tout</a>
        </div>
        
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Client</th>
                        <th>Plats</th>
                        <th>Statut</th>
                        <th>Total</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <div>
                                <div class="font-medium">Restaurant Le Gourmet</div>
                                <div class="text-secondary text-sm">14:30</div>
                            </div>
                        </td>
                        <td>3 plats</td>
                        <td><span class="badge badge-success">Prêt</span></td>
                        <td class="number font-semibold">€45.00</td>
                    </tr>
                    <tr>
                        <td>
                            <div>
                                <div class="font-medium">Café Central</div>
                                <div class="text-secondary text-sm">14:15</div>
                            </div>
                        </td>
                        <td>2 plats</td>
                        <td><span class="badge badge-warning">En cours</span></td>
                        <td class="number font-semibold">€32.50</td>
                    </tr>
                    <tr>
                        <td>
                            <div>
                                <div class="font-medium">Hôtel Plaza</div>
                                <div class="text-secondary text-sm">14:00</div>
                            </div>
                        </td>
                        <td>5 plats</td>
                        <td><span class="badge badge-muted">En attente</span></td>
                        <td class="number font-semibold">€78.00</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
    
    <!-- Popular Dishes -->
    <div class="card">
        <div class="card-header">
            <h3 class="card-title">Plats les Plus Populaires</h3>
            <a href="${pageContext.request.contextPath}/plat" class="btn btn-outline">Gérer</a>
        </div>
        
        <div class="space-y-3">
            <div class="flex items-center justify-between p-3 bg-gray-50 rounded-lg">
                <div class="flex items-center gap-3">
                    <div class="w-10 h-10 bg-primary rounded-lg flex items-center justify-center">
                        <span class="font-bold text-sm">1</span>
                    </div>
                    <div>
                        <div class="font-medium">Poulet Basquaise</div>
                        <div class="text-secondary text-sm">15 commandes</div>
                    </div>
                </div>
                <div class="text-right">
                    <div class="font-semibold">€18.50</div>
                    <div class="text-secondary text-sm">+23%</div>
                </div>
            </div>
            
            <div class="flex items-center justify-between p-3 bg-gray-50 rounded-lg">
                <div class="flex items-center gap-3">
                    <div class="w-10 h-10 bg-secondary rounded-lg flex items-center justify-center">
                        <span class="font-bold text-sm text-white">2</span>
                    </div>
                    <div>
                        <div class="font-medium">Salade Niçoise</div>
                        <div class="text-secondary text-sm">12 commandes</div>
                    </div>
                </div>
                <div class="text-right">
                    <div class="font-semibold">€14.00</div>
                    <div class="text-secondary text-sm">+18%</div>
                </div>
            </div>
            
            <div class="flex items-center justify-between p-3 bg-gray-50 rounded-lg">
                <div class="flex items-center gap-3">
                    <div class="w-10 h-10 bg-yellow-400 rounded-lg flex items-center justify-center">
                        <span class="font-bold text-sm">3</span>
                    </div>
                    <div>
                        <div class="font-medium">Tarte Tatin</div>
                        <div class="text-secondary text-sm">10 commandes</div>
                    </div>
                </div>
                <div class="text-right">
                    <div class="font-semibold">€8.50</div>
                    <div class="text-secondary text-sm">+15%</div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Quick Actions -->
<div class="card mt-4">
    <div class="card-header">
        <h3 class="card-title">Actions Rapides</h3>
    </div>
    
    <div class="grid grid-4">
        <a href="${pageContext.request.contextPath}/calendrier" class="card text-center hover:shadow-lg transition-all">
            <div class="mb-3">
                <svg width="40" height="40" viewBox="0 0 24 24" fill="var(--primary)">
                    <path d="M19 3h-1V1h-2v2H8V1H6v2H5c-1.11 0-1.99.9-1.99 2L3 19c0 1.1.89 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm0 16H5V8h14v11zM7 10h5v5H7z"/>
                </svg>
            </div>
            <h4 class="font-semibold">Planifier Menu</h4>
            <p class="text-secondary text-sm">Calendrier des plats</p>
        </a>
        
        <a href="${pageContext.request.contextPath}/stock" class="card text-center hover:shadow-lg transition-all">
            <div class="mb-3">
                <svg width="40" height="40" viewBox="0 0 24 24" fill="var(--secondary)">
                    <path d="M20 2H4c-1.1 0-1.99.9-1.99 2L2 22l4-4h14c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm-2 12H6v-2h12v2zm0-3H6V9h12v2zm0-3H6V6h12v2z"/>
                </svg>
            </div>
            <h4 class="font-semibold">Gérer Stock</h4>
            <p class="text-secondary text-sm">Inventaire & commandes</p>
        </a>
        
        <a href="${pageContext.request.contextPath}/composant/most-used" class="card text-center hover:shadow-lg transition-all">
            <div class="mb-3">
                <svg width="40" height="40" viewBox="0 0 24 24" fill="var(--primary)">
                    <path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 17H7v-7h2v7zm4 0h-2V7h2v10zm4 0h-2v-4h2v4z"/>
                </svg>
            </div>
            <h4 class="font-semibold">Analytics</h4>
            <p class="text-secondary text-sm">Statistiques & rapports</p>
        </a>
        
        <a href="${pageContext.request.contextPath}/commande" class="card text-center hover:shadow-lg transition-all">
            <div class="mb-3">
                <svg width="40" height="40" viewBox="0 0 24 24" fill="var(--secondary)">
                    <path d="M19 3H5c-1.11 0-2 .9-2 2v14c0 1.1.89 2 2 2h14c1.11 0 2-.9 2-2V5c0-1.1-.89-2-2-2zm-5 14H7v-2h7v2zm3-4H7v-2h10v2zm0-4H7V7h10v2z"/>
                </svg>
            </div>
            <h4 class="font-semibold">Commandes</h4>
            <p class="text-secondary text-sm">Gérer les commandes</p>
        </a>
    </div>
</div>

<style>
.space-y-3 > * + * {
    margin-top: var(--spacing-md);
}

.hover\:shadow-lg:hover {
    box-shadow: var(--shadow-hover);
}

.transition-all {
    transition: all 0.2s ease;
}

.text-sm {
    font-size: 0.875rem;
}

.bg-gray-50 {
    background-color: var(--surface);
}

.bg-primary {
    background-color: var(--primary);
}

.bg-secondary {
    background-color: var(--secondary);
}

.bg-yellow-400 {
    background-color: #fbbf24;
}

.text-white {
    color: white;
}

.table-responsive {
    overflow-x: auto;
}
</style> 