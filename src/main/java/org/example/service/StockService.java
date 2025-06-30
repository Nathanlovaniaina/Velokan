package org.example.service;

import org.example.entity.Stock;
import org.example.repository.StockRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class StockService {

    private final StockRepository stockRepository;

    public StockService(StockRepository stockRepository) {
        this.stockRepository = stockRepository;
    }

    public List<Stock> findAll() {
        return stockRepository.findAll();
    }

    public Optional<Stock> findById(Integer id) {
        return stockRepository.findById(id);
    }

    public List<Stock> findByComposantId(Integer composantId) {
        return stockRepository.findByComposantId(composantId);
    }

    public Stock saveOrUpdate(Stock stock) {
        return stockRepository.save(stock);
    }

    public void delete(Integer id) {
        stockRepository.deleteById(id);
    }
}