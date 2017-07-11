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
<section id="hoofdinhoud">
    <article id="gebruikers">
        <table border="1" width="100%">
            <% 
                SessionFactory factory = HibernateFactory.getSessionFactory();
                Session sessie = factory.openSession();
                Query zoeken = sessie.createQuery("from TblUitleen where teruggebracht = null or teruggebracht = ''");
                List<TblUitleen> uitleningen = zoeken.list();
                
                
                for(int i = 0; i < uitleningen.size(); i++) {
                    %>
                
                    <tr><td><%=uitleningen.get(i).getNaam().getGebruikersnaam()%></td>
                        <td><%=uitleningen.get(i).getSpel().getNaam()%></td>
                    <td><%=uitleningen.get(i).getAantal()%></td>
                    <td><%=uitleningen.get(i).getUitleendatum()%></td>
                    <td><%=uitleningen.get(i).getTerugbrengdatum()%></td>
                    <td><a href="../Terugbrengen.do?uitleen=<%=uitleningen.get(i).getId()%>">Teruggebracht</a><br>
                        <a href="../uitleenAanpassen.jsp?uitleen=<%=uitleningen.get(i).getId()%>">Aanpassen</a><br />
                        <a href="../verlengen.do?uitleen=<%=uitleningen.get(i).getId()%>">Verlengen</a></td></tr>
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