package org.example.entity;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "commandes")
public class Commande {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "id_entreprise", nullable = false)
    private Integer idEntreprise;

    @Column(name = "prix_total")
    private Integer prixTotal;

    @Column(name = "date_heure_prevue")
    private LocalDateTime dateHeurePrevue;

    // Getters and Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getIdEntreprise() {
        return idEntreprise;
    }

    public void setIdEntreprise(Integer idEntreprise) {
        this.idEntreprise = idEntreprise;
    }

    public Integer getPrixTotal() {
        return prixTotal;
    }

    public void setPrixTotal(Integer prixTotal) {
        this.prixTotal = prixTotal;
    }

    public LocalDateTime getDateHeurePrevue() {
        return dateHeurePrevue;
    }

    public void setDateHeurePrevue(LocalDateTime dateHeurePrevue) {
        this.dateHeurePrevue = dateHeurePrevue;
    }
}