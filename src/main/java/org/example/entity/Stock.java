package org.example.entity;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;

@Entity
@Table(name = "stock")
public class Stock {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "id_composant", nullable = false)
    private Composant composant;

    @Temporal(TemporalType.DATE)
    @Column(name = "date_creation")
    private Date dateCreation;

    @Column(name = "qtte_stock")
    private Double quantiteStock;

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

    public Date getDateCreation() {
        return dateCreation;
    }

    public void setDateCreation(Date dateCreation) {
        this.dateCreation = dateCreation;
    }

    public Double getQuantiteStock() {
        return quantiteStock;
    }

    public void setQuantiteStock(Double quantiteStock) {
        this.quantiteStock = quantiteStock;
    }

    public Integer getNombreJourConservation() {
        return nombreJourConservation;
    }

    public void setNombreJourConservation(Integer nombreJourConservation) {
        this.nombreJourConservation = nombreJourConservation;
    }

    public Date getDatePeremption() {
        if (dateCreation == null || nombreJourConservation == null) {
            return null;
        }
        LocalDate localDate = dateCreation.toInstant()
                .atZone(ZoneId.systemDefault())
                .toLocalDate();
        LocalDate peremptionDate = localDate.plusDays(nombreJourConservation);
        return Date.from(peremptionDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
    }
}