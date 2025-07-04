package org.example.repository;

import org.example.entity.PublicationPlat;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PublicationPlatRepository extends JpaRepository<PublicationPlat, Integer> {
} 