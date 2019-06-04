<%-- 
    Document   : salvaProva
    Created on : 03/06/2019, 21:10:57
    Author     : ricks
--%>

<%@page import="br.uniniove.webquiz.DAO.UsuarioDAO"%>
<%@page import="br.uninove.webquiz.model.Resposta"%>
<%@page import="br.uniniove.webquiz.DAO.ResultadoDAO"%>
<%@page import="java.util.ArrayList"%>
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
    int idProva = Integer.parseInt(request.getParameter("idProva"));
    int idUsuario = Integer.parseInt(new UsuarioDAO().getUserByName(session.getAttribute("usuario").toString()).getIdUsuario());
   
        QuestaoDAO qDAO = new QuestaoDAO();
        ArrayList<Questao> questoes = new ArrayList<Questao>();
        questoes = qDAO.getListaQuestoes(idProva);
    
        for(Questao quest: questoes) {
            for(Resposta resp: quest.getResposta()){
                int respParam = Integer.parseInt(request.getParameter(quest.toString()));
                if(respParam == resp.getIdResposta()) {
                    ResultadoDAO rDAO = new ResultadoDAO();
                    rDAO.addResultado(quest.getIdQuestao(), respParam, idUsuario);
                }
            }  
        }
    
        

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Prova finalizada!</h1>
        <%
            response.sendRedirect("visualizaResultado.jsp?idProva="+idProva);
        %>
    </body>
</html>
