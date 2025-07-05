package org.example.entity;

import javax.persistence.*;

@Entity
@Table(name = "composant")
public class Composant {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_type", nullable = false)
    private TypeComposant typeComposant;

    @Column(name = "nom")
    private String nom;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_unite", nullable = false)
    private Unite unite;

    // Getters and Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public TypeComposant getTypeComposant() {
        return typeComposant;
    }

    public void setTypeComposant(TypeComposant typeComposant) {
        this.typeComposant = typeComposant;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public Unite getUnite() {
        return unite;
    }

    public void setUnite(Unite unite) {
        this.unite = unite;
    }
}