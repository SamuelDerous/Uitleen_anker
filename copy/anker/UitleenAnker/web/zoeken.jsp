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

<style>
    .displayListView {
        display: inline-block;
        vertical-align: middle;
        margin-top:5px;
        margin-bottom:5px;
        float: none;
    }

    .displayRow {
        -moz-border-radius:10px; 
        -webkit-border-radius: 10px; 
        -khtml-border-radius: 10px; 
        border-radius: 10px; 
        color: gray;
    }
    .displayRow:hover {
        background-color:yellow;

    }

</style>
<section id="hoofdinhoud"> 
    <h2>Vond <s:property value="lijst.size()" /> hits </h2>
    <s:iterator var="result" value="lijst">
        <div class="lvLevel">
            <a href="accountReserveren?id=${result.get('Nummer')}">

                <div class="row displayRow">
                    <div class="col-xs-2 displayListView"><s:property value="#result.get('Naam')" /> <s:property value="#result.get('Beschrijving')" /></div>
                </div></a>

            <div><hr></div>
        </div>
    </a>
</s:iterator>

</section>
</div>
</body>
</html>
