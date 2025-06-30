package org.example.entity;

import javax.persistence.*;

@Entity
@Table(name = "details_plat")
public class DetailsPlat {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_plat", nullable = false)
    private Plat plat;

    @ManyToOne
    @JoinColumn(name = "id_composant", nullable = false)
    private Composant composant;

    @Column(name = "quantite")
    private Double quantite;

    // Getters and Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Plat getPlat() {
        return plat;
    }

    public void setPlat(Plat plat) {
        this.plat = plat;
    }

    public Composant getComposant() {
        return composant;
    }

    public void setComposant(Composant composant) {
        this.composant = composant;
    }

    public Double getQuantite() {
        return quantite;
    }

    public void setQuantite(Double quantite) {
        this.quantite = quantite;
    }
}