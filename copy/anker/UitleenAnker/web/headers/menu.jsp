<%-- 
    Document   : menu
    Created on : 20-mei-2017, 5:09:16
    Author     : zenodotus
--%>
<%@page import="databank.TblUitleen"%>
<%@page import="databank.TblReservatie"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.List"%>
<%@page import="databank.TblProduct"%>
<%@page import="org.hibernate.Query"%>
<%@page import="org.hibernate.Session"%>
<%@page import="databank.adapter.HibernateFactory"%>
<%@page import="org.hibernate.SessionFactory"%>

<% String gebruiker = (String) session.getAttribute("gebruikersnaam");
String soort = (String) session.getAttribute("soort"); %>
<%if((session.getAttribute("gebruikersnaam") != null && !session.getAttribute("gebruikersnaam").equals(""))
        && (session.getAttribute("soort") != null && session.getAttribute("soort").equals("gebruiker"))) { %>
<div class="container">

            <ul id="nav">
                <li><a class="hsubs" href="#">Uitlenen</a>
                    <ul class="subs">
                        <li><a href="/UitleenAnker/faces/users/uitleningToevoegen.jsp">Toevoegen</a></li>
                        <li><a href="/UitleenAnker/faces/users/uitleningen.jsp">Uitlenen</a></li>
                        <li><a href="/UitleenAnker/faces/users/reservaties.jsp">Reservaties</a></li>
                        
                    </ul>
                </li>
                <li><a class="hsubs" href="#">Gebruikers</a>
                    <ul class="subs">
                        <li><a href="/UitleenAnker/faces/users/gebruikers.jsp">Aanpassen/verwijderen</a></li>
                        <li><a href="/UitleenAnker/faces/users/gebToevoegen.jsp">Toevoegen</a></li>
                        
                    </ul>
                </li>
                <li><a class="hsubs" href="#">Productie</a>
                    <ul class="subs">
                        <li><a href="/UitleenAnker/faces/users/producten.jsp">Aanpassen/verwijderen</a></li>
                        <li><a href="/UitleenAnker/faces/users/productToevoegen.jsp">Toevoegen</a></li>
                        
                    </ul>
                </li>
                <li><a href="#">Inventarisatie</a>
                    <ul class="subs">
                        <li><a href="/UitleenAnker/faces/users/inventaris.jsp">Verwijderen</a></li>
                        <li><a href="/UitleenAnker/faces/users/inventToevoegen.jsp">Toevoegen</a></li>
                        
                    </ul>
                </li>
                
                
                <div id="lavalamp"></div>
            </ul>

        </div>
        
<%} else if ((session.getAttribute("gebruikersnaam") != null && !session.getAttribute("gebruikersnaam").equals(""))
        && (session.getAttribute("soort") != null && (session.getAttribute("soort").equals("medewerker") || session.getAttribute("soort").equals("ontlener")))) { %>
<div class="container">

            <ul id="nav">
                <li><a class="hsubs" href="../ontleners/uitleningen.jsp?action=uitlening">Uitleningen</a>
                    
                </li>
                <li><a class="hsubs" href="../ontleners/uitleningen.jsp?action=reservering">Reserveringen</a>
                    
                </li>
                <li><a class="hsubs" href="../ontleners/account.jsp">Account</a>
                    
                </li>
                
                <div id="lavalamp"></div>
            </ul>

        </div>
        
<%}%>