import cardapio from "../model/CardapioModel.js";

async function listarCardapio(request, response) {
    await cardapio
        .findAll()
        .then(resultado => {response.status(200).json(resultado)})
        .catch(erro => {response.status(500).json(erro)});
}

async function selecionarItem(request, response) {
    await cardapio
        .findByPk(request.params.cod_item)
        .then(resultado => {response.status(200).json(resultado)})
        .catch(erro => {response.status(400).json(erro)});
}

async function criarItem(request, response) {
    await cardapio
        .create({
            valor: request.body.valor,
            tipo: request.body.tipo,
            descricao: request.body.descricao
        })
        .then(resultado => {response.status(200).json(resultado)})
        .catch(erro => {response.status(400).json(erro)});
}

async function alterarItem(request, response) {
    await cardapio
        .update({
            valor: request.body.valor,
            tipo: request.body.tipo,
            descricao: request.body.descricao
        },
        {
            where: {
                cod_item: request.params.cod_item
            }
        })
        .then(resultado => {response.status(200).json(resultado)})
        .catch(erro => {response.status(400).json(erro)});
}

export default {listarCardapio, selecionarItem, criarItem, alterarItem};