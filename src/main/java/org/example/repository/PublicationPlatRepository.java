package org.example.repository;

import org.example.entity.PublicationPlat;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.time.LocalDate;
import java.util.List;

@Repository
public interface PublicationPlatRepository extends JpaRepository<PublicationPlat, Integer> {
    List<PublicationPlat> findByDatePublicationBetween(LocalDate start, LocalDate end);
    @Query("SELECT p FROM PublicationPlat p JOIN FETCH p.plat pl LEFT JOIN FETCH pl.compositions WHERE p.datePublication BETWEEN :start AND :end")
    List<PublicationPlat> findWithCompositionsByDatePublicationBetween(@Param("start") LocalDate start, @Param("end") LocalDate end);
    List<PublicationPlat> findByDatePublication(LocalDate date);
} 