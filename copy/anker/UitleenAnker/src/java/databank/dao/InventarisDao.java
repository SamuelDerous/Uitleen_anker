/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package databank.dao;

import databank.TblInventarisatie;
import databank.TblProduct;
import databank.adapter.HibernateFactory;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

/**
 *
 * @author zenodotus
 */
public class InventarisDao {
    
    private Session session;
    
    public InventarisDao() {
        SessionFactory factory = HibernateFactory.getSessionFactory();
        session = factory.openSession();
            
    }
    
    public List<TblInventarisatie> getInventarisProduct(TblProduct product) {
        Query qryInventaris = session.createQuery("from TblInventarisatie where product = :product");
        qryInventaris.setParameter("product", product);
        return qryInventaris.list();
    }

}
