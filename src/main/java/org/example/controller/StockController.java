package org.example.controller;

import org.example.entity.Stock;
import org.example.service.ComposantService;
import org.example.service.StockService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;

@Controller
@RequestMapping("/stock")
public class StockController {

    private final StockService stockService;
    private final ComposantService composantService;

    public StockController(StockService stockService, ComposantService composantService) {
        this.stockService = stockService;
        this.composantService = composantService;
    }

    @GetMapping("/")
    public String afficherStocks(Model model) {
        model.addAttribute("stocks", stockService.findAll());
        model.addAttribute("stock", new Stock());
        model.addAttribute("composants", composantService.findAll());
        return "stock";
    }

    @GetMapping("/edit")
    public String editerStock(@RequestParam("id") Integer id, Model model) {
        Stock stock = stockService.findById(id).orElse(new Stock());
        model.addAttribute("stock", stock);
        model.addAttribute("stocks", stockService.findAll());
        model.addAttribute("composants", composantService.findAll());
        return "stock";
    }

    @PostMapping("/save")
    public String enregistrerStock(
            @RequestParam(value = "id", required = false) Integer id,
            @RequestParam("composantId") Integer composantId,
            @RequestParam("dateCreation") String dateCreation,
            @RequestParam("qtteStock") Double qtteStock,
            @RequestParam("nombreJourConservation") Integer nombreJourConservation,
            Model model) {
        Stock stock = (id != null) ? stockService.findById(id).orElse(new Stock()) : new Stock();
        stock.setComposant(composantService.findById(composantId).orElseThrow());
        stock.setDateCreation(LocalDate.parse(dateCreation));
        stock.setQtteStock(qtteStock);
        stock.setNombreJourConservation(nombreJourConservation);
        stockService.saveOrUpdate(stock);

        model.addAttribute("succes", "Stock enregistré avec succès");
        model.addAttribute("stocks", stockService.findAll());
        model.addAttribute("stock", new Stock());
        model.addAttribute("composants", composantService.findAll());
        return "stock";
    }

    @GetMapping("/delete")
    public String supprimerStock(@RequestParam("id") Integer id, Model model) {
        stockService.delete(id);
        model.addAttribute("succes", "Stock supprimé avec succès");
        model.addAttribute("stocks", stockService.findAll());
        model.addAttribute("stock", new Stock());
        model.addAttribute("composants", composantService.findAll());
        return "stock";
    }
}