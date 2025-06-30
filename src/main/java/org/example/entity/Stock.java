package org.example.entity;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "stock")
public class Stock {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_composant", nullable = false)
    private Composant composant;

    @Column(name = "date_creation")
    private LocalDate dateCreation;

    @Column(name = "qtte_stock")
    private Double qtteStock;

    @Column(name = "nombre_jour_conservation")
    private Integer nombreJourConservation;

    // Getters and Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Composant getComposant() {
        return composant;
    }

    public void setComposant(Composant composant) {
        this.composant = composant;
    }

    public LocalDate getDateCreation() {
        return dateCreation;
    }

    public void setDateCreation(LocalDate dateCreation) {
        this.dateCreation = dateCreation;
    }

    public Double getQtteStock() {
        return qtteStock;
    }

    public void setQtteStock(Double qtteStock) {
        this.qtteStock = qtteStock;
    }

    public Integer getNombreJourConservation() {
        return nombreJourConservation;
    }

    public void setNombreJourConservation(Integer nombreJourConservation) {
        this.nombreJourConservation = nombreJourConservation;
    }
}