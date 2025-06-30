package org.example.controller;

import org.example.entity.DetailCommande;
import org.example.service.CommandeService;
import org.example.service.DetailCommandeService;
import org.example.service.PlatService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/detail-commande")
public class DetailCommandeController {

    private final DetailCommandeService detailCommandeService;
    private final CommandeService commandeService;
    private final PlatService platService;

    public DetailCommandeController(DetailCommandeService detailCommandeService, CommandeService commandeService, PlatService platService) {
        this.detailCommandeService = detailCommandeService;
        this.commandeService = commandeService;
        this.platService = platService;
    }

    @GetMapping("/")
    public String afficherDetailsCommandes(Model model) {
        model.addAttribute("detailsCommandes", detailCommandeService.findAll());
        model.addAttribute("detailCommande", new DetailCommande());
        model.addAttribute("commandes", commandeService.findAll());
        model.addAttribute("plats", platService.findAll());
        return "detail-commande";
    }

    @GetMapping("/edit")
    public String editerDetailCommande(@RequestParam("id") Integer id, Model model) {
        DetailCommande detailCommande = detailCommandeService.findById(id).orElse(new DetailCommande());
        model.addAttribute("detailCommande", detailCommande);
        model.addAttribute("detailsCommandes", detailCommandeService.findAll());
        model.addAttribute("commandes", commandeService.findAll());
        model.addAttribute("plats", platService.findAll());
        return "detail-commande";
    }

    @PostMapping("/save")
    public String enregistrerDetailCommande(
            @RequestParam(value = "id", required = false) Integer id,
            @RequestParam("commandeId") Integer commandeId,
            @RequestParam("platId") Integer platId,
            @RequestParam("quantite") Integer quantite,
            @RequestParam("prixUnitaire") Integer prixUnitaire,
            Model model) {
        DetailCommande detailCommande = (id != null) ? detailCommandeService.findById(id).orElse(new DetailCommande()) : new DetailCommande();
        detailCommande.setCommande(commandeService.findById(commandeId).orElseThrow());
        detailCommande.setPlat(platService.findById(platId).orElseThrow());
        detailCommande.setQuantite(quantite);
        detailCommande.setPrixUnitaire(prixUnitaire);
        detailCommandeService.saveOrUpdate(detailCommande);

        model.addAttribute("succes", "Détail de commande enregistré avec succès");
        model.addAttribute("detailsCommandes", detailCommandeService.findAll());
        model.addAttribute("detailCommande", new DetailCommande());
        model.addAttribute("commandes", commandeService.findAll());
        model.addAttribute("plats", platService.findAll());
        return "detail-commande";
    }

    @GetMapping("/delete")
    public String supprimerDetailCommande(@RequestParam("id") Integer id, Model model) {
        detailCommandeService.delete(id);
        model.addAttribute("succes", "Détail de commande supprimé avec succès");
        model.addAttribute("detailsCommandes", detailCommandeService.findAll());
        model.addAttribute("detailCommande", new DetailCommande());
        model.addAttribute("commandes", commandeService.findAll());
        model.addAttribute("plats", platService.findAll());
        return "detail-commande";
    }
}