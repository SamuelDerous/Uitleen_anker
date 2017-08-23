/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.action;

import com.opensymphony.xwork2.ActionSupport;
import creatie.Aantal;
import databank.TblPersoon;
import databank.TblProduct;
import databank.dao.PersoonDao;
import databank.dao.ProductDao;
import java.sql.Date;
import java.util.GregorianCalendar;
import static servlets.ProductAanpassen.isNumeric;
import databank.TblReservatie;
import databank.dao.ReservatieDao;

/**
 *
 * @author zenodotus
 */
public class ReserverenAction extends ActionSupport {
    private String gebruikersnaam;
    private int productId;
    private String aantal;

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
    
    
    
    @Override
    public String execute() {
        return SUCCESS;
    }
    
    @Override
    public void validate() {
               
            boolean correct = true;
            
            if(!isNumeric(aantal)) {
                if(aantal.equals("")) {
                    aantal = "1";
                } else {
                    correct = false;
                }
            }
            if(correct) {
                Aantal aantallen = new Aantal();
                PersoonDao gebruikerDao = new PersoonDao();
                ProductDao productDao = new ProductDao();
                GregorianCalendar cal = new GregorianCalendar();
                Date datum = new Date(cal.getTimeInMillis());
                TblProduct product = productDao.getProductById(productId);
                int resAantal = aantallen.maxAantal(product);
                if(resAantal < Integer.parseInt(aantal)) {
                    addActionError("Dit product is al gereserveerd.");
                } else {
                    TblReservatie reservatie = new TblReservatie();
                    reservatie.setProduct(product);
                    TblPersoon persoon = gebruikerDao.getGebruiker(gebruikersnaam);
                    reservatie.setGebruiker(persoon);
                    reservatie.setReservatieDatum(datum);
                    reservatie.setAantal(Integer.parseInt(aantal));
                    ReservatieDao reservatieDao = new ReservatieDao();
                    reservatieDao.toevoegenReservatie(reservatie);
               
                }
            
        } else {
                addActionError("Er is iets fout gegaan bij de verwerking van de reservatie.");
        }
    }
    
}