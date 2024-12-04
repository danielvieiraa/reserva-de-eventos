<?php
/*
  Descrição do Desafio:
    Você precisa realizar uma migração dos dados fictícios que estão na pasta <dados_sistema_legado> para a base da clínica fictícia MedicalChallenge.
    Para isso, você precisa:
      1. Instalar o MariaDB na sua máquina. Dica: Você pode utilizar Docker para isso;
      2. Restaurar o banco da clínica fictícia Medical Challenge: arquivo <medical_challenge_schema>;
      3. Migrar os dados do sistema legado fictício que estão na pasta <dados_sistema_legado>:
        a) Dica: você pode criar uma função para importar os arquivos do formato CSV para uma tabela em um banco temporário no seu MariaDB.
      4. Gerar um dump dos dados já migrados para o banco da clínica fictícia Medical Challenge.
*/

// Importação de Bibliotecas:
include "./lib.php";

// Conexão com o banco da clínica fictícia:
$connMedical = mysqli_connect("localhost", "root", "root", "MedicalChallenge")
or die("Não foi poswsível conectar os servidor MySQL: MedicalChallenge\n");

// Conexão com o banco temporário:
$connTemp = mysqli_connect("localhost", "root", "root", "0temp")
or die("Não foi possível conectar os servidor MySQL: 0temp\n");

// Informações de Inicio da Migração:
echo "Início da Migração: " . dateNow() . ".\n\n";


// Caminho do arquivo CSV com os dados
$csvFile = "C:/Users/Guilherme Bottcher/Desktop/migration-challenge-main/dados_sistema_legado/20210512_pacientes.csv";

// Abre o arquivo CSV
if (($handle = fopen($csvFile, "r")) !== false) {
    // Ignora o cabeçalho
    fgetcsv($handle, 1000, ";", '"');

    // Processa cada linha do arquivo
    while (($data = fgetcsv($handle, 1000, ";", '"')) !== false) {
        // Prepara e executa a consulta SQL
        $sqlInsert = sprintf(
            "INSERT INTO pacientes_temp (cod_paciente, nome_paciente, nasc_paciente, pai_paciente, mae_paciente, cpf_paciente, rg_paciente, sexo_pac, id_conv, convenio, obs_clinicas) 
            VALUES ('%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s')",
            $data[0], $data[1], date("Y-m-d", strtotime($data[2])), $data[3], $data[4], $data[5], $data[6], $data[7], $data[8], $data[9], $data[10]
        );

        if (mysqli_query($connTemp, $sqlInsert)) {
            echo "Paciente {$data[1]} inserido com sucesso.\n";
        } else {
            echo "Erro ao inserir paciente {$data[1]}: " . mysqli_error($connTemp) . "\n";
        }
    }

    fclose($handle);
} else {
    echo "Erro ao abrir o arquivo CSV.\n";
}

// Encerrando as conexões:
$connMedical->close();
$connTemp->close();

// Informações de Fim da Migração:
echo "Fim da Migração: " . dateNow() . ".\n";