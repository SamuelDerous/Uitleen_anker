<%-- 
    Document   : gebToevoegen
    Created on : 20-mei-2017, 12:14:16
    Author     : zenodotus
--%>
<%@page import="databank.TblProduct"%>
<% if((session.getAttribute("gebruikersnaam") != null && !session.getAttribute("gebruikersnaam").equals("")) && session.getAttribute("soort").equals("gebruiker")) { %>
<%@page import="databank.TblPersoon"%>
<%@page import="org.hibernate.Session"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="org.hibernate.Query"%>
<%@page import="databank.adapter.HibernateFactory"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="../headers/header.jsp" />
<jsp:include page="../headers/menu.jsp" />
<section id="hoofdinhoud">
    <article id="gebruikers">
        <table border="1" width="100%">
            <% 
                SessionFactory factory = HibernateFactory.getSessionFactory();
                Session sessie = factory.openSession();
                Query zoeken = sessie.createQuery("from TblPersoon");
                List<TblPersoon> personen = zoeken.list(); 
                for(int i = 0; i < personen.size(); i++) {
                    request.setAttribute("gebruiker", personen.get(i).getGebruikersnaam());
                %>
                
                <tr><td><%=personen.get(i).getGebruikersnaam()%></td>
                    <td><%=personen.get(i).getVoornaam()%></td>
                    <td><%=personen.get(i).getNaam()%></td>
                    <td><%=personen.get(i).getAdres()%></td>
                    <td><%=personen.get(i).getTelefoon()%></td>
                    <td><%=personen.get(i).getEMail()%></td>
                    <td><a href="../Gebruikers.do?gebruiker=<%= personen.get(i).getGebruikersnaam()%>">Verwijderen</a><br>
                        <a href="gebAanpassen.jsp?gebruiker=<%= personen.get(i).getGebruikersnaam()%>">Aanpassen</a><br>
                        <script>
                    $(function () {
                            var dialog;

                            // a workaround for a flaw in the demo system (http://dev.jqueryui.com/ticket/4375), ignore!
                            $("#dialog:ui-dialog").dialog("destroy");



                            $("#uitleen<%=i%>").hide();

                            dialog = $("#uitleen<%=i%>").dialog({
                                autoOpen: ${automatischOpenen},
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
                          <div id="foutmelding">
                            <%if(request.getAttribute("uitlening") != null && request.getAttribute("uitlening").equals("uitgeleend")) {%>
                                Het maximaal aantal uitleningen is bereikt
                                <%request.setAttribute("automatischOpenen", true);
                            }%>
                        </div>  
                        <form id="doen<%=i%>" action="../Uitlenen.do" method="post">
                            
                           <input type="hidden" value="<%=personen.get(i).getGebruikersnaam()%>" name="slctPersonen" />
                           <input type="hidden" value="/users/gebruikers.jsp" name="website" />
                            <% 
                                Query qryProduct = sessie.createQuery("from TblProduct order by naam");
                                
                                List<TblProduct> producten = qryProduct.list(); %>
                                
                                
                                <select name="productId">
                                    <%for(int k = 0; k < producten.size(); k++) {%>
                                    <option value="<%=producten.get(k).getId()%>"><%=producten.get(k).getNaam()%></option>
                                    <%}%>
                                </select>
                                
                                
                            <input type="text" placeholder="aantal" size="4" name="txtAantal" />
                        </form>

                    </div>

                        <br>
                           <script>
                    $(function () {
                            var dialog;

                            // a workaround for a flaw in the demo system (http://dev.jqueryui.com/ticket/4375), ignore!
                            $("#dialog:ui-dialog").dialog("destroy");



                            $("#reserveer<%=i%>").hide();

                            dialog = $("#reserveer<%=i%>").dialog({
                                autoOpen: ${automatischOpenen},
                                height: 400,
                                width: 350,
                                modal: true,
                                closeOnEscape: true,
                                buttons: {
                                    "Reserveren": function () {
                                        
                                        $("#reserve<%=i%>").submit();
                                    }

                                },
                                close: function () {
                                    dialog.dialog("close");

                                }
                            });




                            $("#reserveren<%=i%>").on("click", function (event) {
                                event.preventDefault();
                                dialog.dialog("open");
                            });
                        }
                        );
                </script>
                        <a id="reserveren<%=i%>" href="Reserveren.do?gebruiker=<%=personen.get(i).getGebruikersnaam()%>">Reserveren</a>
                    <div id="reserveer<%=i%>" title="Reserveren" align="center">
                            <div id="foutmelding">
                            <%if(request.getAttribute("uitlening") != null && request.getAttribute("uitlening").equals("uitgeleend")) {%>
                                Het maximaal aantal uitleningen is bereikt
                                <%request.setAttribute("automatischOpenen", true);
                            }%>
                        </div>
                        <form id="reserve<%=i%>" action="../Reservatie.do" method="post">
                            
                           <input type="hidden" value="<%=personen.get(i).getGebruikersnaam()%>" name="gebruikersnaam" />
                            
                                
                                
                                <select name="id">
                                    <%for(int k = 0; k < producten.size(); k++) {%>
                                    <option value="<%=producten.get(k).getId()%>"><%=producten.get(k).getNaam()%></option>
                                    <%}%>
                                </select>
                                
                                
                            <input type="text" placeholder="aantal" size="4" name="txtAantal" />
                        </form>

                    </div>

                    </td></tr>
                <%}
                sessie.close();
                %>
        </table>
    </article>
</section>    
</body>
</html>
<%} else {
    response.sendRedirect("/UitleenAnker/faces/inloggen.jsp");
}%>