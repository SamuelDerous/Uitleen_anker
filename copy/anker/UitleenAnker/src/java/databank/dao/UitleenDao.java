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
    
    public void toevoegenUitleen(TblUitleen uitleen) {
        session.beginTransaction();
        session.save(uitleen);
        session.getTransaction().commit();
        
    }
}
