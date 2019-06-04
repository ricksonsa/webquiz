<%-- 
    Document   : novaResposta
    Created on : 28/05/2019, 20:48:45
    Author     : ricks
--%>

<%@page import="br.uniniove.webquiz.DAO.RespostaDAO"%>
<%@page import="br.uninove.webquiz.model.Resposta"%>
<%@page import="br.uninove.webquiz.model.Questao"%>
<%@page import="br.uniniove.webquiz.DAO.QuestaoDAO"%>
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
RespostaDAO dao = new RespostaDAO();
Questao quest = (Questao)session.getAttribute("questao");

Resposta resp = new Resposta();
resp.setResposta((String)request.getParameter("resposta"));

float f = Float.parseFloat(request.getParameter("valor"));

resp.setValor(f);

boolean correta = request.getParameter("correta") != null ? true : false;

resp.setCorreta(correta);

resp.setIdResposta(dao.inserirResposta(resp, quest.getIdQuestao()).getIdResposta());;
quest.setResposta(dao.getListaRespostas(quest.getIdQuestao()));
dao.relaciona(resp.getIdResposta(), quest.getIdQuestao());

session.setAttribute("questao", quest);
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
