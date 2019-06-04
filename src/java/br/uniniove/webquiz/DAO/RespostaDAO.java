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

/**
 *
 * @author thiagograzianitraue
 */
public class RespostaDAO {

     private static String urlBD = "jdbc:mysql://localhost:3306/prova";
    private static String usuario = "rickson";
    private static String senha = "201102";
    private static Connection conn = null;
    private static Statement stm = null;
    
    public void deleteReposta(int idReposta) throws SQLException, ClassNotFoundException {
         Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(urlBD, usuario, senha);
        stm = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

    String delete = "DELETE FROM tb_rel_questao_resp WHERE idResposta = " + idReposta;
    stm.execute(delete);
    
    delete = "DELETE FROM tb_resposta WHERE idResposta = " + idReposta;
    stm.execute(delete);
    }

    public ArrayList<Resposta> getListaRespostas(int idQuestao) throws SQLException, ClassNotFoundException {
        ArrayList<Resposta> respostas = new ArrayList<Resposta>();
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(urlBD, usuario, senha);
        stm = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

        String select = "select resp.idResposta, resp.resposta, resp.valor, resp.correta from \n"
                + "    tb_resposta as resp,\n"
                + "    tb_rel_questao_resp as rel\n"
                + "where\n"
                + "    resp.idResposta = rel.IDRESPOSTA\n"
                + "and rel.IDQUESTAO = " + idQuestao;

        ResultSet resultados = stm.executeQuery(select);

        while (resultados.next()) {
            Resposta r = new Resposta();
            r.setIdResposta(resultados.getInt("idresposta"));
            r.setResposta(resultados.getString("resposta"));
            r.setValor(resultados.getFloat("valor"));
            r.setCorreta(resultados.getBoolean("correta"));
            respostas.add(r);
        }
        conn.close();

        return respostas;
    }
    
    public Resposta inserirResposta(Resposta resposta, int idQuestao) throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(urlBD, usuario, senha);
        stm = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

        if(resposta.isCorreta()) {
            String update = "UPDATE tb_resposta as A\n" +
                        "INNER JOIN tb_rel_questao_resp as B on A.idResposta = B.idResposta \n" +
                        "SET A.correta = 0 \n" +
                        "WHERE A.correta = 1 AND B.idQuestao = " + idQuestao;
            stm.execute(update);
        }
        
        String select = "INSERT INTO tb_resposta (resposta,valor,correta) VALUES ('"+resposta.getResposta()+"','"+resposta.getValor()+"',"+resposta.isCorreta()+")";
        
        stm.execute(select);

        select = "SELECT MAX(idResposta) AS idResposta FROM tb_resposta";
        
        ResultSet result = stm.executeQuery(select);
        
        while (result.next()) {
          resposta.setIdResposta(result.getInt("idResposta"));
        }
        
        conn.close();

        return resposta;
    }
    
    public void relaciona(int idResposta, int idQuestao)  throws SQLException, ClassNotFoundException {
      Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(urlBD, usuario, senha);
        stm = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

        String select = "INSERT INTO tb_rel_questao_resp (idQuestao,idResposta) VALUES ("+idQuestao+","+idResposta+")";
        
        stm.execute(select);
        conn.close();
    }
}
