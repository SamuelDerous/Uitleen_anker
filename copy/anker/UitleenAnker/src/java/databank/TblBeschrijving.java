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
@Table(name = "tblBeschrijving")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TblBeschrijving.findAll", query = "SELECT t FROM TblBeschrijving t"),
    @NamedQuery(name = "TblBeschrijving.findBySoort", query = "SELECT t FROM TblBeschrijving t WHERE t.soort = :soort")})
public class TblBeschrijving implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @Column(name = "soort")
    private String soort;

    public TblBeschrijving() {
    }

    public TblBeschrijving(String soort) {
        this.soort = soort;
    }

    public String getSoort() {
        return soort;
    }

    public void setSoort(String soort) {
        this.soort = soort;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (soort != null ? soort.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TblBeschrijving)) {
            return false;
        }
        TblBeschrijving other = (TblBeschrijving) object;
        if ((this.soort == null && other.soort != null) || (this.soort != null && !this.soort.equals(other.soort))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "databank.TblBeschrijving[ soort=" + soort + " ]";
    }
    
}
