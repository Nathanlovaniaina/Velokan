package org.example.repository;

import org.example.entity.DetailsPlat;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface DetailsPlatRepository extends JpaRepository<DetailsPlat, Integer> {
    List<DetailsPlat> findByPlatId(Integer platId);
}