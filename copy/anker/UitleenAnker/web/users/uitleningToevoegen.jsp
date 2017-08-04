<%-- 
    Document   : gebAanpassen
    Created on : 20-mei-2017, 17:36:35
    Author     : zenodotus
--%>
<%@page import="databank.TblPersoon"%>
<% if((session.getAttribute("gebruikersnaam") != null && !session.getAttribute("gebruikersnaam").equals("")) && session.getAttribute("soort").equals("gebruiker")) { %>
<%@page import="databank.TblBeschrijving"%>
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
    <article id="formulier" align="center">
				<h2 align="center">Toevoegen</h2>
				<form method="post" action="../Uitlenen.do" name="Toevoegen" onSubmit="return leeg();">
					<table border="0" align="center" width="25%">
						<tr><td colspan="2"><div id="foutmelding" name="foutmelding">
                                                            <%if(request.getAttribute("uitlening") != null && request.getAttribute("uitlening").equals("uitgeleend")) {%>
                                                                    Het maximaal aantal uitleningen voor dit product zal overschreden worden.
                                                             <%}%>
                                                             <%if(request.getAttribute("reservering") != null && request.getAttribute("reservering").equals("gereserveerd")) {%>
                                                                    Dit product is gereserveerd
                                                             <%}%>
            <% 
                SessionFactory factory = HibernateFactory.getSessionFactory();
                Session sessie = factory.openSession();
                Query qryGebruikers = sessie.createQuery("from TblPersoon order by gebruikersnaam");
                Query qryProducten = sessie.createQuery("from TblProduct order by naam");
                List<TblPersoon> personen = qryGebruikers.list();
                List<TblProduct> producten = qryProducten.list();
                sessie.close();
                %>
                  </div></td></tr>
                                                <tr><td><input type="hidden" name="website" value="/users/uitleningToevoegen.jsp" />
                                                        Gebruikersnaam<span id="vereist">*</span></td><td><input type="text" autocomplet="on" class="invullen" name="slctPersonen" id="txtGebruikersnaam" list="gebruikers" />
                                                        <datalist id="gebruikers">
                                                            <%for(int i = 0; i < personen.size(); i++) {%>
                                                            <option value="<%=personen.get(i).getGebruikersnaam()%>" />
                                                            <%}%>
                                                            
                                                        </datalist></td></tr>
                                                <tr><td>Product ID<span id="vereist">*</span> </td><td><input type="text" class="invullen" name="productId" id="txtProductId" list="producten"/>
                                                        <datalist id="producten">
                                                            <%for(int i = 0; i < producten.size(); i++) {%>
                                                            <option value="<%=producten.get(i).getId()%>"><%=producten.get(i).getNaam()%></option>
                                                            <%}%>
                                                        </datalist></td></tr>
                                                <tr><td>Aantal: <span id="vereist">*</span> </td><td><input type="text" class="invullen" name="txtAantal" id="txtAantal" /></td></tr>
                                                
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