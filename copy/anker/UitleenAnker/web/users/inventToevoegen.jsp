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
				<h2 align="center">Toevoegen</h2>
				<form method="post" action="../InventToevoegen.do" name="Toevoegen" onSubmit="return leeg();">
					<table border="0" align="center" width="25%">
						<tr><td colspan="2"><div id="foutmelding" name="foutmelding">
        
            <% 
                SessionFactory factory = HibernateFactory.getSessionFactory();
                Session sessie = factory.openSession();
                Query soort = sessie.createQuery("from TblBeschrijving");
                List<TblBeschrijving> soorten = soort.list();
                Query product = sessie.createQuery("from TblProduct");
                List<TblProduct> producten = product.list();
                %>
                  </div></td></tr>
                                                <tr><td>Productnaam:<span id="vereist">*</span></td><td><Select class="invullen" name="slctProductNaam" id="slctProductNaam" onKeypress="correct(this);">
                                                            <%for(int i = 0; i < producten.size(); i++) {
                                                                        %><option value="<%=producten.get(i).getNaam()%>"><%=producten.get(i).getNaam()%> 
                                                                        <%}%>
                                                        </select>
                                                    </td></tr>
                                                <tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                                                <tr><td>Aankoopdatum<span id="vereist">*</span> </td><td><input type="text" class="invullen" name="txtAankoopdatum" id="txtAankoopdatum" onKeypress="correct(this);"/></td></tr>
                                                <tr><td>Aantal: <span id="vereist">*</span> </td><td><input type="text" class="invullen" name="txtAantal" id="txtAantal" onKeypress="correct(this)" /></td></tr>
                                                
                                                <tr><td>Opmerkingen</td><td><textarea id="txtOpmerkingen" name="txtOpmerkingen" class="invullen" rows="3" ></textarea></td></tr>
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