
  package org.example.repository;

  import org.example.entity.Entreprise;
  import org.springframework.data.jpa.repository.JpaRepository;

  public interface EntrepriseRepository extends JpaRepository<Entreprise, Integer> {
  }