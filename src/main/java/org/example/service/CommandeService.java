package org.example.service;

import org.example.entity.Commande;
import org.example.repository.CommandeRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CommandeService {

    private final CommandeRepository commandeRepository;

    public CommandeService(CommandeRepository commandeRepository) {
        this.commandeRepository = commandeRepository;
    }

    public List<Commande> findAll() {
        return commandeRepository.findAll();
    }

    public Optional<Commande> findById(Integer id) {
        return commandeRepository.findById(id);
    }

    public Commande saveOrUpdate(Commande commande) {
        return commandeRepository.save(commande);
    }

    public void delete(Integer id) {
        commandeRepository.deleteById(id);
    }
}