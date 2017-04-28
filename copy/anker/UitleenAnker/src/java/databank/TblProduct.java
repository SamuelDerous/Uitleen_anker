/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package databank;

import java.io.Serializable;
import java.util.Collection;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author zenodotus
 */
@Entity
@Table(name = "tblProduct")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TblProduct.findAll", query = "SELECT t FROM TblProduct t"),
    @NamedQuery(name = "TblProduct.findById", query = "SELECT t FROM TblProduct t WHERE t.id = :id"),
    @NamedQuery(name = "TblProduct.findByNaam", query = "SELECT t FROM TblProduct t WHERE t.naam = :naam"),
    @NamedQuery(name = "TblProduct.findByAankoopprijs", query = "SELECT t FROM TblProduct t WHERE t.aankoopprijs = :aankoopprijs"),
    @NamedQuery(name = "TblProduct.findByBreukprijs", query = "SELECT t FROM TblProduct t WHERE t.breukprijs = :breukprijs"),
    @NamedQuery(name = "TblProduct.findByAantal", query = "SELECT t FROM TblProduct t WHERE t.aantal = :aantal"),
    @NamedQuery(name = "TblProduct.findByBeschrijving", query = "SELECT t FROM TblProduct t WHERE t.beschrijving = :beschrijving")})
public class TblProduct implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Column(name = "naam")
    private String naam;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "aankoopprijs")
    private Double aankoopprijs;
    @Column(name = "breukprijs")
    private Double breukprijs;
    @Column(name = "aantal")
    private Integer aantal;
    @Column(name = "beschrijving")
    private String beschrijving;
    @Lob
    @Column(name = "opmerking")
    private String opmerking;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "product")
    private Collection<TblInventarisatie> tblInventarisatieCollection;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "spel")
    private Collection<TblUitleen> tblUitleenCollection;

    public TblProduct() {
    }

    public TblProduct(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNaam() {
        return naam;
    }

    public void setNaam(String naam) {
        this.naam = naam;
    }

    public Double getAankoopprijs() {
        return aankoopprijs;
    }

    public void setAankoopprijs(Double aankoopprijs) {
        this.aankoopprijs = aankoopprijs;
    }

    public Double getBreukprijs() {
        return breukprijs;
    }

    public void setBreukprijs(Double breukprijs) {
        this.breukprijs = breukprijs;
    }

    public Integer getAantal() {
        return aantal;
    }

    public void setAantal(Integer aantal) {
        this.aantal = aantal;
    }

    public String getBeschrijving() {
        return beschrijving;
    }

    public void setBeschrijving(String beschrijving) {
        this.beschrijving = beschrijving;
    }

    public String getOpmerking() {
        return opmerking;
    }

    public void setOpmerking(String opmerking) {
        this.opmerking = opmerking;
    }

    @XmlTransient
    public Collection<TblInventarisatie> getTblInventarisatieCollection() {
        return tblInventarisatieCollection;
    }

    public void setTblInventarisatieCollection(Collection<TblInventarisatie> tblInventarisatieCollection) {
        this.tblInventarisatieCollection = tblInventarisatieCollection;
    }

    @XmlTransient
    public Collection<TblUitleen> getTblUitleenCollection() {
        return tblUitleenCollection;
    }

    public void setTblUitleenCollection(Collection<TblUitleen> tblUitleenCollection) {
        this.tblUitleenCollection = tblUitleenCollection;
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
        if (!(object instanceof TblProduct)) {
            return false;
        }
        TblProduct other = (TblProduct) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "databank.TblProduct[ id=" + id + " ]";
    }
    
}
