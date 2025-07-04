package org.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.example.entity.Plat;
import org.example.entity.DetailsPlat;
import org.example.entity.Stock;
import java.util.*;
import java.time.LocalDate;
import org.example.entity.DetailCommande;

@Service
public class RecommandationService {
    @Autowired
    private PlatService platService;
    @Autowired
    private DetailCommandeService detailCommandeService;
    @Autowired
    private StockService stockService;
    @Autowired
    private DetailsPlatService detailsPlatService;
    @Autowired
    private MvtStockService mvtStockService;

    public List<Map<String, Object>> recommanderPlats(String dateStr) {
        LocalDate date = LocalDate.parse(dateStr);
        List<Plat> plats = platService.findAll();
        List<DetailCommande> commandes = detailCommandeService.findAll();
        Map<Integer, Integer> popularite = new HashMap<>();
        Map<Integer, Double> peremptionScore = new HashMap<>();
        int maxCmd = 1;
        // Popularité : nombre de commandes par plat
        for (Plat plat : plats) {
            int nbCmd = 0;
            for (DetailCommande dc : commandes) {
                if (dc.getPlat() != null && dc.getPlat().getId().equals(plat.getId())) {
                    nbCmd++;
                }
            }
            popularite.put(plat.getId(), nbCmd);
            if (nbCmd > maxCmd) maxCmd = nbCmd;
        }
        // Péremption : score selon la date de péremption la plus proche des ingrédients du plat
        for (Plat plat : plats) {
            List<DetailsPlat> details = detailsPlatService.findByPlatId(plat.getId());
            double minDays = Double.MAX_VALUE;
            for (DetailsPlat dp : details) {
                Integer composantId = dp.getComposant() != null ? dp.getComposant().getId() : null;
                if (composantId != null) {
                    List<Stock> stocks = stockService.findByComposantId(composantId);
                    for (Stock stock : stocks) {
                        if (stock != null && stock.getDateCreation() != null && stock.getNombreJourConservation() != null) {
                            LocalDate datePeremption = stock.getDateCreation().plusDays(stock.getNombreJourConservation());
                            long days = java.time.temporal.ChronoUnit.DAYS.between(date, datePeremption);
                            if (days >= 0 && days < minDays) minDays = days;
                        }
                    }
                }
            }
            // Plus la date est proche, plus le score est élevé (exponentiel inversé)
            double scorePeremption = minDays == Double.MAX_VALUE ? 0 : 1.0 / (1 + minDays);
            peremptionScore.put(plat.getId(), scorePeremption);
        }
        // Calcul du score global
        List<Map<String, Object>> result = new ArrayList<>();
        for (Plat plat : plats) {
            double scorePop = (double)popularite.getOrDefault(plat.getId(), 0) / maxCmd;
            double scorePer = peremptionScore.getOrDefault(plat.getId(), 0.0);
            double score = 0.25 * scorePop + 0.85 * scorePer;
            Map<String, Object> map = new HashMap<>();
            map.put("intitule", plat.getIntitule());
            map.put("image", plat.getImage());
            map.put("score", score);
            result.add(map);
        }
        // Trier par score décroissant et retourner les 2 meilleurs
        result.sort((a, b) -> Double.compare((Double)b.get("score"), (Double)a.get("score")));
        return result.subList(0, Math.min(2, result.size()));
    }
} 