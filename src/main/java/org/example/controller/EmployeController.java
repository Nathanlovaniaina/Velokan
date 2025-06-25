package org.example.controller;

import org.example.entity.Employe;
import org.example.service.EmployeService;
import org.example.entity.PaiementSalaire;
import org.example.service.PaiementSalaireService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/employe")
public class EmployeController {

    private final EmployeService employeService;
    private final PaiementSalaireService paiementSalaireService;

    public EmployeController(EmployeService employeService, PaiementSalaireService paiementSalaireService) {
        this.employeService = employeService;
        this.paiementSalaireService = paiementSalaireService;
    }

    @GetMapping("/payement_salaire")
    public String toPayement(Model model) {
        model.addAttribute("employes", employeService.findAll());
        return "payement_salaire";
    }

    @PostMapping("/t_payement_salaire")
    public String traiterPaiement(
            @RequestParam("id_employe") Integer idEmploye,
            @RequestParam("montant") Double montant,
            Model model) {

        var employeOpt = employeService.findById(idEmploye);
        if (employeOpt.isEmpty()) {
            model.addAttribute("retour", "Employé non trouvé");
            model.addAttribute("employes", employeService.findAll());
            return "payement_salaire";
        }

        PaiementSalaire paiement = new PaiementSalaire();
        paiement.setEmploye(employeOpt.get());
        paiement.setDatePaie(new java.util.Date());
        paiement.setSomme(montant);

        paiementSalaireService.save(paiement);

        model.addAttribute("retour", "Paiement effectué avec succès");
        model.addAttribute("employes", employeService.findAll());
        return "payement_salaire";
    }
}