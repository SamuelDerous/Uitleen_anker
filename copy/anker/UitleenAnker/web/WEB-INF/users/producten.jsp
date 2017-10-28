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
<%@taglib uri="/struts-tags" prefix="s"%>

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

            
            <jsp:useBean id="producten" class="databank.dao.ProductDao" />
            <c:forEach var="product" items="${producten.alleProducten}">


                <tr><td><c:if test="${product.website ne null || product.website ne ''}" var="testWebsite"><a href="${product.website}" target="_blank"></c:if>${product.naam}<c:if test="${testWebsite}"></a></c:if></td>
                <td>${product.aantal}</td>
                <td>${product.beschrijving.soort}</td>
                <td class="test"><a href="verwijderenProduct?productId=${product.id}">Verwijderen</a><br>
                    
                    <a href="producten?productId=${product.id}">Aanpassen</a><br>
                    <script>
                    $(function () {
                            var dialog;

                            // a workaround for a flaw in the demo system (http://dev.jqueryui.com/ticket/4375), ignore!
                            $("#dialog:ui-dialog").dialog("destroy");



                            $("#uitleen${product.id}").hide();

                            dialog = $("#uitleen${product.id}").dialog({
                                autoOpen: false,
                                height: 400,
                                width: 350,
                                modal: true,
                                closeOnEscape: true,
                                buttons: {
                                    "Uitlenen": function () {
                                        
                                        $("#doen${product.id}").submit();
                                    }

                                },
                                close: function () {
                                    dialog.dialog("close");

                                }
                            });




                            $("#uitlenen${product.id}").on("click", function (event) {
                                event.preventDefault();
                                dialog.dialog("open");
                            });
                        }
                        );
                </script>
                    <a href="#" id="uitlenen${product.id}">Uitlenen</a>
                    <div id="uitleen${product.id}" title="Uitlening" align="center">
                        <div id="foutmelding">
                            <s:actionerror escape="false" />
                        </div>
                        <form id="doen${product.id}" action="uitlenenProduct" method="post">
                           
                           <input type="hidden" value="${product.id}" name="productId" />
                           <input type="hidden" value="/users/producten.jsp" name="website" /> 
                           <select name="gebruikersnaam"> 
                                <jsp:useBean id="gebruikers" class="databank.dao.PersoonDao" />
                                <c:forEach var="gebruiker" items="${gebruikers.alleGebruikers}">
                                
                                
                                    
                                    <option value="${gebruiker.gebruikersnaam}">${gebruiker.gebruikersnaam}</option>
                                            
                                </c:forEach>           
                                </select>
                            <input type="text" placeholder="aantal" size="4" name="aantal" />
                        </form>

                    </div>

                </td>               
            </tr>           
            </c:forEach>
        </table>
    </article>
</section>    
</body>
</html>
<% } else {
        response.sendRedirect("/UitleenAnker/faces/inloggen.jsp");
    }
%>