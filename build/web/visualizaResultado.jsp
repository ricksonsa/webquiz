<%-- 
    Document   : visualizaResultado
    Created on : 03/06/2019, 22:12:46
    Author     : ricks
--%>

<%@page import="br.uniniove.webquiz.DAO.UsuarioDAO"%>
<%@page import="br.uniniove.webquiz.DAO.ResultadoDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="br.uninove.webquiz.model.Resposta"%>
<%@page import="br.uninove.webquiz.model.Questao"%>
<%@page import="br.uninove.webquiz.model.Prova"%>
<%@page import="br.uniniove.webquiz.DAO.ProvaDAO"%>
<%@page import="br.uniniove.webquiz.DAO.RespostaDAO"%>
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
    boolean fezEstaProva = false;
    ProvaDAO provaDAO = new ProvaDAO();
    int idUsuario = Integer.parseInt(new UsuarioDAO().getUserByName(session.getAttribute("usuario").toString()).getIdUsuario());
    Prova prova = provaDAO.getProvaById(Integer.parseInt(request.getParameter("idProva")));
    RespostaDAO respostaDAO = new RespostaDAO();
    ResultadoDAO resultDAO = new ResultadoDAO();
    List<Resposta> respostas = new ArrayList<>();
    
    prova = provaDAO.getProvaQuestoes(prova);
    
    for(Questao q: prova.getQuestoes()) {
        ArrayList<Resposta> resps = new ArrayList<Resposta>();
        Resposta r = resultDAO.getRespostaFromResultadoUsingIdQuestao(q.getIdQuestao(),idUsuario);
        if(r!= null) {
             resps.add(r);
        fezEstaProva = true;
        }
        q.setResposta(resps);
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
          <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">    
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
     
       <title>Prova</title>
       
                    
<style>
     body{
        margin-top: 5%;
        margin-left: 35%;
        background: #463e51;
    }
    
    .round{
        border-radius: 9px;
    }
    
       .backg{
        background: #7e7191 !important;
        border-radius: 9px !important;
        border: 1px solid black !important;
        color: white !important;
    }
    
    .image{
        width: 42px;
        
    }
    
    .card-body {
    -ms-flex: 1 1 auto;
    flex: 1 1 auto;
    padding: 1.25rem;
    color: white !important;
     background: #463e51 !important;
}
</style>
    </head>
    <body>        
        <a class="text-center" href="painel.jsp"><- Voltar ao painel</a>
        <div class="card text-center" style="width: 50%;">
            <div class="card-header">
            <%
                out.print("<h3>Resultados</h3>");
                out.print("<small>"+prova.getDescricaoProva()+"</small>");
            %>
            </div>
            
            <div class="card-body">
                
        <%
            if(fezEstaProva) {
               float total = 0;
            for(Questao q: prova.getQuestoes()) {
            
            out.print("<h3>" + q.getQuestao() + "</h3>");
            
            for(Resposta r: q.getResposta()) {
                out.print("<p>" + r.getResposta() + " - Peso: " + r.getValor());
                
                if(r.isCorreta()){
                    out.print(" <span style='color:white;background:green; padding: 2px;'>CORRETA</span>");
                    total += r.getValor();
                } 
                else
                    out.print(" <span style='color:white;background:red; padding: 2px;'>ERRADO</span>");
                //out.print("<a style='color:white;background:red;float:right;padding:2px;' href='removerResposta.jsp?idResposta="+r.getIdResposta()+"'>Remover</a>");
                out.print("</p>");
                
                    } 
                }
            out.print("<hr>");
            out.print("<h3>Nota: "+total+"</h3>");
            }
            else{
                out.print("<h3>Prova não realizada.</h3>");
            }
            
        %>
   
            </div>
        
        
        </div>
      
    </body>
</html>