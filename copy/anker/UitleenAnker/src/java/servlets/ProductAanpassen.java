/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import databank.TblBeschrijving;
import databank.TblPersoon;
import databank.TblProduct;
import databank.TblSoort;
import databank.adapter.HibernateFactory;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

/**
 *
 * @author zenodotus
 */
public class ProductAanpassen extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String productId = request.getParameter("product");
            String aankoopprijs = request.getParameter("txtAankoopprijs");
            String breukprijs = request.getParameter("txtBreukprijs");
            String aantal = request.getParameter("txtAantal");
            String opmerkingen = request.getParameter("txtOpmerkingen");
            String aankoopdatum = request.getParameter("txtAankoopdatum");
            String soort = request.getParameter("slctSoorten");
            double dbAankoopprijs = 0, dbBreukprijs = 0;
            int intAantal = 0;
            SessionFactory factory = HibernateFactory.getSessionFactory();
            boolean correct = true;
            
            if(!isNumeric(aankoopprijs)) {
                if(aankoopprijs.equals("")) {
                    aankoopprijs = "0";
                } else {
                    correct = false;
                }
            }
            if(!isNumeric(breukprijs)) {
                if(breukprijs.equals("")) {
                    breukprijs = "0";
                } else {
                    correct = false;
                }
            }
            if(!isNumeric(aantal)) {
                if(aantal.equals("")) {
                    aantal = "0";
                } else {
                    correct = false;
                }
            }
            if(!isDate(aankoopdatum)) {
                if(aankoopdatum.equals("")) {
                    Date nu = new Date();
                    aankoopdatum = nu.toString();
                } else {
                    correct = false;
                }
            }
                
            if(correct == true) {
            dbAankoopprijs = Double.parseDouble(aankoopprijs);
            dbBreukprijs = Double.parseDouble(breukprijs);
            intAantal = Integer.parseInt(aantal);
            DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            Date dAankoopdatum = (Date) formatter.parse(aankoopdatum);
            Session sessie = factory.openSession();
            Transaction tx = sessie.beginTransaction();
            TblProduct product = (TblProduct) sessie.load(TblProduct.class, Integer.parseInt(productId));
            tx.commit();
            product.setAankoopprijs(dbAankoopprijs);
            product.setBreukprijs(dbBreukprijs);
            product.setAantal(intAantal);
            product.setOpmerking(opmerkingen);
            product.setAankoopdatum(dAankoopdatum);
            TblBeschrijving tblBeschrijving = new TblBeschrijving();
            tblBeschrijving.setSoort(soort);
            product.setBeschrijving(tblBeschrijving);
            Transaction updateProduct = sessie.beginTransaction();
            sessie.update(product);
            updateProduct.commit();
            sessie.close();
            response.sendRedirect("users/producten.jsp");
            } else {
                response.sendRedirect("users/productAanpassen.jsp?product=" + productId);
            }
        }
        catch (Exception ex) {
            response.sendRedirect("users/productAanpassen.jsp");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    
    public static boolean isNumeric(String str)  
{  
  try  
  {  
    double d = Double.parseDouble(str);  
  }  
  catch(NumberFormatException nfe)  
  {  
    return false;  
  }  
  return true;  
}

     public static boolean isDate(String str)  
{  
  try  
  {  
      DateFormat formatter = new SimpleDateFormat("yyyy-mm-dd");
      Date d = (Date) formatter.parse(str);  
  }  
  catch(Exception ex)  
  {  
    return false;  
  }  
  return true;  
}
}
