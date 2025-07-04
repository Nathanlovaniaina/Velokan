package org.example.entity;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "plat")
public class Plat {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "intitule")
    private String intitule;

    @Column(name = "prix")
    private Integer prix;

    @Column(name = "date_creation")
    private LocalDate dateCreation;

    @Column(name = "image")
    private String image;

    @OneToMany(mappedBy = "plat", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<DetailsPlat> compositions = new ArrayList<>();

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getIntitule() {
        return intitule;
    }

    public void setIntitule(String intitule) {
        this.intitule = intitule;
    }

    public Integer getPrix() {
        return prix;
    }

    public void setPrix(Integer prix) {
        this.prix = prix;
    }

    public LocalDate getDateCreation() {
        return dateCreation;
    }

    public void setDateCreation(LocalDate dateCreation) {
        this.dateCreation = dateCreation;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public List<DetailsPlat> getCompositions() {
        return compositions;
    }

    public void setCompositions(List<DetailsPlat> compositions) {
        this.compositions = compositions;
    }

    public void addComposition(DetailsPlat detail) {
        compositions.add(detail);
        detail.setPlat(this);
    }

    public void removeComposition(DetailsPlat detail) {
        compositions.remove(detail);
        detail.setPlat(null);
    }
}