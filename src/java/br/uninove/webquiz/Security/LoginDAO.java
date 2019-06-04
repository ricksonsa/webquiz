/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.uninove.webquiz.Security;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author ricks
 */

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author Internet
 */
public class LoginDAO {
      private String idUsuario;
    private String usuario;
    private String senha;
    
    private static String urlBD = "jdbc:mysql://localhost:3306/prova";
    Connection conn = null;
    private static Statement stm = null;

    /**
     * @return the login
     */
    public String getUsuario() {
        return usuario;
    }

    /**
     * @param login the login to set
     */
    public void setUsuario(String login) {
        this.usuario = login;
    }

    /**
     * @return the senha
     */
    public String getSenha() {
        return senha;
    }

    /**
     * @param senha the senha to set
     */
    public void setSenha(String senha) {
        this.senha = senha;
    }
    
    public String autenticar() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection (urlBD, "rickson", "201102");
        stm = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, 
                ResultSet.CONCUR_READ_ONLY);

        String select = "select * from tb_usuario "
                + "where usuario = '" + usuario + "' "
                + "and senha = '" + senha + "'";

        
        ResultSet resultados = stm.executeQuery(select);

        //conta o número de linhas retornadas
        int linhas = 0;
        if (resultados.last()) {
            linhas = resultados.getRow();
            resultados.first();
            setIdUsuario(resultados.getString(1));
        }
        conn.close();
        return (getIdUsuario());
    }

    /**
     * @return the idUsuario
     */
    public String getIdUsuario() {
        return idUsuario;
    }

    /**
     * @param idUsuario the idUsuario to set
     */
    public void setIdUsuario(String idUsuario) {
        this.idUsuario = idUsuario;
    }
}

