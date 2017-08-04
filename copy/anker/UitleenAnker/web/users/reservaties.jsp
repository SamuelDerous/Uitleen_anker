<%-- 
    Document   : reservaties
    Created on : 28-jun-2017, 20:51:33
    Author     : zenodotus
--%>

<%@page import="databank.TblReservatie"%>
<% if((session.getAttribute("gebruikersnaam") != null && !session.getAttribute("gebruikersnaam").equals("")) && session.getAttribute("soort").equals("gebruiker")) { %>
<%@page import="databank.TblInventarisatie"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="org.hibernate.Query"%>
<%@page import="databank.adapter.HibernateFactory"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="../headers/header.jsp" />
<jsp:include page="../headers/menu.jsp" />
<script>
    function bericht() {
    <% if(request.getAttribute("reservatie") != null && request.getAttribute("reservatie").equals("gereserveerd")) {%>
            alert("Het maximaal aantal reservaties is bereikt");
        
    <%}%>
</script>
    
<section id="hoofdinhoud">
    <article id="gebruikers">
        <table border="1" width="100%">
            <% 
                SessionFactory factory = HibernateFactory.getSessionFactory();
                Session sessie = factory.openSession();
                Query zoeken = sessie.createQuery("from TblReservatie");
                List<TblReservatie> reservaties = zoeken.list();
                
                
                for(int i = 0; i < reservaties.size(); i++) {
                    %>
                
                    <tr><td><%=reservaties.get(i).getGebruiker().getGebruikersnaam()%></td>
                    <td><%=reservaties.get(i).getProduct().getNaam()%></td>
                    <td><%=reservaties.get(i).getAantal()%></td>
                    <td><%=reservaties.get(i).getReservatieDatum()%>
                    <td><a href="../ReservatieVerwijderen.do?reservatie=<%= reservaties.get(i).getId()%>">Verwijderen</a><br>
                        <a href="../Omzetten.do?reservatie=<%=reservaties.get(i).getId()%>" onclick="bericht();">Uitlenen</a><br></td></tr>
                <%}
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