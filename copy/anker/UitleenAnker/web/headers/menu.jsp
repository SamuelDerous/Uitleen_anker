<%-- 
    Document   : menu
    Created on : 20-mei-2017, 5:09:16
    Author     : zenodotus
--%>
<%if((session.getAttribute("gebruikersnaam") != null && !session.getAttribute("gebruikersnaam").equals(""))
        && (session.getAttribute("soort") != null && session.getAttribute("soort").equals("gebruiker"))) { %>
<div class="container">

            <ul id="nav">
                <li><a class="hsubs" href="#">Uitlenen</a>
                    <ul class="subs">
                        <li><a href="../users/uitlenen.jsp">Uitlenen</a></li>
                        <li><a href="../users/reservaties.jsp">Reservaties</a></li>
                        
                    </ul>
                </li>
                <li><a class="hsubs" href="#">Gebruikers</a>
                    <ul class="subs">
                        <li><a href="../users/gebruikers.jsp">Aanpassen/verwijderen</a></li>
                        <li><a href="../users/gebruikersAanpassen.jsp">Toevoegen</a></li>
                        <li><a href="../users/gebruikersBeheren.jsp">Beheren</a></li>
                        
                    </ul>
                </li>
                <li><a class="hsubs" href="#">Productie</a>
                    <ul class="subs">
                        <li><a href="../users/productToevoegen.jsp">Toevoegen/verwijderen</a></li>
                        <li><a href="../users/productAanpassen.jsp">Aanpassen</a></li>
                        <li><a href="../users/productBeheren.jsp">Beheren</a></li>
                        
                    </ul>
                </li>
                <li><a href="#">Inventarisatie</a>
                    <ul class="subs">
                        <li><a href="../users/invToevoegen.jsp">Toevoegen/verwijderen</a></li>
                        <li><a href="../users/invAanpassen.jsp">Aanpassen</a></li>
                        <li><a href="../users/invBeheren.jsp">Beheren</a></li>
                        
                    </ul>
                </li>
                
                <div id="lavalamp"></div>
            </ul>

        </div>
<%}%>