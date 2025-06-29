package org.example.repository;
import java.time.LocalDate;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;

@Repository
public class SuiviRecetteRepository {

    @PersistenceContext
    private EntityManager entityManager;

    @SuppressWarnings("unchecked")
    public List<Object[]> getRevenuMensuelParAnnee(LocalDate startDate, LocalDate endDate, 
                                              Long entrepriseId, Long platId) {
        StringBuilder sql = new StringBuilder("""
            SELECT 
                EXTRACT(MONTH FROM f.date_emission) AS mois,
                EXTRACT(YEAR FROM f.date_emission) AS annee,
                SUM(f.montant_total) AS revenu_mensuel,
                COUNT(DISTINCT f.id) AS nombre_factures
            FROM 
                facture f
            JOIN 
                commandes c ON f.id_commandes = c.id
            WHERE 1=1
        """);

        // Ajout des filtres de base
        sql.append(" AND f.date_emission BETWEEN :startDate AND :endDate");
        sql.append(" AND f.statut = 'Paye'");

        // Filtres optionnels
        if (entrepriseId != null) {
            sql.append(" AND f.id_entreprise = :entrepriseId");
        }
        if (platId != null) {
            sql.append(" AND c.id_plat = :platId");
        }

        // Group by et order by
        sql.append("""
            GROUP BY 
                mois, annee
            ORDER BY 
                annee, mois
        """);

        javax.persistence.Query query = entityManager.createNativeQuery(sql.toString());
        query.setParameter("startDate", startDate);
        query.setParameter("endDate", endDate);

        if (entrepriseId != null) {
            query.setParameter("entrepriseId", entrepriseId);
        }
        if (platId != null) {
            query.setParameter("platId", platId);
        }

        return query.getResultList();
    }

    @SuppressWarnings("unchecked")
    public List<Object[]> getRevenuParEntreprise(LocalDate startDate, LocalDate endDate) {
        String sql = """
            SELECT 
                e.nom AS entreprise,
                SUM(f.montant_total) AS revenu_entreprise,
                COUNT(DISTINCT f.id_commandes) AS nombre_total_commandes,
                SUM(c.quantite) AS nombre_total_plats
            FROM 
                facture f
            JOIN 
                entreprise e ON f.id_entreprise = e.id
            JOIN 
                commandes c ON f.id_commandes = c.id
            WHERE 
                f.date_emission BETWEEN :startDate AND :endDate
                AND f.statut = 'Paye'
            GROUP BY 
                e.nom
            ORDER BY 
                revenu_entreprise DESC;
        """;

        javax.persistence.Query query = entityManager.createNativeQuery(sql);
        query.setParameter("startDate", startDate);
        query.setParameter("endDate", endDate);

        return query.getResultList();
    }

    @SuppressWarnings("unchecked")
    public List<Object[]> getRevenuJournalierEtEvolution(LocalDate startDate, LocalDate endDate) {
        String sql = """
            SELECT 
                date_emission,
                revenu_journalier,
                LAG(revenu_journalier) OVER (ORDER BY date_emission) AS revenu_veille,
                (revenu_journalier - LAG(revenu_journalier) OVER (ORDER BY date_emission)) AS evolution
            FROM (
                SELECT 
                    date_emission,
                    SUM(montant_total) AS revenu_journalier
                FROM 
                    facture
                WHERE 
                    date_emission BETWEEN :startDate AND :endDate
                    AND statut = 'Paye'
                GROUP BY 
                    date_emission
            ) AS journalier
            ORDER BY 
                date_emission
        """;
    
        javax.persistence.Query query = entityManager.createNativeQuery(sql);
        query.setParameter("startDate", startDate);
        query.setParameter("endDate", endDate);
    
        return query.getResultList();
    }

    @SuppressWarnings("unchecked")
    public List<Object[]> getFacturesEnRetard(LocalDate startDate, LocalDate endDate) {
        String sql = """
            SELECT 
                f.id AS facture,
                e.nom AS entreprise,
                f.montant_total,
                f.date_emission,
                CURRENT_DATE - f.date_emission AS jours_retard
            FROM 
                facture f
            JOIN 
                entreprise e ON f.id_entreprise = e.id
            WHERE 
                (f.statut = 'En retard' OR f.statut = 'En attente')
                AND f.date_emission BETWEEN :startDate AND :endDate
            ORDER BY 
                jours_retard DESC
        """;
    
        javax.persistence.Query query = entityManager.createNativeQuery(sql);
        query.setParameter("startDate", startDate);
        query.setParameter("endDate", endDate);
    
        return query.getResultList();
    }


}

