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
                        <li><a href="uitleningToevoegen">Toevoegen</a></li>
                        <li><a href="uitleningenUsers">Uitlenen</a></li>
                        <li><a href="reservatiesUsers">Reservaties</a></li>
                        
                    </ul>
                </li>
                <li><a class="hsubs" href="#">Gebruikers</a>
                    <ul class="subs">
                        <li><a href="gebruikersUsers">Aanpassen/verwijderen</a></li>
                        <li><a href="gebToevoegenUsers">Toevoegen</a></li>
                        
                    </ul>
                </li>
                <li><a class="hsubs" href="#">Productie</a>
                    <ul class="subs">
                        <li><a href="productenUsers">Aanpassen/verwijderen</a></li>
                        <li><a href="productControle">Te controleren</a></li>
                        <li><a href="productToevoegenUsers">Toevoegen</a></li>
                        
                    </ul>
                </li>
                <li><a class="hsubs" href="#">Inventarisatie</a>
                    <ul class="subs">
                        <li><a href="inventarisUsers">Verwijderen</a></li>
                        <li><a href="inventToevoegenUsers">Toevoegen</a></li>
                        
                    </ul>
                </li>
                
                <li><a href="#">Overzichten</a>
                    <ul class="subs">
                        <li><a href="overzichtUitleningen">periodiek Overzicht</a></li>
                        <li><a href="uitleningenArchief">Uitleningen</a>
                    </ul>
                </li>
                
                
                <div id="lavalamp"></div>
            </ul>

        </div>
        
<%} else if ((session.getAttribute("gebruikersnaam") != null && !session.getAttribute("gebruikersnaam").equals(""))) { %>
<div class="container">

            <ul align="right" id="nav">
                <li><a class="hsubs" href="uitleningenUitlener?action=uitlening">Uitleningen</a>
                    
                </li>
                <li><a class="hsubs" href="uitleningenUitlener?action=reservering">Reserveringen</a>
                    
                </li>
                <li><a class="hsubs" href="gebruikersGen?gebruikersnaam=${gebruikersnaam}">Account</a>
                    
                </li>
                
                <div id="lavalamp"></div>
            </ul>

        </div>
        
<%}%>