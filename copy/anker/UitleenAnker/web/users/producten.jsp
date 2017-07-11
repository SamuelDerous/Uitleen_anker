<%-- 
    Document   : gebToevoegen
    Created on : 20-mei-2017, 12:14:16
    Author     : zenodotus
--%>
<%@page import="databank.TblPersoon"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% if ((session.getAttribute("gebruikersnaam") != null && !session.getAttribute("gebruikersnaam").equals("")) && session.getAttribute("soort").equals("gebruiker")) { %>
<%@page import="databank.TblProduct"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="org.hibernate.Query"%>
<%@page import="databank.adapter.HibernateFactory"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="../headers/header.jsp" />
<jsp:include page="../headers/menu.jsp" />
<script	  src="https://code.jquery.com/jquery-3.2.1.js"
          integrity="sha256-DZAnKJ/6XZ9si04Hgrsxu/8s717jcIzLy3oi35EouyE="
crossorigin="anonymous"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<% int i = 0; %>

<section id="hoofdinhoud">
    <article id="gebruikers">
        <table border="1" width="100%">

            <%
                SessionFactory factory = HibernateFactory.getSessionFactory();
                Session sessie = factory.openSession();
                Query zoeken = sessie.createQuery("from TblProduct");
                List<TblProduct> producten = zoeken.list();
                for (i = 0; i < producten.size(); i++) {
                    request.setAttribute("product", producten.get(i).getId());
            %>





            <tr><td><%if (producten.get(i).getWebsite() != null && !producten.get(i).getWebsite().equals("")) {%><a href="<%=producten.get(i).getWebsite()%>" target="_blank"><%=producten.get(i).getNaam()%></a><% } else {%><%=producten.get(i).getNaam()%><%}%></td>
                <td><%=producten.get(i).getAantal()%></td>
                <td><%=producten.get(i).getBeschrijving().getSoort()%></td>
                <td class="test"><a href="../ProductVerwijderen.do?product=<%= producten.get(i).getId()%>">Verwijderen</a><br>
                    
                    <a href="productAanpassen.jsp?product=<%= producten.get(i).getId()%>">Aanpassen</a><br>
                        
                    <script>
                        $(function () {
                            var dialog;

                            // a workaround for a flaw in the demo system (http://dev.jqueryui.com/ticket/4375), ignore!
                            $("#dialog:ui-dialog").dialog("destroy");



                            $("#uitleen<%=i%>").hide();

                            dialog = $("#uitleen<%=i%>").dialog({
                                autoOpen: false,
                                height: 400,
                                width: 350,
                                modal: true,
                                closeOnEscape: true,
                                buttons: {
                                    "Uitlenen": function () {
                                        
                                        $("#doen<%=i%>").submit();
                                    }

                                },
                                close: function () {
                                    dialog.dialog("close");

                                }
                            });




                            $("#uitlenen<%=i%>").on("click", function (event) {
                                event.preventDefault();
                                dialog.dialog("open");
                            });
                        }
                        );
                    </script>
                    <a href="#" id="uitlenen<%=i%>">Uitlenen</a>
                    <div id="uitleen<%=i%>" title="Uitlening" align="center">
                            
                        <form id="doen<%=i%>" action="../Uitlenen.do" method="post">
                            <%=producten.get(i).getId()%>
                           <input type="hidden" value="<%=producten.get(i).getId()%>" name="productId" />
                            <% 
                                Query personen = sessie.createQuery("from TblPersoon order by gebruikersnaam");
                                
                                List<TblPersoon> pers = personen.list(); %>
                                
                                <select name="slctPersonen">
                                    <%for(int k = 0; k < pers.size(); k++) {%>
                                    <option value="<%=pers.get(k).getGebruikersnaam()%>"><%=pers.get(k).getGebruikersnaam()%>
                                    <%}%>
                                </select>
                                <%=i%>
                            <input type="text" placeholder="aantal" size="4" name="txtAantal" />
                        </form>

                    </div>

                </td>               
            </tr>           
            <%}
                sessie.close();
            %>
        </table>
    </article>
</section>    
</body>
</html>
<% } else {
        response.sendRedirect("/UitleenAnker/faces/inloggen.jsp");
    }
%>