/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import databank.TblPersoon;
import databank.TblSoort;
import databank.adapter.HibernateFactory;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

/**
 *
 * @author zenodotus
 */
public class Aanpassen extends HttpServlet {

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
            String gebruikersnaam = request.getParameter("gebruiker");
            String naam = request.getParameter("txtNaam");
            String voornaam = request.getParameter("txtVoornaam");
            String adres = request.getParameter("txtAdres");
            String telefoon = request.getParameter("txtTelefoon");
            String email = request.getParameter("txtEmail");
            String soort = request.getParameter("slctSoorten");
            if(soort == null || soort.equals("")) {
                soort = "ontlener";
            }
            SessionFactory factory = HibernateFactory.getSessionFactory();
            boolean correct = true;
            Session sessie = factory.openSession();
            Transaction tx = sessie.beginTransaction();
            TblPersoon persoon = (TblPersoon) sessie.load(TblPersoon.class, gebruikersnaam);
            tx.commit();
            persoon.setNaam(naam);
            persoon.setVoornaam(voornaam);
            persoon.setAdres(adres);
            persoon.setTelefoon(telefoon);
            persoon.setEMail(email);
            TblSoort tblSoort = new TblSoort();
            tblSoort.setSoort(soort);
            persoon.setSoort(tblSoort);
            Transaction updatePersoon = sessie.beginTransaction();
            sessie.update(persoon);
            updatePersoon.commit();
            sessie.close();
            response.sendRedirect("users/gebruikers.jsp");
        }
        catch (Exception ex) {
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
