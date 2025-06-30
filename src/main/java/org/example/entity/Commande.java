package org.example.entity;

import javax.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "commandes")
public class Commande {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_entreprise", nullable = false)
    private Entreprise entreprise;

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

    public Entreprise getEntreprise() {
        return entreprise;
    }

    public void setEntreprise(Entreprise entreprise) {
        this.entreprise = entreprise;
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