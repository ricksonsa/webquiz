<%-- 
    Document   : editarProva
    Created on : 02/06/2019, 00:18:15
    Author     : ricks
--%>

<%@page import="br.uninove.webquiz.model.Prova"%>
<%@page import="br.uniniove.webquiz.DAO.ProvaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
            if (session.getAttribute("login") != null) {
                if ((Boolean) session.getAttribute("login")) {
                } else {
                    response.sendRedirect("index.html");
                }
            }else{
                response.sendRedirect("index.html");
            }
        %>
           <%
            request.setCharacterEncoding("UTF-8");
        %>
<%
int idProva = Integer.parseInt(request.getParameter("idProva"));

ProvaDAO dao = new ProvaDAO();

Prova prova = dao.getProvaById(idProva);
session.setAttribute("prova",prova);
response.sendRedirect("visualizaProva.jsp");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
