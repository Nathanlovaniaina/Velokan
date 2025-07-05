package org.example.service;

import org.example.entity.Stock;
import org.example.repository.StockRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class StockService {

    @Autowired
    private StockRepository stockRepository;

    public List<Stock> getStocksEnAlerte() {
        Calendar calendar = Calendar.getInstance();
        calendar.add(Calendar.DAY_OF_MONTH, 7);
        Date thresholdDate = calendar.getTime();

        return stockRepository.findAll().stream()
                .filter(stock -> {
                    Calendar peremption = Calendar.getInstance();
                    peremption.setTime(stock.getDateCreation());
                    peremption.add(Calendar.DAY_OF_MONTH, stock.getNombreJourConservation());
                    return !peremption.getTime().after(thresholdDate);
                })
                .collect(Collectors.toList());
    }

    public List<Stock> getStocksEnAlerteQuantite(double quantiteReference) {
        double seuil = 0.1 * quantiteReference;
        return stockRepository.findAll().stream()
                .filter(stock -> stock.getQuantiteStock() <= seuil)
                .collect(Collectors.toList());
    }

    public double getTotalQuantiteStock(List<Stock> stocks) {
        return stocks.stream()
                .mapToDouble(Stock::getQuantiteStock)
                .sum();
    }
}