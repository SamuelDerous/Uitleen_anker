<%-- 
    Document   : registreren
    Created on : 10-mei-2017, 11:59:46
    Author     : zenodotus
--%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="headers/header.jsp" />
<script type="text/javascript" src="js/validation.js"></script>

<section id="hoofdinhoud">
			<article id="formulier" align="center">
				<h2 align="center">Registreren</h2>
				<s:form action="registreren" name="registratie">
					<table border="0" align="center" width="25%">
						<tr><td colspan="2"><div id="foutmelding" name="foutmelding">
                                                            <s:actionerror />
                                    
                                                    </div></td></tr>
                                                <tr><td><s:textfield class="invullen" name="gebruikersnaam" id="txtGebruikersnaam" label="gebruikersnaam" /></td></tr>
                                                <tr><s:password class="invullen" name="wachtwoord" id="txtWachtwoord" label="wachtwoord" /></td></tr>
                                                <tr><td><s:password class="invullen" name="bevestig" id="txtBevestig" label="Bevestig wachtwoord" /></td></tr>
						<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
                                                <tr><td><s:textfield class="invullen" name="voornaam" id="txtVoornaam" label="Voornaam" /></td></tr>
                                                <tr><td><s:textfield class="invullen" name="naam" id="txtNaam" label="Naam" /></td></tr>
						<tr><s:textarea id="txtAdres" name="adres" class="invullen" rows="3" label="Adres" /></td></tr>
						<tr><td><s:textfield class="invullen" name="telefoon" id="txtTelefoon" label="Telefoon" /></td></tr>
                                                <tr><td><s:textfield class="invullen" name="email" id="txtEmail" label="E-mail"/></td></tr>
						<tr><td>&nbsp;</td><td>&nbsp;</td></tr>
						<tr><td colspan="2" align="center"><<s:submit value="Registreer" id="txtSubmit" /><s:reset value="Wissen" /></td></tr>
						<tr><td>&nbsp;</td><td>&nbsp;</td></tr>						
					</table>				
				</s:form>			
			</article>      
      </section>
    </div>
  </body>
</html>
