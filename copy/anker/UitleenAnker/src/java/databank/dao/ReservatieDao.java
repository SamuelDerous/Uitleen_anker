/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package databank.dao;

import databank.TblProduct;
import databank.TblReservatie;
import databank.adapter.HibernateFactory;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

/**
 *
 * @author zenodotus
 */
public class ReservatieDao {
    
    private Session session;
    
    public ReservatieDao() {
        SessionFactory factory = HibernateFactory.getSessionFactory();
        session = factory.openSession();
            
    }
    
    public List<TblReservatie> getReservatiesProduct(TblProduct product) {
        Query qryReservaties = session.createQuery("from TblReservatie where product = :product");
        qryReservaties.setParameter("product", product);
        return qryReservaties.list();
    }
    
    public void toevoegenReservatie(TblReservatie reservatie) {
         session.beginTransaction();
         session.save(reservatie);
         session.getTransaction().commit();
         
    }
}
