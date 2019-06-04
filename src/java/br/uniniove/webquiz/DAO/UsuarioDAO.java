/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.uniniove.webquiz.DAO;

import br.uninove.webquiz.Security.LoginDAO;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author ricks
 */
public class UsuarioDAO {
  private static String urlBD = "jdbc:mysql://localhost:3306/prova";
    private static String usuario = "rickson";
    private static String senha = "201102";
    private static Connection conn = null;
    private static Statement stm = null;

    public LoginDAO getUserByName(String username) throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection(urlBD, usuario, senha);
        stm = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);

        String query = "SELECT * FROM tb_usuario WHERE usuario = '"+username+"'";

        ResultSet result = stm.executeQuery(query);
        LoginDAO usuario = new LoginDAO();
        while(result.next()) {
            usuario.setIdUsuario(result.getString("idUsuario"));
            usuario.setUsuario(result.getString("usuario"));
        }

        conn.close();
        return usuario;

    }   
}
