package org.example.controller;

import org.example.entity.MvtStock;
import org.example.service.ComposantService;
import org.example.service.MvtStockService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;

@Controller
@RequestMapping("/mvt-stock")
public class MvtStockController {

    private final MvtStockService mvtStockService;
    private final ComposantService composantService;

    public MvtStockController(MvtStockService mvtStockService, ComposantService composantService) {
        this.mvtStockService = mvtStockService;
        this.composantService = composantService;
    }

    @GetMapping("/")
    public String afficherMvtStocks(Model model) {
        model.addAttribute("mvtStocks", mvtStockService.findAll());
        model.addAttribute("mvtStock", new MvtStock());
        model.addAttribute("composants", composantService.findAll());
        return "mvt-stock";
    }

    @GetMapping("/edit")
    public String editerMvtStock(@RequestParam("id") Integer id, Model model) {
        MvtStock mvtStock = mvtStockService.findById(id).orElse(new MvtStock());
        model.addAttribute("mvtStock", mvtStock);
        model.addAttribute("mvtStocks", mvtStockService.findAll());
        model.addAttribute("composants", composantService.findAll());
        return "mvt-stock";
    }

    @PostMapping("/save")
    public String enregistrerMvtStock(
            @RequestParam(value = "id", required = false) Integer id,
            @RequestParam("composantId") Integer composantId,
            @RequestParam("typeMvt") Integer typeMvt,
            @RequestParam("quantite") Double quantite,
            @RequestParam("dateMvt") String dateMvt,
            @RequestParam(value = "datePeremption", required = false) String datePeremption,
            Model model) {
        MvtStock mvtStock = (id != null) ? mvtStockService.findById(id).orElse(new MvtStock()) : new MvtStock();
        mvtStock.setComposant(composantService.findById(composantId).orElseThrow());
        mvtStock.setTypeMvt(typeMvt);
        mvtStock.setQuantite(quantite);
        mvtStock.setDateMvt(LocalDate.parse(dateMvt));
        mvtStock.setDatePeremption(datePeremption != null && !datePeremption.isEmpty() ? LocalDate.parse(datePeremption) : null);
        mvtStockService.saveOrUpdate(mvtStock);

        model.addAttribute("succes", "Mouvement de stock enregistré");
        model.addAttribute("mvtStocks", mvtStockService.findAll());
        model.addAttribute("mvtStock", new MvtStock());
        model.addAttribute("composants", composantService.findAll());
        return "mvt-stock";
    }

    @GetMapping("/delete")
    public String supprimerMvtStock(@RequestParam("id") Integer id, Model model) {
        mvtStockService.delete(id);
        model.addAttribute("succes", "Mouvement de stock supprimé");
        model.addAttribute("mvtStocks", mvtStockService.findAll());
        model.addAttribute("mvtStock", new MvtStock());
        model.addAttribute("composants", composantService.findAll());
        return "mvt-stock";
    }
}