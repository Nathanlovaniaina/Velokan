package org.example.controller;

import org.example.entity.Employe;
import org.example.service.EmployeService;
import org.example.entity.PayementSalaire;
import org.example.service.PayementSalaireService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/employe")
public class EmployeController {

    private final EmployeService employeService;
    private final PayementSalaireService PayementSalaireService;

    public EmployeController(EmployeService employeService, PayementSalaireService PayementSalaireService) {
        this.employeService = employeService;
        this.PayementSalaireService = PayementSalaireService;
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

        PayementSalaire Payement = new PayementSalaire();
        Payement.setEmploye(employeOpt.get());
        Payement.setDatePaie(new java.util.Date());
        Payement.setSomme(montant);

        PayementSalaireService.save(Payement);

        model.addAttribute("retour", "Payement effectué avec succès");
        model.addAttribute("employes", employeService.findAll());
        return "payement_salaire";
    }
}