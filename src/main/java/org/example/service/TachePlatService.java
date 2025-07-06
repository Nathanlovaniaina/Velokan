package org.example.service;

import org.example.entity.TachePlat;
import org.example.repository.TachePlatRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class TachePlatService {

    private final TachePlatRepository tachePlatRepository;

    public TachePlatService(TachePlatRepository tachePlatRepository) {
        this.tachePlatRepository = tachePlatRepository;
    }

    public TachePlat saveOrUpdate(TachePlat tachePlat) {
        return tachePlatRepository.save(tachePlat);
    }

    public List<TachePlat> findAll() {
        return tachePlatRepository.findAll();
    }

    public Optional<TachePlat> findById(Integer id) {
        return tachePlatRepository.findById(id);
    }

    @Transactional
    public void deleteById(Integer id) {
        tachePlatRepository.findById(id).ifPresent(tache -> {
            tachePlatRepository.delete(tache);
        });
    }

    public boolean existsById(Integer id) {
        return tachePlatRepository.existsById(id);
    }

    public List<TachePlat> findByPlatId(Integer platId) {
        return tachePlatRepository.findByPlatId(platId);
    }
    
}
