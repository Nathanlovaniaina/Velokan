package org.example.controller;

import org.example.entity.Entreprise;
import org.example.entity.Plat;
import org.example.service.CommandeService;
import org.example.service.EntrepriseService;
import org.example.service.PlatService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import javax.transaction.Transactional;
import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/commande")
public class CommandeControleur {

    private final EntrepriseService entrepriseService;
    private final PlatService platService;
    private final CommandeService commandeService;

    public CommandeControleur(EntrepriseService entrepriseService, PlatService platService, CommandeService commandeService) {
        this.entrepriseService = entrepriseService;
        this.platService = platService;
        this.commandeService = commandeService;
    }

    @GetMapping("/form")
    @Transactional
    public String getForm(Model model, HttpSession session) {
        model.addAttribute("entreprises", entrepriseService.findAll());
        // Gestion d'un éventuel message d'erreur en session
        String error = (String) session.getAttribute("error");
        if (error != null) {
            model.addAttribute("error", error);
            session.removeAttribute("error");
        }
        return "Commande/form";
    }

    @GetMapping("/api/getPlat")
    @ResponseBody 
    public List<Plat> getAllPlats() {
        return platService.findAll();
    }

   @PostMapping("/CreerCommande")
    public String creerCommande(
            @RequestParam("idEntreprise") Long idEntreprise,
            @RequestParam("dateLivraison") @DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm") LocalDateTime dateLivraison,
            @RequestParam Map<String, String> allParams,
            @RequestParam(value = "commentaires", required = false) String commentaires,
            HttpSession session) {

        // Validation
        if (idEntreprise == null || dateLivraison == null) {
            session.setAttribute("error", "Les champs obligatoires sont manquants");
            return "redirect:/commande/form";
        }

        // Extraction des plats
        List<Map<String, String>> platsCommandes = new ArrayList<>();
        int platCount = 0;
        int prixTotal = 0;
        List<Plat> listPlats = platService.findAll();
        while (allParams.containsKey("plats[" + platCount + "].id")) {
            Map<String, String> plat = new HashMap<>();
            String platIdStr = allParams.get("plats[" + platCount + "].id");
            String quantiteStr = allParams.get("plats[" + platCount + "].quantite");
            plat.put("id", platIdStr);
            plat.put("nom", allParams.get("plats[" + platCount + "].nom"));
            plat.put("quantite", quantiteStr);
            if (platIdStr != null) {
                platsCommandes.add(plat);
                for (Plat plat2 : listPlats) {
                    if (plat2.getId().toString().equalsIgnoreCase(platIdStr)) {        
                        prixTotal += plat2.getPrix() * Integer.parseInt(quantiteStr);
                        System.out.println("Prix unitaire du plat est:"+plat2.getPrix());
                        break;
                    }
                }
                platCount++;
            }
            
        }

        // Récupération complète de l'entreprise
        Entreprise entreprise = entrepriseService.findById(Integer.parseInt(idEntreprise.toString()))
                .orElseThrow(() -> new IllegalArgumentException("Entreprise introuvable"));

        // Préparation des données
        Map<String, Object> commandeData = new HashMap<>();
        commandeData.put("entreprise", entreprise); // Objet complet maintenant
        commandeData.put("dateLivraison", dateLivraison.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm")));
        commandeData.put("commentaires", commentaires != null ? commentaires : "Aucun");
        commandeData.put("plats", platsCommandes);
        commandeData.put("totalPlats", platCount);

        session.setAttribute("commande", commandeData);
        session.setAttribute("prixTotal", prixTotal);
        return "redirect:/commande/confirmation";
    }

    @GetMapping("/confirmation")
    public String afficherConfirmation(HttpSession session, Model model) {
        Map<String, Object> commandeData = (Map<String, Object>) session.getAttribute("commande");
        int prixTotal = (int) session.getAttribute("prixTotal");
        System.out.println("Le prix total est :"+prixTotal);

        if (commandeData == null) {
            return "redirect:/commande/form";
        }

        model.addAllAttributes(commandeData); // Transfert vers le modèle
        return "Commande/confirmation";
    }

    @GetMapping("/insert")
    public String insertionCommande(HttpSession session, Model model) {
        Map<String, Object> commandeData = (Map<String, Object>) session.getAttribute("commande");
        Integer prixTotal = (Integer) session.getAttribute("prixTotal");

        if (commandeData == null || prixTotal == null) {
            session.setAttribute("error", "Aucune commande à valider.");
            return "redirect:/commande/form";
        }

        try {
            // Extraction des données nécessaires
            Entreprise entreprise = (Entreprise) commandeData.get("entreprise");
            String dateLivraisonStr = (String) commandeData.get("dateLivraison");
            @SuppressWarnings("unchecked")
            List<Map<String, String>> platsCommandes = (List<Map<String, String>>) commandeData.get("plats");
            String commentaires = (String) commandeData.get("commentaires");
        
            // Conversion de la date
            LocalDateTime dateLivraison = LocalDateTime.parse(dateLivraisonStr, java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
        
            // Appel du service avec les vraies valeurs
            commandeService.creerCommande(
                entreprise.getId().longValue(),
                dateLivraison,
                platsCommandes,
                commentaires,
                prixTotal
            );
            session.removeAttribute("commande");
            model.addAllAttributes(commandeData); 
            return "Commande/confirmation";
        } catch (Exception e) {
            session.setAttribute("error", "Erreur lors de la validation de la commande : " + e.getMessage());
            return "redirect:/commande/confirmation";
        }
    }
}