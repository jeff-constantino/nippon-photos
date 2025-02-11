package dao;

import connection.SingleConnectionBanco;
import model.ModelLogin;
import model.ModelVendas;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DAOVendasRepository {

    private Connection connection;



    public DAOVendasRepository() {
        connection = SingleConnectionBanco.getConnection();

    }

    public int totalPagina(Long userLogado) throws Exception {
        String sql = "SELECT count(1) as total FROM vendas where venda_id= " +userLogado;
        PreparedStatement preparedSql = connection.prepareStatement(sql);
        ResultSet resultSet = preparedSql.executeQuery();
        resultSet.next();

        Double cadastro = resultSet.getDouble("total");
        Double porpagina = 6.0;
        Double pagina = cadastro/porpagina;
        Double resto = pagina % 2;
        if (resto >0){
            pagina++;
        }
        return pagina.intValue();
    }

    public ModelVendas gravarVenda(ModelVendas modelVendas, Long userLogado) throws Exception {
        String sql = "INSERT INTO vendas(vendedor_id, nome, prod1_din, prod1_deb, prod1_cred, prod1_pix, "
                + "prod2_din, prod2_deb, prod2_cred, prod2_pix, prod3_din, prod3_deb, prod3_cred, prod3_pix, "
                + "ft_total, enc_total, dig_total, sobras, data_venda, ribbon, ribbon_dif) "
                + "VALUES (?, UPPER(?), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement preparedSql = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            connection.setAutoCommit(false); // Desabilita o auto-commit
            // Define os parâmetros
            preparedSql.setLong(1, modelVendas.getVendedor_id());
            preparedSql.setString(2, modelVendas.getNome());
            preparedSql.setInt(3, modelVendas.getProd1_din());
            preparedSql.setInt(4, modelVendas.getProd1_deb());
            preparedSql.setInt(5, modelVendas.getProd1_cred());
            preparedSql.setInt(6, modelVendas.getProd1_pix());

            preparedSql.setInt(7, modelVendas.getProd2_din());
            preparedSql.setInt(8, modelVendas.getProd2_deb());
            preparedSql.setInt(9, modelVendas.getProd2_cred());
            preparedSql.setInt(10, modelVendas.getProd2_pix());

            preparedSql.setInt(11, modelVendas.getProd3_din());
            preparedSql.setInt(12, modelVendas.getProd3_deb());
            preparedSql.setInt(13, modelVendas.getProd3_cred());
            preparedSql.setInt(14, modelVendas.getProd3_pix());


            // Calcula os totais
            int ft_total = modelVendas.getProd1_din() + modelVendas.getProd1_deb() + modelVendas.getProd1_cred() + modelVendas.getProd1_pix();
            int enc_total = modelVendas.getProd2_din() + modelVendas.getProd2_deb() + modelVendas.getProd2_cred() + modelVendas.getProd2_pix();
            int dig_total = modelVendas.getProd3_din() + modelVendas.getProd3_deb() + modelVendas.getProd3_cred() + modelVendas.getProd3_pix();

            // Define os novos parâmetros para os totais
            preparedSql.setInt(15, ft_total);
            preparedSql.setInt(16, enc_total);
            preparedSql.setInt(17, dig_total);

            preparedSql.setInt(18, modelVendas.getSobras());


            // Verifica se a data_venda não é nula
            if (modelVendas.getData_venda() == null) {
                throw new IllegalArgumentException("O parâmetro 'data_venda' não pode ser nulo.");
            }

            // Define a data corretamente no formato SQL
            preparedSql.setDate(19, new java.sql.Date(modelVendas.getData_venda().getTime()));

            // Adicionando o parâmetro do ribbon
            preparedSql.setString(20, modelVendas.getRibbon());
            preparedSql.setInt(21, modelVendas.getRibbon_dif());

            // Executa a inserção
            preparedSql.executeUpdate();

            // Recupera o ID gerado
            ResultSet generatedKeys = preparedSql.getGeneratedKeys();
            if (generatedKeys.next()) {
                long generatedId = generatedKeys.getLong(1);
                modelVendas.setVenda_id(generatedId);
            } else {
                throw new SQLException("Falha ao obter o ID gerado.");
            }

            connection.commit();
            return this.consultaVenda(modelVendas.getVenda_id(), userLogado);
        }
    }




    public ModelVendas atualizarVenda(Long venda_id, ModelVendas modelVendas, Long userLogado) throws Exception {
        String sql = "UPDATE vendas SET nome = UPPER(?), vendedor_id = ?, prod1_din = ?, prod1_deb = ?, prod1_cred = ?, prod1_pix = ?, "
                + "prod2_din = ?, prod2_deb = ?, prod2_cred = ?, prod2_pix = ?, prod3_din = ?, prod3_deb = ?, prod3_cred = ?, "
                + "prod3_pix = ?, ft_total = ?, enc_total = ?, dig_total = ?, data_venda = ?, sobras = ?, ribbon = ? "
                + "WHERE venda_id = ?";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            connection.setAutoCommit(false); // Desabilita o auto-commit
            // Define os parâmetros
            statement.setString(1, modelVendas.getNome());
            statement.setLong(2, modelVendas.getVendedor_id());
            statement.setInt(3, modelVendas.getProd1_din());
            statement.setInt(4, modelVendas.getProd1_deb());
            statement.setInt(5, modelVendas.getProd1_cred());
            statement.setInt(6, modelVendas.getProd1_pix());

            statement.setInt(7, modelVendas.getProd2_din());
            statement.setInt(8, modelVendas.getProd2_deb());
            statement.setInt(9, modelVendas.getProd2_cred());
            statement.setInt(10, modelVendas.getProd2_pix());

            statement.setInt(11, modelVendas.getProd3_din());
            statement.setInt(12, modelVendas.getProd3_deb());
            statement.setInt(13, modelVendas.getProd3_cred());
            statement.setInt(14, modelVendas.getProd3_pix());

            // Calcula os totais
            int ft_total = modelVendas.getProd1_din() + modelVendas.getProd1_deb() + modelVendas.getProd1_cred() + modelVendas.getProd1_pix();
            int enc_total = modelVendas.getProd2_din() + modelVendas.getProd2_deb() + modelVendas.getProd2_cred() + modelVendas.getProd2_pix();
            int dig_total = modelVendas.getProd3_din() + modelVendas.getProd3_deb() + modelVendas.getProd3_cred() + modelVendas.getProd3_pix();

            // Define os novos parâmetros dos totais
            statement.setInt(15, ft_total);
            statement.setInt(16, enc_total);
            statement.setInt(17, dig_total);

            // Verifica se a data_venda não é nula
            if (modelVendas.getData_venda() == null) {
                throw new IllegalArgumentException("O parâmetro 'data_venda' não pode ser nulo.");
            }

            // Define a data corretamente no formato SQL
            statement.setDate(18, new java.sql.Date(modelVendas.getData_venda().getTime()));

            statement.setInt(19, modelVendas.getSobras());

            // Adicionando o parâmetro do ribbon
            statement.setString(20, modelVendas.getRibbon());

            // Condições para atualização
            statement.setLong(21, venda_id);

            // Executa a atualização
            statement.executeUpdate();
            connection.commit();
        }

        return this.consultaVenda(venda_id, userLogado);
    }


    public List<ModelVendas> consultaVendasRel() throws Exception {
        List<ModelVendas> modelVendasList = new ArrayList<>();

        String sql = "SELECT * FROM vendas order by venda_id desc";
        PreparedStatement preparedSql = connection.prepareStatement(sql);
        ResultSet resultado = preparedSql.executeQuery();

        while (resultado.next()) { // Verifica se há resultados
            ModelVendas modelVenda = new ModelVendas();
            modelVenda = new ModelVendas();
            modelVenda.setVenda_id(resultado.getLong("venda_id"));
            modelVenda.setVendedor_id(resultado.getString("vendedor_id"));
            modelVenda.setNome(resultado.getString("nome"));

            // Campos adicionais
            modelVenda.setProd1_din(resultado.getInt("prod1_din"));
            modelVenda.setProd1_deb(resultado.getInt("prod1_deb"));
            modelVenda.setProd1_cred(resultado.getInt("prod1_cred"));
            modelVenda.setProd1_pix(resultado.getInt("prod1_pix"));
            modelVenda.setProd2_din(resultado.getInt("prod2_din"));
            modelVenda.setProd2_deb(resultado.getInt("prod2_deb"));
            modelVenda.setProd2_cred(resultado.getInt("prod2_cred"));
            modelVenda.setProd2_pix(resultado.getInt("prod2_pix"));
            modelVenda.setProd3_din(resultado.getInt("prod3_din"));
            modelVenda.setProd3_deb(resultado.getInt("prod3_deb"));
            modelVenda.setProd3_cred(resultado.getInt("prod3_cred"));
            modelVenda.setProd3_pix(resultado.getInt("prod3_pix"));
            modelVenda.setSobras(resultado.getInt("sobras"));
            modelVenda.setRibbon(resultado.getString("ribbon"));
            modelVenda.setData_venda(resultado.getDate("data_venda"));
            modelVenda.setSobras(resultado.getInt("sobras"));

            modelVendasList.add(modelVenda);
        }
        return modelVendasList;
    }
    public List<ModelLogin> buscaFuncionariosAtivos() throws Exception {
        List<ModelLogin> funcionariosAtivos = new ArrayList<>();
        String sql = "SELECT id, nome FROM model_login WHERE UPPER(status) = 'ATIVO'";

        try (PreparedStatement preparedSql = connection.prepareStatement(sql);
             ResultSet resultado = preparedSql.executeQuery()) {

            while (resultado.next()) {
                ModelLogin funcionario = new ModelLogin();
                funcionario.setId(resultado.getLong("id")); // Supondo que você tenha um método setId em ModelLogin
                funcionario.setNome(resultado.getString("nome")); // Supondo que você tenha um método setNome em ModelLogin
                funcionariosAtivos.add(funcionario);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Logar o erro
            throw new Exception("Erro ao buscar funcionários ativos: " + e.getMessage());
        }
        return funcionariosAtivos;
    }

    public List<ModelVendas> consultaVendasRel(String nomeFuncionario, String dataInicial, String dataFinal) throws Exception {
        List<ModelVendas> modelVendasList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT v.* FROM vendas v ")
                .append("INNER JOIN model_login l ON v.vendedor_id = l.id ")
                .append("WHERE UPPER(l.status) = 'ATIVO'");

        // Adiciona a condição para o nome do funcionário, se fornecido
        if (nomeFuncionario != null && !nomeFuncionario.isEmpty()) {
            sql.append(" AND UPPER(l.nome) LIKE UPPER(?)"); // Comparação case insensitive
        }

        // Adiciona as condições de data, se fornecidas
        if (dataInicial != null && !dataInicial.isEmpty() && dataFinal != null && !dataFinal.isEmpty()) {
            sql.append(" AND v.data_venda BETWEEN ? AND ?");
        }

        sql.append(" ORDER BY v.venda_id DESC");

        try (PreparedStatement preparedSql = connection.prepareStatement(sql.toString())) {
            int index = 1;

            // Define o parâmetro do nome, se necessário
            if (nomeFuncionario != null && !nomeFuncionario.isEmpty()) {
                preparedSql.setString(index++, "%" + nomeFuncionario + "%");
            }

            // Define os parâmetros de data, se necessário
            if (dataInicial != null && !dataInicial.isEmpty() && dataFinal != null && !dataFinal.isEmpty()) {
                preparedSql.setString(index++, dataInicial);
                preparedSql.setString(index++, dataFinal);
            }

            ResultSet resultado = preparedSql.executeQuery();

            while (resultado.next()) {
                ModelVendas modelVenda = new ModelVendas();
                modelVenda.setVenda_id(resultado.getLong("venda_id"));
                modelVenda.setVendedor_id(resultado.getString("vendedor_id"));
                modelVenda.setNome(resultado.getString("nome"));

                // Campos adicionais
                modelVenda.setProd1_din(resultado.getInt("prod1_din"));
                modelVenda.setProd1_deb(resultado.getInt("prod1_deb"));
                modelVenda.setProd1_cred(resultado.getInt("prod1_cred"));
                modelVenda.setProd1_pix(resultado.getInt("prod1_pix"));
                modelVenda.setProd2_din(resultado.getInt("prod2_din"));
                modelVenda.setProd2_deb(resultado.getInt("prod2_deb"));
                modelVenda.setProd2_cred(resultado.getInt("prod2_cred"));
                modelVenda.setProd2_pix(resultado.getInt("prod2_pix"));
                modelVenda.setProd3_din(resultado.getInt("prod3_din"));
                modelVenda.setProd3_deb(resultado.getInt("prod3_deb"));
                modelVenda.setProd3_cred(resultado.getInt("prod3_cred"));
                modelVenda.setProd3_pix(resultado.getInt("prod3_pix"));
                modelVenda.setSobras(resultado.getInt("sobras"));
                modelVenda.setRibbon(resultado.getString("ribbon"));
                modelVenda.setData_venda(resultado.getDate("data_venda"));

                modelVendasList.add(modelVenda);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log do erro
            throw new Exception("Erro ao buscar vendas: " + e.getMessage());
        }
        return modelVendasList;
    }

    public List<ModelVendas> listVenda(Long vendedor_id) throws Exception {
        List<ModelVendas> modelVendasList = new ArrayList<>();

        String sql = "SELECT * FROM vendas WHERE vendedor_id = ?";
        PreparedStatement preparedSql = connection.prepareStatement(sql);
        preparedSql.setLong(1, vendedor_id);
        ResultSet resultado = preparedSql.executeQuery();

        while (resultado.next()) {
            ModelVendas modelVendedor = new ModelVendas();
            modelVendedor.setVenda_id(resultado.getLong("venda_id"));
            modelVendedor.setVendedor_id(resultado.getString("vendedor_id"));
            modelVendedor.setNome(resultado.getString("nome"));
            modelVendedor.setProd1_din(resultado.getInt("prod1_din"));
            modelVendedor.setProd1_deb(resultado.getInt("prod1_deb"));
            modelVendedor.setProd1_cred(resultado.getInt("prod1_cred"));
            modelVendedor.setProd1_pix(resultado.getInt("prod1_pix"));
            modelVendedor.setProd2_din(resultado.getInt("prod2_din"));
            modelVendedor.setProd2_deb(resultado.getInt("prod2_deb"));
            modelVendedor.setProd2_cred(resultado.getInt("prod2_cred"));
            modelVendedor.setProd2_pix(resultado.getInt("prod2_pix"));
            modelVendedor.setProd3_din(resultado.getInt("prod3_din"));
            modelVendedor.setProd3_deb(resultado.getInt("prod3_deb"));
            modelVendedor.setProd3_cred(resultado.getInt("prod3_cred"));
            modelVendedor.setProd3_pix(resultado.getInt("prod3_pix"));
            modelVendedor.setSobras(resultado.getInt("sobras"));
            modelVendedor.setRibbon(resultado.getString("ribbon"));
            modelVendedor.setData_venda(resultado.getDate("data_venda"));

            modelVendasList.add(modelVendedor);

        }
        return modelVendasList;
    }

    public List<ModelVendas> vendaDia() throws Exception {
        List<ModelVendas> modelVendasList = new ArrayList<>();

        // Consulta para obter a última data de venda registrada
        String sqlData = "SELECT MAX(data_venda) AS ultima_data FROM vendas";
        PreparedStatement preparedSqlData = connection.prepareStatement(sqlData);
        ResultSet resultadoData = preparedSqlData.executeQuery();

        if (resultadoData.next()) {
            Date ultimaData = resultadoData.getDate("ultima_data");

            if (ultimaData != null) {
                // Consulta para buscar as vendas da última data registrada
                String sql = "SELECT * FROM vendas WHERE data_venda = ? ORDER BY venda_id DESC";
                PreparedStatement preparedSql = connection.prepareStatement(sql);
                preparedSql.setDate(1, ultimaData);
                ResultSet resultado = preparedSql.executeQuery();

                while (resultado.next()) {
                    ModelVendas modelVenda = new ModelVendas();
                    modelVenda.setVenda_id(resultado.getLong("venda_id"));
                    modelVenda.setVendedor_id(resultado.getString("vendedor_id"));
                    modelVenda.setNome(resultado.getString("nome"));

                    // Campos adicionais
                    modelVenda.setProd1_din(resultado.getInt("prod1_din"));
                    modelVenda.setProd1_deb(resultado.getInt("prod1_deb"));
                    modelVenda.setProd1_cred(resultado.getInt("prod1_cred"));
                    modelVenda.setProd1_pix(resultado.getInt("prod1_pix"));
                    modelVenda.setProd2_din(resultado.getInt("prod2_din"));
                    modelVenda.setProd2_deb(resultado.getInt("prod2_deb"));
                    modelVenda.setProd2_cred(resultado.getInt("prod2_cred"));
                    modelVenda.setProd2_pix(resultado.getInt("prod2_pix"));
                    modelVenda.setProd3_din(resultado.getInt("prod3_din"));
                    modelVenda.setProd3_deb(resultado.getInt("prod3_deb"));
                    modelVenda.setProd3_cred(resultado.getInt("prod3_cred"));
                    modelVenda.setProd3_pix(resultado.getInt("prod3_pix"));
                    modelVenda.setSobras(resultado.getInt("sobras"));
                    modelVenda.setRibbon(resultado.getString("ribbon"));
                    modelVenda.setData_venda(resultado.getDate("data_venda"));

                    modelVendasList.add(modelVenda);
                }
            }
        }
        return modelVendasList;
    }


    public ModelVendas buscarVendaPorId(Long idVenda) throws SQLException {
        ModelVendas venda = null;
        String sql = "SELECT * FROM vendas WHERE venda_id = ?";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, idVenda);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                venda = new ModelVendas();
                venda.setVenda_id(rs.getLong("venda_id"));
                venda.setNome(rs.getString("nome"));
                venda.setProd1_din(rs.getInt("prod1_din"));
                venda.setProd1_deb(rs.getInt("prod1_deb"));
                venda.setProd1_cred(rs.getInt("prod1_cred"));
                venda.setProd1_pix(rs.getInt("prod1_pix"));
                venda.setProd2_din(rs.getInt("prod2_din"));
                venda.setProd2_deb(rs.getInt("prod2_deb"));
                venda.setProd2_cred(rs.getInt("prod2_cred"));
                venda.setProd2_pix(rs.getInt("prod2_pix"));
                venda.setProd3_din(rs.getInt("prod3_din"));
                venda.setProd3_deb(rs.getInt("prod3_deb"));
                venda.setProd3_cred(rs.getInt("prod3_cred"));
                venda.setProd3_pix(rs.getInt("prod3_pix"));
                venda.setSobras(rs.getInt("sobras"));
                venda.setRibbon(rs.getString("ribbon"));

                // Tratamento do vendedor_id
                String vendedorId = rs.getString("vendedor_id");
                try {
                    if (vendedorId != null) {
                        venda.setVendedor_id(vendedorId);
                    } else {
                        venda.setVendedor_id(null); // Ou trate como preferir
                    }
                } catch (Exception e) {
                    // Captura a exceção aqui e trate-a conforme necessário
                    System.err.println("Erro ao definir vendedor_id: " + e.getMessage());
                    // Você pode lançar uma SQLException aqui se desejar
                }

                // Tratamento da data
                Date dataVenda = rs.getDate("data_venda");
                if (dataVenda != null) {
                    venda.setData_venda(dataVenda);
                } else {
                    venda.setData_venda(null); // Ou trate como preferir
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Erro ao buscar a venda pelo ID: " + e.getMessage());
        }

        return venda;
    }







    public ModelVendas consultaVenda(Long venda_id,  Long userLogado) throws Exception {
        // Verifica se o venda_id é nulo antes de prosseguir
        if (venda_id == null) {
            throw new IllegalArgumentException("venda_id não pode ser nulo.");
        }

        ModelVendas modelVendas = null;

        String sql = "SELECT * FROM vendas WHERE venda_id = ?";
        PreparedStatement preparedSql = connection.prepareStatement(sql);
        preparedSql.setLong(1,venda_id); // Usar setLong diretamente

        ResultSet resultado = preparedSql.executeQuery();
        if (resultado.next()) { // Verifica se há resultados
            modelVendas = new ModelVendas();
            modelVendas.setVenda_id(resultado.getLong("venda_id"));
            modelVendas.setVendedor_id(resultado.getString("vendedor_id"));
            modelVendas.setNome(resultado.getString("nome"));

            // Campos adicionais
            modelVendas.setProd1_din(resultado.getInt("prod1_din"));
            modelVendas.setProd1_deb(resultado.getInt("prod1_deb"));
            modelVendas.setProd1_cred(resultado.getInt("prod1_cred"));
            modelVendas.setProd1_pix(resultado.getInt("prod1_pix"));
            modelVendas.setProd2_din(resultado.getInt("prod2_din"));
            modelVendas.setProd2_deb(resultado.getInt("prod2_deb"));
            modelVendas.setProd2_cred(resultado.getInt("prod2_cred"));
            modelVendas.setProd2_pix(resultado.getInt("prod2_pix"));
            modelVendas.setProd3_din(resultado.getInt("prod3_din"));
            modelVendas.setProd3_deb(resultado.getInt("prod3_deb"));
            modelVendas.setProd3_cred(resultado.getInt("prod3_cred"));
            modelVendas.setProd3_pix(resultado.getInt("prod3_pix"));
            modelVendas.setSobras(resultado.getInt("sobras"));
        } else {
            // Se não houver resultados, retornar null ou lançar uma exceção
            modelVendas = null; // Retorna null se a venda não existir
        }
        return modelVendas;
    }
    public List<ModelLogin> consultaFuncionarioList(String nome) throws Exception {
        List<ModelLogin> retorno = new ArrayList<ModelLogin>();
        String sql = "SELECT * FROM model_login WHERE UPPER(nome) LIKE UPPER(?) AND useradmin IS FALSE AND status = UPPER('ATIVO')";

        try (PreparedStatement preparedSql = connection.prepareStatement(sql)) {
            preparedSql.setString(1, "%" + nome + "%");
            ResultSet resultSet = preparedSql.executeQuery();

            while (resultSet.next()) {
                ModelLogin modelLogin = new ModelLogin();
                modelLogin.setId(resultSet.getLong("id"));
                modelLogin.setNome(resultSet.getString("nome"));
                retorno.add(modelLogin);
            }
        } catch (SQLException e) {
            System.err.println("Erro ao executar a consulta: " + e.getMessage());
            throw e; // Lança a exceção novamente para ser tratada na servlet
        }

        return retorno;
    }






    public ModelVendas consultaUsuario (String nome) throws Exception{
        ModelVendas modelVendas = new ModelVendas();

        String sql = "SELECT * FROM model_login WHERE UPPER(nome) = UPPER (?)";
        PreparedStatement preparedSql = connection.prepareStatement(sql);
        preparedSql.setString(1, nome);

        ResultSet resultado = preparedSql.executeQuery();
        while (resultado.next()) {
            modelVendas.setVendedor_id (resultado.getString("id"));
            modelVendas.setNome(resultado.getString("nome"));
        }
        return modelVendas;
    }


    public void deleteVenda(long id) throws Exception {
        String sql = "DELETE FROM vendas WHERE venda_id = ?";
        try (PreparedStatement preparedSql = connection.prepareStatement(sql)) {
            preparedSql.setLong(1, id);
            int rowsAffected = preparedSql.executeUpdate();
            connection.commit();

            // Log para verificar o ID e o número de linhas afetadas
            System.out.println("Tentando excluir venda com ID: " + id);
            System.out.println("Linhas afetadas: " + rowsAffected);

            if (rowsAffected == 0) {
                System.out.println("Nenhuma venda encontrada com o ID: " + id);
            } else {
                System.out.println("Venda excluída com sucesso!");
            }
        }
    }




    public boolean validarVenda(String nome) throws Exception {
        String sql= "SELECT COUNT (1) > 0 AS EXISTE FROM vendas WHERE UPPER(nome) = UPPER (?) and DATE  = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, nome);
        ResultSet resultado = statement.executeQuery();
        resultado.next();
        return resultado.getBoolean("existe");

    }




    public List<ModelVendas> listaVendas(Long idVendedorPai) throws Exception {
        String sql = "select * from Vendas where vendedor_id = ?";
        List<ModelVendas> retorno = new ArrayList<>();

        PreparedStatement preparedStatement = connection.prepareStatement(sql);

        ResultSet rs = preparedStatement.executeQuery();
        while (rs.next()){
            ModelVendas modelVendas = new ModelVendas();

            modelVendas.setNome(rs.getString("nome"));

            modelVendas.setProd1_din(rs.getInt("prod1_din"));
            modelVendas.setProd1_deb(rs.getInt("prod1_deb"));
            modelVendas.setProd1_cred(rs.getInt("prod1_cred"));
            modelVendas.setProd1_pix(rs.getInt("prod1_pix"));

            modelVendas.setProd2_din(rs.getInt("prod2_din"));
            modelVendas.setProd2_deb(rs.getInt("prod2_deb"));
            modelVendas.setProd2_cred(rs.getInt("prod2_cred"));
            modelVendas.setProd2_pix(rs.getInt("prod2_pix"));

            modelVendas.setProd3_din(rs.getInt("prod3_din"));
            modelVendas.setProd3_deb(rs.getInt("prod3_deb"));
            modelVendas.setProd3_cred(rs.getInt("prod3_cred"));
            modelVendas.setProd3_pix(rs.getInt("prod3_pix"));

            modelVendas.setSobras(rs.getInt("sobras"));
            modelVendas.setUsuario_cad_id(rs.getLong("usuario_cad_id"));
            modelVendas.setVendedor_id(rs.getString("vendedor_id"));
            modelVendas.setData_venda(rs.getDate("data_venda"));




            retorno.add(modelVendas);
        }
        return retorno;

    }
}