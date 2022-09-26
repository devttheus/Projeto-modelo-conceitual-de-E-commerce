-- inserção de dados e queries
USE eCommerce;

ShOW tables;

-- INSERIR: idClient(auto-increment), fName, minit, lName, cpf, address
INSERT INTO clients(fName, minit, lName, cpf, address)
			values("Maria","M","Silva",123456789,"rua silva de prata 29 - Cidade das flores"),
				  ("Matheus","O","Pimentel",987654321,"rua almeida 289,Centro - Cidade das flores"),
				  ("Ricardo","F","Silva",475678913,"avenida alemeda vinha 1009,Centro - flores"),
				  ("Julia","S","França",789123456,"rua lareijras 861,Centro - Cidade das flores"),
				  ("Roberta","G","Assis",987456312,"avenida koller 19,Centro - Cidade das flores"),
				  ("Isadora","M","Cruz",654789123,"rua almeida de prata 28,Centro - Cidade das flores");
                  
-- INSERIR: idProduct(auto-increment), pName, classification_Kids bool,category ("eletrônico","vestimento","brinquedo","alimentos","móveis"),avaliacao, size
INSERT INTO product(pName, classification_Kids,category,avaliacao, size)
			values("Fone de ouvido",false,"eletrônico","4",null),
				  ("Barbie Elza",true,"brinquedo","3",null),
                  ("Body Carters",true,"vestimento","5",null),
                  ("Microfone Vedo",false,"eletrônico","4",null),
                  ("Sofá retratil",false,"móveis","3","3x57x80"),
                  ("Farinha",false,"alimentos","2",null),
                  ("FireStica",false,"eletrônico","3",null);
	
SELECT * FROM clients;
SELECT * FROM product;

-- orderStatus enum("Cancelado","Confirmado","Em processamento") default "Em processamento"
INSERT INTO orders(idOrderClient, orderStatus,orderDescription,sendValue,paymentCash)
			values(1,default,"compra via aplicativo",null,1),
				  (2,default,"compra via aplicativo",50,0),
                  (3,"Confirmado",null,null,1),
                  (4,default,"compra via site",150,0);
                  
select * from ordes;
-- proOrdStatus enum("Disponível","Sem estoque") default "Disponível",
INSERT into productOrder(idProOrProduct,idProOrOrder,proOrdQuantity,proOrdStatus)
				  values(1,1,2,null),
						(2,1,1,null),
                        (3,2,1,null);

INSERT into productStorage(storageLocation,quantity)
					values("Rio de Janeiro",1000),
						  ("Rio de Janeiro",500),
                          ("São Paulo",10),
                          ("São Paulo",100),
                          ("São Paulo",10),
                          ("Brasília",60);

SELECT * FROM storageLocation;
INSERT into storageLocation(idLProduct,idLStorage,location)
					value(1,2,"RJ"),
						 (2,6,"GO");

INSERT into supplier(socialName,cnpj,contact)
			  values("Almeida e filhos", 123456789101213,"21985474"),
					("Eletrônicos Silva",854519649141553,"21985484"),
                    ("Eletrônicos Valma",101213454554554,"21974474");
                    
INSERT into productSupplier(idPsSupplier,idPsProduct,quantity)
					 values(1,1,500),
						   (1,2,400),
                           (2,4,633),
                           (3,3,5),
                           (2,5,10);

INSERT into seller(socialName ,abstName ,cnpj ,cpf , Location ,contact)
			values("Tech eletronics",null,123456789456321,null,"Rio de Janeiro",219946287),
				  ("Botique Durgas",null,null,123456789,"Rio de Janeiro",219946287),
                  ("Kids World",null,445878265995669,null,"São Paulo",454878785);

select * FROM seller;

INSERT into productSeller(idpSeller,idPProduct,quantityProduct)
				   values(1,6,80),
						 (2,7,10);

-- recuperar todas as informações
select * from clients c, orders o WHERE c.idClient = o.idOrderClient;

-- recuperar algumas informações específicas
select fName,lName,idOrder, orderStatus from clients c, orders o WHERE c.idClient = o.idOrderClient;

-- Alias
select concat(fName,lName) AS Client ,idOrder AS Request, orderStatus AS Status from clients c, orders o WHERE c.idClient = o.idOrderClient;

INSERT INTO orders(idOrderClient, orderStatus,orderDescription,sendValue,paymentCash)
			values(2,default,"compra via aplicativo",null,1);
            
-- Para agrupar
SELECT count(*) FROM clients c, orders o 
				WHERE c.idClient = o.idOrderClient;
                
SELECT * FROM clients
		LEFT OUTER JOIN orders 
        ON idClient = idOrderClient;




SELECT * FROM productOrder;
SELECT * FROM orders;
-- recupera os pedidos com o produto associado
SELECT * FROM clients c INNER JOIN orders o ON c.idClient = o.idOrderClient
		INNER JOIN productOrder p
					ON p.idProOrProduct = o.idOrder
                    group by idClient;

-- Recupera quantos pedidos foram realizados pelos clientes
SELECT c.idClient, fName, count(*) FROM clients c INNER JOIN orders o ON c.idClient = o.idOrderClient
		INNER JOIN productOrder p
					ON p.idProOrProduct = o.idOrder
                    group by idClient;