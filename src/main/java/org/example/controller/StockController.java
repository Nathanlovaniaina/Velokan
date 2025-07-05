package org.example.controller;

import org.example.entity.Stock;
import org.example.service.StockService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/stock")
public class StockController {

    @Autowired
    private StockService stockService;

    @GetMapping("/")
    public String getStocksEnAlerte(Model model) {
        List<Stock> stocksConservation = stockService.getStocksEnAlerte();
        List<Stock> stocksQuantite = stockService.getStocksEnAlerteQuantite(100.0);
        double totalQuantiteConservation = stockService.getTotalQuantiteStock(stocksConservation);
        double totalQuantiteQuantite = stockService.getTotalQuantiteStock(stocksQuantite);

        model.addAttribute("stocksConservation", stocksConservation);
        model.addAttribute("stocksQuantite", stocksQuantite);
        model.addAttribute("totalQuantiteConservation", totalQuantiteConservation);
        model.addAttribute("totalQuantiteQuantite", totalQuantiteQuantite);
        model.addAttribute("currentDate", new SimpleDateFormat("dd/MM/yyyy").format(new Date()));

        return "listeStockAlerte";
    }
}