/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.action;

import com.opensymphony.xwork2.Action;
import databank.TblUitleen;
import databank.dao.UitleenDao;
import java.util.GregorianCalendar;

/**
 *
 * @author zenodotus
 */
public class Terugbrengen implements Action {

    private int uitleen;

    public int getUitleen() {
        return uitleen;
    }

    public void setUitleen(int uitleen) {
        this.uitleen = uitleen;
    }
    
    @Override
    public String execute() throws Exception {
        GregorianCalendar cal = new GregorianCalendar();
        
        UitleenDao uitleenDao = new UitleenDao();
        TblUitleen uitlening = uitleenDao.getUitleningen(uitleen);
        uitlening.setTeruggebracht(cal.getTime());
        uitleenDao.aanpassen(uitlening);
        return SUCCESS;
    }
    
    
}
