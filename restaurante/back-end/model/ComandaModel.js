import { Sequelize } from "sequelize";
import banco from "../banco.js";

export default banco.define("comanda", {
    id_comanda: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true,
        allowNull: false
    },
    num_mesa: {
        type: Sequelize.INTEGER,
        allowNull: false
    },
    valor: {
        type: Sequelize.FLOAT,
        allowNull: false
    },
    fechada: {
        type: Sequelize.BOOLEAN,
        defaultValue: false
    }
})