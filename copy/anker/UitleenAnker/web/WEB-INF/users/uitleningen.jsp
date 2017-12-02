<%-- 
    Document   : uitleningen
    Created on : 30-jun-2017, 18:15:43
    Author     : zenodotus
--%>

<%@page import="databank.TblUitleen"%>
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
<section id="hoofdinhoud">
    <article id="gebruikers">
        <table border="1" width="100%">
            <% 
                if(request.getAttribute("email") != null && request.getAttribute("email").equals("verzonden")) {
            %><script> alert("Dit product is gereserveerd er is naar de gebruiker een bericht gezonden");</script><%
                    
            }
                    %>
                    <jsp:useBean id="uitleningen" class="databank.dao.UitleenDao" />
                    <c:forEach var="uitlening" items="${uitleningen.actieveUitleningen}">
                    <tr><td>${uitlening.naam.gebruikersnaam}</td>
                        <td>${uitlening.spel.naam}</td>
                    <td>${uitlening.aantal}</td>
                    <td>${uitlening.uitleendatum}</td>
                    <s:set value="%{uitlening.terugbrengdatum}" var="terugbrengdatum" />
                    <s:text name="%{terugbrengdatum}" />
                    <td><s:if test="%{compareDates(#attr.uitlening.terugbrengdatum)}"><span id="teLaat"></s:if>${uitlening.terugbrengdatum}<s:if test="%{compareDates(#attr.uitlening.terugbrengdatum)}"></span></s:if></td>
                    <td><a href="terugbrengenUitleningen?uitleen=${uitlening.id}">Teruggebracht</a><br>
                        <a href="uitleningProductAanpassen?uitleen=${uitlening.id}">Aanpassen</a><br />
                        <a href="verlengenUitleningen?uitleen=${uitlening.id}">Verlengen</a></td></tr>
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