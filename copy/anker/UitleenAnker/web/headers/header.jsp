<!DOCTYPE html>
<html lang="nl-be">
  <head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/hoofdpagina.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/menu.css">
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
                    <li><a href="uitloggen.jsp">Uitloggen</a></li>
                </ul>
            <%} else {%>
          <ul>
            <li><a href="inloggen.jsp">Inloggen</a></li>
            <li><a href="registreren.jsp">Registreren</a></li>
          </ul>
          <%}%>
        </div>
        <div id="dataMenu">
        	<form method="post" action="zoeken.do">
				<input type="text" id="txtZoeken" placeholder="Geef een zoekterm in" size="25" />
				<input type="submit" value="Zoeken" />        	
        	</form>
        	<hr />
        		
      </nav>
   
     