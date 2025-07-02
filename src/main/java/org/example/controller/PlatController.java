package org.example.controller;

import org.example.entity.Plat;
import org.example.service.ComposantService;
import org.example.service.PlatService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@Controller
@RequestMapping("/plat")
public class PlatController {

    private final PlatService platService;
    private final ComposantService composantService;

    public PlatController(PlatService platService, ComposantService composantService) {
        this.platService = platService;
        this.composantService = composantService;
    }

    @GetMapping("/")
    public String afficherPlats(Model model) {
        model.addAttribute("plats", platService.findAll());
        model.addAttribute("plat", new Plat());
        model.addAttribute("composants", composantService.findAll());
        model.addAttribute("totalPlats", platService.findAll().size());
        return "plat";
    }

    @GetMapping("/edit")
    public String editerPlat(@RequestParam("id") Integer id, Model model) {
        Plat plat = platService.findById(id).orElse(new Plat());
        model.addAttribute("plat", plat);
        model.addAttribute("composants", composantService.findAll());
        model.addAttribute("plats", platService.findAll());
        model.addAttribute("totalPlats", platService.findAll().size());
        return "plat";
    }

    @PostMapping("/save")
    public String enregistrerPlat(
            @RequestParam(value = "id", required = false) Integer id,
            @RequestParam("intitule") String intitule,
            @RequestParam("prix") Integer prix,
            @RequestParam(value = "composantIds", required = false) List<Integer> composantIds,
            @RequestParam(value = "quantites", required = false) List<Double> quantites,
            Model model) {
        try {
            Plat plat = (id != null) ? platService.findById(id).orElse(new Plat()) : new Plat();
            plat.setIntitule(intitule);
            plat.setPrix(prix);
            platService.saveOrUpdate(plat, composantIds, quantites);
            model.addAttribute("succes", "Plat enregistré avec succès");
        } catch (IllegalArgumentException e) {
            model.addAttribute("erreur", e.getMessage());
        } catch (Exception e) {
            model.addAttribute("erreur", "Erreur inattendue lors de l'enregistrement.");
        }
        model.addAttribute("plats", platService.findAll());
        model.addAttribute("plat", new Plat());
        model.addAttribute("composants", composantService.findAll());
        model.addAttribute("totalPlats", platService.findAll().size());
        return "plat";
    }

    @GetMapping("/delete")
    public String supprimerPlat(@RequestParam("id") Integer id, Model model) {
        try {
            platService.delete(id);
            model.addAttribute("succes", "Plat supprimé avec succès");
        } catch (Exception e) {
            model.addAttribute("erreur", "Erreur lors de la suppression : " + e.getMessage());
        }
        model.addAttribute("plats", platService.findAll());
        model.addAttribute("plat", new Plat());
        model.addAttribute("composants", composantService.findAll());
        model.addAttribute("totalPlats", platService.findAll().size());
        return "plat";
    }

    @GetMapping("/since-date")
    public String afficherPlatsDepuisDate(@RequestParam(value = "date", required = false) String date, Model model) {
        if (date != null && !date.isEmpty()) {
            LocalDate localDate = LocalDate.parse(date);
            List<Plat> plats = platService.findPlatsSinceDate(localDate);
            model.addAttribute("plats", plats);
            model.addAttribute("totalPlats", plats.size());
            model.addAttribute("selectedDate", date);
        } else {
            model.addAttribute("plats", platService.findAll());
            model.addAttribute("totalPlats", platService.findAll().size());
        }
        model.addAttribute("plat", new Plat());
        model.addAttribute("composants", composantService.findAll());
        return "plat";
    }
}