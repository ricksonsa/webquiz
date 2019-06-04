<%-- 
    Document   : removerResposta
    Created on : 02/06/2019, 03:21:36
    Author     : ricks
--%>
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
<%@page import="br.uniniove.webquiz.DAO.RespostaDAO"%>
<%
RespostaDAO dao = new RespostaDAO();
dao.deleteReposta(Integer.parseInt(request.getParameter("idResposta")));
response.sendRedirect("visualizaProva.jsp");
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
