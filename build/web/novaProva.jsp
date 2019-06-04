<%-- 
    Document   : novaProva
    Created on : 28/05/2019, 20:46:45
    Author     : ricks
--%>

<%@page import="br.uniniove.webquiz.DAO.ProvaDAO"%>
<%@page import="br.uninove.webquiz.model.Prova"%>
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
String descricao = request.getParameter("descricao");

Prova prova = new Prova();
prova.setDescricaoProva(descricao);

ProvaDAO dao = new ProvaDAO();

prova = dao.inserirProva(prova);

session.setAttribute("prova", prova);
response.sendRedirect("novaQuestao.html");

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
     
        
    </body>
</html>
