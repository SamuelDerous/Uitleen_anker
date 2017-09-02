/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package databank.dao;

import databank.TblPersoon;
import databank.TblProduct;
import databank.TblUitleen;
import databank.adapter.HibernateFactory;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

/**
 *
 * @author zenodotus
 */
public class UitleenDao {
    private Session session;
    
    public UitleenDao() {
        SessionFactory factory = HibernateFactory.getSessionFactory();
        session = factory.openSession();
            
    }
    
    public List<TblUitleen> getActieveUitleningen(TblProduct product) {
        Query qryUitleningen = session.createQuery("from TblUitleen where spel = :product and (teruggebracht <> null or teruggebracht <> '')");
        qryUitleningen.setParameter("product", product);
        return qryUitleningen.list();
    }
    
    public List<TblUitleen> getActieveUitleningen() {
        Query qryUitleningen = session.createQuery("from TblUitleen where (teruggebracht <> null or teruggebracht <> '')");
        
        return qryUitleningen.list();
    }
    
    
    public void toevoegenUitleen(TblUitleen uitleen) {
        session.beginTransaction();
        session.save(uitleen);
        session.getTransaction().commit();
        
    }
    
    public TblUitleen getUitleningen(int id) {
        
                
                Query zoeken = session.createQuery("from TblUitleen where id = :id");
                
                zoeken.setParameter("id", id);
                
                List<TblUitleen> uitleningen = zoeken.list();
                session.close();
                return uitleningen.get(0);
                
    }
    
    public void aanpassen(TblUitleen uitleen) {
            Transaction tx = session.beginTransaction();
            TblUitleen uitleenTabel = (TblUitleen) session.load(TblUitleen.class, uitleen.getId());
            tx.commit();
            uitleenTabel.setUitleendatum(uitleen.getUitleendatum());
            uitleenTabel.setTerugbrengdatum(uitleen.getTerugbrengdatum());
            uitleenTabel.setAantal(uitleen.getAantal());
            uitleenTabel.setBoete(uitleen.getBoete());
            uitleenTabel.setHuurprijs(uitleen.getHuurprijs());
            uitleenTabel.setTeruggebracht(uitleen.getTeruggebracht());
            uitleenTabel.setOpmerking(uitleen.getOpmerking());
            Transaction updateProduct = session.beginTransaction();
            session.update(uitleenTabel);
            updateProduct.commit();
            session.close();
            
            
    }
}
