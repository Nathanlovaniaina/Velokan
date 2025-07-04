package org.example.controller;

import org.example.entity.Composant;
import org.example.service.ComposantService;
import org.example.service.TypeComposantService;
import org.example.service.UniteService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.LocalDate;

@Controller
@RequestMapping("/composant")
public class ComposantController {

    private final ComposantService composantService;
    private final TypeComposantService typeComposantService;
    private final UniteService uniteService;

    public ComposantController(ComposantService composantService, TypeComposantService typeComposantService, UniteService uniteService) {
        this.composantService = composantService;
        this.typeComposantService = typeComposantService;
        this.uniteService = uniteService;
    }

    @GetMapping("/")
    public String afficherComposants(Model model) {
        model.addAttribute("composants", composantService.findAll());
        model.addAttribute("composant", new Composant());
        model.addAttribute("types", typeComposantService.findAll());
        model.addAttribute("unites", uniteService.findAll());
        return "composant";
    }

    @GetMapping("/edit")
    public String editerComposant(@RequestParam("id") Integer id, Model model) {
        Composant composant = composantService.findById(id).orElse(new Composant());
        model.addAttribute("composant", composant);
        model.addAttribute("composants", composantService.findAll());
        model.addAttribute("types", typeComposantService.findAll());
        model.addAttribute("unites", uniteService.findAll());
        return "composant";
    }

    @PostMapping("/save")
    public String enregistrerComposant(
            @RequestParam(value = "id", required = false) Integer id,
            @RequestParam("nom") String nom,
            @RequestParam("typeId") Integer typeId,
            @RequestParam("uniteId") Integer uniteId,
            Model model) {
        Composant composant = (id != null) ? composantService.findById(id).orElse(new Composant()) : new Composant();
        composant.setNom(nom);
        composant.setTypeComposant(typeComposantService.findById(typeId).orElseThrow());
        composant.setUnite(uniteService.findById(uniteId).orElseThrow());
        composantService.saveOrUpdate(composant);

        model.addAttribute("succes", "Composant enregistré avec succès");
        model.addAttribute("composants", composantService.findAll());
        model.addAttribute("composant", new Composant());
        model.addAttribute("types", typeComposantService.findAll());
        model.addAttribute("unites", uniteService.findAll());
        return "composant";
    }

    @GetMapping("/delete")
    public String supprimerComposant(@RequestParam("id") Integer id, Model model) {
        composantService.delete(id);
        model.addAttribute("succes", "Composant supprimé avec succès");
        model.addAttribute("composants", composantService.findAll());
        model.addAttribute("composant", new Composant());
        model.addAttribute("types", typeComposantService.findAll());
        model.addAttribute("unites", uniteService.findAll());
        return "composant";
    }

    @GetMapping("/most-used")
    public String afficherComposantsPlusUtilises(
            @RequestParam(value = "dateDebut", required = false) String dateDebut,
            @RequestParam(value = "dateFin", required = false) String dateFin,
            @RequestParam(value = "typeId", required = false) Integer typeId,
            Model model) {
        LocalDate debutDate = dateDebut != null && !dateDebut.isEmpty() ? LocalDate.parse(dateDebut) : LocalDate.now().minusDays(30);
        LocalDate finDate = dateFin != null && !dateFin.isEmpty() ? LocalDate.parse(dateFin) : LocalDate.now();
        java.time.LocalDateTime debut = debutDate.atStartOfDay();
        java.time.LocalDateTime fin = finDate.atTime(23,59,59);

        model.addAttribute("composantUsages", composantService.findMostUsedComposants(debut, fin, typeId));
        model.addAttribute("types", typeComposantService.findAll());
        model.addAttribute("selectedDateDebut", dateDebut);
        model.addAttribute("selectedDateFin", dateFin);
        model.addAttribute("selectedTypeId", typeId);
        return "composant-most-used";
    }
}