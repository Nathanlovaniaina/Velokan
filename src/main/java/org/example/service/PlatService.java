package org.example.service;

import org.example.entity.Plat;
import org.example.repository.PlatRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class PlatService {

    private final PlatRepository platRepository;

    public PlatService(PlatRepository platRepository) {
        this.platRepository = platRepository;
    }

    public List<Plat> findAll() {
        return platRepository.findAll();
    }

    public Optional<Plat> findById(Integer id) {
        return platRepository.findById(id);
    }

    public Plat saveOrUpdate(Plat plat) {
        if (plat.getDateCreation() == null) {
            plat.setDateCreation(LocalDate.now());
        }
        return platRepository.save(plat);
    }

    public void delete(Integer id) {
        platRepository.deleteById(id);
    }

    public List<Plat> findPlatsSinceDate(LocalDate date) {
        return platRepository.findByDateCreationGreaterThanEqual(date);
    }

    public long countPlatsSinceDate(LocalDate date) {
        return platRepository.findByDateCreationGreaterThanEqual(date).size();
    }
}