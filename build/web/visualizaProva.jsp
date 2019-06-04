<%-- 
    Document   : visualizaProva
    Created on : 01/06/2019, 13:55:41
    Author     : ricks
--%>

<%@page import="br.uninove.webquiz.model.Resposta"%>
<%@page import="br.uniniove.webquiz.DAO.RespostaDAO"%>
<%@page import="br.uniniove.webquiz.DAO.QuestaoDAO"%>
<%@page import="br.uniniove.webquiz.DAO.ProvaDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="br.uninove.webquiz.model.Questao"%>
<%@page import="java.util.List"%>
<%@page import="br.uninove.webquiz.model.Prova"%>
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
    Prova prova = (Prova)session.getAttribute("prova");
    
    ProvaDAO provaDAO = new ProvaDAO();
    RespostaDAO respostaDAO = new RespostaDAO();
    
    prova = provaDAO.getProvaQuestoes(prova);
    
    for(Questao q: prova.getQuestoes()) {
        q.setResposta(respostaDAO.getListaRespostas(q.getIdQuestao()));
    }
    
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
          <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">    
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
     
             
<style>
    body{
        margin-top: 10%;
        margin-left: 30%;
    }
</style>

        <title>Prova</title>
    </head>
    <body>     
        <a class="text-center" href="painel.jsp"><- Voltar ao painel</a>
        <div class="card text-center" style="width: 50%;">
            
            <div class="card-header">
                <%
                out.print("<h3>"+prova.getDescricaoProva()+"</h3>");
                %>
             
            </div>
            
            <div class="card-body">
                
        <%
            for(Questao q: prova.getQuestoes()) {
            
            out.print("<h3>" + q.getQuestao() + "</h3>");
            
            for(Resposta r: q.getResposta()) {
                out.print("<p>" + r.getResposta() + " - Peso: " + r.getValor());
                if(r.isCorreta())
                    out.print(" <span style='color:white;background:green; padding: 2px;'>CORRETA</span>");
                out.print("<a style='color:white;background:red;float:right;padding:2px;' href='removerResposta.jsp?idResposta="+r.getIdResposta()+"'>Remover</a>");
                out.print("</p>");
                
            }
            out.print("<a href='novaResposta.jsp?idQuestao="+q.getIdQuestao()+"'>Nova alternativa</a>");
    out.print("<hr>");
    }%>
    
    <a href='novaQuestao.html'>Nova Questão</a>
        
            </div>
        
        
        </div>
      
    </body>
</html>
