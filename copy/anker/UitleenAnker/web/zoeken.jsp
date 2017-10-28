<%-- 
    Document   : zoeken
    Created on : 24-jun-2017, 0:48:18
    Author     : zenodotus
--%>

<%@page import="java.util.ArrayList, org.apache.lucene.document.Document"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<jsp:include page="headers/header.jsp" />
<jsp:include page="headers/menu.jsp" />
<section id="hoofdinhoud"> 
<h2>Vond <s:property value="lijst.size()" /> hits </h2>
<s:iterator var="result" value="lijst">
    
    <a href="accountReserveren?id=${result.get('Nummer')}"><article id="zoekItem">
            <p><s:property value="#result.get('Naam')" /> <s:property value="#result.get('Beschrijving')" />
        <hr>           
        </p>        
                
                    
        </article></a>
</s:iterator>

</section>
    </div>
  </body>
</html>
