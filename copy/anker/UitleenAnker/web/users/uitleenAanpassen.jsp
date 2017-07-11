<%-- 
    Document   : uitleenAanpassen
    Created on : 3-jul-2017, 3:42:32
    Author     : zenodotus
--%>

<%@page import="databank.TblUitleen"%>
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
                int id = Integer.parseInt(request.getParameter("uitleen"));
                
                Query zoeken = sessie.createQuery("from TblUitleen where id = :id");
                
                zoeken.setParameter("id", id);
                
                List<TblUitleen> uitleningen = zoeken.list();
                sessie.close();
                %>
                  </div></td></tr>
                                                <tr><td><input type="hidden" name="uitleen" value="<%=uitleningen.get(0).getId()%>"/>
                                                        Gebruikersnaam:</td><td><b><%=uitleningen.get(0).getNaam().getGebruikersnaam() %></span></b> </td></tr>
                                                <tr><td>Product</td><td><b><%=uitleningen.get(0).getSpel().getNaam()%></b></td></tr>
                                                <tr><td>Uitleendatum<span id="vereist">*</span> </td><td><input type="text" value="<%=uitleningen.get(0).getUitleendatum()%>" class="invullen" name="txtUitleendatum" id="txtUitleendatum" onKeypress="correct(this)" /></td></tr>
                                                <tr><td>Terugbrengdatum<span id="vereist">*</span> </td><td><input type="text" value="<%=uitleningen.get(0).getTerugbrengdatum()%>" class="invullen" name="txtTerugbrengdatum" id="txtTerugbrengdatum" onKeypress="correct(this);"/></td></tr>
                                                <tr><td>Aantal <span id="vereist">*</span> </td><td><input type="text" value="<%=uitleningen.get(0).getAantal().toString()%>" class="invullen" name="txtAantal" id="txtAantal" onKeypress="correct(this)" /></td></tr>
                                                
                                                <tr><td>boete</td><td><input t ype="text" value="<%=uitleningen.get(0).getBoete().toString()%>" class=invullen" name="txtBoete" id="txtBoete" /></td></tr>
                                                <tr><td>huurprijs</td><td><input type="text" class="invullen" value="<%=uitleningen.get(0).getHuurprijs()%>" name="txtHuurprijs" id="txtHuurprijs" /></td></tr>
                                                <tr><td>Opmerking </td><td><textarea id="txtOpmerking" name="txtOpmerking" class="invullen"><%=uitleningen.get(0).getOpmerking()%></textarea>
                                                </td>
                                                <tr><td>Teruggebracht</td><td><input type="text" value="<%=uitleningen.get(0).getTeruggebracht()%>" class="invullen" id="txtTeruggebracht" name="txtTeruggebracht" /></td></tr>
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