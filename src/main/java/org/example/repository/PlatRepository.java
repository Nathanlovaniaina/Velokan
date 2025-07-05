  package org.example.repository;

  import org.example.entity.Plat;
  import org.springframework.data.jpa.repository.JpaRepository;

  public interface PlatRepository extends JpaRepository<Plat, Integer> {
  }