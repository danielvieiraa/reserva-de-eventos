import pedido from "../model/PedidoModel.js";
import comanda from "../model/ComandaModel.js";


// Função para listar todos os pedidos da comanda
async function listarpedidos(request, response) {
    await pedido
        .findAll()
        .then(resultado => response.status(200).json(resultado))
        .catch(erro => response.status(500).json(erro));
}

// Função para selecionar item por pedido
async function selecionaritem(request, response) {
    await pedido
        .findByPk(request.params.id_pedido)
        .then(resultado => {
            if (resultado) {
                response.status(200).json(resultado);
            } else {
                response.status(404).json({ mensagem: "Pedido não encontrado" });
            }
        })
        .catch(erro => response.status(400).json(erro));
}
// Função para selecionar pedidos de uma comanda específica
async function selecionarComandaitem(request, response) {
    await pedido
        .findAll({
            where: {
                id_comanda: request.params.id_comanda, // Filtro pelo id_comanda
            }
        })
        .then(resultado => {
            if (resultado.length > 0) { // Verifica se há pedidos retornados
                response.status(200).json(resultado);
            } else {
                response.status(404).json({ mensagem: "Nenhum pedido encontrado para esta comanda" });
            }
        })
        .catch(erro => response.status(400).json(erro));
}


// Função para criar uma novo pedido e inserir item na comanda
async function criarpedido(request, response) {
    await pedido
        .create({
            id_comanda: request.body.id_comanda,
            cod_item: request.body.cod_item,
            quantidade: request.body.quantidade,
            status: request.body.status,
            tipo: request.body.tipo


        })
        .then(resultado => response.status(201).json(resultado))
        .catch(erro => response.status(400).json(erro));
}

// Função para alterar uma comanda existente
async function alterarpedido(request, response) {
    await pedido
        .update(
            {
                id_comanda: request.body.id_comanda,
                cod_item: request.body.cod_item,
                quantidade: request.body.quantidade
            },
            {
                where: {
                    id_pedido: request.params.id_pedido
                }
            }
        )
        .then(resultado => {
            if (resultado[0] === 1) { // Verifica se alguma linha foi alterada
                response.status(200).json({ mensagem: "Comanda atualizada com sucesso" });
            } else {
                response.status(404).json({ mensagem: "Comanda não encontrada" });
            }
        })
        .catch(erro => response.status(400).json(erro));
}

// lista pedidos da cozinha
async function listarPedidosCozinha(request, response) {
    await pedido
        .findAll({
            where: {
                tipo: true // verifica se o pedido é feito na cozinha
            }
        })
        .then(resultado => {
            if (resultado.length > 0){
                response.status(200).json(resultado)
            } else {
                response.status(404).json({mensagem: "Nenhum pedido para a cozinha"})
            }
        })
        .catch(erro => response.status(500).json(erro))
}

// lista pedidos da copa
async function listarPedidosCopa(request, response) {
    await pedido
        .findAll({
            where: {
                tipo: false // verifica se o pedido é feito na copa
            }
        })
        .then(resultado => {
            if (resultado.length > 0){
                response.status(200).json(resultado)
            } else {
                response.status(404).json({mensagem: "Nenhum pedido para a copa"})
            }
        })
        .catch(erro => response.status(500).json(erro))
}


export default { listarpedidos, selecionaritem, criarpedido, alterarpedido, selecionarComandaitem, listarPedidosCozinha, listarPedidosCopa };
