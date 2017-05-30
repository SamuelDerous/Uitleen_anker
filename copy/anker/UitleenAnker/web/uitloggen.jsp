<%-- 
    Document   : uitloggen
    Created on : 27-mei-2017, 15:41:24
    Author     : zenodotus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% session.setAttribute("gebruikersnaam", null);
        session.setAttribute("soort", null);
        response.sendRedirect("inloggen.jsp"); %>
    </body>
</html>
