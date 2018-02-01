/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.action;

import com.opensymphony.xwork2.ActionSupport;
import databank.TblProduct;
import databank.dao.ProductDao;
import org.apache.struts2.ServletActionContext;

/**
 *
 * @author zenodotus
 */
public class ControleAction extends ActionSupport {
    
    private int productId;
    private String volledig;
    
    public String execute() {
        ProductDao dao = new ProductDao();
        System.out.println("productId: " + productId);
        TblProduct product = dao.getProductById(productId);
        System.out.println(volledig);
        if(volledig != null) {   
        if(volledig.equals("on")) {
            volledig = "1";
        } else {
            volledig = "0";
        }      
        } else {
                volledig = "0";
                }
   
        product.setControle(1);
        product.setVolledig(Integer.parseInt(volledig));
        dao.aanpassen(product);
        return SUCCESS;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getVolledig() {
        return volledig;
    }

    public void setVolledig(String volledig) {
        this.volledig = volledig;
    }
    
    
    
    
    
}
