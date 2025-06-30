package org.example.repository;

import org.example.entity.MvtStock;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MvtStockRepository extends JpaRepository<MvtStock, Integer> {
}