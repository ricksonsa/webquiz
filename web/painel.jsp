<%-- 
    Document   : painel
    Created on : 28/05/2019, 16:32:00
    Author     : thiagograzianitraue
--%>

<%@page import="br.uniniove.webquiz.DAO.ProvaDAO"%>
<%@page import="br.uninove.webquiz.model.Prova"%>
<%@page import="java.util.ArrayList"%>
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
              <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">    
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
     
             
<style>
    body{
        margin-top: 5%;
        margin-left: 60px;
        margin-right: 60px;
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
</style>
    </head>
    <body>
        <nav class="navbar navbar-light bg-light backg">
  <a class="navbar-brand" href="#">
    <img src="https://cdn4.iconfinder.com/data/icons/school-education-4/256/Test-512.png" width="30" height="30" class="d-inline-block align-top" alt="">
    Prova 2 AV1 - Lista de Provas disponíveis
  </a>
</nav>
        <br/>
        <br/>
        <a href="novaProva.html">Cadastrar uma prova nova...</a>
        <%
            ArrayList<Prova> provas = new ArrayList<Prova>();
            ProvaDAO pDAO = new ProvaDAO();
            provas = pDAO.getProvas();

            if (provas.isEmpty()) {
                out.print("Sem provas cadastradas!");
            } else {
                out.print("<table class='table table-dark round'>");
                out.print("<tr>");
                out.print("<th>Prova</th>");
                out.print("<th>Qtd. de questões</th>");
                out.print("<th>Valor da prova</th>");
                out.print("<th>Realizar prova</th>");
                out.print("<th>Ver resultado</th>");
                out.print("<th>Editar</th>");
                out.print("<th>Excluir</th>");
                out.print("</tr>");
                for (Prova p : provas) {
                    out.print("<tr>");
                    out.print("<td>" + p.getDescricaoProva() + "</td>");
                    out.print("<td>" + pDAO.getTotalQuestoes(p.getIdProva()) + "</td>");
                    out.print("<td>" + pDAO.getValorProva(p.getIdProva()) + "</td>");
                    out.print("<td><a href=\'realizarProva.jsp?idProva=" + p.getIdProva() + "\'><img class='image' src='https://image.flaticon.com/icons/svg/1118/1118907.svg'/></a></td>");
                    out.print("<td><a href=\'visualizaResultado.jsp?idProva=" + p.getIdProva() + "\'><img class='image' src='https://image.flaticon.com/icons/svg/139/139319.svg'/></a></td>");
                    out.print("<td><a href=\'editarProva.jsp?idProva=" + p.getIdProva() + "\'><img class='image' src='https://image.flaticon.com/icons/svg/1160/1160119.svg'/></a></td>");
                    out.print("<td><a href=\'excluiProva.jsp?idProva=" + p.getIdProva() + "\'><img  class='image'src='https://image.flaticon.com/icons/svg/291/291211.svg'/></a></td>");
                    out.print("</tr>");
                }
                out.print("</table>");
            }
        %>
        <br/><br/>
        
    </body>
</html>
