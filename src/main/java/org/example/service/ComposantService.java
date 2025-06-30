package org.example.service;

import org.example.entity.Composant;
import org.example.repository.ComposantRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ComposantService {

    private final ComposantRepository composantRepository;

    public ComposantService(ComposantRepository composantRepository) {
        this.composantRepository = composantRepository;
    }

    public List<Composant> findAll() {
        return composantRepository.findAll();
    }

    public Optional<Composant> findById(Integer id) {
        return composantRepository.findById(id);
    }

    public Composant saveOrUpdate(Composant composant) {
        return composantRepository.save(composant);
    }

    public void delete(Integer id) {
        composantRepository.deleteById(id);
    }
}