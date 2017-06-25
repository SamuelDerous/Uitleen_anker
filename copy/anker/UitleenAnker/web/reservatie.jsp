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
<section id="hoofdinhoud">
    <% int id = Integer.parseInt(request.getParameter("id"));
    SessionFactory factory = HibernateFactory.getSessionFactory();
                Session sessie = factory.openSession();
                Query zoeken = sessie.createQuery("from TblProduct where id = :id");
                Query reservatie = sessie.createQuery("from TblReservatie where product = :id and reservatieDatum > :datum");
                Query uitlening = sessie.createQuery("from TblUitleen where teruggebracht <> 1");
                zoeken.setParameter("id", id);
                reservatie.setParameter("id", id);
                GregorianCalendar cal = new GregorianCalendar();
                Date datum = new Date(cal.getTimeInMillis());
                reservatie.setParameter("datum", datum);
                List<TblProduct> producten = zoeken.list();
                List<TblReservatie> reservaties = reservatie.list();
                List<TblUitleen> uitleningen = uitlening.list(); %>
                
			<article id="formulier" align="center">
                            <table border="0" width="100%">
                                <tr><td width="20%">Naam:</td><td width="80%"><%=producten.get(0).getNaam()%></td></tr>
                                <tr><td>Aantal:</td><td><%=producten.get(0).getAantal()%></td></tr>
                                <tr><td>Uitgavevorm:</td><td><%=producten.get(0).getBeschrijving().getSoort()%></td></tr>
                                <tr><td>Aankoopdatum:</td><td><%=producten.get(0).getAankoopdatum()%></td></tr>
                                <tr><td>Breukprijs:</td><td><%=producten.get(0).getBreukprijs()%></td></tr>
                                <tr><td>Beschrijving:</td><td><%=producten.get(0).getOpmerking()%></td></tr>
                                <tr><td>Website:</td><td><%=producten.get(0).getWebsite()%></td></tr>
                                <tr><td colspan=2"><hr></td></tr>
                                <tr><td colspan="2">&nbsp;</td></tr>
                                <tr><td>Reservaties</td><td align="right"><%=reservaties.size()%></td>
                                    <%if(!uitleningen.isEmpty()) {
                                        for(int i = 0; i < uitleningen.size(); i++) {
                                            %>
                                <tr><td class="uitgeleend">Uitgeleend tot</td><td align="right" class="uitgeleend"><%=uitleningen.get(i).getTerugbrengdatum()%></td></tr>
                                        <%}%>
                                <tr><td>Totaal</td><td align="right"><%=uitleningen.size()%>
                                        <%}%>
                                        
			</article>      
      </section>
    </div>
  </body>
</html>
