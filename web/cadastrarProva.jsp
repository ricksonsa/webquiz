<%-- 
    Document   : cadastrarProva
    Created on : 28/05/2019, 20:16:01
    Author     : ricks
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="br.uninove.webquiz.model.Questao"%>
<%@page import="br.uninove.webquiz.model.Resposta"%>
<%
    List<Questao> questoes = new ArrayList();

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
        <script>
             function addQuestao() {
                 console.log("teste");
                      <%
                          Questao questao = new Questao();
                      %>      
                      var element = document.getElementById('container');
                      
                      var func = '<%       
                                    questao.setQuestao(request.getParameter("descricao"));
                                    questoes.add(questao);
                                    for(Questao quest: questoes){
                                        out.print("<h2>aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa</h2>");
                                        out.print("<p>"+quest.getQuestao()+"</p>");
                                        if(quest.getResposta() != null) {
                                             for(Resposta resp: quest.getResposta()){
                                            out.print("<p>Resposta: "+resp.getResposta()+"</p>");
                                            out.print("<p>Peso "+resp.getValor()+"</p>");
                                        }
                                      }                   
                                    }
                                %>';
                      
                      element.innerHTML = element.innerHTML + func;
             }
            </script>
        
    </head>
    <body>
        <h1>Hello World!</h1>
        
        <form action="" method="POST">
            <h2>Descricao</h2>
            <input type="text" name="descricao">
        
            <button type="button" onClick="addQuestao()">Adicionar Questão</button>
            <div id="container">
                
            </div>
        </form> 
            
            
    </body>
</html>
