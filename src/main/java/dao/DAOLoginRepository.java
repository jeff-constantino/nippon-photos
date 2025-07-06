package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import connection.SingleConnectionBanco;
import model.ModelContas;
import model.ModelLogin;

public class DAOLoginRepository {
    private final Connection connection;


    public DAOLoginRepository() {

        connection = SingleConnectionBanco.getConnection();


    }

    public boolean validarAutenticacao(ModelLogin modelLogin) throws Exception{

        String sql = "select * from model_login where upper (login) = upper (?) and upper (senha) = upper (?) ";

        PreparedStatement statement = connection.prepareStatement(sql);

        statement.setString(1, modelLogin.getLogin());
        statement.setString(2, modelLogin.getSenha());

        ResultSet resultSet = statement.executeQuery();

        return resultSet.next();/*autenticado*//*n�o autenticado*/

    }


    public List<ModelContas> listarContasVencendoEm7Dias() throws SQLException {
        List<ModelContas> contas = new ArrayList<>();
        String sql = "SELECT * FROM contas WHERE data_de_pagamento BETWEEN CURRENT_DATE AND CURRENT_DATE + INTERVAL '7 days'";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ModelContas conta = new ModelContas();
                conta.setNumero_pedido(rs.getLong("numero_pedido"));
                conta.setEmpresa(rs.getString("empresa"));
                conta.setItens(rs.getString("itens"));
                conta.setValor(rs.getDouble("valor"));
                conta.setData_de_pedido(rs.getDate("data_de_pedido"));
                conta.setData_de_pagamento(rs.getDate("data_de_pagamento"));
                contas.add(conta);
            }
        }
        return contas;
    }



}