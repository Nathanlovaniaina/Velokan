package org.example.controller;

import org.example.entity.Commande;
import org.example.service.CommandeService;
import org.example.service.EntrepriseService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

@Controller
@RequestMapping("/commande")
public class CommandeController {

    private final CommandeService commandeService;
    private final EntrepriseService entrepriseService;

    public CommandeController(CommandeService commandeService, EntrepriseService entrepriseService) {
        this.commandeService = commandeService;
        this.entrepriseService = entrepriseService;
    }

    @GetMapping("/")
    public String afficherCommandes(Model model) {
        model.addAttribute("commandes", commandeService.findAll());
        model.addAttribute("commande", new Commande());
        model.addAttribute("entreprises", entrepriseService.findAll());
        return "commande";
    }

    @GetMapping("/edit")
    public String editerCommande(@RequestParam("id") Integer id, Model model) {
        Commande commande = commandeService.findById(id).orElse(new Commande());
        model.addAttribute("commande", commande);
        model.addAttribute("commandes", commandeService.findAll());
        model.addAttribute("entreprises", entrepriseService.findAll());
        return "commande";
    }

    @PostMapping("/save")
    public String enregistrerCommande(
            @RequestParam(value = "id", required = false) Integer id,
            @RequestParam("entrepriseId") Integer entrepriseId,
            @RequestParam("prixTotal") Integer prixTotal,
            @RequestParam("dateHeurePrevue") String dateHeurePrevue,
            Model model) {
        Commande commande = (id != null) ? commandeService.findById(id).orElse(new Commande()) : new Commande();
        commande.setEntreprise(entrepriseService.findById(entrepriseId).orElseThrow());
        commande.setPrixTotal(prixTotal);
        commande.setDateHeurePrevue(LocalDateTime.parse(dateHeurePrevue));
        commandeService.saveOrUpdate(commande);

        model.addAttribute("succes", "Commande enregistrée avec succès");
        model.addAttribute("commandes", commandeService.findAll());
        model.addAttribute("commande", new Commande());
        model.addAttribute("entreprises", entrepriseService.findAll());
        return "commande";
    }

    @GetMapping("/delete")
    public String supprimerCommande(@RequestParam("id") Integer id, Model model) {
        commandeService.delete(id);
        model.addAttribute("succes", "Commande supprimée avec succès");
        model.addAttribute("commandes", commandeService.findAll());
        model.addAttribute("commande", new Commande());
        model.addAttribute("entreprises", entrepriseService.findAll());
        return "commande";
    }
}