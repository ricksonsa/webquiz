<%-- 
    Document   : excluiProva
    Created on : 04/06/2019, 19:38:49
    Author     : ricks
--%>

<%@page import="br.uniniove.webquiz.DAO.ProvaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ProvaDAO dao =  new ProvaDAO();
    dao.excluirProva(Integer.parseInt( request.getParameter("idProva")));
    response.sendRedirect("painel.jsp");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
