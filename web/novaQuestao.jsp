<%-- 
    Document   : novaQuestao
    Created on : 28/05/2019, 20:48:32
    Author     : ricks
--%>

<%@page import="br.uninove.webquiz.model.Prova"%>
<%@page import="br.uniniove.webquiz.DAO.ProvaDAO"%>
<%@page import="br.uninove.webquiz.model.Questao"%>
<%@page import="br.uniniove.webquiz.DAO.QuestaoDAO"%>
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
    QuestaoDAO dao = new QuestaoDAO();
    Questao quest = new Questao();
    quest.setQuestao(request.getParameter("nomeQuestao"));
    
    
    quest = dao.insertQuestao(quest);
    ProvaDAO provaDAO = new ProvaDAO();
    Prova prova = (Prova)session.getAttribute("prova");
    
    provaDAO.relaciona(prova.getIdProva(), quest.getIdQuestao());

    session.setAttribute("questao", quest);
    response.sendRedirect("novaResposta.jsp?idQuestao="+quest.getIdQuestao());
    
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
