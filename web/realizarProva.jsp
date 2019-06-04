<%-- 
    Document   : realizarProva
    Created on : 28/05/2019, 17:38:12
    Author     : thiagograzianitraue
--%>

<%@page import="br.uninove.webquiz.model.Questao"%>
<%@page import="br.uninove.webquiz.model.Resposta"%>
<%@page import="java.util.ArrayList"%>
<%@page import="br.uniniove.webquiz.DAO.RespostaDAO"%>
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
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% int idProva = Integer.parseInt(request.getParameter("idProva")); %>
        <form id="theForm" action="salvaProva.jsp?idProva=<%out.print(idProva);%>" method="POST">
        <%
           

            QuestaoDAO qDAO = new QuestaoDAO();
            ArrayList<Questao> questoes = new ArrayList<Questao>();
            questoes = qDAO.getListaQuestoes(idProva);

            for (int i = 0; i < questoes.size(); i++) {
                out.print("<b>" + (i + 1) + " - " + questoes.get(i).getQuestao() + "</b><br/>");
                for (int j = 0; j < questoes.get(i).getResposta().size(); j++) {
                    out.print("&emsp; <input type=\"radio\" name=\"" + questoes.get(i).getIdQuestao() + "\" value="+questoes.get(i).getResposta().get(j).getIdResposta()+">" + questoes.get(i).getResposta().get(j).getResposta() + "<br>");
                            //+ "" + questoes.get(i).getResposta().get(j).getResposta() + "<br/>");
                }

                out.print("<br/><br/>");
            }


        %>
        <button type="submit">Enviar</button>
        </form>

        <script>
            
            function send() {
                
                document.getElementById('theForm').submit();
            }
        </script>
    </body>
</html>
