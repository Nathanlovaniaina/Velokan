package org.example.service;

import org.example.entity.PublicationPlat;
import org.example.repository.PublicationPlatRepository;
import org.springframework.stereotype.Service;

@Service
public class PublicationPlatService {
    private final PublicationPlatRepository publicationPlatRepository;

    public PublicationPlatService(PublicationPlatRepository publicationPlatRepository) {
        this.publicationPlatRepository = publicationPlatRepository;
    }

    public PublicationPlat save(PublicationPlat publicationPlat) {
        return publicationPlatRepository.save(publicationPlat);
    }
} 