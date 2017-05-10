/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package databank;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author zenodotus
 */
@Entity
@Table(name = "tblPersoon")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TblPersoon.findAll", query = "SELECT t FROM TblPersoon t"),
    @NamedQuery(name = "TblPersoon.findById", query = "SELECT t FROM TblPersoon t WHERE t.id = :id"),
    @NamedQuery(name = "TblPersoon.findByGebruikersnaam", query = "SELECT t FROM TblPersoon t WHERE t.gebruikersnaam = :gebruikersnaam"),
    @NamedQuery(name = "TblPersoon.findByNaam", query = "SELECT t FROM TblPersoon t WHERE t.naam = :naam"),
    @NamedQuery(name = "TblPersoon.findByVoornaam", query = "SELECT t FROM TblPersoon t WHERE t.voornaam = :voornaam"),
    @NamedQuery(name = "TblPersoon.findByAdres", query = "SELECT t FROM TblPersoon t WHERE t.adres = :adres"),
    @NamedQuery(name = "TblPersoon.findByTelefoon", query = "SELECT t FROM TblPersoon t WHERE t.telefoon = :telefoon"),
    @NamedQuery(name = "TblPersoon.findByEMail", query = "SELECT t FROM TblPersoon t WHERE t.eMail = :eMail"),
    @NamedQuery(name = "TblPersoon.findByWachtwoord", query = "SELECT t FROM TblPersoon t WHERE t.wachtwoord = :wachtwoord")})
public class TblPersoon implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @Column(name = "Gebruikersnaam")
    private String gebruikersnaam;
    @Column(name = "naam")
    private String naam;
    @Column(name = "voornaam")
    private String voornaam;
    @Column(name = "adres")
    private String adres;
    @Column(name = "telefoon")
    private String telefoon;
    @Column(name = "eMail")
    private String eMail;
    @Column(name = "wachtwoord")
    private String wachtwoord;

    public TblPersoon() {
    }

    public TblPersoon(Integer id) {
        this.id = id;
    }

    public TblPersoon(Integer id, String gebruikersnaam) {
        this.id = id;
        this.gebruikersnaam = gebruikersnaam;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getGebruikersnaam() {
        return gebruikersnaam;
    }

    public void setGebruikersnaam(String gebruikersnaam) {
        this.gebruikersnaam = gebruikersnaam;
    }

    public String getNaam() {
        return naam;
    }

    public void setNaam(String naam) {
        this.naam = naam;
    }

    public String getVoornaam() {
        return voornaam;
    }

    public void setVoornaam(String voornaam) {
        this.voornaam = voornaam;
    }

    public String getAdres() {
        return adres;
    }

    public void setAdres(String adres) {
        this.adres = adres;
    }

    public String getTelefoon() {
        return telefoon;
    }

    public void setTelefoon(String telefoon) {
        this.telefoon = telefoon;
    }

    public String getEMail() {
        return eMail;
    }

    public void setEMail(String eMail) {
        this.eMail = eMail;
    }

    public String getWachtwoord() {
        return wachtwoord;
    }

    public void setWachtwoord(String wachtwoord) {
        this.wachtwoord = wachtwoord;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TblPersoon)) {
            return false;
        }
        TblPersoon other = (TblPersoon) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "databank.TblPersoon[ id=" + id + " ]";
    }
    
}
