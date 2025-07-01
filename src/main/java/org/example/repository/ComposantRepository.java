package org.example.repository;

import org.example.entity.Composant;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface ComposantRepository extends JpaRepository<Composant, Integer> {

    @Query("SELECT c.nom, SUM(dp.quantite * dc.quantite) as totalUtilise " +
           "FROM DetailCommande dc " +
           "JOIN dc.plat p " +
           "JOIN DetailsPlat dp ON dp.plat = p " +
           "JOIN dp.composant c " +
           "JOIN dc.commande co " +
           "WHERE co.dateHeurePrevue BETWEEN :dateDebut AND :dateFin " +
           "AND (:typeId IS NULL OR c.typeComposant.id = :typeId) " +
           "GROUP BY c.nom " +
           "ORDER BY totalUtilise DESC")
    List<Object[]> findMostUsedComposants(@Param("dateDebut") LocalDateTime dateDebut,
                                         @Param("dateFin") LocalDateTime dateFin,
                                         @Param("typeId") Integer typeId);
}