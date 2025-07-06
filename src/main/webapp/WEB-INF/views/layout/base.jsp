<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${param.title != null ? param.title : 'BitePoint'} - Gestion Restaurant</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bitepoint.css">
    <c:if test="${param.additionalCss != null}">
        <link rel="stylesheet" href="${pageContext.request.contextPath}${param.additionalCss}">
    </c:if>
</head>
<body>
    <!-- Sidebar Navigation -->
    <nav class="sidebar" id="sidebar">
        <div class="sidebar-header">
            <h1 class="sidebar-title">Vélokan</h1>
        </div>
        
        <ul class="nav-menu">
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/" class="nav-link ${param.activePage == 'dashboard' ? 'active' : ''}">
                    <span class="nav-icon">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M3 13h8V3H3v10zm0 8h8v-6H3v6zm10 0h8V11h-8v10zm0-18v6h8V3h-8z"/>
                        </svg>
                    </span>
                    Dashboard
                </a>
            </li>
            
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/plat/" class="nav-link ${param.activePage == 'menu' ? 'active' : ''}">
                    <span class="nav-icon">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M8.1 13.34l2.83-2.83L3.91 3.5c-1.56 1.56-1.56 4.09 0 5.66l4.19 4.18zm6.78-1.81c1.53.71 3.68.21 5.27-1.38 1.91-1.91 2.28-4.65.81-6.12-1.46-1.46-4.2-1.1-6.12.81-1.59 1.59-2.09 3.74-1.38 5.27L3.7 19.87l1.41 1.41L12 14.41l6.88 6.88 1.41-1.41L13.41 13l1.47-1.47z"/>
                        </svg>
                    </span>
                    Menu
                </a>
            </li>
            
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/commande" class="nav-link ${param.activePage == 'orders' ? 'active' : ''}">
                    <span class="nav-icon">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M19 3H5c-1.11 0-2 .9-2 2v14c0 1.1.89 2 2 2h14c1.11 0 2-.9 2-2V5c0-1.1-.89-2-2-2zm-5 14H7v-2h7v2zm3-4H7v-2h10v2zm0-4H7V7h10v2z"/>
                        </svg>
                    </span>
                    Commandes
                </a>
            </li>
            
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/calendrier" class="nav-link ${param.activePage == 'calendar' ? 'active' : ''}">
                    <span class="nav-icon">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M19 3h-1V1h-2v2H8V1H6v2H5c-1.11 0-1.99.9-1.99 2L3 19c0 1.1.89 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm0 16H5V8h14v11zM7 10h5v5H7z"/>
                        </svg>
                    </span>
                    Calendrier
                </a>
            </li>
            
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/composant/most-used" class="nav-link ${param.activePage == 'analytics' ? 'active' : ''}">
                    <span class="nav-icon">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 17H7v-7h2v7zm4 0h-2V7h2v10zm4 0h-2v-4h2v4z"/>
                        </svg>
                    </span>
                    Analytics
                </a>
            </li>
            
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/stock" class="nav-link ${param.activePage == 'inventory' ? 'active' : ''}">
                    <span class="nav-icon">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M20 2H4c-1.1 0-1.99.9-1.99 2L2 22l4-4h14c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm-2 12H6v-2h12v2zm0-3H6V9h12v2zm0-3H6V6h12v2z"/>
                        </svg>
                    </span>
                    Stock
                </a>
            </li>
            
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/entreprise" class="nav-link ${param.activePage == 'clients' ? 'active' : ''}">
                    <span class="nav-icon">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M16 4c0-1.11.89-2 2-2s2 .89 2 2-.89 2-2 2-2-.89-2-2zm4 18v-6h2.5l-2.54-7.63A1.5 1.5 0 0 0 18.54 8H17c-.8 0-1.54.37-2.01 1l-1.7 2.26V15h-1.5v-6h-.23l-1.7-2.26A2.5 2.5 0 0 0 8.54 8H7c-.8 0-1.54.37-2.01 1L2.5 16H5v6h2v-6h1.5v6h2v-6H12v6h2v-6h1.5v6h2z"/>
                        </svg>
                    </span>
                    Clients
                </a>
            </li>
            
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/settings" class="nav-link ${param.activePage == 'settings' ? 'active' : ''}">
                    <span class="nav-icon">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M19.14,12.94c0.04-0.3,0.06-0.61,0.06-0.94c0-0.32-0.02-0.64-0.07-0.94l2.03-1.58c0.18-0.14,0.23-0.41,0.12-0.61 l-1.92-3.32c-0.12-0.22-0.37-0.29-0.59-0.22l-2.39,0.96c-0.5-0.38-1.03-0.7-1.62-0.94L14.4,2.81c-0.04-0.24-0.24-0.41-0.48-0.41 h-3.84c-0.24,0-0.43,0.17-0.47,0.41L9.25,5.35C8.66,5.59,8.12,5.92,7.63,6.29L5.24,5.33c-0.22-0.08-0.47,0-0.59,0.22L2.74,8.87 C2.62,9.08,2.66,9.34,2.86,9.48l2.03,1.58C4.84,11.36,4.8,11.69,4.8,12s0.02,0.64,0.07,0.94l-2.03,1.58 c-0.18,0.14-0.23,0.41-0.12,0.61l1.92,3.32c0.12,0.22,0.37,0.29,0.59,0.22l2.39-0.96c0.5,0.38,1.03,0.7,1.62,0.94l0.36,2.54 c0.05,0.24,0.24,0.41,0.48,0.41h3.84c0.24,0,0.44-0.17,0.47-0.41l0.36-2.54c0.59-0.24,1.13-0.56,1.62-0.94l2.39,0.96 c0.22,0.08,0.47,0,0.59-0.22l1.92-3.32c0.12-0.22,0.07-0.47-0.12-0.61L19.14,12.94z M12,15.6c-1.98,0-3.6-1.62-3.6-3.6 s1.62-3.6,3.6-3.6s3.6,1.62,3.6,3.6S13.98,15.6,12,15.6z"/>
                        </svg>
                    </span>
                    Paramètres
                </a>
            </li>
        </ul>
    </nav>

    <!-- Main Content -->
    <main class="main-content">
        <!-- Mobile Menu Toggle -->
        <button class="btn btn-outline" id="mobileMenuToggle" style="display: none; margin-bottom: var(--spacing-md);">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
                <path d="M3 18h18v-2H3v2zm0-5h18v-2H3v2zm0-7v2h18V6H3z"/>
            </svg>
            Menu
        </button>

        <!-- Page Content -->
        <c:import url="${param.content}" />
    </main>

    <!-- Scripts -->
    <script>
        // Mobile menu toggle
        document.addEventListener('DOMContentLoaded', function() {
            const mobileMenuToggle = document.getElementById('mobileMenuToggle');
            const sidebar = document.getElementById('sidebar');
            
            if (mobileMenuToggle) {
                mobileMenuToggle.addEventListener('click', function() {
                    sidebar.classList.toggle('open');
                });
            }
            
            // Close sidebar when clicking outside on mobile
            document.addEventListener('click', function(e) {
                if (window.innerWidth <= 768) {
                    if (!sidebar.contains(e.target) && !mobileMenuToggle.contains(e.target)) {
                        sidebar.classList.remove('open');
                    }
                }
            });
            
            // Show/hide mobile menu toggle based on screen size
            function handleResize() {
                if (window.innerWidth <= 768) {
                    mobileMenuToggle.style.display = 'inline-flex';
                } else {
                    mobileMenuToggle.style.display = 'none';
                    sidebar.classList.remove('open');
                }
            }
            
            window.addEventListener('resize', handleResize);
            handleResize(); // Initial check
        });
    </script>
    
    <c:if test="${param.additionalScripts != null}">
        <jsp:include page="${param.additionalScripts}" />
    </c:if>
</body>
</html> 