<%-- 
    Document   : inloggen.jsp
    Created on : 10-mei-2017, 11:59:34
    Author     : zenodotus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />

<section id="hoofdinhoud">
			<article id="formulier" align="center">
				<h2 align="center">Inloggen</h2>
                                <div id="foutmelding">
                                    <%if(session.getAttribute("gebruikersnaam") != null && session.getAttribute("gebruikersnaam").equals("")) { %>
                                        Gebruikersnaam en wachtwoord zijn niet gekend.
                                    <%}%>
                                </div>
				<form method="post" action="Inloggen.do">
					<table border="0" align="center" width="25%">
						<tr><td>Gebruikersnaam: </td><td><input type="text" class="invullen" name="txtGebruikersnaam" id="txtGebruikersnaam" placeholder="Geef uw gebruikersnaam op" /></td></tr>
						<tr><td>Wachtwoord: </td><td><input type="password" class="invullen" name="txtWachtwoord" id="txtWachtwoord"  /></td></tr>
						<tr><td>&nbsp;</td><td>&nbsp;</td></tr>						
						<tr><td colspan="2" align="center"><input type="submit" value="Inloggen" id="txtSubmit" /><input type="reset" value="Wissen" /></td></tr>	
						<tr><td>&nbsp;</td><td>&nbsp;</td></tr>				
					</table>				
				</form>			
			</article>      
      </section>
    </div>
  </body>
</html>
