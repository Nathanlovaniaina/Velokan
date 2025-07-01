package org.example.service;

import org.example.entity.Plat;
import org.example.repository.PlatRepository;
import org.springframework.stereotype.Service;

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

    public Plat save(Plat plat) {
        return platRepository.save(plat);
    }

    public void deleteById(Integer id) {
        platRepository.deleteById(id);
    }

}