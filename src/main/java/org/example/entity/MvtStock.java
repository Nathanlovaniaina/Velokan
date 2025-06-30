package org.example.entity;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "mvt_stock")
public class MvtStock {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_composant", nullable = false)
    private Composant composant;

    @Column(name = "type_mvt")
    private Integer typeMvt;

    @Column(name = "quantite")
    private Double quantite;

    @Column(name = "date_mvt", nullable = false)
    private LocalDate dateMvt;

    @Column(name = "date_peremption")
    private LocalDate datePeremption;

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

    public Integer getTypeMvt() {
        return typeMvt;
    }

    public void setTypeMvt(Integer typeMvt) {
        this.typeMvt = typeMvt;
    }

    public Double getQuantite() {
        return quantite;
    }

    public void setQuantite(Double quantite) {
        this.quantite = quantite;
    }

    public LocalDate getDateMvt() {
        return dateMvt;
    }

    public void setDateMvt(LocalDate dateMvt) {
        this.dateMvt = dateMvt;
    }

    public LocalDate getDatePeremption() {
        return datePeremption;
    }

    public void setDatePeremption(LocalDate datePeremption) {
        this.datePeremption = datePeremption;
    }
}