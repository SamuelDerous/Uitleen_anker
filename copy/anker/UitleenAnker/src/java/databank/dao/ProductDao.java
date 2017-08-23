/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package databank.dao;

import databank.TblPersoon;
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
public class ProductDao {
    private Session session;
    
    public ProductDao() {
        SessionFactory factory = HibernateFactory.getSessionFactory();
        session = factory.openSession();
            
    }
    
    public List<TblProduct> getAlleProducten() {
        Query qryProduct = session.createQuery("from TblProduct order by naam");
        return qryProduct.list();
    }
    
    public TblProduct getProductById(int id) {
            Query qryProduct = session.createQuery("from TblProduct where id = :id");
            qryProduct.setParameter("id", id);
            TblProduct product = (TblProduct) qryProduct.list().get(0);
            
            return product;
            
    }
}
