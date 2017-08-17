/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import creatie.Aantal;
import databank.TblUitleen;
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
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

/**
 *
 * @author zenodotus
 */
public class Verlengen extends HttpServlet {

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
            String id = request.getParameter("uitleen");
            
            boolean correct = true;
            boolean isUitgeleend = false;
            boolean isGereserveerd = false;
            
            SessionFactory factory = HibernateFactory.getSessionFactory();
            Session session = factory.openSession();
            Query qryUitleen = session.createQuery("from TblUitleen where id = :id");
            qryUitleen.setParameter("id", Integer.parseInt(id));
            TblUitleen uitleen = (TblUitleen) qryUitleen.list().get(0);
            Aantal aantallen = new Aantal();
            int aantalUitlenen = aantallen.aantalUitgeleend(uitleen.getSpel(), session);
            int aantalReservaties = aantallen.aantalReservaties(uitleen.getSpel(), session);
            int maxUitleningen = aantallen.maxAantal(uitleen.getSpel(), session);
            int aantal = uitleen.getAantal();
                        
            if((aantalUitlenen + aantal) > maxUitleningen) {
                isUitgeleend = true;
                correct = false;
            }
            if(aantalReservaties + aantal > maxUitleningen) {
                isGereserveerd = true;
                correct = false;
            }
            
            
            if(correct) {
                
                GregorianCalendar cal = new GregorianCalendar();
                Date datum = new Date(cal.getTimeInMillis());
                GregorianCalendar calTermijn = new GregorianCalendar();
                calTermijn.add(GregorianCalendar.DAY_OF_YEAR, 28);
                Date termijn = new Date(calTermijn.getTimeInMillis());
                uitleen.setTerugbrengdatum(termijn);
                
                session.beginTransaction();
                session.save(uitleen);
                session.getTransaction().commit();
                session.close();
                RequestDispatcher view = request.getRequestDispatcher("ontleners/uitleningen.jsp?action=uitlening");
                view.forward(request, response);
            
        } else {
                if(isGereserveerd) {
                    request.setAttribute("reservering", "gereserveerd");
                }
                if(isUitgeleend) {
                    request.setAttribute("uitlening", "uitgeleend");
                }
                RequestDispatcher view = request.getRequestDispatcher("ontleners/uitleningen.jsp?action=uitlening");
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
