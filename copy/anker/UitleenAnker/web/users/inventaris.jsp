<%-- 
    Document   : gebToevoegen
    Created on : 20-mei-2017, 12:14:16
    Author     : zenodotus
--%>
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
<section id="hoofdinhoud">
    <article id="gebruikers">
        <table border="1" width="100%">
            <% 
                SessionFactory factory = HibernateFactory.getSessionFactory();
                Session sessie = factory.openSession();
                Query zoeken = sessie.createQuery("from TblInventarisatie");
                List<TblInventarisatie> invents = zoeken.list(); 
                for(int i = 0; i < invents.size(); i++) {
                    request.setAttribute("inventaris", invents.get(i).getId());
                %>
                
                <tr><td><%=invents.get(i).getProduct().getNaam()%></td>
                    <td><%=invents.get(i).getAantal()%></td>
                    <td><%=invents.get(i).getOpmerking()%></td>
                    <td><a href="../InventVerwijderen.do?invent=<%= invents.get(i).getId()%>">Verwijderen</a><br></td></tr>
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