package org.example.service;

import org.example.entity.MvtStock;
import org.example.repository.MvtStockRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class MvtStockService {

    private final MvtStockRepository mvtStockRepository;

    public MvtStockService(MvtStockRepository mvtStockRepository) {
        this.mvtStockRepository = mvtStockRepository;
    }

    public List<MvtStock> findAll() {
        return mvtStockRepository.findAll();
    }

    public Optional<MvtStock> findById(Integer id) {
        return mvtStockRepository.findById(id);
    }

    public MvtStock saveOrUpdate(MvtStock mvtStock) {
        return mvtStockRepository.save(mvtStock);
    }

    public void delete(Integer id) {
        mvtStockRepository.deleteById(id);
    }
}