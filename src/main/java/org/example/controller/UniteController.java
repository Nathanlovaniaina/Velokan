package org.example.controller;

import org.example.entity.Unite;
import org.example.service.UniteService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/unite")
public class UniteController {

    private final UniteService uniteService;

    public UniteController(UniteService uniteService) {
        this.uniteService = uniteService;
    }

    @GetMapping("/")
    public String afficherUnites(Model model) {
        model.addAttribute("unites", uniteService.findAll());
        model.addAttribute("unite", new Unite());
        return "unite";
    }

    @GetMapping("/edit")
    public String editerUnite(@RequestParam("id") Integer id, Model model) {
        Unite unite = uniteService.findById(id).orElse(new Unite());
        model.addAttribute("unite", unite);
        model.addAttribute("unites", uniteService.findAll());
        return "unite";
    }

    @PostMapping("/save")
    public String enregistrerUnite(
            @RequestParam(value = "id", required = false) Integer id,
            @RequestParam("nom") String nom,
            @RequestParam("symbol") String symbol,
            Model model) {
        Unite unite = (id != null) ? uniteService.findById(id).orElse(new Unite()) : new Unite();
        unite.setNom(nom);
        unite.setSymbol(symbol);
        uniteService.saveOrUpdate(unite);

        model.addAttribute("succes", "Unité enregistrée avec succès");
        model.addAttribute("unites", uniteService.findAll());
        model.addAttribute("unite", new Unite());
        return "unite";
    }

    @GetMapping("/delete")
    public String supprimerUnite(@RequestParam("id") Integer id, Model model) {
        uniteService.delete(id);
        model.addAttribute("succes", "Unité supprimée avec succès");
        model.addAttribute("unites", uniteService.findAll());
        model.addAttribute("unite", new Unite());
        return "unite";
    }
}