<%-- 
    Document   : gebAanpassen
    Created on : 20-mei-2017, 17:36:35
    Author     : zenodotus
--%>
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
				<h2 align="center">Aanpassen</h2>
				<form method="post" action="../ProductAanpassen.do" name="Aanpassen" onSubmit="return leeg();">
					<table border="0" align="center" width="25%">
						<tr><td colspan="2"><div id="foutmelding" name="foutmelding">
        
            <% 
                SessionFactory factory = HibernateFactory.getSessionFactory();
                Session sessie = factory.openSession();
                int product = Integer.parseInt(request.getParameter("product"));
                
                Query zoeken = sessie.createQuery("from TblProduct where id = :id");
                Query soort = sessie.createQuery("from TblBeschrijving");
                zoeken.setParameter("id", product);
                List<TblProduct> producten = zoeken.list();
                List<TblBeschrijving> soorten = soort.list();
                sessie.close();
                %>
                  </div></td></tr>
                                                <tr><td><input type="hidden" name="product" value="<%=producten.get(0).getId()%>"/>Gebruikersnaam:</td><td><b><span name="product"><%= producten.get(0).getNaam()%></span></b> </td></tr>
                                                <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                                                <tr><td>Aankoopprijs<span id="vereist">*</span> </td><td><input type="text" value="<%= producten.get(0).getAankoopprijs() %>" class="invullen" name="txtAankoopprijs" id="txtAankoopprijs" onKeypress="correct(this);"/></td></tr>
                                                <tr><td>Breukprijs:<span id="vereist">*</span> </td><td><input type="text" value="<%= producten.get(0).getBreukprijs() %>" class="invullen" name="txtBreukprijs" id="txtBreukprijs" onKeypress="correct(this)" /></td></tr>
                                                <tr><td>Aankoopdatum<span id="vereist">*</span> </td><td><input type="text" value="<%= producten.get(0).getAankoopdatum() %>" class="invullen" name="txtAankoopdatum" id="txtAankoopdatum" onKeypress="correct(this);"/></td></tr>
                                                <tr><td>Aantal: <span id="vereist">*</span> </td><td><input type="text" value="<%= producten.get(0).getAantal() %>" class="invullen" name="txtAantal" id="txtAantal" onKeypress="correct(this)" /></td></tr>
                                                
                                                <tr><td>Opmerkingen</td><td><textarea id="txtOpmerkingen" name="txtOpmerkingen" class="invullen" rows="3" ><%= producten.get(0).getOpmerking() %></textarea></td></tr>
                                                <tr><td>Website:</td><td><input type="text" class="invullen" value="<%= producten.get(0).getWebsite() %>" name="txtWebsite" id="txtWebsite" /></td></tr>
                                                <tr><td>Soort materiaal: </td><td><select name="slctSoorten" class="invullen">
                                                                        <%for(int i = 0; i < soorten.size(); i++) {
                                                                        %><option value="<%=soorten.get(i).getSoort()%>" <% if(soorten.get(i).getSoort().equals(producten.get(0).getBeschrijving().getSoort())) {%> selected <%}%>><%=soorten.get(i).getSoort()%> 
                                                                        <%}%>
                                                </select></td>
                                                <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                                                <tr><td colspan="2" align="center"><input type="submit" value="Aanpassen" id="txtSubmit" /><input type="reset" value="Wissen" /></td></tr>
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