<%-- 
    Document   : registreren
    Created on : 10-mei-2017, 11:59:46
    Author     : zenodotus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />

<section id="hoofdinhoud">
			<article id="formulier" align="center">
				<h2 align="center">Registreren</h2>
				<form method="post" action="inloggen.do">
					<table border="0" align="center" width="25%">
						<tr><td>Gebruikersnaam: </td><td><input type="text" class="invullen" id="txtGebruikersnaam" /></td></tr>
						<tr><td>Wachtwoord: </td><td><input type="password" class="invullen" id="txtWachtwoord" /></td></tr>
						<tr><td>Bevestig wachtwoord: </td><td><input type="password" class="invullen" id="txtBevestig" /></td></tr>
						<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
						<tr><td>Voornaam: </td><td><input type="text" class="invullen" id="txtVoornaam"/></td></tr>
						<tr><td>Naam: </td><td><input type="text" class="invullen" id="txtNaam" /></td></tr>
						<tr><td>Adres: </td><td><textarea id="txtAdres" class="invullen" rows="3" ></textarea></td></tr>
						<tr><td>Telefoon: </td><td><input type="text" class="invullen" id="txtTelefoon" /></td></tr>
						<tr><td>E-mail: </td><td><input type="text" class="invullen" id="txtEmail" /></td></tr>
						<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
						<tr><td colspan="2" align="center"><input type="submit" value="Registreer" id="txtSubmit" /><input type="reset" value="Wissen" /></td></tr>
						<tr><td>&nbsp;</td><td>&nbsp;</td></tr>						
					</table>				
				</form>			
			</article>      
      </section>
    </div>
  </body>
</html>
