/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package creatie;

import databank.TblInventarisatie;
import databank.TblPersoon;
import databank.TblProduct;
import databank.TblReservatie;
import databank.TblUitleen;
import databank.adapter.HibernateFactory;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

/**
 *
 * @author zenodotus
 */
public class Aantal {
    
        
    public int aantalUitgeleend(TblProduct product, Session session) {
        Query qryUitleningen = session.createQuery("from TblUitleen where spel = :product and (teruggebracht <> null or teruggebracht <> '')");
        qryUitleningen.setParameter("product", product);
        Query qryInventaris = session.createQuery("from TblInventarisatie where product = :product");
        qryInventaris.setParameter("product", product);
        List<TblUitleen> uitleningen = qryUitleningen.list();
        List<TblInventarisatie> inventaris = qryInventaris.list();
        int aantalUitlenen = 0;
        int aantalInvent = 0;
        for(int i = 0; i < uitleningen.size(); i++) {
            aantalUitlenen += uitleningen.get(i).getAantal();
        }
        for(int i = 0; i < inventaris.size(); i++) {
            aantalInvent += inventaris.get(i).getAantal();
        }  
        return aantalInvent + aantalUitlenen;
    }
    
    public int maxReservaties(TblProduct product, Session session) {
            Query qryReservaties = session.createQuery("from TblReservatie where product = :product");
            qryReservaties.setParameter("product", product);
            Query qryInventaris = session.createQuery("from TblInventarisatie where product = :product");
            qryInventaris.setParameter("product", product);
            List<TblReservatie> reservaties = qryReservaties.list();
            List<TblInventarisatie> inventaris = qryInventaris.list();
            int aantalUitlenen = 0;
            int aantalReservaties = 0;
            int aantalInvent = 0;
            
            for(int i = 0; i < reservaties.size(); i++) {
                aantalReservaties += reservaties.get(i).getAantal();
            }
            for(int i = 0; i < inventaris.size(); i++) {
                aantalInvent += inventaris.get(i).getAantal();
            }
            
            return aantalReservaties + aantalInvent;
    }
    public int aantalReservaties(TblProduct product, Session session) {
            Query qryReservaties = session.createQuery("from TblReservatie where product = :product");
            qryReservaties.setParameter("product", product);
            List<TblReservatie> reservaties = qryReservaties.list();
            int aantalReservaties = 0;
            
            for(int i = 0; i < reservaties.size(); i++) {
                aantalReservaties += reservaties.get(i).getAantal();
            }
            
            return aantalReservaties;
    }
    
    public int maxAantal(TblProduct product, Session session) {
        Query qryAantalProduct = session.createQuery("from TblProduct where id = :id");
        qryAantalProduct.setParameter("id", product.getId());
        Query qryAantalInvent = session.createQuery("from TblInventarisatie where product = :product");
        qryAantalInvent.setParameter("product", product);
        int aantalProduct = 0;
        int aantalInvent = 0;
        List<TblProduct> producten = qryAantalProduct.list();
        List<TblInventarisatie> invents = qryAantalInvent.list();
        for(int i = 0; i < producten.size(); i++) {
            aantalProduct += producten.get(i).getAantal();
        }
        for(int i = 0; i < invents.size(); i++) {
            aantalInvent += invents.get(i).getAantal();
        }
        
        return (aantalProduct + aantalInvent);
    }
    
}
