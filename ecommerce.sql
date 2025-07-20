SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Cliente` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `idCliente` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Identificação` VARCHAR(45) NULL,
  `Endereço` VARCHAR(45) NULL,
  `TipoPessoa` ENUM('F', 'J') NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Entrega`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Entrega` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Entrega` (
  `idEntrega` INT NOT NULL,
  `Código de Rastreio` VARCHAR(45) NULL,
  `Data de Emissão` DATE NULL,
  `Data do Envio` DATE NULL,
  `Data da Entrega` DATE NULL,
  PRIMARY KEY (`idEntrega`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Pedido` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Pedido` (
  `idPedido` INT NOT NULL,
  `Status` VARCHAR(45) NULL,
  `Descrição` VARCHAR(45) NULL,
  `Frete` FLOAT NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Entrega_idEntrega` INT NOT NULL,
  PRIMARY KEY (`idPedido`, `Cliente_idCliente`),
  INDEX `fk_Pedido_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  INDEX `fk_Pedido_Entrega1_idx` (`Entrega_idEntrega` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_Entrega1`
    FOREIGN KEY (`Entrega_idEntrega`)
    REFERENCES `mydb`.`Entrega` (`idEntrega`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produtos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Produtos` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Produtos` (
  `idProdutos` INT NOT NULL,
  `Categoria` VARCHAR(45) NULL,
  `Descrição` VARCHAR(45) NULL,
  PRIMARY KEY (`idProdutos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Fornecedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Fornecedor` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Fornecedor` (
  `idFornecedor` INT NOT NULL,
  `Razão Social` VARCHAR(45) NULL,
  `CNPJ` VARCHAR(45) NULL,
  PRIMARY KEY (`idFornecedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Estoque`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Estoque` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Estoque` (
  `idEstoque` INT NOT NULL,
  `Local` VARCHAR(45) NULL,
  PRIMARY KEY (`idEstoque`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ProdutoEstoque`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ProdutoEstoque` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ProdutoEstoque` (
  `Estoque_idEstoque` INT NOT NULL,
  `Produtos_idProdutos` INT NOT NULL,
  `Quantidade` INT NULL,
  `DataAtualização` DATE NULL,
  PRIMARY KEY (`Estoque_idEstoque`, `Produtos_idProdutos`),
  INDEX `fk_Estoque_has_Produtos_Produtos1_idx` (`Produtos_idProdutos` ASC) VISIBLE,
  INDEX `fk_Estoque_has_Produtos_Estoque1_idx` (`Estoque_idEstoque` ASC) VISIBLE,
  CONSTRAINT `fk_Estoque_has_Produtos_Estoque1`
    FOREIGN KEY (`Estoque_idEstoque`)
    REFERENCES `mydb`.`Estoque` (`idEstoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Estoque_has_Produtos_Produtos1`
    FOREIGN KEY (`Produtos_idProdutos`)
    REFERENCES `mydb`.`Produtos` (`idProdutos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Disponibiliza Produto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Disponibiliza Produto` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Disponibiliza Produto` (
  `Produtos_idProdutos` INT NOT NULL,
  `Fornecedor_idFornecedor` INT NOT NULL,
  PRIMARY KEY (`Produtos_idProdutos`, `Fornecedor_idFornecedor`),
  INDEX `fk_Produtos_has_Fornecedor_Fornecedor1_idx` (`Fornecedor_idFornecedor` ASC) VISIBLE,
  INDEX `fk_Produtos_has_Fornecedor_Produtos1_idx` (`Produtos_idProdutos` ASC) VISIBLE,
  CONSTRAINT `fk_Produtos_has_Fornecedor_Produtos1`
    FOREIGN KEY (`Produtos_idProdutos`)
    REFERENCES `mydb`.`Produtos` (`idProdutos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produtos_has_Fornecedor_Fornecedor1`
    FOREIGN KEY (`Fornecedor_idFornecedor`)
    REFERENCES `mydb`.`Fornecedor` (`idFornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PedidoProduto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`PedidoProduto` ;

CREATE TABLE IF NOT EXISTS `mydb`.`PedidoProduto` (
  `Pedido_idPedido` INT NOT NULL,
  `Produtos_idProdutos` INT NOT NULL,
  `Quantidade` INT NULL,
  `Valor Unitário` FLOAT NULL,
  PRIMARY KEY (`Pedido_idPedido`, `Produtos_idProdutos`),
  INDEX `fk_Pedido_has_Produtos_Produtos1_idx` (`Produtos_idProdutos` ASC) VISIBLE,
  INDEX `fk_Pedido_has_Produtos_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_has_Produtos_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `mydb`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_has_Produtos_Produtos1`
    FOREIGN KEY (`Produtos_idProdutos`)
    REFERENCES `mydb`.`Produtos` (`idProdutos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Terceiro - Vendedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Terceiro - Vendedor` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Terceiro - Vendedor` (
  `idTerceiro - Vendedor` INT NOT NULL,
  `Razão Social` VARCHAR(45) NULL,
  `Local` VARCHAR(45) NULL,
  PRIMARY KEY (`idTerceiro - Vendedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ProdutoVendedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`ProdutoVendedor` ;

CREATE TABLE IF NOT EXISTS `mydb`.`ProdutoVendedor` (
  `Terceiro - Vendedor_idTerceiro - Vendedor` INT NOT NULL,
  `Produtos_idProdutos` INT NOT NULL,
  `Quantidade` INT NULL,
  `Valor` FLOAT NULL,
  PRIMARY KEY (`Terceiro - Vendedor_idTerceiro - Vendedor`, `Produtos_idProdutos`),
  INDEX `fk_Terceiro - Vendedor_has_Produtos_Produtos1_idx` (`Produtos_idProdutos` ASC) VISIBLE,
  INDEX `fk_Terceiro - Vendedor_has_Produtos_Terceiro - Vendedor1_idx` (`Terceiro - Vendedor_idTerceiro - Vendedor` ASC) VISIBLE,
  CONSTRAINT `fk_Terceiro - Vendedor_has_Produtos_Terceiro - Vendedor1`
    FOREIGN KEY (`Terceiro - Vendedor_idTerceiro - Vendedor`)
    REFERENCES `mydb`.`Terceiro - Vendedor` (`idTerceiro - Vendedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Terceiro - Vendedor_has_Produtos_Produtos1`
    FOREIGN KEY (`Produtos_idProdutos`)
    REFERENCES `mydb`.`Produtos` (`idProdutos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Meio de Pagamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Meio de Pagamento` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Meio de Pagamento` (
  `idPagamento` INT NOT NULL,
  `Meio de Pagamento` ENUM('Pix', 'Cartão') NULL,
  `Data Pagamento` DATE NULL,
  `Valor` FLOAT NULL,
  `Pedido_idPedido` INT NOT NULL,
  PRIMARY KEY (`idPagamento`),
  INDEX `fk_Pagamento_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  CONSTRAINT `fk_Pagamento_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `mydb`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cartão`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Cartão` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Cartão` (
  `idCartão` INT NOT NULL,
  `Número do Cartão` VARCHAR(45) NULL,
  `Pagamento_idPagamento` INT NOT NULL,
  PRIMARY KEY (`idCartão`),
  INDEX `fk_Cartão_Pagamento1_idx` (`Pagamento_idPagamento` ASC) VISIBLE,
  CONSTRAINT `fk_Cartão_Pagamento1`
    FOREIGN KEY (`Pagamento_idPagamento`)
    REFERENCES `mydb`.`Meio de Pagamento` (`idPagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pix`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Pix` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Pix` (
  `idPix` INT NOT NULL,
  `Pagamento_idPagamento` INT NOT NULL,
  PRIMARY KEY (`idPix`, `Pagamento_idPagamento`),
  INDEX `fk_Dinheiro_Pagamento1_idx` (`Pagamento_idPagamento` ASC) VISIBLE,
  CONSTRAINT `fk_Dinheiro_Pagamento1`
    FOREIGN KEY (`Pagamento_idPagamento`)
    REFERENCES `mydb`.`Meio de Pagamento` (`idPagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PJ Pessoa Jurídica`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`PJ Pessoa Jurídica` ;

CREATE TABLE IF NOT EXISTS `mydb`.`PJ Pessoa Jurídica` (
  `idPJ` INT NOT NULL,
  `CNPJ` VARCHAR(14) NULL,
  `Razão Social` VARCHAR(45) NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idPJ`),
  INDEX `fk_PJ Pessoa Jurídica_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_PJ Pessoa Jurídica_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`PF Pessoa Física`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`PF Pessoa Física` ;

CREATE TABLE IF NOT EXISTS `mydb`.`PF Pessoa Física` (
  `idPF` INT NOT NULL,
  `CPF` VARCHAR(11) NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idPF`),
  INDEX `fk_PF Pessoa Física_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_PF Pessoa Física_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `mydb`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

