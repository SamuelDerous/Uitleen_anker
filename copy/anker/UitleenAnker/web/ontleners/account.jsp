<%-- 
    Document   : gebAanpassen
    Created on : 20-mei-2017, 17:36:35
    Author     : zenodotus
--%>
<% if((session.getAttribute("gebruikersnaam") != null && !session.getAttribute("gebruikersnaam").equals("")) && (session.getAttribute("soort").equals("ontlener") || session.getAttribute("soort").equals("medewerker"))) { %>

<%@page import="databank.TblSoort"%>
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
    <article id="formulier" align="center">
				<h2 align="center">Aanpassen</h2>
				<form method="post" action="../Aanpassen.do" name="Aanpassen" onSubmit="return leeg();">
					<table border="0" align="center" width="25%">
						<tr><td colspan="2"><div id="foutmelding" name="foutmelding">
        
            <% 
                SessionFactory factory = HibernateFactory.getSessionFactory();
                Session sessie = factory.openSession();
                String gebruiker = (String) session.getAttribute("gebruikersnaam");
                
                Query zoeken = sessie.createQuery("from TblPersoon where gebruikersnaam = :gebruikersnaam");
                Query soort = sessie.createQuery("from TblSoort");
                zoeken.setParameter("gebruikersnaam", gebruiker);
                List<TblPersoon> personen = zoeken.list();
                List<TblSoort> soorten = soort.list();
                sessie.close();
                %>
                  </div></td></tr>
                                                <tr><td><input type="hidden" name="gebruiker" value="<%=personen.get(0).getGebruikersnaam()%>"/>Gebruikersnaam:</td><td><b><span name="gebruikersnaam"><%= personen.get(0).getGebruikersnaam() %></span></b> </td></tr>
                                                <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                                                <tr><td>Voornaam:<span id="vereist">*</span> </td><td><input type="text" value="<%= personen.get(0).getVoornaam() %>" class="invullen" name="txtVoornaam" id="txtVoornaam" onKeypress="correct(this);"/></td></tr>
                                                <tr><td>Naam:<span id="vereist">*</span> </td><td><input type="text" value="<%= personen.get(0).getNaam() %>" class="invullen" name="txtNaam" id="txtNaam" onKeypress="correct(this)" /></td></tr>
                                                <tr><td>Adres: </td><td><textarea id="txtAdres" name="txtAdres" class="invullen" rows="3" ><%= personen.get(0).getAdres() %></textarea></td></tr>
                                                <tr><td>Telefoon: </td><td><input type="text" class="invullen" value="<%= personen.get(0).getTelefoon() %>" name="txtTelefoon" id="txtTelefoon" /></td></tr>
                                                <tr><td>E-mail:<span id="vereist">*</span> </td><td><input type="email" value="<%= personen.get(0).getEMail() %>" class="invullen" name="txtEmail" id="txtEmail" onKeypress="correct(this)"/></td></tr>
                                                                                                            <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                                                <tr><td colspan="2" align="center"><input type="submit" value="Aanpassen" id="txtSubmit" /><input type="reset" value="Wissen" /><input type="button" name="btnWachtwoord" onclick=location.href="resetWachtwoord.jsp?gebruiker=<%=personen.get(0).getGebruikersnaam()%>"   value="Reset ww" /></td></tr>
						<tr><td>&nbsp;</td><td>&nbsp;</td></tr>	
        </table>
</form>
    </article>
</section>
</div>
</body>
</html>
<%} else {
    response.sendRedirect("/UitleenAnker/faces/inloggen.jsp");
}%>