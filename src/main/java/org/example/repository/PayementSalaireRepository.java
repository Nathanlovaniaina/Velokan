package org.example.repository;

import org.example.entity.PayementSalaire;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PayementSalaireRepository extends JpaRepository<PayementSalaire, Integer> {
    // Méthodes personnalisées possibles
}
