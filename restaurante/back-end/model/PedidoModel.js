import { Sequelize } from "sequelize";
import banco from "../banco.js";

export default banco.define("pedido", {
    id_pedido: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false
    },
    id_comanda: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: {
            model: 'Comanda',
            key: 'id_comanda'
        }
    },
     cod_item: {
        type: Sequelize.INTEGER,
        allowNull: false,
        references: {
            model: 'Cardapio',
            key: 'cod_item'
        }
    },
    quantidade: {
        type: Sequelize.INTEGER,
        allowNull: false
    },
    status: {
        type: Sequelize.BOOLEAN,
        allowNull: false,
    },
    tipo: {
        type: Sequelize.BOOLEAN,
        allowNull: false
    }

})