package org.example.repository;

import org.example.entity.PaiementSalaire;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PaiementSalaireRepository extends JpaRepository<PaiementSalaire, Integer> {
    // Méthodes personnalisées possibles
}
