package org.example.repository;

import org.example.entity.Plat;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

// import java.util.Optional;  // <-- Manquait cet import

public interface PlatRepository extends JpaRepository<Plat, Integer> {
   List<Plat> findByIntitule(String intitule); // liste au lieu d'Optional/unique
}
