package org.example.repository;

import org.example.entity.Plat;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface PlatRepository extends JpaRepository<Plat, Integer> {

    @Query("SELECT DISTINCT p FROM Plat p LEFT JOIN FETCH p.compositions dp JOIN FETCH dp.composant c JOIN FETCH c.unite")
    List<Plat> findAllWithCompositions();

    @Query("SELECT DISTINCT p FROM Plat p LEFT JOIN FETCH p.compositions dp JOIN FETCH dp.composant c JOIN FETCH c.unite WHERE p.dateCreation >= :date")
    List<Plat> findByDateCreationGreaterThanEqualWithCompositions(@Param("date") LocalDate date);

    @Query("SELECT p FROM Plat p LEFT JOIN FETCH p.compositions dp JOIN FETCH dp.composant c JOIN FETCH c.unite WHERE p.id = :id")
    Plat findByIdWithCompositions(@Param("id") Integer id);

    
}