CREATE DATABASE  IF NOT EXISTS `los_simpson` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `los_simpson`;
-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: los_simpson
-- ------------------------------------------------------
-- Server version	8.0.42

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `capitulos`
--

DROP TABLE IF EXISTS `capitulos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `capitulos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `titulo` varchar(45) DEFAULT NULL,
  `numero_episodio` int NOT NULL,
  `temporada` int NOT NULL,
  `fecha_emision` date DEFAULT NULL,
  `sinopsis` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `capitulos`
--

LOCK TABLES `capitulos` WRITE;
/*!40000 ALTER TABLE `capitulos` DISABLE KEYS */;
INSERT INTO `capitulos` VALUES (1,'Simpsons Roasting on an Open Fire',1,1,'1989-12-17',' En este episodio navideño inaugural, Homero descubre que no recibirá su bono de Navidad y debe encontrar una alternativa para pagar los regalos. Trabaja como Santa Claus en un centro comercial, mientras Bart descubre que Santa no existe. Al final, en un giro adorable, Homero lleva a la familia a ver una mascota canina callejera —que Maggie adopta—, redescubriendo el espíritu navideño.'),(2,'Last Exit to Springfield',17,4,'1993-03-04','Cuando la Planta Nuclear de Springfield revoca el plan dental de sus empleados, Homero —como líder sindical— enfrenta al Sr. Burns en una huelga histórica. Mientras tanto, Lisa necesita frenillos, lo que aumenta la tensión. Este episodio es considerado por muchos como uno de los mejores, logrando una mezcla perfecta de humor, música y crítica social '),(3,'Lisa\'s Wedding',19,6,'1995-03-19','Lisa visita a una vidente que le predice un futuro amoroso. La acción salta a 2010, donde Lisa está comprometida con un joven británico elitista. La familia viaja al Reino Unido para conocerlo y, pese a las diferencias culturales, prospera el afecto familiar. Ganador del Emmy a Mejor Programa Animado, este episodio combina humor romántico con emotiva nostalgia'),(4,'Homer at the Bat',17,3,'1992-02-20','Homero se une al equipo de softball de la Planta Nuclear, que enfrenta a un equipo rival. Para asegurarse la victoria, el Sr. Burns contrata a varias estrellas de las Grandes Ligas de béisbol para jugar con el equipo de Springfield. El episodio es una parodia de los deportes y está lleno de humor y cameos famosos.'),(5,'Treehouse of Horror V',6,6,'1994-10-30','Episodio especial de Halloween con tres historias: una parodia de \"El resplandor\", una historia sobre viajes en el tiempo que altera la realidad, y una versión satírica de \"La mosca\". Es uno de los episodios más aclamados de la saga \"Treehouse of Horror\".'),(6,'Bart Gets an F',1,2,'1990-10-11','Bart está a punto de repetir curso porque tiene malas notas. Con la ayuda de la maestra Edna Krabappel y estudiando duro, intenta aprobar su examen final. Este episodio muestra un lado más sensible de Bart y la importancia de la educación.');
/*!40000 ALTER TABLE `capitulos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `capitulos_has_frases`
--

DROP TABLE IF EXISTS `capitulos_has_frases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `capitulos_has_frases` (
  `capitulos_id` int NOT NULL,
  `frases_id` int NOT NULL,
  PRIMARY KEY (`frases_id`),
  KEY `fk_capitulos_has_frases_frases1_idx` (`frases_id`),
  KEY `fk_capitulos_has_frases_capitulos1_idx` (`capitulos_id`),
  CONSTRAINT `fk_capitulos_has_frases_capitulos1` FOREIGN KEY (`capitulos_id`) REFERENCES `capitulos` (`id`),
  CONSTRAINT `fk_capitulos_has_frases_frases1` FOREIGN KEY (`frases_id`) REFERENCES `frases` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `capitulos_has_frases`
--

LOCK TABLES `capitulos_has_frases` WRITE;
/*!40000 ALTER TABLE `capitulos_has_frases` DISABLE KEYS */;
INSERT INTO `capitulos_has_frases` VALUES (1,13),(1,19),(1,25),(2,14),(2,20),(2,26),(3,15),(3,21),(3,27),(4,16),(4,22),(4,28),(5,17),(5,23),(5,29),(6,18),(6,24);
/*!40000 ALTER TABLE `capitulos_has_frases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `capitulos_has_personajes`
--

DROP TABLE IF EXISTS `capitulos_has_personajes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `capitulos_has_personajes` (
  `capitulos_id` int NOT NULL,
  `personajes_id` int NOT NULL,
  PRIMARY KEY (`capitulos_id`,`personajes_id`),
  KEY `fk_capitulos_has_personajes_personajes1_idx` (`personajes_id`),
  KEY `fk_capitulos_has_personajes_capitulos1_idx` (`capitulos_id`),
  CONSTRAINT `fk_capitulos_has_personajes_capitulos1` FOREIGN KEY (`capitulos_id`) REFERENCES `capitulos` (`id`),
  CONSTRAINT `fk_capitulos_has_personajes_personajes1` FOREIGN KEY (`personajes_id`) REFERENCES `personajes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `capitulos_has_personajes`
--

LOCK TABLES `capitulos_has_personajes` WRITE;
/*!40000 ALTER TABLE `capitulos_has_personajes` DISABLE KEYS */;
/*!40000 ALTER TABLE `capitulos_has_personajes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `frases`
--

DROP TABLE IF EXISTS `frases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `frases` (
  `id` int NOT NULL AUTO_INCREMENT,
  `texto` longtext NOT NULL,
  `marca_tiempo` varchar(10) DEFAULT NULL,
  `descripcion` longtext,
  `personajes_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_frases_personajes1_idx` (`personajes_id`),
  CONSTRAINT `fk_frases_personajes1` FOREIGN KEY (`personajes_id`) REFERENCES `personajes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `frases`
--

LOCK TABLES `frases` WRITE;
/*!40000 ALTER TABLE `frases` DISABLE KEYS */;
INSERT INTO `frases` VALUES (13,'Si no tienes nada bueno que decir, ven a sentarte aquí conmigo',NULL,NULL,9),(14,'Muy bien. No me casaré nunca',NULL,NULL,10),(15,'Es curioso cómo la música puede hacer que los recuerdos vuelvan',NULL,NULL,10),(16,'A veces una mujer tiene que defenderse por sí misma',NULL,NULL,9),(17,'D\'oh!',NULL,NULL,11),(18,'¡Excelente',NULL,NULL,13),(19,'¡Ay, caramba',NULL,NULL,12),(20,'¡No fui yo!',NULL,NULL,12),(21,'¡Cowabunga!',NULL,NULL,12),(22,'¿Por qué nadie me entiende?',NULL,NULL,10),(23,'Tengo 8 años y ya he leído más que tú en toda tu vida',NULL,NULL,10),(24,'Mmm... donas',NULL,NULL,11),(25,'¡Estúpido Flanders!',NULL,NULL,11),(26,'¡Hooooomero!',NULL,NULL,9),(27,'No me parece una buena idea, Homero.',NULL,NULL,9),(28,'¡Liberen a los sabuesos!',NULL,NULL,13),(29,'Smithers, ¿quién es ese hombre?',NULL,NULL,13);
/*!40000 ALTER TABLE `frases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personajes`
--

DROP TABLE IF EXISTS `personajes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `personajes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `apellido` varchar(45) DEFAULT NULL,
  `ocupacion` longtext,
  `descripcion` longtext,
  `alias` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personajes`
--

LOCK TABLES `personajes` WRITE;
/*!40000 ALTER TABLE `personajes` DISABLE KEYS */;
INSERT INTO `personajes` VALUES (9,'Marjorie Jacqueline','Bouvier Simpson','Ama de casa','Mujer de 38 años de edad, esposa de Homer, madre de Lisa, Bart, Magui y Hugo. Su rasgo más distintivo es su enorme cabello azul, peinado en un altísimo estilo \"beehive\" (colmena).\n\nTiene una complexión delgada y alta.\n\nGeneralmente viste un vestido verde strapless, zapatos rojos y un collar de perlas rojas.Paciente, cariñosa y abnegada: Es el pilar emocional y moral de la familia Simpson.\n\nRepresenta la figura clásica de madre entregada, aunque con momentos donde demuestra deseos reprimidos de independencia o realización personal.\n\nSuele ser tolerante, incluso frente al caos causado por Homer o Bart, pero también sabe imponerse cuando es necesario.\n\nTiene una fuerte conciencia moral y social, aunque más conservadora que la de Lisa. Le gusta la cocina, el orden, el arte y las manualidades.\n\nEn distintos episodios ha incursionado en actividades artísticas, trabajo comunitario, e incluso en profesiones como policía o agente inmobiliaria.\n\nLe apasiona mantener a su familia unida, a pesar de sus muchos defectos.','Marge, Señora Simpson, Marjorie'),(10,'Lisa Marie','Simpson','Estudiante','Mujer de 8 años de edad, hija de Homer y Marge. Cabello en forma de estrella puntiaguda. Generalmente usa un vestido rojo sin mangas, un collar de perlas blancas y zapatos rojos. De complexión delgada y estatura baja.Inteligente y madura para su edad: Lisa tiene un coeficiente intelectual de 159.\n\nAmante del conocimiento: Le apasiona la lectura, la ciencia, la filosofía y la historia.\n\nMoralista y ética: Suele preocuparse por temas sociales, medioambientales y de justicia.\n\nVegetariana y budista.\n\nFeminista y progresista, frecuentemente entra en conflicto con la mentalidad conservadora de su entorno. Toca el saxofón con gran habilidad (su ídolo es el difunto saxofonista Bleeding Gums Murphy).\n\nLe gusta la música jazz y clásica.\n\nA menudo se involucra en causas como el medioambiente, los derechos de los animales o la política.','Lisa, Cerebrito, Sabionda\n\n, Señorita Perfecta'),(11,'Homer Jay','Simpson','Inspector de seguridad en la Planta Nuclear','Hombre de aproximadamente 39 años. De complexión robusta (con sobrepeso).\n\nPiel amarilla (como todos los personajes de la serie).\n\nCabello escaso: dos pelos en la parte superior de la cabeza y una línea en forma de M.\n\nSiempre usa una camisa blanca de manga corta, pantalón azul y zapatos negros.\n\nPerezoso, impulsivo y despistado, pero a veces sorprendentemente sensible.\n\nTiene bajo coeficiente intelectual (el número exacto varía entre episodios, pero se ha dicho que es 55), aunque es funcional y a veces hasta ingenioso.\n\nSuele actuar por instinto y deseo inmediato, lo que lo mete en problemas constantemente.\n\nA pesar de todos sus defectos, ama profundamente a su familia, aunque muchas veces no lo demuestre de la mejor forma.\n\n Su jefe es el Sr. Burns, a quien teme y respeta a la vez. Come en exceso, especialmente donas, hamburguesas, y cerveza Duff.\n\nLe encanta mirar televisión, dormir y pasar el rato en el bar de Moe con sus amigos.\n\nTiene una relación complicada con el trabajo y las responsabilidades.\n\nA pesar de su flojera, ha tenido decenas de trabajos diferentes a lo largo de la serie: astronauta, inventor, cantante de ópera, conductor, etc.','Homer, Homero, el elegido'),(12,'Bartholomew JoJo','Simpson','Estudiante','Hombre de 10 años de edad. Cabello en picos puntiagudos (color amarillo, igual que su piel).\n\nGeneralmente viste una camiseta roja, shorts azules, zapatillas azules y medias blancas.\n\nEs bajito, delgado y con expresión traviesa casi siempre. Travieso, rebelde y bromista por excelencia.\n\nTiene un espíritu de desobediencia e irreverencia que lo mete constantemente en problemas.\n\nAunque parece despreocupado, en el fondo desea ser querido y aceptado, especialmente por su familia y algunas figuras de autoridad.\n\nLe gusta desafiar reglas, maestros y figuras adultas, especialmente a Skinner, el director de su escuela.\n\n Asiste a la Escuela Primaria de Springfield, donde suele sacar malas notas y hacer travesuras.\n\nSu maestra es Edna Krabappel (en las primeras temporadas).\n\nEs enemigo frecuente del director Seymour Skinner. Le encanta andar en skate, ver televisión (especialmente Tomy y Daly), jugar videojuegos, hacer bromas telefónicas, y fastidiar a su hermana Lisa.\n\nAdmira a Krusty el Payaso y sueña con ser famoso o libre de responsabilidades.\n\nTiene un sentido del humor ácido y sarcástico.\n\n ','Bart, El Barto,Chico problema'),(13,'Charles Montgomery','Plantagenet Schicklgruber Burns','Propietario y presidente de la Planta Nuclear de Springfield','Hombre de aproximadamente 104 años. Extremadamente delgado y encorvado, casi esquelético.\n\nPiel pálida, rostro arrugado y sin expresión cálida.\n\nUsa traje verde oscuro, corbata negra, y siempre va acompañado por su asistente personal, Smithers.\n\n Casi siempre junta las manos con los dedos hacia abajo mientras dice su icónica frase. Es el arquetipo del multimillonario despiadado, mezquino y desconectado de la realidad.\n\nCodicioso, cruel, manipulador y egoísta. Carece de empatía por los demás.\n\nDesprecia a los pobres, los sindicatos, los animales, el medioambiente... prácticamente a todo el mundo.\n\nTiene valores anticuados, como si siguiera viviendo en el siglo XIX.\n\nA menudo olvida el nombre de sus empleados, especialmente el de Homero Simpson, aunque han interactuado decenas de veces. Su asistente y admirador leal es Waylon Smithers, quien también está enamorado de él.\n\nNo tiene muchos amigos, pero ha tenido varios enemigos, incluyendo a Homer, Lisa, y hasta los Rolling Stones en un episodio.\n\nFue novio de la madre de Marge en el pasado. ','Sr. Burns, Monty\r, El hombre más rico de Springfield ');
/*!40000 ALTER TABLE `personajes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-01 13:54:24
