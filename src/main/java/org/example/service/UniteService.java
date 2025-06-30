package org.example.service;

import org.example.entity.Unite;
import org.example.repository.UniteRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UniteService {

    private final UniteRepository uniteRepository;

    public UniteService(UniteRepository uniteRepository) {
        this.uniteRepository = uniteRepository;
    }

    public List<Unite> findAll() {
        return uniteRepository.findAll();
    }

    public Optional<Unite> findById(Integer id) {
        return uniteRepository.findById(id);
    }

    public Unite saveOrUpdate(Unite unite) {
        return uniteRepository.save(unite);
    }

    public void delete(Integer id) {
        uniteRepository.deleteById(id);
    }
}