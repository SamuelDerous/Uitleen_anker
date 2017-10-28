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
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<script>
    
</script>
    
<section id="hoofdinhoud">
    <article id="gebruikers">
        <table border="1" width="100%">
            <tr><td colspan="5"><div id="foutmelding"><s:actionerror escape="false" /></div></td>
                
                    <jsp:useBean id="reservaties" class="databank.dao.ReservatieDao" />
                    <c:forEach var="reservatie" items="${reservaties.alleReservaties}">
                    <tr><td>${reservatie.gebruiker.gebruikersnaam}</td>
                    <td>${reservatie.product.naam}</td>
                    <td>${reservatie.aantal}</td>
                    <td>${reservatie.reservatieDatum}
                    <td><a href="reservatieVerwijderen?reservatie=${reservatie.id}">Verwijderen</a><br>
                        <a href="omzetten?reservatie=${reservatie.id}" onclick="bericht();">Uitlenen</a><br></td></tr>
                    </c:forEach>
                        </table>
    </article>
</section>    
</body>
</html>
<% } else {
    response.sendRedirect("/UitleenAnker/faces/inloggen.jsp");
}
%>