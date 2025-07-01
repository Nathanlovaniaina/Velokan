package org.example.service;

import org.example.entity.dto.ComposantUsageDTO;
import org.example.entity.Composant;
import org.example.repository.ComposantRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

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

    public List<ComposantUsageDTO> findMostUsedComposants(LocalDateTime dateDebut, LocalDateTime dateFin, Integer typeId) {
        return composantRepository.findMostUsedComposants(dateDebut, dateFin, typeId)
                .stream()
                .map(row -> new ComposantUsageDTO((String) row[0], ((Number) row[1]).doubleValue()))
                .collect(Collectors.toList());
    }
}