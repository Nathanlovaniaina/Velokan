package org.example.service;

import org.example.entity.PayementSalaire;
import org.example.repository.PayementSalaireRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PayementSalaireService {

    private final PayementSalaireRepository PayementSalaireRepository;

    public PayementSalaireService(PayementSalaireRepository PayementSalaireRepository) {
        this.PayementSalaireRepository = PayementSalaireRepository;
    }

    // Sauvegarde un Payement de salaire
    public PayementSalaire save(PayementSalaire Payement) {
        return PayementSalaireRepository.save(Payement);
    }

    // Liste tous les paiements
    public List<PayementSalaire> findAll() {
        return PayementSalaireRepository.findAll();
    }

    // Recherche par id (optionnel)
    public PayementSalaire findById(Integer id) {
        return PayementSalaireRepository.findById(id).orElse(null);
    }
}
