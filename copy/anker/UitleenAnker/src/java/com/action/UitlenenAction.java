/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.action;

import com.opensymphony.xwork2.ActionSupport;
import creatie.Aantal;
import static creatie.Controle.isNumeric;
import databank.TblPersoon;
import databank.TblProduct;
import databank.TblUitleen;
import databank.dao.PersoonDao;
import databank.dao.ProductDao;
import databank.dao.UitleenDao;
import java.sql.Date;
import java.util.GregorianCalendar;

/**
 *
 * @author zenodotus
 */
public class UitlenenAction extends ActionSupport {
    private String gebruikersnaam;
    private int productId;
    private String aantal;
    private String website;

    public String getGebruikersnaam() {
        return gebruikersnaam;
    }

    public void setGebruikersnaam(String gebruikersnaam) {
        this.gebruikersnaam = gebruikersnaam;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getAantal() {
        return aantal;
    }

    public void setAantal(String aantal) {
        this.aantal = aantal;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }
    
    @Override
    public String execute() {
        return SUCCESS;
    }
    
    @Override
    public void validate() {
            boolean correct = true;
            boolean isUitgeleend = false;
            boolean isGereserveerd = false;
            PersoonDao persoonDao = new PersoonDao();
            ProductDao productDao = new ProductDao();
            UitleenDao uitleenDao = new UitleenDao();
            TblPersoon persoon = persoonDao.getGebruiker(gebruikersnaam);
            TblProduct product = productDao.getProductById(productId);
            
            Aantal aantallen = new Aantal();
            int aantalUitlenen = aantallen.aantalUitgeleend(product);
            int aantalReservaties = aantallen.aantalReservaties(product);
            int maxUitleningen = aantallen.maxAantal(product);
                  
                        
            if(!isNumeric(aantal)) {
                if(aantal.equals("")) {
                    aantal = "1";
                } else {
                    correct = false;
                }
            }
            if(isNumeric(aantal)) {
                if((aantalUitlenen + Integer.parseInt(aantal)) > maxUitleningen) {
                    isUitgeleend = true;
                    correct = false;
                }
                if(aantalReservaties + (Integer.parseInt(aantal)) > maxUitleningen) {
                    isGereserveerd = true;
                    correct = false;
                }
            }
            
            if(correct) {
                TblUitleen uitleen = new TblUitleen();
                
                GregorianCalendar cal = new GregorianCalendar();
                Date datum = new Date(cal.getTimeInMillis());
                uitleen.setSpel(product);
                
                uitleen.setNaam(persoon);
                uitleen.setUitleendatum(datum);
                uitleen.setAantal(Integer.parseInt(aantal));
                GregorianCalendar calTermijn = new GregorianCalendar();
                calTermijn.add(GregorianCalendar.DAY_OF_YEAR, 28);
                Date termijn = new Date(calTermijn.getTimeInMillis());
                uitleen.setTerugbrengdatum(termijn);
                
                uitleenDao.toevoegenUitleen(uitleen);
        } else {
                if(isGereserveerd) {
                    addActionError("Het maximaal aantal is al gereserveerd.");
                }
                if(isUitgeleend) {
                    addActionError("Het maximaal aantal is al uitgeleend.");
                } else {
                    addActionError("Er is iets fout gegaan bij het verwerken van uw de uitlening.");
                }
                
            }
            
    }
}
   

