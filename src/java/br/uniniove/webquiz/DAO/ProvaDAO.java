/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.uniniove.webquiz.DAO;

import br.uninove.webquiz.model.Prova;
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
public class ProvaDAO {
    
    private static String urlBD = "jdbc:mysql://localhost:3306/prova";
    private static String usuario = "rickson";
    private static String senha = "201102";
    private static Connection conn = null;
    private static Statement stm = null;

    public ArrayList<Prova> getProvas() throws SQLException, ClassNotFoundException {
        ArrayList<Prova> provas = new ArrayList<Prova>();
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(urlBD, usuario, senha);
        stm = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

        String select = "SELECT * FROM tb_prova";

        ResultSet resultados = stm.executeQuery(select);

        while (resultados.next()) {
            Prova p = new Prova();
            p.setDescricaoProva(resultados.getString("descProva"));
            p.setIdProva(resultados.getInt("idprova"));

            provas.add(p);
        }
        conn.close();

        return provas;
    }

    public int getTotalQuestoes(int idProva) throws SQLException {
        //select count(idProva) from "tb_rel_prova_questao" where IDPROVA = 1
        conn = DriverManager.getConnection(urlBD, usuario, senha);
        stm = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        String select = "select count(idProva) as contagem from tb_rel_prova_questao where IDPROVA = " + idProva;
        ResultSet resultados = stm.executeQuery(select);
        int contagem = 0;
        while (resultados.next()) {
            contagem = resultados.getInt("contagem");
        }
        conn.close();
        return contagem;
    }
    
    public Prova getProvaQuestoes(Prova p) throws SQLException {
        //select count(idProva) from "tb_rel_prova_questao" where IDPROVA = 1
        conn = DriverManager.getConnection(urlBD, usuario, senha);
        stm = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        String select = 
                "SELECT P.idProva, P.descProva, Q.idQuestao, Q.questao "
                + "FROM prova.tb_prova as P, prova.tb_questao as Q "
                + "INNER JOIN tb_rel_prova_questao as C ON C.idQuestao = Q.idQuestao "
                + "WHERE C.idProva = P.idProva AND P.idProva = " + p.getIdProva();
        ResultSet resultados = stm.executeQuery(select);
        List<Questao> questoes = new ArrayList<>();
        
        while (resultados.next()) {
            Questao q = new Questao();
            q.setIdQuestao(resultados.getInt("idQuestao"));
            q.setQuestao(resultados.getString("questao"));
            questoes.add(q);
        }
        p.setQuestoes((ArrayList<Questao>) questoes);
        conn.close();
        return p;
    }
    

    public float getValorProva(int idProva) throws SQLException, ClassNotFoundException {
        QuestaoDAO qDAO = new QuestaoDAO();
        ArrayList<Resposta> respostas = new ArrayList<Resposta>();
        ArrayList<Questao> questoes = new ArrayList<Questao>();
        questoes = qDAO.getListaQuestoes(idProva);
        float valor = 0;
        for (Questao q : questoes) {
            respostas = q.getResposta();
            for (Resposta r : respostas) {
                valor += r.getValor();
            }
        }
        return valor;
    }
    
    public void relaciona(int idProva, int IdQuestao) throws SQLException, ClassNotFoundException {
       conn = DriverManager.getConnection(urlBD, usuario, senha);
        stm = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        String select = "INSERT INTO tb_rel_prova_questao(idProva,idQuestao) VALUES('"+idProva+"',"+IdQuestao+")";
        stm.execute(select);
        conn.close();
    }
    
    public Prova inserirProva(Prova prova) throws SQLException, ClassNotFoundException {
       conn = DriverManager.getConnection(urlBD, usuario, senha);
        stm = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        String select = "INSERT INTO tb_prova (descProva) VALUES ('"+prova.getDescricaoProva()+"')";
        stm.execute(select);
        
        select = "SELECT MAX(idProva) AS idProva FROM tb_prova";
        
        ResultSet result = stm.executeQuery(select);
        
        while (result.next()) {
          prova.setIdProva(result.getInt("idProva"));
        }
        
        conn.close();
        
        return prova;
    }
    
    public Prova getProvaById(int idProva) throws SQLException, ClassNotFoundException {
       conn = DriverManager.getConnection(urlBD, usuario, senha);
        stm = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        String select = "SELECT * FROM tb_prova WHERE idProva = " + idProva;
        ResultSet result = stm.executeQuery(select);
        Prova prova = new Prova();
        while (result.next()) {
          prova.setIdProva(result.getInt("idProva"));
          prova.setDescricaoProva(result.getString("descProva"));
        }
        
        conn.close();
        
        return prova;
    }
    
    public void excluirProva (int idProva) throws SQLException, ClassNotFoundException {
       conn = DriverManager.getConnection(urlBD, usuario, senha);
        stm = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
        String delete = "delete from tb_rel_prova_questao where idProva = " + idProva;
        stm.execute(delete);
        delete = "delete from tb_prova where idProva = " + idProva;
        stm.execute(delete);
        conn.close();
       
    }

}
