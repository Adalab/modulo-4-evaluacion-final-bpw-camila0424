const express = require("express");
const cors = require("cors");
const path = require("path");
const mysql = require("mysql2/promise");
require("dotenv").config();

const server = express();

server.use(cors());
server.use(express.json());

const port = 4000;
server.listen(port, () => {
  console.log(`Servidor iniciado <http://localhost:${port}>`);
});

async function getConnection() {
  const connData = {
    host: process.env.MYSQL_HOST,
    port: process.env.MYSQL_PORT,
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASSWORD,
    database: process.env.MYSQL_DATABASE,
  };
  const conn = await mysql.createConnection(connData);
  await conn.connect();

  return conn;
}

// ENDPOINTS DE APIS
// TODAS LAS FRASES CON TODA SU INFORMACION--------------------------------------------------------
server.get("/api/frases", async (req, res) => {
  const conn = await getConnection();

  const [results] =
    await conn.query(`SELECT texto, personajes_id, p.nombre, p.apellido, p.ocupacion, p.descripcion, p.alias, 
            c.titulo, c.numero_episodio, c.temporada, c.fecha_emision, c.sinopsis
            FROM los_simpson.frases f
                JOIN personajes p ON (f.personajes_id = p.id)
                JOIN capitulos_has_frases cf ON  (f.id =cf.frases_id)
                JOIN capitulos c ON (c.id= cf.capitulos_id);`);

  await conn.end();

  res.json(results);
});

// SOLO UNA FRASE----------------------------------------------------------------------
server.get("/api/frases/:id", async (req, res) => {
  try {
    const conn = await getConnection();
    const { id } = req.params;

    const [results] = await conn.query(
      `
      SELECT texto, personajes_id, p.nombre, p.apellido, p.ocupacion, p.descripcion, p.alias, 
             c.titulo, c.numero_episodio, c.temporada, c.fecha_emision, c.sinopsis
      FROM los_simpson.frases f
      JOIN personajes p ON (f.personajes_id = p.id)
      JOIN capitulos_has_frases cf ON (f.id = cf.frases_id)
      JOIN capitulos c ON (c.id = cf.capitulos_id)
      WHERE f.id = ?;
      `,
      [id]
    );

    await conn.end();

    if (results.length === 0) {
      return res.status(404).json({ error: "Frase no encontrada" });
    }

    res.json(results[0]);
  } catch (error) {
    res.status(500).json({ error: "Error en la base de datos" });
  }
});

// CREAR UNA FRASE CON POST -------------------------------------------------------------------------------------
server.post("/api/frases", async (req, res) => {
  try {
    const conn = await getConnection();

    const { texto, marca_tiempo, descripcion, personajes_id } = req.body; //si no creaba esta constante no me funcionaba el postman

    const [results] = await conn.execute(
      `
      INSERT INTO los_simpson.frases (texto, marca_tiempo, descripcion, personajes_id)
      VALUES (?, ?, ?, ?);
      `,
      [texto, marca_tiempo, descripcion, personajes_id]
    );

    await conn.end();

    res.json({
      success: true,
      frase: {
        id: results.insertId,
        texto,
        marca_tiempo,
        descripcion,
        personajes_id,
      },
    });
  } catch (error) {
    console.error(error);
    res
      .status(500)
      .json({ success: false, error: "Error al insertar la frase" });
  }
});

//END POINT CON PUT/UPDATE------------------------------------------------------------------------------------------
server.put("/api/frases/:id", async (req, res) => {
  try {
    const conn = await getConnection();

    const { id } = req.params; //poniendolo solamente en la linea 135 me daba error así que cree una variable con el id del url

    // Obenemos los datos enviados  (JSON)
    const { texto, marca_tiempo, descripcion, personajes_id } = req.body;

    //Validamos que todos los campos necesarios estén
    if (!texto || !marca_tiempo || !descripcion || !personajes_id) {
      await conn.end();
      return res
        .status(400)
        .json({ success: false, message: "Faltan campos obligatorios." });
    }

    // Ejecutamos la consulta SQL UPDATE para modificar la frase
    const [result] = await conn.execute(
      `UPDATE los_simpson.frases
       SET texto = ?, marca_tiempo = ?, descripcion = ?, personajes_id = ?
       WHERE id = ?`,
      [texto, marca_tiempo, descripcion, personajes_id, id]
    );
    //Cerramos la conexión
    await conn.end();
    //Verificamos si seactualizó alguna fila
    if (result.affectedRows === 0) {
      return res
        .status(404)
        .json({ success: false, message: "Frase no encontrada." });
    }
    //Si todo fue bien, enviamos la frase como respuesta
    res.json({
      success: true,
      message: "Frase actualizada correctamente.",
      frase: {
        id,
        texto,
        marca_tiempo,
        descripcion,
        personajes_id,
      },
    });
  } catch (error) {
    //Si ocurre un error respondemos con error500

    res
      .status(500)
      .json({ success: false, error: "Error al actualizar la frase." });
  }
});

//END POINT METODO DELETE-------------------------------------------------------------------------------------------------
server.delete("/api/frases/:id", async (req, res) => {
  try {
    //Obtenemos el ID desde los parámetros de la URL
    const { id } = req.params;

    //Abimos una conexión a la base de datos
    const conn = await getConnection();

    //Ejecutamos la consulta de MYSQL para elimnar la frase con ese ID
    const [result] = await conn.execute(
      `DELETE FROM los_simpson.frases WHERE id = ?`,
      [id] //  pasamos el ID como parámetro
    );

    //Cerramos la conexión
    await conn.end();

    //Verificamos si realmente se eliminó alguna fila
    if (result.affectedRows === 0) {
      // Si no se eliminó nada, es porque no seencontró una frase con ese ID y entonces respondemos con TRUE
      return res.status(404).json({
        success: false,
        message: "Frase no encontrada.",
      });
    }

    //Si se eliminó correctamente, respondemos con TRUE
    res.json({
      success: true,
      message: `Frase con ID ${id} eliminada correctamente.`,
    });
  } catch (error) {
    //En caso de error enviamos error 500

    res.status(500).json({
      success: false,
      error: "Error interno al eliminar la frase.",
    });
  }
});

// NO ENCONTRADO
server.use(/.*/, (req, res) => {
  res.status(404).sendFile(path.join(__dirname, "../FRONTEND/error404.html"));
});

//hice 2 ENDPOINT con el método GET aunqeu creo que pude haberlos hecho en un o solo y agregar las verificaciones y los condicionales despues de cerrar la conexión pero por estructura mental que se me hizo más claro de esa forma
