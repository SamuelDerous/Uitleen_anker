<%-- 
    Document   : inloggen.jsp
    Created on : 10-mei-2017, 11:59:34
    Author     : zenodotus
--%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="headers/header.jsp" />
<jsp:include page="headers/menu.jsp" />
<section id="hoofdinhoud">
			<article id="formulier" align="center">
				<h2 align="center">Inloggen</h2>
                                
				<s:form action="loginUser">
                                    <table border="0" width="25%" align="center">
                                        <tr colspan="2" align="center">        <div id="foutmelding" name="foutmelding">
                                                                    <s:actionerror />
                                        </div></tr> 
                                        <tr><td><s:textfield name="gebruikersnaam" label="gebruikersnaam" placeholder="Geef uw gebruikersnaam op"/></td></tr>
                                        <tr><td><s:password name="wachtwoord" label="wachtwoord"/></tr></td>
                                    <tr><td>&nbsp;</td></tr>	<br />						
                                    <tr><td><s:submit value="Inloggen" id="txtSubmit" /><s:reset value="Wissen" /></td><tr>	
						<tr><td>&nbsp;</td></tr>					
                                    </table>
				</s:form>			
			</article>      
      </section>
    </div>
  </body>
</html>
