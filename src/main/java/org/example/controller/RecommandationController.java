package org.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.*;
import java.util.Map;
import java.util.List;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.TreeMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.example.service.RecommandationService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.example.service.PublicationPlatService;
import org.example.entity.PublicationPlat;
import org.example.entity.Plat;
import java.time.LocalDate;
import javax.servlet.http.HttpServletResponse;
import com.lowagie.text.*;
import com.lowagie.text.pdf.PdfWriter;
import com.lowagie.text.pdf.PdfPTable;

@Controller
public class RecommandationController {
    @Autowired
    private RecommandationService recommandationService;
    @Autowired
    private PublicationPlatService publicationPlatService;
    @Autowired
    private org.example.service.PlatService platService;

    @GetMapping(value = "/api/recommandation", produces = "application/json")
    @ResponseBody
    public Map<String, Object> getRecommandations(@RequestParam("date") String date) {
        Map<String, Object> result = new HashMap<>();
        result.put("plats", recommandationService.recommanderPlats(date));
        return result;
    }

    @PostMapping(value = "/api/publication_plat", consumes = "application/json")
    @ResponseBody
    public Map<String, Object> publierPlats(@RequestBody Map<String, Object> payload) {
        String dateStr = (String) payload.get("date");
        java.util.List<Integer> platIds = (java.util.List<Integer>) payload.get("plats");
        LocalDate date = LocalDate.parse(dateStr);
        boolean ok = true;
        for (Integer platId : platIds) {
            Plat plat = platService.findById(platId).orElse(null);
            if (plat != null) {
                PublicationPlat pub = new PublicationPlat();
                pub.setPlat(plat);
                pub.setDatePublication(date);
                publicationPlatService.save(pub);
            } else {
                ok = false;
            }
        }
        Map<String, Object> result = new HashMap<>();
        result.put("success", ok);
        return result;
    }

    @GetMapping(value = "/api/publications", produces = "application/json")
    @ResponseBody
    public java.util.List<Map<String, Object>> getPublications(
        @RequestParam("start") String start,
        @RequestParam("end") String end
    ) {
        java.time.LocalDate startDate = java.time.LocalDate.parse(start);
        java.time.LocalDate endDate = java.time.LocalDate.parse(end);
        java.util.List<org.example.entity.PublicationPlat> pubs = publicationPlatService.findByDatePublicationBetween(startDate, endDate);
        java.util.List<Map<String, Object>> result = new ArrayList<>();
        for (org.example.entity.PublicationPlat pub : pubs) {
            Map<String, Object> map = new HashMap<>();
            map.put("date", pub.getDatePublication().toString());
            map.put("plat", pub.getPlat().getIntitule());
            map.put("image", pub.getPlat().getImage());
            map.put("id", pub.getPlat().getId());
            result.add(map);
        }
        return result;
    }

    @GetMapping("/api/publications/pdf")
    public void exportPublicationsPdf(@RequestParam("start") String start,
                                      @RequestParam("end") String end,
                                      HttpServletResponse response) throws Exception {
        java.time.LocalDate startDate = java.time.LocalDate.parse(start);
        java.time.LocalDate endDate = java.time.LocalDate.parse(end);
        java.util.List<org.example.entity.PublicationPlat> pubs = publicationPlatService.findByDatePublicationBetween(startDate, endDate);
        // Préparer les données groupées par date
        Map<java.time.LocalDate, java.util.List<org.example.entity.PublicationPlat>> pubsByDate = new TreeMap<>();
        for (org.example.entity.PublicationPlat pub : pubs) {
            pubsByDate.computeIfAbsent(pub.getDatePublication(), k -> new ArrayList<>()).add(pub);
        }
        // Préparer la réponse HTTP
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=publications.pdf");
        // Générer le PDF
        Document document = new Document();
        PdfWriter.getInstance(document, response.getOutputStream());
        document.open();
        document.add(new Paragraph("Publications de plats du " + start + " au " + end));
        document.add(new Paragraph(" "));
        for (Map.Entry<java.time.LocalDate, java.util.List<org.example.entity.PublicationPlat>> entry : pubsByDate.entrySet()) {
            document.add(new Paragraph("Date : " + entry.getKey()));
            PdfPTable table = new PdfPTable(2);
            table.addCell("Plat");
            table.addCell("Image (URL)");
            for (org.example.entity.PublicationPlat pub : entry.getValue()) {
                table.addCell(pub.getPlat().getIntitule());
                table.addCell(pub.getPlat().getImage() != null ? pub.getPlat().getImage() : "");
            }
            document.add(table);
            document.add(new Paragraph(" "));
        }
        document.close();
    }
} 