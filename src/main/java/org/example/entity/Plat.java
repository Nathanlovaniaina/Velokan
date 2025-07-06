package org.example.entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "plat")
public class Plat {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "intitule", nullable = false, length = 100)
    private String intitule;

    @Column(name = "prix", nullable = false)
    private Integer prix;

    @Temporal(TemporalType.DATE)
    @Column(name = "date_creation", nullable = false)
    private Date dateCreation;

    @Column(name = "image", length = 255)
    private String image;

    // Getters and Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getIntitule() { return intitule; }
    public void setIntitule(String intitule) { this.intitule = intitule; }

    public Integer getPrix() { return prix; }
    public void setPrix(Integer prix) { this.prix = prix; }

    public Date getDateCreation() { return dateCreation; }
    public void setDateCreation(Date dateCreation) { this.dateCreation = dateCreation; }

    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
}