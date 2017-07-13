/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import databank.TblPersoon;
import databank.TblProduct;
import databank.TblReservatie;
import databank.adapter.HibernateFactory;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.GregorianCalendar;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import static servlets.ProductAanpassen.isNumeric;

/**
 *
 * @author zenodotus
 */
public class Reservatie extends HttpServlet {

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
            String aantal = request.getParameter("txtAantal");
            int id = Integer.parseInt(request.getParameter("id"));
            String gebruiker = request.getParameter("gebruikersnaam");
            
            boolean correct = true;
            if(!isNumeric(aantal)) {
                if(aantal.equals("")) {
                    aantal = "1";
                } else {
                    correct = false;
                }
            }
            if(correct) {
                TblReservatie reservatie = new TblReservatie();
                SessionFactory factory = HibernateFactory.getSessionFactory();
                Session session = factory.openSession();
                Query qryGebruiker = session.createQuery("from TblPersoon where gebruikersnaam = :gebruiker");
                qryGebruiker.setParameter("gebruiker", gebruiker);
                Query qryProduct = session.createQuery("from TblProduct where id = :id");
                qryProduct.setParameter("id", id);
                GregorianCalendar cal = new GregorianCalendar();
                Date datum = new Date(cal.getTimeInMillis());
                TblProduct product = (TblProduct) qryProduct.list().get(0);
                reservatie.setProduct(product);
                TblPersoon persoon = (TblPersoon) qryGebruiker.list().get(0);
                reservatie.setGebruiker(persoon);
                reservatie.setReservatieDatum(datum);
                reservatie.setAantal(Integer.parseInt(aantal));
                
                session.beginTransaction();
                session.save(reservatie);
                session.getTransaction().commit();
                session.close();
                RequestDispatcher view = request.getRequestDispatcher("/users/gebruikers.jsp");
                view.forward(request, response);
            
        } else {
                RequestDispatcher view = request.getRequestDispatcher("/users/gebruikers.jsp");
                view.forward(request, response);
            }
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
