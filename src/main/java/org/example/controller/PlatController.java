package org.example.controller;

import org.example.entity.Plat;
import org.example.service.PlatService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/plat")
public class PlatController {

    private final PlatService platService;

    public PlatController(PlatService platService) {
        this.platService = platService;
    }

    @GetMapping("/")
    public String afficherPlats(Model model) {
        model.addAttribute("plats", platService.findAll());
        model.addAttribute("plat", new Plat());
        return "plat";
    }

    @GetMapping("/edit")
    public String editerPlat(@RequestParam("id") Integer id, Model model) {
        Plat plat = platService.findById(id).orElse(new Plat());
        model.addAttribute("plat", plat);
        model.addAttribute("plats", platService.findAll());
        return "plat";
    }

    @PostMapping("/save")
    public String enregistrerPlat(
            @RequestParam(value = "id", required = false) Integer id,
            @RequestParam("intitule") String intitule,
            @RequestParam("prix") Integer prix,
            Model model) {
        Plat plat = (id != null) ? platService.findById(id).orElse(new Plat()) : new Plat();
        plat.setIntitule(intitule);
        plat.setPrix(prix);
        platService.saveOrUpdate(plat);

        model.addAttribute("succes", "Plat enregistré avec succès");
        model.addAttribute("plats", platService.findAll());
        model.addAttribute("plat", new Plat());
        return "plat";
    }

    @GetMapping("/delete")
    public String supprimerPlat(@RequestParam("id") Integer id, Model model) {
        platService.delete(id);
        model.addAttribute("succes", "Plat supprimé avec succès");
        model.addAttribute("plats", platService.findAll());
        model.addAttribute("plat", new Plat());
        return "plat";
    }
}