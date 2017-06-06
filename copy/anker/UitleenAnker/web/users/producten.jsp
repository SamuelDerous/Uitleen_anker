<%-- 
    Document   : gebToevoegen
    Created on : 20-mei-2017, 12:14:16
    Author     : zenodotus
--%>
<% if((session.getAttribute("gebruikersnaam") != null && !session.getAttribute("gebruikersnaam").equals("")) && session.getAttribute("soort").equals("gebruiker")) { %>
<%@page import="databank.TblProduct"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="org.hibernate.Query"%>
<%@page import="databank.adapter.HibernateFactory"%>
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
                Query zoeken = sessie.createQuery("from TblProduct");
                List<TblProduct> producten = zoeken.list(); 
                for(int i = 0; i < producten.size(); i++) {
                    request.setAttribute("product", producten.get(i).getId());
                %>
                
                <tr><td><%if(producten.get(i).getWebsite() != null && !producten.get(i).getWebsite().equals("")) {%><a href="<%=producten.get(i).getWebsite()%>" target="_blank"><%=producten.get(i).getNaam()%></a><% } else {%><%=producten.get(i).getNaam()%><%}%></td>
                    <td><%=producten.get(i).getAantal()%></td>
                    <td><%=producten.get(i).getBeschrijving().getSoort() %></td>
                    <td><a href="../ProductVerwijderen.do?product=<%= producten.get(i).getId()%>">Verwijderen</a><br><a href="productAanpassen.jsp?product=<%= producten.get(i).getId()%>">Aanpassen</a></td></tr>
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