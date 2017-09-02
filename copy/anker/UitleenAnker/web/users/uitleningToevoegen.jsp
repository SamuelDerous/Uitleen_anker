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
<%@taglib uri="/struts-tags" prefix="s"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<section id="hoofdinhoud">
    <article id="formulier" align="center">
				<h2 align="center">Toevoegen</h2>
				<form method="post" action="uitlenen" name="Toevoegen" onSubmit="return leeg();">
					<table border="0" align="center" width="25%">
						<tr><td colspan="2"><div id="foutmelding" name="foutmelding">
                                                            <s:actionerror escape="false" />
            
                  </div></td></tr>
                                                <tr><td><input type="hidden" name="action" value="toevoegen" />
                                                        Gebruikersnaam<span id="vereist">*</span></td><td><input type="text" autocomplet="on" class="invullen" name="slctPersonen" id="gebruikersnaam" list="gebruikers" />
                                                        <datalist id="gebruikers">
                                                            <jsp:useBean id="personen" class="databank.dao.PersoonDao" />
                                                            <c:forEach var="gebruiker" items="${pesonen.alleGebruikers}">
                                                            <option value="${gebruiker.gebruikersnaam}" />
                                                            </c:forEach>
                                                            
                                                        </datalist></td></tr>
                                                <tr><td>Product ID<span id="vereist">*</span> </td><td><input type="text" class="invullen" name="productId" id="txtProductId" list="producten"/>
                                                        <datalist id="producten">
                                                            <jsp:useBean id="productie" class="databank.dao.ProductDao" />
                                                            <c:forEach var="product" items="${productie.alleProducten}">
                                                            <option value="${product.id}">${product.naam}</option>
                                                            </c:forEach>
                                                        </datalist></td></tr>
                                                <tr><td>Aantal: <span id="vereist">*</span> </td><td><input type="text" class="invullen" name="aantal" id="txtAantal" /></td></tr>
                                                
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