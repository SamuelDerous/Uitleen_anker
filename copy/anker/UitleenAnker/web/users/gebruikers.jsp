<%-- 
    Document   : gebToevoegen
    Created on : 20-mei-2017, 12:14:16
    Author     : zenodotus
--%>

<%@page import="databank.TblPersoon"%>
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
                Query zoeken = sessie.createQuery("from TblPersoon");
                List<TblPersoon> personen = zoeken.list(); 
                for(int i = 0; i < personen.size(); i++) {
                    request.setAttribute("gebruiker", personen.get(i).getGebruikersnaam());
                %>
                
                <tr><td><%=personen.get(i).getGebruikersnaam()%></td>
                    <td><%=personen.get(i).getVoornaam()%></td>
                    <td><%=personen.get(i).getNaam()%></td>
                    <td><%=personen.get(i).getAdres()%></td>
                    <td><%=personen.get(i).getTelefoon()%></td>
                    <td><%=personen.get(i).getEMail()%></td>
                    <td><a href="../Gebruikers.do?gebruiker=<%= personen.get(i).getGebruikersnaam()%>">Verwijderen</a><br><a href="gebAanpassen.jsp?gebruiker=<%= personen.get(i).getGebruikersnaam()%>">Aanpassen</a></td></tr>
                <%}
                sessie.close();
                %>
        </table>
    </article>
</section>    
</body>
</html>
