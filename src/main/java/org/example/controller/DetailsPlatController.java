package org.example.controller;

import org.example.entity.DetailsPlat;
import org.example.service.ComposantService;
import org.example.service.DetailsPlatService;
import org.example.service.PlatService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/details-plat")
public class DetailsPlatController {

    private final DetailsPlatService detailsPlatService;
    private final PlatService platService;
    private final ComposantService composantService;

    public DetailsPlatController(DetailsPlatService detailsPlatService, PlatService platService, ComposantService composantService) {
        this.detailsPlatService = detailsPlatService;
        this.platService = platService;
        this.composantService = composantService;
    }

    @GetMapping("/")
    public String afficherDetailsPlats(Model model) {
        model.addAttribute("detailsPlats", detailsPlatService.findAll());
        model.addAttribute("detailsPlat", new DetailsPlat());
        model.addAttribute("plats", platService.findAll());
        model.addAttribute("composants", composantService.findAll());
        return "details-plat";
    }

    @GetMapping("/edit")
    public String editerDetailsPlat(@RequestParam("id") Integer id, Model model) {
        DetailsPlat detailsPlat = detailsPlatService.findById(id).orElse(new DetailsPlat());
        model.addAttribute("detailsPlat", detailsPlat);
        model.addAttribute("detailsPlats", detailsPlatService.findAll());
        model.addAttribute("plats", platService.findAll());
        model.addAttribute("composants", composantService.findAll());
        return "details-plat";
    }

    @PostMapping("/save")
    public String enregistrerDetailsPlat(
            @RequestParam(value = "id", required = false) Integer id,
            @RequestParam("platId") Integer platId,
            @RequestParam("composantId") Integer composantId,
            @RequestParam("quantite") Double quantite,
            Model model) {
        DetailsPlat detailsPlat = (id != null) ? detailsPlatService.findById(id).orElse(new DetailsPlat()) : new DetailsPlat();
        detailsPlat.setPlat(platService.findById(platId).orElseThrow());
        detailsPlat.setComposant(composantService.findById(composantId).orElseThrow());
        detailsPlat.setQuantite(quantite);
        detailsPlatService.saveOrUpdate(detailsPlat);

        model.addAttribute("succes", "Détail du plat enregistré avec succès");
        model.addAttribute("detailsPlats", detailsPlatService.findAll());
        model.addAttribute("detailsPlat", new DetailsPlat());
        model.addAttribute("plats", platService.findAll());
        model.addAttribute("composants", composantService.findAll());
        return "details-plat";
    }

    @GetMapping("/delete")
    public String supprimerDetailsPlat(@RequestParam("id") Integer id, Model model) {
        detailsPlatService.delete(id);
        model.addAttribute("succes", "Détail du plat supprimé avec succès");
        model.addAttribute("detailsPlats", detailsPlatService.findAll());
        model.addAttribute("detailsPlat", new DetailsPlat());
        model.addAttribute("plats", platService.findAll());
        model.addAttribute("composants", composantService.findAll());
        return "details-plat";
    }
}