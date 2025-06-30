package org.example.repository;

import org.example.entity.TypeComposant;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TypeComposantRepository extends JpaRepository<TypeComposant, Integer> {
}