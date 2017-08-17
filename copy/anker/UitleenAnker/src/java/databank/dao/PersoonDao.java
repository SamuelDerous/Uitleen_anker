/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package databank.dao;

import creatie.EncryptionIni;
import databank.TblPersoon;
import databank.TblSoort;
import databank.adapter.HibernateFactory;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

/**
 *
 * @author zenodotus
 */
public class PersoonDao {
    
    private Session session;
    
    public PersoonDao() {
        SessionFactory factory = HibernateFactory.getSessionFactory();
        session = factory.openSession();
            
    }
    
    public List<TblPersoon> login(String gebruikersnaam, String wachtwoord) {
        Query zoeken = session.createQuery("from TblPersoon where gebruikersnaam = :gebruikersnaam and wachtwoord = :wachtwoord");
        zoeken.setParameter("gebruikersnaam", gebruikersnaam);
        zoeken.setParameter("wachtwoord", wachtwoord);
        List<TblPersoon> personen = zoeken.list();
        return personen;
    }
    
    public List<TblPersoon> gebruikers(String gebruikersnaam) {
        Query zoeken = session.createQuery("from TblPersoon where gebruikersnaam = :gebruikersnaam");
        zoeken.setParameter("gebruikersnaam", gebruikersnaam);
        List<TblPersoon> personen = zoeken.list();
        return personen;
            
    }
    
    public void toevoegen(TblPersoon persoon) {
        session.beginTransaction();
        session.save(persoon);
        session.getTransaction().commit();    
    }
    
    public boolean toevoegen(String gebruikersnaam, String voornaam, String naam, String wachtwoord, 
            String adres, String telefoon, String email, String soortnaam) {
        
        try {    
            TblPersoon persoon = new TblPersoon();
            persoon.setGebruikersnaam(gebruikersnaam);
            String encrWachtwoord = EncryptionIni.encrypt(wachtwoord);
            persoon.setWachtwoord(encrWachtwoord);
            persoon.setNaam(naam);
            persoon.setVoornaam(voornaam);
            persoon.setAdres(adres);
            persoon.setTelefoon(telefoon);
            TblSoort soort = new TblSoort();
            soort.setSoort(soortnaam);
            persoon.setSoort(soort);
            persoon.setEMail(email);
            session.beginTransaction();
            session.save(persoon);
            session.getTransaction().commit();
            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
            
    } 
}
