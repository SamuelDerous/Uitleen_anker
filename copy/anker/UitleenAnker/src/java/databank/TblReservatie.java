/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package databank;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author zenodotus
 */
@Entity
@Table(name = "tblReservatie")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TblReservatie.findAll", query = "SELECT t FROM TblReservatie t"),
    @NamedQuery(name = "TblReservatie.findById", query = "SELECT t FROM TblReservatie t WHERE t.id = :id"),
    @NamedQuery(name = "TblReservatie.findByProduct", query = "SELECT t FROM TblReservatie t WHERE t.product = :product"),
    @NamedQuery(name = "TblReservatie.findByReservatieDatum", query = "SELECT t FROM TblReservatie t WHERE t.reservatieDatum = :reservatieDatum"),
    @NamedQuery(name = "TblReservatie.findByOphaalDatum", query = "SELECT t FROM TblReservatie t WHERE t.ophaalDatum = :ophaalDatum")})
public class TblReservatie implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Column(name = "product")
    private Integer product;
    @Column(name = "reservatieDatum")
    @Temporal(TemporalType.DATE)
    private Date reservatieDatum;
    @Column(name = "ophaalDatum")
    @Temporal(TemporalType.DATE)
    private Date ophaalDatum;
    @JoinColumn(name = "id", referencedColumnName = "id", insertable = false, updatable = false)
    @OneToOne(optional = false)
    private TblProduct tblProduct;

    public TblReservatie() {
    }

    public TblReservatie(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getProduct() {
        return product;
    }

    public void setProduct(Integer product) {
        this.product = product;
    }

    public Date getReservatieDatum() {
        return reservatieDatum;
    }

    public void setReservatieDatum(Date reservatieDatum) {
        this.reservatieDatum = reservatieDatum;
    }

    public Date getOphaalDatum() {
        return ophaalDatum;
    }

    public void setOphaalDatum(Date ophaalDatum) {
        this.ophaalDatum = ophaalDatum;
    }

    public TblProduct getTblProduct() {
        return tblProduct;
    }

    public void setTblProduct(TblProduct tblProduct) {
        this.tblProduct = tblProduct;
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
        if (!(object instanceof TblReservatie)) {
            return false;
        }
        TblReservatie other = (TblReservatie) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "databank.TblReservatie[ id=" + id + " ]";
    }
    
}
