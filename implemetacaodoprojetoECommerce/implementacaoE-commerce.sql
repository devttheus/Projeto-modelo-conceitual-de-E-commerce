-- Criação para o banco de dados para o cenário de E-commerce
CREATE database if not exists eCommerce;
-- DROP database eCommerce;
USE eCommerce;

-- Criar tabela cliente --
CREATE table if not exists clients(
	idClient int auto_increment primary key,
    fName varchar(15),
    minit char(3),
    lName varchar(20),
    cpf char(11) NOT NULL,
    address varchar(50),
    constraint unique_cpf_Client unique(cpf)
);

ALTER table clients auto_increment=1;

desc clients;

-- Criar tabela produto --
/*Observações:
size = dimensão produto
*/
CREATE table if not exists product(
	idProduct int auto_increment primary key,
    pName varchar(15) NOT NULL,
    classification_Kids bool default false,
    category enum("eletrônico","vestimento","brinquedo","alimentos","móveis") NOT NULL,
    avaliacao float default 0,
    size varchar(10)
);

ALTER table product auto_increment=1;

desc product;

-- Criar tabela de pagamento --
/* PARA SER CONTINUADO NO DESAFIO: 
 *terminar de imcrementar a tabela e crie as conexões
 *necessárias, além disso, reflita essa modificação no diagrama de esquema relacional.
 *Criar constrait relacionadas ao pagamento.
 *
 *Colocar dentro da tabela orders: idPayment -- foreign key
 *Para referenciar essa tabela
 *
 */
CREATE table if not exists payments(
	idClient int,
    idPayment int,
    typePayment enum("Cartão","Boleto","Dois cartãoes") NOT NULL,
    limitAvailable float,
    primary key(idClient,idPayment)
);

desc payments;

-- DROP table orders;

-- Criar tabela pedido --
CREATE table if not exists orders(
	idOrder int auto_increment primary key,
    idOrderClient int, 
    orderStatus enum("Cancelado","Confirmado","Em processamento") default "Em processamento",
    orderDescription varchar(255),
    sendValue float default 10,
    paymentCash boolean default false,
    constraint fk_Orders_Client foreign key(idOrderClient) references clients(idClient)
		on UPDATE cascade
);

ALTER table orders auto_increment=1;

desc orders;

-- Criar tabela estoque --
CREATE table if not exists productStorage(
	idProductStorage int auto_increment primary key,
    storageLocation varchar(50),
    quantity INT default 0
);

ALTER table productStorage auto_increment=1;


desc productStorage;

-- Criar tabela fornecedor --
CREATE table if not exists supplier(
	idSupplier int auto_increment primary key,
    socialName varchar(255) NOT NULL,
    cnpj char(15) NOT NULL,
    contact char(11) NOT NULL,
    constraint unique_cnpj_Supplier unique(cnpj)
);

ALTER table supplier auto_increment=1;

desc supplier;

-- Criar tabela vendedor --
/*Observações:
Seller = TerceiroVendedor
*/
CREATE table if not exists seller(
	idSeller int auto_increment primary key,
    socialName varchar(255) NOT NULL,
    abstName varchar(255),
	Location varchar(255),
    cnpj char(15),
    cpf char(9),
    contact char(11) NOT NULL,
    constraint unique_cnpj_Seller unique(cnpj),
	constraint unique_cpf_Seller unique(cpf)
);

ALTER table seller auto_increment=1;

desc seller;

/*Obervações:
 *productSeller é a entidade produtosVendedor(terceiro), no diagrama de esquema relacional
 */
CREATE table if not exists productSeller(
	idpSeller int,
	idPProduct int,
	quantityProduct int default 1,
    primary key(idpSeller, idPProduct),
    constraint fk_Product_Seller foreign key(idpSeller) references seller(idSeller),
    constraint fk_Product_Product foreign key(idPProduct) references product(idProduct)
);

desc productSeller;

/*Obervações:
 *productOrder é a entidade produtos&Pedido, no diagrama de esquema relacional
 */
CREATE table if not exists productOrder(
	idProOrProduct int,
    idProOrOrder int,
    proOrdQuantity int default 1,
    proOrdStatus enum("Disponível","Sem estoque") default "Disponível",
    primary key(idProOrProduct,idProOrOrder),
    constraint fk_ProductOrder_Seller foreign key(idProOrProduct) references product(idProduct),
    constraint fk_ProductOrder_Product foreign key(idProOrOrder) references orders(idOrder)
);

desc productOrder;

/*Obervações:
 *StorageLocation é a entidade produto_em_estoque, no diagrama de esquema relacional
 */
CREATE table if not exists StorageLocation(
	idLProduct int,
    idLStorage int,
    location varchar(255) NOT NULL,
    primary key(idLProduct,idLStorage),
    constraint fk_Storage_Location_Product foreign key(idLProduct) references product(idProduct),
    constraint fk_Storage_Location_Storage foreign key(idLStorage) references productStorage(idProductStorage)
);

desc StorageLocation;

/*Obervações:
 *productSupplier é a entidade produtosVendedor(terceiro), no diagrama de esquema relacional
 */
CREATE table if not exists productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int NOT NULL,
    primary key(idPsSupplier,idPsProduct),
    constraint fk_Product_Supplier_Supplier foreign key(idPsSupplier) references supplier(idSupplier),
    constraint fk_Product_Supplier_Product foreign key(idPsProduct) references product(idProduct)
);

desc productSupplier;

SHOW tables;
-- USE information_schema;
-- SHOW tables; -- constra
-- desc REFERENTIAL_CONSTRAINTS; 
-- select * FROM REFERENTIAL_CONSTRAINTS; -- procurar como achar as constrait da minha entidade
-- select * FROM REFERENTIAL_CONSTRAINTS where CONSTRAINT_SCHEMA = "eCommerce";