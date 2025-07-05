
package org.example.entity;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "entreprise")
public class Entreprise {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "nom", length = 100)
    private String nom;

    @Column(name = "adresse", length = 100)
    private String adresse;

    @Column(name = "latitude")
    private Double latitude;

    @Column(name = "longitude")
    private Double longitude;

    @Temporal(TemporalType.DATE)
    @Column(name = "debut_date_contrat")
    private Date debutDateContrat;

    // Getters and Setters
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

    public String getAdresse() {
        return adresse;
    }

    public void setAdresse(String adresse) {
        this.adresse = adresse;
    }

    public Double getLatitude() {
        return latitude;
    }

    public void setLatitude(Double latitude) {
        this.latitude = latitude;
    }

    public Double getLongitude() {
        return longitude;
    }

    public void setLongitude(Double longitude) {
        this.longitude = longitude;
    }

    public Date getDebutDateContrat() {
        return debutDateContrat;
    }

    public void setDebutDateContrat(Date debutDateContrat) {
        this.debutDateContrat = debutDateContrat;
    }
}