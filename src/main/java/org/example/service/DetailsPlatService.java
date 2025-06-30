package org.example.service;

import org.example.entity.DetailsPlat;
import org.example.repository.DetailsPlatRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class DetailsPlatService {

    private final DetailsPlatRepository detailsPlatRepository;

    public DetailsPlatService(DetailsPlatRepository detailsPlatRepository) {
        this.detailsPlatRepository = detailsPlatRepository;
    }

    public List<DetailsPlat> findAll() {
        return detailsPlatRepository.findAll();
    }

    public Optional<DetailsPlat> findById(Integer id) {
        return detailsPlatRepository.findById(id);
    }

    public List<DetailsPlat> findByPlatId(Integer platId) {
        return detailsPlatRepository.findByPlatId(platId);
    }

    public DetailsPlat saveOrUpdate(DetailsPlat detailsPlat) {
        return detailsPlatRepository.save(detailsPlat);
    }

    public void delete(Integer id) {
        detailsPlatRepository.deleteById(id);
    }
}