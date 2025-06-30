package org.example.repository;

import org.example.entity.Plat;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface PlatRepository extends JpaRepository<Plat, Integer> {
    List<Plat> findByDateCreationGreaterThanEqual(LocalDate date);
}