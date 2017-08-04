<%-- 
    Document   : uitleningen
    Created on : 30-jun-2017, 18:15:43
    Author     : zenodotus
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="databank.TblReservatie"%>
<%@page import="databank.TblUitleen"%>
<% if((session.getAttribute("gebruikersnaam") != null && !session.getAttribute("gebruikersnaam").equals("")) && (session.getAttribute("soort").equals("ontlener") || session.getAttribute("soort").equals("medewerker"))) { %>
<%@page import="databank.TblInventarisatie"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="org.hibernate.Query"%>
<%@page import="databank.adapter.HibernateFactory"%>
<%@page import="databank.TblPersoon"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="../headers/header.jsp" />
<jsp:include page="../headers/menu.jsp" />
<section id="hoofdinhoud">
    <article id="gebruikers">
        <table border="1" width="100%">
            <% 
                SessionFactory factory = HibernateFactory.getSessionFactory();
                Session sessie = factory.openSession();
                Query qryGebruiker = sessie.createQuery("from TblPersoon where gebruikersnaam = :gebruikersnaam");
                qryGebruiker.setParameter("gebruikersnaam", session.getAttribute("gebruikersnaam"));
                TblPersoon persoon = (TblPersoon) qryGebruiker.list().get(0);
                List<TblUitleen> uitleningen = null;
                List<TblReservatie> reservaties = null;
                if(request.getParameter("action").equals("uitlening")) {
                    Query zoeken = sessie.createQuery("from TblUitleen where teruggebracht = null or teruggebracht = '' and naam = :ontlener");
                    zoeken.setParameter("ontlener", persoon);
                    uitleningen = zoeken.list();
                } else if (request.getParameter("action").equals("reservering")) {
                    Query zoeken = sessie.createQuery("from TblReservatie where gebruiker = :ontlener");
                    zoeken.setParameter("ontlener", persoon);
                    reservaties = zoeken.list();
                }
                
                if(request.getParameter("action").equals("uitlening")) {
                for(int i = 0; i < uitleningen.size(); i++) {
                    %>
                
                    <tr><td><%=uitleningen.get(i).getNaam().getGebruikersnaam()%></td>
                        <td><%=uitleningen.get(i).getSpel().getNaam()%></td>
                    <td><%=uitleningen.get(i).getAantal()%></td>
                    <td><%=uitleningen.get(i).getUitleendatum()%></td>
                    <td><%=uitleningen.get(i).getTerugbrengdatum()%></td>
                    <td><a href="../verlengen.do?uitleen=<%=uitleningen.get(i).getId()%>">Verlengen</a></td></tr>
                <%}
                }
else if (request.getParameter("action").equals("reservering")) {
for(int i = 0; i < reservaties.size(); i++) {
                    %>
                
                    <tr><td><%=reservaties.get(i).getGebruiker().getGebruikersnaam()%></td>
                        <td><%=reservaties.get(i).getProduct().getNaam()%></td>
                    <td><%=reservaties.get(i).getAantal()%></td>
                    <td>
                        <a href="../ReservatieVerwijderen.do?reservatie=<%= reservaties.get(i).getId()%>">Verwijderen</a></td></tr>
                <%}
                    
}
                    
                sessie.close();
                %>
        </table>
    </article>
</section>    
</body>
</html>
<% } else {
    response.sendRedirect("/UitleenAnker/faces/inloggen.jsp");
}
%>