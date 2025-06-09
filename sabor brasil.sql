-- Criação do banco de dados
CREATE DATABASE IF NOT EXISTS `sabor_brasil` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `sabor_brasil`;

-- Tabela: usuario
CREATE TABLE `usuario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `nickname` varchar(50) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `createdat` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedat` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `nickname` (`nickname`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabela: empresa
CREATE TABLE `empresa` (
  `id_empresa` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `logo` text,
  `createdat` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedat` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_empresa`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabela: publicacao
CREATE TABLE `publicacao` (
  `id_publicacao` int NOT NULL AUTO_INCREMENT,
  `foto` text,
  `nome_pet` varchar(100) NOT NULL,
  `local` varchar(100) DEFAULT NULL,
  `cidade` varchar(100) DEFAULT NULL,
  `usuarioid` int NOT NULL,
  `createdat` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedat` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_publicacao`),
  KEY `publicacao_ibfk_1` (`usuarioid`),
  CONSTRAINT `publicacao_ibfk_1` FOREIGN KEY (`usuarioid`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabela: comentario
CREATE TABLE `comentario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usuarioid` int NOT NULL,
  `publicacaoid` int NOT NULL,
  `texto` text NOT NULL,
  `data_comentario` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `usuarioid` (`usuarioid`),
  KEY `publicacaoid` (`publicacaoid`),
  CONSTRAINT `comentario_ibfk_1` FOREIGN KEY (`usuarioid`) REFERENCES `usuario` (`id`),
  CONSTRAINT `comentario_ibfk_2` FOREIGN KEY (`publicacaoid`) REFERENCES `publicacao` (`id_publicacao`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Tabela: curtida
CREATE TABLE `curtida` (
  `id` int NOT NULL AUTO_INCREMENT,
  `usuarioid` int NOT NULL,
  `publicacaoid` int NOT NULL,
  `tipo_interacao` enum('like','deslike','none') NOT NULL DEFAULT 'none',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usuario_publicacao_unique` (`usuarioid`,`publicacaoid`),
  KEY `usuarioid` (`usuarioid`),
  KEY `publicacaoid` (`publicacaoid`),
  CONSTRAINT `curtida_ibfk_1` FOREIGN KEY (`usuarioid`) REFERENCES `usuario` (`id`),
  CONSTRAINT `curtida_ibfk_2` FOREIGN KEY (`publicacaoid`) REFERENCES `publicacao` (`id_publicacao`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Inserção de dados
INSERT INTO `usuario` (`id`, `nome`, `email`, `nickname`, `senha`, `createdat`, `updatedat`) VALUES
(1, 'Ana Souza', 'ana.souza@email.com', 'anasz', 'senha123', '2025-04-05 03:35:05', '2025-04-05 03:35:05'),
(2, 'Carlos Lima', 'carlos.lima@email.com', 'carlim', 'minhasenha', '2025-04-05 03:35:05', '2025-04-05 03:35:05'),
(3, 'Mariana Alves', 'mariana.alves@email.com', 'mari_a', '1234abcd', '2025-04-05 03:35:05', '2025-04-05 03:35:05'),
(4, 'Paulo', 'okok@gmail.com', 'Paulin', '1234', '2025-04-05 03:58:50', '2025-04-05 03:58:50');

INSERT INTO `empresa` (`id_empresa`, `nome`, `logo`, `createdat`, `updatedat`) VALUES
(1, 'Pet do Brasil', 'images/logo_pet_do_brasil.png', '2025-04-04 23:18:38', '2025-04-04 23:18:38');

INSERT INTO `publicacao` (`id_publicacao`, `foto`, `nome_pet`, `local`, `cidade`, `usuarioid`, `createdat`, `updatedat`) VALUES
(1, 'images/pet01.png', 'Luna', 'Parque Ibirapuera', 'São Paulo-SP', 1, '2025-04-04 23:18:38', '2025-04-04 23:18:38'),
(2, 'images/pet02.png', 'Max', 'Praia de Copacabana', 'Rio de Janeiro-RJ', 2, '2025-04-04 23:18:38', '2025-04-04 23:18:38'),
(3, 'images/pet03.png', 'Bella', 'Parque Barigui', 'Curitiba-PR', 3, '2025-04-04 23:18:38', '2025-04-04 23:18:38'),
(4, '/images/1743824718500.jpg', 'pet', 'minas gerais', 'caratinga', 1, '2025-04-05 03:45:18', '2025-04-05 03:45:18');

INSERT INTO `comentario` (`id`, `usuarioid`, `publicacaoid`, `texto`, `data_comentario`) VALUES
(1, 1, 4, 'oi', '2025-04-05 00:46:31'),
(8, 4, 4, 'oioi', '2025-04-07 16:36:25');

INSERT INTO `curtida` (`id`, `usuarioid`, `publicacaoid`, `tipo_interacao`) VALUES
(1, 1, 4, 'like'),
(3, 4, 1, 'like'),
(10, 4, 3, 'none'),
(18, 4, 4, 'deslike');
