package org.example.repository;

import org.example.entity.PublicationPlat;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.time.LocalDate;
import java.util.List;

@Repository
public interface PublicationPlatRepository extends JpaRepository<PublicationPlat, Integer> {
    List<PublicationPlat> findByDatePublicationBetween(LocalDate start, LocalDate end);
    List<PublicationPlat> findByDatePublication(LocalDate date);
} 