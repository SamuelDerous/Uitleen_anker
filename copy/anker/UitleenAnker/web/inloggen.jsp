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
				<form method="post" action="inloggen.do">
					<table border="0" align="center" width="25%">
						<tr><td>Gebruikersnaam: </td><td><input type="text" class="invullen" id="txtGebruikersnaam" placeholder="Geef uw gebruikersnaam op" /></td></tr>
						<tr><td>Wachtwoord: </td><td><input type="password" class="invullen" id="txtWachtwoord"  /></td></tr>
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
