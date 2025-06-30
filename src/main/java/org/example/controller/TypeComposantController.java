package org.example.controller;

import org.example.entity.TypeComposant;
import org.example.service.TypeComposantService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/type-composant")
public class TypeComposantController {

    private final TypeComposantService typeComposantService;

    public TypeComposantController(TypeComposantService typeComposantService) {
        this.typeComposantService = typeComposantService;
    }

    @GetMapping("/")
    public String afficherTypesComposants(Model model) {
        model.addAttribute("typesComposants", typeComposantService.findAll());
        model.addAttribute("typeComposant", new TypeComposant());
        return "type-composant";
    }

    @GetMapping("/edit")
    public String editerTypeComposant(@RequestParam("id") Integer id, Model model) {
        TypeComposant typeComposant = typeComposantService.findById(id).orElse(new TypeComposant());
        model.addAttribute("typeComposant", typeComposant);
        model.addAttribute("typesComposants", typeComposantService.findAll());
        return "type-composant";
    }

    @PostMapping("/save")
    public String enregistrerTypeComposant(
            @RequestParam(value = "id", required = false) Integer id,
            @RequestParam("nom") String nom,
            Model model) {
        TypeComposant typeComposant = (id != null) ? typeComposantService.findById(id).orElse(new TypeComposant()) : new TypeComposant();
        typeComposant.setNom(nom);
        typeComposantService.saveOrUpdate(typeComposant);

        model.addAttribute("succes", "Type de composant enregistré avec succès");
        model.addAttribute("typesComposants", typeComposantService.findAll());
        model.addAttribute("typeComposant", new TypeComposant());
        return "type-composant";
    }

    @GetMapping("/delete")
    public String supprimerTypeComposant(@RequestParam("id") Integer id, Model model) {
        typeComposantService.delete(id);
        model.addAttribute("succes", "Type de composant supprimé avec succès");
        model.addAttribute("typesComposants", typeComposantService.findAll());
        model.addAttribute("typeComposant", new TypeComposant());
        return "type-composant";
    }
}