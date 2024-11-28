import express from "express";
import banco from "./banco.js";
import cors from "cors";
import cardapio from "./controller/Cardapio.js";
import Comanda from "./controller/Comanda.js";
import Pedido from "./controller/Pedido.js";

try{
    await banco.authenticate();
    console.log('Conexão estabelecida com sucesso!');
} catch (error){
    console.log("Não foi possível conectar com o banco de dados: ", error);
}

const app = express();
app.use(express.json());
app.use(cors());

// Métodos Cardapio
app.get("/cardapio", cardapio.listarCardapio);
app.get("/cardapio/:cod_item", cardapio.selecionarItem);
app.post("/cardapio", cardapio.criarItem);
app.patch("/cardapio/:cod_item", cardapio.criarItem)


//metodos comanda

app.get("/comanda", Comanda.listarComandas);
app.get("/comanda/:id_comanda", Comanda.selecionarComanda);
app.post("/comanda", Comanda.criarComanda);

//medotos pedido

app.get("/pedido", Pedido.listarpedidos);
app.get("/pedido/:id_pedido", Pedido.selecionaritem);
app.get("/pedidos/:id_comanda", Pedido.selecionarComandaitem);
app.get("/cozinha/pedidos", Pedido.listarPedidosCozinha);
app.get("/copa/pedidos", Pedido.listarPedidosCopa);
app.post("/pedido", Pedido.criarpedido);
app.patch("/pedido/:id_pedido", Pedido.alterarpedido);

app.listen(4000);