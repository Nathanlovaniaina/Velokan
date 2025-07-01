package org.example.controller;

import org.example.repository.CommandeRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.*;

@Controller
@RequestMapping("/commandes")
public class CommandeController {

    private static final Logger logger = LoggerFactory.getLogger(CommandeController.class);
    private final CommandeRepository commandeRepository;

    public CommandeController(CommandeRepository commandeRepository) {
        this.commandeRepository = commandeRepository;
    }

    @GetMapping("/count")
    public String countOrdersByDate(
            @RequestParam(value = "date", required = false) String dateStr,
            @RequestParam(value = "endDate", required = false) String endDateStr,
            Model model) {
        logger.info("countOrdersByDate called with date={} endDate={}", dateStr, endDateStr);

        if (dateStr == null || dateStr.trim().isEmpty()) {
            model.addAttribute("error", "Erreur : veuillez fournir une date de début au format AAAA‑MM‑JJ.");
            return "commandes/count";
        }

        try {
            LocalDate startDate = LocalDate.parse(dateStr, DateTimeFormatter.ISO_LOCAL_DATE);
            LocalDate endDate = (endDateStr == null || endDateStr.trim().isEmpty())
                                  ? startDate
                                  : LocalDate.parse(endDateStr, DateTimeFormatter.ISO_LOCAL_DATE);

            if (startDate.isAfter(endDate)) {
                model.addAttribute("error", "La date de début doit être antérieure ou égale à la date de fin.");
                return "commandes/count";
            }

            // Récupération des données
            List<Object[]> results = commandeRepository.countByDateRange(startDate, endDate);

            if (results.isEmpty()) {
                // Aucun résultat dans la plage → on fait un seul jour
                long count = commandeRepository.countByDate(startDate);
                model.addAttribute("date", dateStr);
                model.addAttribute("nombreCommandes", count);
                model.addAttribute("isSingleDay", true);
                return "commandes/count";
            }

            // Comptage de la veille réelle
            long previousCount = commandeRepository.countByDate(startDate.minusDays(1));

            List<Map<String, Object>> orderDataList = new ArrayList<>();
            for (Object[] row : results) {
                LocalDate d = ((java.sql.Date) row[0]).toLocalDate();
                long count = ((Number) row[1]).longValue();

                long diff = count - previousCount;
                String evolution = diff > 0 ? "A évolué" : diff < 0 ? "A diminué" : "Pas d'évolution";

                Map<String, Object> od = new LinkedHashMap<>();
                od.put("date", d.toString());
                od.put("count", count);
                od.put("evolution", evolution);
                orderDataList.add(od);

                previousCount = count;
                logger.debug("Date={}, count={}, évolution={}", d, count, evolution);
            }

            model.addAttribute("orderDataList", orderDataList);
            model.addAttribute("startDate", dateStr);
            model.addAttribute("endDate", endDateStr);
            model.addAttribute("isSingleDay", false);

        } catch (DateTimeParseException e) {
            logger.error("Format de date invalide", e);
            model.addAttribute("error", "Erreur : format de date invalide. Utilisez AAAA‑MM‑JJ.");
        } catch (Exception e) {
            logger.error("Erreur base données", e);
            model.addAttribute("error", "Erreur serveur. Veuillez réessayer.");
        }

        return "commandes/count";
    }

    @GetMapping("/chart")
    public String showOrdersChart(
            @RequestParam(value = "startDate", required = false) String startDateStr,
            @RequestParam(value = "endDate", required = false) String endDateStr,
            Model model) {
        logger.info("showOrdersChart called with startDate={} endDate={}", startDateStr, endDateStr);

        if (startDateStr == null || startDateStr.trim().isEmpty()) {
            model.addAttribute("error", "Erreur : veuillez fournir une date de début au format AAAA‑MM‑JJ.");
            return "commandes/count";
        }

        try {
            LocalDate start = LocalDate.parse(startDateStr, DateTimeFormatter.ISO_LOCAL_DATE);
            LocalDate end = (endDateStr == null || endDateStr.trim().isEmpty())
                              ? start
                              : LocalDate.parse(endDateStr, DateTimeFormatter.ISO_LOCAL_DATE);

            if (start.isAfter(end)) {
                model.addAttribute("error", "La date de début doit être antérieure ou égale à la date de fin.");
                return "commandes/count";
            }

            List<Object[]> results = commandeRepository.countByDateRange(start, end);

            if (results.isEmpty()) {
                long count = commandeRepository.countByDate(start);
                model.addAttribute("date", startDateStr);
                model.addAttribute("nombreCommandes", count);
                model.addAttribute("isSingleDay", true);
                return "commandes/count";
            }

            long previousCount = commandeRepository.countByDate(start.minusDays(1));
            List<Map<String, Object>> orderDataList = new ArrayList<>();
            for (Object[] row : results) {
                LocalDate d = ((java.sql.Date) row[0]).toLocalDate();
                long count = ((Number) row[1]).longValue();

                long diff = count - previousCount;
                String evolution = diff > 0 ? "A évolué" : diff < 0 ? "A diminué" : "Pas d'évolution";

                Map<String, Object> od = new LinkedHashMap<>();
                od.put("date", d.toString());
                od.put("count", count);
                od.put("evolution", evolution);
                orderDataList.add(od);

                previousCount = count;
                logger.debug("Date={}, count={}, évolution={}", d, count, evolution);
            }

            model.addAttribute("orderDataList", orderDataList);
            model.addAttribute("startDate", startDateStr);
            model.addAttribute("endDate", endDateStr);
            model.addAttribute("isSingleDay", false);

        } catch (DateTimeParseException e) {
            logger.error("Format de date invalide", e);
            model.addAttribute("error", "Erreur : format de date invalide. Utilisez AAAA‑MM‑JJ.");
        } catch (Exception e) {
            logger.error("Erreur base données", e);
            model.addAttribute("error", "Erreur serveur. Veuillez réessayer.");
        }

        return "commandes/count";
    }
}
