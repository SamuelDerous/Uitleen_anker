/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import creatie.Aantal;
import creatie.EncryptionIni;
import databank.TblPersoon;
import databank.TblReservatie;
import databank.TblUitleen;
import databank.adapter.HibernateFactory;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.GregorianCalendar;
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

/**
 *
 * @author zenodotus
 */
public class Omzetten extends HttpServlet {

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
            SessionFactory factory = HibernateFactory.getSessionFactory();
            Session session = factory.openSession();
            String reservatieId = request.getParameter("reservatie");
            Query zoeken = session.createQuery("from TblReservatie where id = :id");
            zoeken.setParameter("id", Integer.parseInt(reservatieId));
            List<TblReservatie> reservatie = zoeken.list();
            Aantal aantallen = new Aantal();
            int aantalUitleningen = aantallen.aantalUitgeleend(reservatie.get(0).getProduct(), session);
            if(!reservatie.isEmpty()) {
                if((aantalUitleningen + reservatie.get(0).getAantal()) > aantalUitleningen) {
                    session.close();
                    request.setAttribute("Uitlening", "uitgeleend");
                    RequestDispatcher view = request.getRequestDispatcher("users/Reservaties.jsp");
                    view.forward(request, response);
                
                } else {
                TblUitleen uitlening = new TblUitleen();
                uitlening.setNaam(reservatie.get(0).getGebruiker());
                uitlening.setSpel(reservatie.get(0).getProduct());
                uitlening.setAantal(reservatie.get(0).getAantal());
                GregorianCalendar cal = new GregorianCalendar();
                Date datum = new Date(cal.getTimeInMillis());
                uitlening.setUitleendatum(datum);
                GregorianCalendar calTermijn = new GregorianCalendar();
                calTermijn.add(GregorianCalendar.DAY_OF_YEAR, 28);
                Date termijn = new Date(calTermijn.getTimeInMillis());
                uitlening.setTerugbrengdatum(termijn);
                session.beginTransaction();
                session.save(uitlening);
                session.delete(reservatie.get(0));
                session.getTransaction().commit();
                session.close();
                RequestDispatcher view = request.getRequestDispatcher("users/Reservaties.jsp");
                view.forward(request, response);
                }
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