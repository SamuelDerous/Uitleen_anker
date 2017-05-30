<%-- 
    Document   : registreren
    Created on : 10-mei-2017, 11:59:46
    Author     : zenodotus
--%>
<% if((session.getAttribute("gebruikersnaam") != null && !session.getAttribute("gebruikersnaam").equals("")) && session.getAttribute("soort").equals("gebruiker")) { %>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="java.util.List"%>
<%@page import="databank.TblSoort"%>
<%@page import="org.hibernate.Query"%>
<%@page import="org.hibernate.Session"%>
<%@page import="databank.adapter.HibernateFactory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="../headers/header.jsp" />
<jsp:include page="../headers/menu.jsp" />

<script type="text/javascript" src="../js/validation.js"></script>
<% 
                SessionFactory factory = HibernateFactory.getSessionFactory();
                Session sessie = factory.openSession();
                String gebruiker = request.getParameter("gebruiker");
                
                Query soort = sessie.createQuery("from TblSoort");
                List<TblSoort> soorten = soort.list();
                sessie.close();
                %>
<section id="hoofdinhoud">
			<article id="formulier" align="center">
				<h2 align="center">Gebruiker Toevoegen</h2>
				<form method="post" action="/UitleenAnker/faces/Toevoegen.do" name="toevoegen" onSubmit="return leeg();">
					<table border="0" align="center" width="25%">
						<tr><td colspan="2"><div id="foutmelding" name="foutmelding">
                                                <%if((request.getAttribute("gebruikersnaamNotUnique") != null) && (request.getAttribute("gebruikersnaamNotUnique").equals("correct"))) { %>
                                        Er bestaat al een gebruiker met deze gebruikersnaam; kies een andere
                                    <%}%>
                                                    </div></td></tr>
                                                <tr><td>Gebruikersnaam:<span id="vereist">*</span></td><td><input type="text" class="invullen" name="txtGebruikersnaam" id="txtGebruikersnaam" onKeypress="correct(this);"/></td></tr>
                                                <tr><td>Wachtwoord:<span id="vereist">*</span> </td><td><input type="password" class="invullen" name="txtWachtwoord" id="txtWachtwoord" onKeypress="correct(this)" /></td></tr>
                                                <tr><td>Bevestig wachtwoord:<span id="vereist">*</span> </td><td><input type="password" class="invullen" name="txtBevestig" id="txtBevestig" onKeyUp="gelijkeWachtwoorden()" /></td></tr>
						<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                                                <tr><td>Voornaam:<span id="vereist">*</span> </td><td><input type="text" value="<%= request.getAttribute("naam") == null ? "" : request.getAttribute("naam") %>" class="invullen" name="txtVoornaam" id="txtVoornaam" onKeypress="correct(this);"/></td></tr>
                                                <tr><td>Naam:<span id="vereist">*</span> </td><td><input type="text" value="<%= request.getAttribute("voornaam") == null ? "" : request.getAttribute("voornaam") %>" class="invullen" name="txtNaam" id="txtNaam" onKeypress="correct(this)" /></td></tr>
						<tr><td>Adres: </td><td><textarea id="txtAdres" name="txtAdres" class="invullen" rows="3" ><%= request.getAttribute("adres") == null ? "" : request.getAttribute("adres") %></textarea></td></tr>
						<tr><td>Telefoon: </td><td><input type="text" class="invullen" value="<%= request.getAttribute("telefoon") == null ? "" : request.getAttribute("telefoon") %>" name="txtTelefoon" id="txtTelefoon" /></td></tr>
                                                <tr><td>E-mail:<span id="vereist">*</span> </td><td><input type="email" value="<%= request.getAttribute("email") == null ? "" : request.getAttribute("email") %>" class="invullen" name="txtEmail" id="txtEmail" onKeypress="correct(this)"/></td></tr>
                                                <tr><td>Soort gebruiker:</td><td><select name="slctSoorten" class="invullen">
                                                                        <%for(int i = 0; i < soorten.size(); i++) {
                                                                        %><option value="<%=soorten.get(i).getSoort()%>"><%=soorten.get(i).getSoort()%></option> 
                                                                        <%}%>
                                                        </select></td>
						<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
						<tr><td colspan="2" align="center"><input type="submit" value="Toevoegen" id="txtSubmit" /><input type="reset" value="Wissen" /></td></tr>
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