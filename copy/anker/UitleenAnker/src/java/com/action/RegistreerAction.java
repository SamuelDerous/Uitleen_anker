/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.action;

import com.opensymphony.xwork2.ActionSupport;
import static creatie.Controle.isNumeric;
import databank.TblPersoon;
import databank.dao.PersoonDao;

/**
 *
 * @author zenodotus
 */
public class RegistreerAction extends ActionSupport {
    
    private String naam, voornaam, adres, telefoon, email, gebruikersnaam, wachtwoord, bevestig, soort;

    public String getNaam() {
        return naam;
    }

    public void setNaam(String naam) {
        this.naam = naam;
    }

    public String getVoornaam() {
        return voornaam;
    }

    public void setVoornaam(String voornaam) {
        this.voornaam = voornaam;
    }

    public String getAdres() {
        return adres;
    }

    public void setAdres(String adres) {
        this.adres = adres;
    }

    public String getTelefoon() {
        return telefoon;
    }

    public void setTelefoon(String telefoon) {
        this.telefoon = telefoon;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getGebruikersnaam() {
        return gebruikersnaam;
    }

    public void setGebruikersnaam(String gebruikersnaam) {
        this.gebruikersnaam = gebruikersnaam;
    }

    public String getWachtwoord() {
        return wachtwoord;
    }

    public void setWachtwoord(String wachtwoord) {
        this.wachtwoord = wachtwoord;
    }

    public String getBevestig() {
        return bevestig;
    }

    public void setBevestig(String bevestig) {
        this.bevestig = bevestig;
    }

    public String getSoort() {
        return soort;
    }

    public void setSoort(String soort) {
        this.soort = soort;
    }
    
    
    
    @Override
    public String execute() {
        return SUCCESS;
    }
    
    @Override
    public void validate() {
        PersoonDao dao = new PersoonDao();
        TblPersoon notUnique = dao.getGebruiker(gebruikersnaam);
        boolean correct = true;
        if(soort == null || soort.isEmpty()) {
            soort = "ontlener";
        }
        if(gebruikersnaam.isEmpty()) {
            correct = false;
            addActionError("Er dient een unieke gebruikersnaam ingevuld te worden.<br>");
        }
        if(wachtwoord.isEmpty()) {
            correct = false;
            addActionError("Er dient een wachtwoord opgegeven te worden.<br>");
        }
        if(!bevestig.equals(wachtwoord)) {
            correct = false;
            addActionError("Het wachtwoord is niet gelijk aan de bevestiging.<br>");
        }
        if(email.isEmpty()) {
            correct = false;
            addActionError("Er dient een correct e-mailadres opgegeven te worden.<br>");
        }
        if(notUnique != null) {
            correct = false;
            addActionError("Deze gebruikersnaam is al in gebruik. Probeer een andere.<br>");
        }
        if(!isNumeric(telefoon)) {
            correct = false;
            addActionError("Het telefoonnummer dient uitsluitend uit cijfers te bestaan.<br>");
        }
        if(correct == true) {
            if(!dao.toevoegen(gebruikersnaam, voornaam, naam, wachtwoord, adres, telefoon, email, soort)) {
                addActionError("Er is iets fout gegaan tijdens de verwerking van uw registratie.<br>");
            }
        }
        
    }
}
