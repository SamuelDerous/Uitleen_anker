/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import creatie.EncryptionIni;
import databank.TblBeschrijving;
import databank.TblPersoon;
import databank.TblProduct;
import databank.TblSoort;
import databank.adapter.HibernateFactory;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.GeneralSecurityException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import static servlets.ProductAanpassen.isDate;
import static servlets.ProductAanpassen.isNumeric;

/**
 *
 * @author zenodotus
 */
public class ProductToevoegen extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            String productId = request.getParameter("product");
            String productnaam = request.getParameter("txtProductNaam");
            String aankoopprijs = request.getParameter("txtAankoopprijs");
            String breukprijs = request.getParameter("txtBreukprijs");
            String aantal = request.getParameter("txtAantal");
            String opmerkingen = request.getParameter("txtOpmerkingen");
            String aankoopdatum = request.getParameter("txtAankoopdatum");
            String website = request.getParameter("txtWebsite");
            String soort = request.getParameter("slctSoorten");
            double dbAankoopprijs = 0, dbBreukprijs = 0;
            int intAantal = 0;
            SessionFactory factory = HibernateFactory.getSessionFactory();
            boolean correct = true;
            Session session = factory.openSession();
            Query zoeken = session.createQuery("from TblProduct where naam = :productnaam");
            zoeken.setParameter("productnaam", productnaam);
            List<TblProduct> producten = zoeken.list();
            HttpSession sessie = request.getSession();
            
            if(!producten.isEmpty()) {
                correct = false; 
                request.setAttribute("productNotUnique", "correct");
                RequestDispatcher view = request.getRequestDispatcher("users/productToevoegen.jsp");
                 view.forward(request, response);
            }
            
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
            
            
            if (correct == false) {
                session.close();
                request.setAttribute("Product", productId);
                request.setAttribute("txtProduct", productnaam);
                request.setAttribute("txtAankoopprijs", aankoopprijs);
                request.setAttribute("txtBreukprijs", breukprijs);
                request.setAttribute("txtAantal", aantal);
                request.setAttribute("txtOpmerkingen", opmerkingen);
                request.setAttribute("txtAankoopdatum", aankoopdatum);
                request.setAttribute("txtWebsite", website);
                
                RequestDispatcher view = request.getRequestDispatcher("users/productToevoegen.jsp");
                 view.forward(request, response);
            }     
             else {
                
                
                TblProduct product = new TblProduct();
                dbAankoopprijs = Double.parseDouble(aankoopprijs);
                dbBreukprijs = Double.parseDouble(breukprijs);
                intAantal = Integer.parseInt(aantal);
                product.setNaam(productnaam);
                product.setAankoopprijs(dbAankoopprijs);
                product.setBreukprijs(dbBreukprijs);
                product.setAantal(intAantal);
                product.setOpmerking(opmerkingen);
                DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                Date dAankoopdatum = (Date) formatter.parse(aankoopdatum);
                product.setAankoopdatum(dAankoopdatum);
                product.setWebsite(website);
                TblBeschrijving beschrijving = new TblBeschrijving();
                beschrijving.setSoort(soort);
                product.setBeschrijving(beschrijving);
                
                SessionFactory sessionFactory = HibernateFactory.getSessionFactory();
                session = sessionFactory.openSession();
                session.beginTransaction();
                session.save(product);
                session.getTransaction().commit();
                session.close();
                RequestDispatcher view = request.getRequestDispatcher("users/productToevoegen.jsp");
                view.forward(request, response);
            }
            
        
        } catch (Exception ex) {
            ex.printStackTrace();
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

}
