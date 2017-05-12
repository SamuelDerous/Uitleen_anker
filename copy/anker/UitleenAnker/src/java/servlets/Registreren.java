/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import databank.TblPersoon;
import databank.adapter.HibernateFactory;
import java.io.IOException;
import java.io.PrintWriter;
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
public class Registreren extends HttpServlet {

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
            String gebruikersnaam = request.getParameter("txtGebruikersnaam");
            String wachtwoord = request.getParameter("txtWachtwoord");
            String bevestig = request.getParameter("txtBevestig");
            String naam = request.getParameter("txtNaam");
            String voornaam = request.getParameter("txtVoornaam");
            String adres = request.getParameter("txtAdres");
            String telefoon = request.getParameter("txtTelefoon");
            String email = request.getParameter("txtEmail");
            SessionFactory factory = HibernateFactory.getSessionFactory();
            Session session = factory.openSession();
            Query zoeken = session.createQuery("from TblPersoon where gebruikersnaam = :gebruikersnaam");
            zoeken.setParameter("gebruikersnaam", gebruikersnaam);
            List<TblPersoon> personen = zoeken.list();
            HttpSession sessie = request.getSession();
            if(!personen.isEmpty()) {
                 request.setAttribute("gebruikersnaamNotUnique", "correct");
                 session.close();
                 RequestDispatcher view = request.getRequestDispatcher("registreren.jsp");
                 view.forward(request, response);
                
            } else {
                TblPersoon persoon = new TblPersoon();
                persoon.setGebruikersnaam(gebruikersnaam);
                persoon.setWachtwoord(wachtwoord);
                persoon.setNaam(naam);
                persoon.setVoornaam(voornaam);
                persoon.setAdres(adres);
                persoon.setTelefoon(telefoon);
                persoon.setEMail(email);
                SessionFactory sessionFactory = HibernateFactory.getSessionFactory();
                session = sessionFactory.openSession();
                session.beginTransaction();
                session.save(persoon);
                session.getTransaction().commit();
                session.close();
                RequestDispatcher view = request.getRequestDispatcher("geregistreerd.jsp");
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
