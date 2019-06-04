/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.uniniove.webquiz.DAO;

import br.uninove.webquiz.model.Questao;
import br.uninove.webquiz.model.Resposta;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author thiagograzianitraue
 */
public class QuestaoDAO {

     private static String urlBD = "jdbc:mysql://localhost:3306/prova";
    private static String usuario = "rickson";
    private static String senha = "201102";
    private static Connection conn = null;
    private static Statement stm = null;

    public ArrayList<Questao> getListaQuestoes(int idProva) throws SQLException, ClassNotFoundException {
        ArrayList<Questao> questoes = new ArrayList<Questao>();
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(urlBD, usuario, senha);
        stm = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

        String select = "select quest.IDQUESTAO, quest.QUESTAO from \n"
                + "    tb_questao as quest,\n"
                + "    tb_rel_prova_questao as rel\n"
                + "where\n"
                + "    quest.IDQUESTAO = rel.IDQUESTAO\n"
                + "and rel.IDPROVA = " + idProva;

        ResultSet resultados = stm.executeQuery(select);

        while (resultados.next()) {
            Questao q = new Questao();
            q.setIdQuestao(resultados.getInt("IDQUESTAO"));
            q.setQuestao(resultados.getString("QUESTAO"));
            
            ArrayList<Resposta> respostas = new ArrayList<Resposta>();
            RespostaDAO rDAO = new RespostaDAO();
            respostas = rDAO.getListaRespostas(q.getIdQuestao());
            q.setResposta(respostas);
           
            questoes.add(q);
        }
        conn.close();

        return questoes;
    }
    
     public Questao getQuestao(int questaoId) throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(urlBD, usuario, senha);
        stm = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

        String select = "SELECT * FROM tb_questao WHERE idQuestao = " + questaoId;

        ResultSet resultados = stm.executeQuery(select);
        Questao q = new Questao();
        while (resultados.next()) {
            
            q.setIdQuestao(resultados.getInt("IDQUESTAO"));
            q.setQuestao(resultados.getString("QUESTAO"));
            
            ArrayList<Resposta> respostas = new ArrayList<Resposta>();
            RespostaDAO rDAO = new RespostaDAO();
            respostas = rDAO.getListaRespostas(q.getIdQuestao());
            q.setResposta(respostas);
        }
        conn.close();

        return  q;
    }
     
     public Questao insertQuestao(Questao questao) throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(urlBD, usuario, senha);
        stm = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

        String select = "INSERT INTO tb_questao (questao) VALUES ('"+questao.getQuestao()+"')";

        stm.execute(select);
        Questao q = new Questao();
        
        select = "SELECT MAX(idQuestao) as idQuestao FROM tb_questao";
        
        ResultSet result = stm.executeQuery(select);
        
         while (result.next()) {
            q.setIdQuestao(result.getInt("idQuestao"));
         }
        
        conn.close();

        return  q;
    }

}
