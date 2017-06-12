<%-- 
    Document   : gebAanpassen
    Created on : 20-mei-2017, 17:36:35
    Author     : zenodotus
--%>
<%@page import="databank.TblInventarisatie"%>
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
                Query invent = sessie.createQuery("from TblInventarisatie where product = :product");
                invent.setParameter("product", producten.get(0));
                List<TblInventarisatie> invents = invent.list();
                sessie.close();
                session.setAttribute("web", "/UitleenAnker/faces/users/productAanpassen.jsp?product=" + product);
                %>
                  </div></td></tr>
                                                <tr><td><input type="hidden" name="website" value="/UitleenAnker/faces/users/productAanpassen.jsp?product=<%=producten.get(0).getId()%>" /><input type="hidden" name="product" value="<%=producten.get(0).getId()%>"/>Gebruikersnaam:</td><td><b><span name="product"><%= producten.get(0).getNaam()%></span></b> </td></tr>
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
                                                                        <% if(!invents.isEmpty()) {
                                                                            int som = 0;%>
                                                                            <h2 align="center">Inventarisatie</h2>
                                                <table border="1" width="100%">
                                                    <thead><td><b>Naam Product</b></td><td><b>Aantal</b></td><td>&nbsp;</td></thead>
                                                    <% for(int i = 0; i < invents.size(); i++) {
                                                        %><tr><td><%=invents.get(i).getProduct().getNaam()%></td><td><%=invents.get(i).getAantal()%></td><td><a href="../InventVerwijderen.do?invent=<%= invents.get(i).getId()%>">Verwijderen</a></td></tr>
                                                        <% som += invents.get(i).getAantal(); }%>
                                                        <tr><td>TOTAAL: </td><td><%=som%></td><td>&nbsp;</td></tr>
                                                        </table>
                                                        <%}%>
    </article>
</section>
</div>
</body>
</html>
<%} else {
    response.sendRedirect("/UitleenAnker/faces/inloggen.jsp");
}%>