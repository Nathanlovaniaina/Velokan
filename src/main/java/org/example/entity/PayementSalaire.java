package org.example.entity;

import javax.persistence.*;

@Entity
@Table(name = "PayementSalaire")
public class PayementSalaire {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String nom;

    private Double salaire;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "employe_id")
    private Employe employe;

    @Temporal(TemporalType.TIMESTAMP)
    private java.util.Date datePaie;

    private Double somme;

    // Getters & Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public Double getSalaire() {
        return salaire;
    }

    public void setSalaire(Double salaire) {
        this.salaire = salaire;
    }

    public Employe getEmploye() {
        return employe;
    }

    public void setEmploye(Employe employe) {
        this.employe = employe;
    }

    public java.util.Date getDatePaie() {
        return datePaie;
    }

    public void setDatePaie(java.util.Date datePaie) {
        this.datePaie = datePaie;
    }

    public Double getSomme() {
        return somme;
    }

    public void setSomme(Double somme) {
        this.somme = somme;
    }
}
