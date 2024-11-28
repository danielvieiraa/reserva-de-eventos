CREATE OR REPLACE FUNCTION atualizar_valor_comanda()
RETURNS TRIGGER AS $$
BEGIN

	UPDATE comanda
    SET valor = COALESCE(valor, 0) + (
        SELECT c.valor * NEW.quantidade
        FROM cardapio c
        WHERE c.cod_item = NEW.cod_item
    )
    WHERE id_comanda = NEW.id_comanda;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_atualizar_valor_comanda
AFTER INSERT ON pedido
FOR EACH ROW
EXECUTE FUNCTION atualizar_valor_comanda();


create table comanda (
  id_comanda serial primary key,
  num_mesa int,
  valor FLOAT,
  fechada BOOLEAN DEFAULT FALSE
);

CREATE TABLE cardapio (
    valor FLOAT,
    cod_item SERIAL PRIMARY KEY,
    tipo VARCHAR(50),
    nome VARCHAR(50),
    descricao VARCHAR(100),
    urlImagen VARCHAR(100)
);


create table pedido (
  id_pedido serial primary key,
  cod_item int,
  id_comanda int,
  quantidade int,
  status BOOLEAN NOT NULL DEFAULT TRUE, --se for false está em preparo se for true está pronto
  tipo BOOLEAN NOT NULL DEFAULT TRUE, -- se for bebida false vai para copa se for prato true vai para cozinha
  constraint fk_comanda foreign key (id_comanda)references comanda(id_comanda),
  constraint fk_cardapio foreign key (cod_item) references cardapio(cod_item)
);



create table users (
    id_usuario serial primary key,
    nome varchar(50),
    email varchar(50),
    senha varchar(255)  
);
	


INSERT INTO comanda (num_mesa) VALUES
(1),
(2),
(3);


INSERT INTO cardapio (valor, tipo, descricao) VALUES
(29.90, 'Prato Principal', 'Frango Grelhado com Legumes'),
(19.90, 'Entradas', 'Salada Caesar'),
(9.90, 'Bebidas', 'Refrigerante'),
(14.90, 'Sobremesa', 'Pudim de Leite');


INSERT INTO pedido (id_comanda, cod_item, quantidade) VALUES
(1, 1, 1),
(1, 2, 1),
(2, 3, 1),
(3, 4, 1);

INSERT INTO users (nome, email, senha) VALUES
('João Silva', 'joao@email.com', 'senha123'),
('Maria Oliveira', 'maria@email.com', 'senha456'),
('Pedro Santos', 'pedro@email.com', 'senha789');