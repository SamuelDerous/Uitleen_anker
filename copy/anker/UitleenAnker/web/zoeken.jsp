<%-- 
    Document   : zoeken
    Created on : 24-jun-2017, 0:48:18
    Author     : zenodotus
--%>

<%@page import="java.util.ArrayList, org.apache.lucene.document.Document"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="headers/header.jsp" />
<jsp:include page="headers/menu.jsp" />
<section id="hoofdinhoud">
    <% ArrayList<Document> lijst = (ArrayList<Document>) request.getAttribute("documenten"); 
    %><h2>Vond <%=lijst.size()%> hits </h2><%
    for(int i = 0; i < lijst.size(); i++) {
    %><a href="reservatie.jsp?id=<%= lijst.get(i).get("Nummer")%>"><article id="zoekItem">
        <p><%= lijst.get(i).get("Naam")%> <br> <%=lijst.get(i).get("Beschrijving")%>
        <hr>           
        </p>        
                
                    
        </article></a>
<%}%>
</section>
    </div>
  </body>
</html>
