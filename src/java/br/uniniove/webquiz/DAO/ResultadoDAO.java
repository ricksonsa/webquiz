/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.uniniove.webquiz.DAO;

import br.uninove.webquiz.model.Prova;
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
 * @author ricks
 */
public class ResultadoDAO {
      private static String urlBD = "jdbc:mysql://localhost:3306/prova";
    private static String usuario = "rickson";
    private static String senha = "201102";
    private static Connection conn = null;
    private static Statement stm = null;

    public void addResultado(int idQuestao, int idResposta, int idUsuario) throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(urlBD, usuario, senha);
        stm = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

        String query = "INSERT INTO tb_resultado (idQuestao,idResposta,idUsuario) VALUES ("+idQuestao+","+idResposta+","+idUsuario+")";

        stm.execute(query);

        conn.close();

    }
    
    public Resposta getRespostaFromResultadoUsingIdQuestao(int idQuestao,int idUsuario) throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(urlBD, usuario, senha);
        stm = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

        String query = "SELECT A.idResposta, A.resposta, A.valor, A.correta "
                + "FROM tb_resposta A INNER JOIN tb_rel_questao_resp B ON A.idResposta = B.idResposta "
                + "INNER JOIN tb_resultado C ON B.idQuestao = C.idQuestao "
                + "WHERE C.idResposta = A.idResposta AND C.idUsuario = "+idUsuario+" AND C.idQuestao = " + idQuestao;

        ResultSet result = stm.executeQuery(query);
        Resposta resp = new Resposta();
        
        
        while(result.next()) {
            resp.setIdResposta(result.getInt("idResposta"));
            resp.setResposta(result.getString("resposta"));
            resp.setValor(result.getFloat("valor"));
            resp.setCorreta(result.getBoolean("correta"));
        }
        
        conn.close();
        return resp;
    }
    
    //SELECT A.idResposta, A.resposta, A.valor, A.correta FROM tb_resposta A INNER JOIN tb_rel_questao_resp B ON A.idResposta = B.idResposta INNER JOIN tb_resultado C ON B.idQuestao = C.idQuestao WHERE C.idQuestao = 24;
}
