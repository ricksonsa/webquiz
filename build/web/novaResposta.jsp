<%-- 
    Document   : novaResposta
    Created on : 02/06/2019, 01:20:37
    Author     : ricks
--%>

<%@page import="br.uninove.webquiz.model.Questao"%>
<%@page import="br.uniniove.webquiz.DAO.QuestaoDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
    QuestaoDAO questDAO = new QuestaoDAO();
    Questao quest = questDAO.getQuestao(Integer.parseInt(request.getParameter("idQuestao")));
    session.setAttribute("questao", quest);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
       <form action="salvaResposta.jsp" method="POST">
            <h2>
                Resposta: 
            </h2>
            <input type="text" name="resposta"/>
            
             <h2>
                Peso: 
            </h2>
            <input type="number" name="valor"/>
            
            <h2>
                É a alternativa correta: 
            </h2>
            <input type="checkbox" name="correta" value="correta"/>
            
            
            <br>
            <button type="submit">Salvar</button>
        </form>
    </body>
</html>
