package org.example.controller;

import org.example.entity.Entreprise;
import org.example.service.EntrepriseService;
import org.locationtech.jts.geom.Coordinate;
import org.locationtech.jts.geom.GeometryFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;

@Controller
@RequestMapping("/entreprise")
public class EntrepriseController {

    private final EntrepriseService entrepriseService;
    private final GeometryFactory geometryFactory;

    public EntrepriseController(EntrepriseService entrepriseService) {
        this.entrepriseService = entrepriseService;
        this.geometryFactory = new GeometryFactory();
    }

    @GetMapping("/")
    public String afficherEntreprises(Model model) {
        model.addAttribute("entreprises", entrepriseService.findAll());
        model.addAttribute("entreprise", new Entreprise());
        return "entreprise";
    }

    @GetMapping("/edit")
    public String editerEntreprise(@RequestParam("id") Integer id, Model model) {
        Entreprise entreprise = entrepriseService.findById(id).orElse(new Entreprise());
        model.addAttribute("entreprise", entreprise);
        model.addAttribute("entreprises", entrepriseService.findAll());
        return "entreprise";
    }

    @PostMapping("/save")
    public String enregistrerEntreprise(
            @RequestParam(value = "id", required = false) Integer id,
            @RequestParam("nom") String nom,
            @RequestParam("adresse") String adresse,
            @RequestParam("latitude") Double latitude,
            @RequestParam("longitude") Double longitude,
            @RequestParam("debutDateContrat") String debutDateContrat,
            Model model) {
        try {
            Entreprise entreprise = (id != null) ? entrepriseService.findById(id).orElse(new Entreprise()) : new Entreprise();
            entreprise.setNom(nom);
            entreprise.setAdresse(adresse);
            entreprise.setLatitude(latitude);
            entreprise.setLongitude(longitude);
            // Créer un point géométrique à partir de latitude et longitude
            entreprise.setGeom(geometryFactory.createPoint(new Coordinate(longitude, latitude)));
            entreprise.setDebutDateContrat(LocalDate.parse(debutDateContrat));
            entrepriseService.saveOrUpdate(entreprise);

            model.addAttribute("succes", "Entreprise enregistrée avec succès");
        } catch (Exception e) {
            model.addAttribute("erreur", "Erreur lors de l'enregistrement : " + e.getMessage());
        }

        model.addAttribute("entreprises", entrepriseService.findAll());
        model.addAttribute("entreprise", new Entreprise());
        return "entreprise";
    }

    @GetMapping("/delete")
    public String supprimerEntreprise(@RequestParam("id") Integer id, Model model) {
        try {
            entrepriseService.delete(id);
            model.addAttribute("succes", "Entreprise supprimée avec succès");
        } catch (Exception e) {
            model.addAttribute("erreur", "Erreur lors de la suppression : " + e.getMessage());
        }

        model.addAttribute("entreprises", entrepriseService.findAll());
        model.addAttribute("entreprise", new Entreprise());
        return "entreprise";
    }
}