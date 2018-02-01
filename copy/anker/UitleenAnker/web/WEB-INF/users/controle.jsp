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


<% int i = 0; %>

<section id="hoofdinhoud">
    <article id="gebruikers">
        <div id="foutmelding">
                            <s:actionerror escape="false" />
                        </div>
        <table id="controleTable" border="1" width="100%">
            
            <thead>
            <tr>
                <th>Product</th>
                <th>Aantal</th>
                <th>Soort</th>
                <th>Volledigheid</th>
                <th>Controle</th>
            </tr>
        </thead>
        <tbody>
            <jsp:useBean id="producten" class="databank.dao.ProductDao" />
            <c:forEach var="product" items="${producten.teControleren}">
                
                
                    
                    <tr><td><form action="gecontroleerd" method="post" id="form${product.id}"><input type="hidden" name="productId" value="${product.id}" /></form><c:if test="${product.website ne null && product.website ne ''}" var="testWebsite"><a href="${product.website}" target="_blank"></c:if>${product.naam}<c:if test="${testWebsite}"></a></c:if></td>
                <td>${product.aantal}</td>
                <td>${product.beschrijving.soort}</td>
                <td><input type="checkbox" form="form${product.id}" name="volledig" value="on" <c:if test="${product.volledig eq 1}">checked</c:if>>Volledig</td>
                <td class="test"><input form="form${product.id}" type="submit" value="Gecontroleerd" /><br>
                    
                    

                </td></tr>
                
                       
            </c:forEach>
        </tbody>
        </table>
    </article>
</section>  
            
            <script language="JavaScript" type="text/javascript">
<!--
$(document).ready(function() {
    $('#controleTable').DataTable();
} );
-->
</script> 
</body>
</html>
<% } else {
        response.sendRedirect("/UitleenAnker/faces/inloggen.jsp");
    }%>
