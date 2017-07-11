<%-- 
    Document   : reservatie
    Created on : 24-jun-2017, 23:39:28
    Author     : zenodotus
--%>

<%@page import="databank.TblUitleen"%>
<%@page import="databank.TblReservatie"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.List"%>
<%@page import="databank.TblProduct"%>
<%@page import="org.hibernate.Query"%>
<%@page import="org.hibernate.Session"%>
<%@page import="databank.adapter.HibernateFactory"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="headers/header.jsp" />
<jsp:include page="headers/menu.jsp" />
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
 
<script src="${pageContext.request.contextPath}/js/formulier.js"></script>
<section id="hoofdinhoud">
    <% int id = Integer.parseInt(request.getParameter("id"));
    SessionFactory factory = HibernateFactory.getSessionFactory();
                Session sessie = factory.openSession();
                Query zoeken = sessie.createQuery("from TblProduct where id = :id");
                
                Query uitlening = sessie.createQuery("from TblUitleen where (teruggebracht = '' or teruggebracht = null) and spel = :product");
                zoeken.setParameter("id", id);
                GregorianCalendar cal = new GregorianCalendar();
                Date datum = new Date(cal.getTimeInMillis());
                List<TblProduct> producten = zoeken.list();
                Query reservatie = sessie.createQuery("from TblReservatie where product = :id");
                reservatie.setParameter("id", producten.get(0));
                uitlening.setParameter("product", producten.get(0));
                
                List<TblReservatie> reservaties = reservatie.list();
                List<TblUitleen> uitleningen = uitlening.list(); %>
                
                <div class="dialoog" title="reservatie">
                    <% if(session.getAttribute("gebruikersnaam") != null && !session.getAttribute("gebruikersnaam").equals("")) {%>
                    <form id="doen" action="Reserveren.do" method="post">
                        <table id="formTabel" border="0" align="center">
                            <tr><td><input type="hidden" name="id" value="<%=id%>"><input type="text" placeholder="aantal" size="4" name="txtAantal" /></td></tr>
                        </table>
                    </form>
                    <%} else {%>
                    <p>U dient aangemeld te zijn om te kunnen reserveren</p>
                    <%}%>
                </div>
                <article id="formulier" align="center">
                            <table border="0" width="100%">
                                <tr><td width="20%">Naam:</td><td colspan="2" width="80%"><%=producten.get(0).getNaam()%></td></tr>
                                <tr><td>Aantal:</td><td colspan="2"><%=producten.get(0).getAantal()%></td></tr>
                                <tr><td>Uitgavevorm:</td><td colspan="2"><%=producten.get(0).getBeschrijving().getSoort()%></td></tr>
                                <tr><td>Aankoopdatum:</td><td colspan="2"><%=producten.get(0).getAankoopdatum()%></td></tr>
                                <tr><td>Breukprijs:</td><td colspan="2"><%=producten.get(0).getBreukprijs()%></td></tr>
                                <tr><td>Beschrijving:</td><td colspan="2"><%=producten.get(0).getOpmerking()%></td></tr>
                                <tr><td>Website:</td><td colspan="2"><%=producten.get(0).getWebsite()%></td></tr>
                                <tr><td colspan=3"><hr></td></tr>
                                <tr><td colspan="3">&nbsp;</td></tr>
                                <tr><td>Reservaties</td><td align="right"><%=reservaties.size()%></td><td><button class="create" value="Reserveer">Reserveer</button>
                                    <%if(!uitleningen.isEmpty()) {
                                        for(int i = 0; i < uitleningen.size(); i++) {
                                            %>
                                <tr><td class="uitgeleend">Uitgeleend tot</td><td colspan="2" align="right" class="uitgeleend"><%=uitleningen.get(i).getTerugbrengdatum()%></td></tr>
                                        <%}%>
                                <tr><td>Totaal</td><td colspan="2" align="right"><%=uitleningen.size()%>
                                        <%}%>
                                        
			</article>
                                        
                 
      </section>
    </div>
  </body>
</html>
