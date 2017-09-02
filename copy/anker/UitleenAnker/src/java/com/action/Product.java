/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.action;

import com.opensymphony.xwork2.Action;
import databank.TblProduct;
import databank.dao.ProductDao;

/**
 *
 * @author zenodotus
 */
public class Product implements Action {

    private TblProduct product;
    private int productId;
    private String actie;

    public String getActie() {
        return actie;
    }

    public void setActie(String actie) {
        this.actie = actie;
    }
    
    

    public TblProduct getProduct() {
        return product;
    }

    public void setProduct(TblProduct product) {
        this.product = product;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }
    
    
    @Override
    public String execute() throws Exception {
        ProductDao productDao = new ProductDao();
        product = productDao.getProductById(productId);
        return SUCCESS;
    }
    
}
