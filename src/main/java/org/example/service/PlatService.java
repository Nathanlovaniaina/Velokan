package org.example.service;

import org.example.entity.Composant;
import org.example.entity.DetailsPlat;
import org.example.entity.Plat;
import org.example.repository.ComposantRepository;
import org.example.repository.PlatRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class PlatService {

    private final PlatRepository platRepository;
    private final ComposantRepository composantRepository;

    public PlatService(PlatRepository platRepository, ComposantRepository composantRepository) {
        this.platRepository = platRepository;
        this.composantRepository = composantRepository;
    }

    public List<Plat> findAll() {
        return platRepository.findAllWithCompositions();
    }

    public Optional<Plat> findById(Integer id) {
        return Optional.ofNullable(platRepository.findByIdWithCompositions(id));
    }

    public Plat saveOrUpdate(Plat plat, List<Integer> composantIds, List<Double> quantites) {
        if (plat == null) {
            throw new IllegalArgumentException("Le plat ne peut pas être null.");
        }
        if (plat.getDateCreation() == null) {
            plat.setDateCreation(LocalDate.now());
        }
        if (composantIds == null || quantites == null || composantIds.isEmpty() || composantIds.size() != quantites.size()) {
            throw new IllegalArgumentException("Au moins un composant avec une quantité valide est requis.");
        }
        plat.getCompositions().clear(); // Clear existing compositions
        for (int i = 0; i < composantIds.size(); i++) {
            Integer composantId = composantIds.get(i);
            Double quantite = quantites.get(i);
            if (quantite <= 0) {
                throw new IllegalArgumentException("La quantité doit être supérieure à 0 pour le composant ID: " + composantId);
            }
            Composant composant = composantRepository.findById(composantId)
                    .orElseThrow(() -> new IllegalArgumentException("Composant non trouvé: " + composantId));
            DetailsPlat detail = new DetailsPlat();
            detail.setComposant(composant);
            detail.setQuantite(quantite);
            plat.addComposition(detail);
        }
        return platRepository.save(plat);
    }

    public void delete(Integer id) {
        platRepository.deleteById(id);
    }

    public List<Plat> findPlatsSinceDate(LocalDate date) {
        return platRepository.findByDateCreationGreaterThanEqualWithCompositions(date);
    }

    public long countPlatsSinceDate(LocalDate date) {
        return platRepository.findByDateCreationGreaterThanEqualWithCompositions(date).size();
    }
}