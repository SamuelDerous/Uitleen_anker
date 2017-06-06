/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import databank.TblBeschrijving;
import databank.TblInventarisatie;
import databank.TblProduct;
import databank.adapter.HibernateFactory;
import java.io.IOException;
import java.io.PrintWriter;
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
public class InventToevoegen extends HttpServlet {

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
            
            String productnaam = request.getParameter("slctProductNaam");
            String aantal = request.getParameter("txtAantal");
            String opmerkingen = request.getParameter("txtOpmerkingen");
            String aankoopdatum = request.getParameter("txtAankoopdatum");
            int intAantal = 0;
            SessionFactory factory = HibernateFactory.getSessionFactory();
            boolean correct = true;
            Session session = factory.openSession();
            Query zoeken = session.createQuery("from TblProduct where naam = :productnaam");
            zoeken.setParameter("productnaam", productnaam);
            List<TblProduct> producten = zoeken.list();
            HttpSession sessie = request.getSession();
            TblProduct prod = new TblProduct();
            if(producten.isEmpty()) {
                correct = false; 
                request.setAttribute("productNotUnique", "correct");
                RequestDispatcher view = request.getRequestDispatcher("users/inventToevoegen.jsp");
                 view.forward(request, response);
            } else {
                prod = producten.get(0);
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
                request.setAttribute("slctProduct", productnaam);
                request.setAttribute("txtAantal", aantal);
                request.setAttribute("txtOpmerkingen", opmerkingen);
                request.setAttribute("txtAankoopdatum", aankoopdatum);
                
                RequestDispatcher view = request.getRequestDispatcher("users/inventToevoegen.jsp");
                 view.forward(request, response);
            }     
             else {
                
                
                TblInventarisatie product = new TblInventarisatie();
                intAantal = Integer.parseInt(aantal);
                
                product.setProduct(prod);
                product.setAantal(intAantal);
                product.setOpmerking(opmerkingen);
                DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                Date dAankoopdatum = (Date) formatter.parse(aankoopdatum);
                product.setDatum(dAankoopdatum);
                product.setOpmerking(opmerkingen);
                
                SessionFactory sessionFactory = HibernateFactory.getSessionFactory();
                session = sessionFactory.openSession();
                session.beginTransaction();
                session.save(product);
                session.getTransaction().commit();
                session.close();
                RequestDispatcher view = request.getRequestDispatcher("users/inventToevoegen.jsp");
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
