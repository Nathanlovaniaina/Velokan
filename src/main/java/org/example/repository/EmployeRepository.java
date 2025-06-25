package org.example.repository;

import org.example.entity.Employe;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EmployeRepository extends JpaRepository<Employe, Integer> {
    // Méthodes personnalisées possibles
}
