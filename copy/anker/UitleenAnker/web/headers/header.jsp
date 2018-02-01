<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>

<!DOCTYPE html>
<html lang="nl-be">
  <head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/hoofdpagina.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/menu.css">
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
    
    <!-- Load jQuery JS -->
    <script src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
    <!-- Load jQuery UI Main JS  -->
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/datatables.min.css" />
    
    
    <!-- Load SCRIPT.JS which will create datepicker for input field  -->
    <script src="${pageContext.request.contextPath}/js/maskedinput.js"></script>
    <script src="${pageContext.request.contextPath}/js/datum.js"></script>
    <script src="${pageContext.request.contextPath}/js/datatables.min.js"></script>

    
  </head>
  <body>
    
    <div id="wrapper">
      <header> 
      <img src="${pageContext.request.contextPath}/images/dekade.jpg">
        <b>Begeleidingscentrum Spermalie</b><br>
        Staggaardstraat 9, 8000 Brugge<br>
        tel. 050 47 25 06 <br>
        <b>De Kade - Het Anker</b><br>
        Beisbroekdreef 12, 8200 Brugge<br>
        tel.: 050 39 09 35 </header>
      <nav>
        <div id="menu" align="right">
            <% if(session.getAttribute("gebruikersnaam") != null && !(session.getAttribute("gebruikersnaam").equals(""))) {
                %><ul><li>Welkom, <%=session.getAttribute("gebruikersnaam")%></li>
                    <li><a href="${pageContext.request.contextPath}/uitloggen.jsp">Uitloggen</a></li>
                </ul>
            <%} else {%>
          <ul>
            <li><a href="${pageContext.request.contextPath}/inloggen.jsp">Inloggen</a></li>
            <li><a href="${pageContext.request.contextPath}/registreren.jsp">Registreren</a></li>
          </ul>
          <%}%>
        </div>
        <div id="dataMenu">
        	<s:form method="post" action="zoeken">
				<input type="text" id="txtZoeken" name="search" placeholder="Geef een zoekterm in" size="25" />
				<s:submit theme="simple" value="Zoeken" />        	
        	</s:form>
        	<hr />
        		
      </nav>
   
     
