BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "DATABASECHANGELOG" (
	"ID"	varchar(255) NOT NULL,
	"AUTHOR"	varchar(255) NOT NULL,
	"FILENAME"	varchar(255) NOT NULL,
	"DATEEXECUTED"	datetime NOT NULL,
	"ORDEREXECUTED"	integer NOT NULL,
	"EXECTYPE"	varchar(10) NOT NULL,
	"MD5SUM"	varchar(35) DEFAULT NULL,
	"DESCRIPTION"	varchar(255) DEFAULT NULL,
	"COMMENTS"	varchar(255) DEFAULT NULL,
	"TAG"	varchar(255) DEFAULT NULL,
	"LIQUIBASE"	varchar(20) DEFAULT NULL,
	"CONTEXTS"	varchar(255) DEFAULT NULL,
	"LABELS"	varchar(255) DEFAULT NULL,
	"DEPLOYMENT_ID"	varchar(10) DEFAULT NULL
);
CREATE TABLE IF NOT EXISTS "DATABASECHANGELOGLOCK" (
	"ID"	integer NOT NULL,
	"LOCKED"	integer NOT NULL,
	"LOCKGRANTED"	datetime DEFAULT NULL,
	"LOCKEDBY"	varchar(255) DEFAULT NULL,
	PRIMARY KEY("ID")
);
CREATE TABLE IF NOT EXISTS "compteur" (
	"type"	varchar(10) NOT NULL,
	"prefix"	varchar(10) NOT NULL,
	"suffix"	varchar(50) NOT NULL,
	PRIMARY KEY("type")
);
CREATE TABLE IF NOT EXISTS "payment_mode" (
	"id"	integer NOT NULL,
	"designation"	varchar(255) DEFAULT NULL,
	"purchase"	integer NOT NULL,
	"sale"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "privilege" (
	"id"	integer NOT NULL,
	"name"	varchar(255) DEFAULT NULL,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "privilege_seq" (
	"next_val"	integer DEFAULT NULL
);
CREATE TABLE IF NOT EXISTS "produit" (
	"type"	varchar(31) NOT NULL,
	"id"	integer NOT NULL,
	"archived"	integer DEFAULT 0,
	"archived_by"	varchar(255) DEFAULT NULL,
	"archived_on"	datetime(6) DEFAULT NULL,
	"created_by"	varchar(255) DEFAULT NULL,
	"created_on"	datetime(6) DEFAULT NULL,
	"updated_by"	varchar(255) DEFAULT NULL,
	"updated_on"	datetime(6) DEFAULT NULL,
	"barcode_image"	varchar(255) DEFAULT NULL,
	"is_deleted"	integer DEFAULT 0,
	"marge"	float NOT NULL,
	"marque"	varchar(255) DEFAULT NULL,
	"name"	varchar(255) DEFAULT NULL,
	"prix_achat"	decimal(38, 2) DEFAULT NULL,
	"prix_vente"	decimal(38, 2) DEFAULT NULL,
	"qte"	integer NOT NULL,
	"reference"	varchar(255) DEFAULT NULL,
	"add_inf"	float DEFAULT NULL,
	"add_sup"	float DEFAULT NULL,
	"axe"	float DEFAULT NULL,
	"base"	varchar(255) DEFAULT NULL,
	"coloration"	varchar(255) DEFAULT NULL,
	"cyl_inf"	float DEFAULT NULL,
	"cyl_sup"	float DEFAULT NULL,
	"description"	varchar(255) DEFAULT NULL,
	"dia"	float DEFAULT NULL,
	"indice"	float DEFAULT NULL,
	"matiere"	varchar(255) DEFAULT NULL,
	"photochromique"	varchar(255) DEFAULT NULL,
	"sph_inf"	float DEFAULT NULL,
	"sph_sup"	float DEFAULT NULL,
	"vision_type"	text DEFAULT NULL,
	"fournisseur_id"	integer DEFAULT NULL,
	"magasin_id"	integer DEFAULT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	CONSTRAINT "FK8ehkew7bg1x7dkjc7i1sm8yu7" FOREIGN KEY("fournisseur_id") REFERENCES "t_fournisseur"("id"),
	CONSTRAINT "FKothbgu2bn7oa29y8tfnodr33v" FOREIGN KEY("magasin_id") REFERENCES "t_magasin"("id")
);
CREATE TABLE IF NOT EXISTS "role" (
	"id"	integer NOT NULL,
	"name"	varchar(255) DEFAULT NULL,
	PRIMARY KEY("id")
);
CREATE TABLE IF NOT EXISTS "role_seq" (
	"next_val"	integer DEFAULT NULL
);
CREATE TABLE IF NOT EXISTS "roles_privileges" (
	"role_id"	integer NOT NULL,
	"privilege_id"	integer NOT NULL,
	CONSTRAINT "FK5yjwxw2gvfyu76j3rgqwo685u" FOREIGN KEY("privilege_id") REFERENCES "privilege"("id"),
	CONSTRAINT "FK9h2vewsqh8luhfq71xokh4who" FOREIGN KEY("role_id") REFERENCES "role"("id")
);
CREATE TABLE IF NOT EXISTS "supplement_verre" (
	"id"	integer NOT NULL,
	"archived"	integer DEFAULT 0,
	"archived_by"	varchar(255) DEFAULT NULL,
	"archived_on"	datetime(6) DEFAULT NULL,
	"created_by"	varchar(255) DEFAULT NULL,
	"created_on"	datetime(6) DEFAULT NULL,
	"updated_by"	varchar(255) DEFAULT NULL,
	"updated_on"	datetime(6) DEFAULT NULL,
	"code"	varchar(255) DEFAULT NULL,
	"description"	varchar(255) DEFAULT NULL,
	"prix_achat"	decimal(38, 2) DEFAULT NULL,
	"prix_vente"	decimal(38, 2) DEFAULT NULL,
	"type"	varchar(255) DEFAULT NULL,
	"magasin_id"	integer DEFAULT NULL,
	"verre_id"	integer DEFAULT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	CONSTRAINT "FK2bia8pa41so92nf3ximm6myfn" FOREIGN KEY("magasin_id") REFERENCES "t_magasin"("id"),
	CONSTRAINT "FKo5hrwyk1bmoo511uykaophxey" FOREIGN KEY("verre_id") REFERENCES "produit"("id")
);
CREATE TABLE IF NOT EXISTS "t_achat" (
	"id"	integer NOT NULL,
	"archived"	integer DEFAULT 0,
	"archived_by"	varchar(255) DEFAULT NULL,
	"archived_on"	datetime(6) DEFAULT NULL,
	"created_by"	varchar(255) DEFAULT NULL,
	"created_on"	datetime(6) DEFAULT NULL,
	"updated_by"	varchar(255) DEFAULT NULL,
	"updated_on"	datetime(6) DEFAULT NULL,
	"date_achat"	date DEFAULT NULL,
	"date_recption"	date DEFAULT NULL,
	"etat"	varchar(255) DEFAULT NULL,
	"facture_achat_id"	integer DEFAULT NULL,
	"fournisseur_id"	integer DEFAULT NULL,
	"is_deleted"	integer DEFAULT 0,
	"montant_rest"	decimal(38, 2) DEFAULT NULL,
	"reference"	varchar(255) DEFAULT NULL,
	"totalap"	decimal(38, 2) DEFAULT NULL,
	"total_achat"	decimal(38, 2) DEFAULT NULL,
	"totalttc"	decimal(38, 2) DEFAULT NULL,
	"tva"	float NOT NULL,
	"magasin_id"	integer DEFAULT NULL,
	"is_delivered"	integer DEFAULT 1,
	PRIMARY KEY("id" AUTOINCREMENT),
	CONSTRAINT "FKn91470vapn3x04ym894ew5l0d" FOREIGN KEY("facture_achat_id") REFERENCES "t_facture_achat"("id"),
	CONSTRAINT "FKh2mneutf839g6alax1moq3v07" FOREIGN KEY("fournisseur_id") REFERENCES "t_fournisseur"("id"),
	CONSTRAINT "FKeal7bbiru9r8c0fsm6c2nv85y" FOREIGN KEY("magasin_id") REFERENCES "t_magasin"("id")
);
CREATE TABLE IF NOT EXISTS "t_avoir_achat" (
	"id"	integer NOT NULL,
	"archived"	integer DEFAULT 0,
	"archived_by"	varchar(255) DEFAULT NULL,
	"archived_on"	datetime(6) DEFAULT NULL,
	"created_by"	varchar(255) DEFAULT NULL,
	"created_on"	datetime(6) DEFAULT NULL,
	"updated_by"	varchar(255) DEFAULT NULL,
	"updated_on"	datetime(6) DEFAULT NULL,
	"date"	date DEFAULT NULL,
	"is_confirmed"	integer DEFAULT 1,
	"is_deleted"	integer DEFAULT 0,
	"motif"	varchar(255) DEFAULT NULL,
	"num_avoir"	varchar(255) DEFAULT NULL,
	"fournisseur_id"	integer DEFAULT NULL,
	"magasin_id"	integer DEFAULT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	CONSTRAINT "FK114i23vynv5ut2ltlndr9nd2l" FOREIGN KEY("fournisseur_id") REFERENCES "t_fournisseur"("id"),
	CONSTRAINT "FKi1ij5jfn112g9ovl97uag624s" FOREIGN KEY("magasin_id") REFERENCES "t_magasin"("id")
);
CREATE TABLE IF NOT EXISTS "t_avoir_vente" (
	"id"	integer NOT NULL,
	"archived"	integer DEFAULT 0,
	"archived_by"	varchar(255) DEFAULT NULL,
	"archived_on"	datetime(6) DEFAULT NULL,
	"created_by"	varchar(255) DEFAULT NULL,
	"created_on"	datetime(6) DEFAULT NULL,
	"updated_by"	varchar(255) DEFAULT NULL,
	"updated_on"	datetime(6) DEFAULT NULL,
	"date"	date DEFAULT NULL,
	"is_confirmed"	integer DEFAULT 1,
	"is_deleted"	integer DEFAULT 0,
	"montant"	decimal(38, 2) DEFAULT NULL,
	"motif"	varchar(255) DEFAULT NULL,
	"num_avoir"	varchar(255) DEFAULT NULL,
	"client_id"	integer DEFAULT NULL,
	"magasin_id"	integer DEFAULT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	CONSTRAINT "FK6sfou6kshyyd8kub44vq6r72c" FOREIGN KEY("client_id") REFERENCES "t_client"("id"),
	CONSTRAINT "FKqey2n1l99cfv07ldd45h67d5d" FOREIGN KEY("magasin_id") REFERENCES "t_magasin"("id")
);
CREATE TABLE IF NOT EXISTS "t_cheque" (
	"id"	integer NOT NULL,
	"archived"	integer DEFAULT 0,
	"archived_by"	varchar(255) DEFAULT NULL,
	"archived_on"	datetime(6) DEFAULT NULL,
	"created_by"	varchar(255) DEFAULT NULL,
	"created_on"	datetime(6) DEFAULT NULL,
	"updated_by"	varchar(255) DEFAULT NULL,
	"updated_on"	datetime(6) DEFAULT NULL,
	"date_cheque"	date DEFAULT NULL,
	"date_remise"	date DEFAULT NULL,
	"montant"	decimal(38, 2) DEFAULT NULL,
	"nom_cheque"	varchar(255) DEFAULT NULL,
	"num_cheque"	varchar(255) DEFAULT NULL,
	"status"	integer DEFAULT NULL,
	"type"	text DEFAULT NULL,
	"magasin_id"	integer DEFAULT NULL,
	"reglement_id"	integer DEFAULT NULL,
	"reglement_achat_id"	integer DEFAULT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	UNIQUE("reglement_achat_id"),
	UNIQUE("reglement_id"),
	CONSTRAINT "FKh40igp3o4m6dywc7y5j0kgrf9" FOREIGN KEY("magasin_id") REFERENCES "t_magasin"("id"),
	CONSTRAINT "FKfkewi42y8x6myb0dq37fhsy35" FOREIGN KEY("reglement_achat_id") REFERENCES "t_reglement_achat"("id"),
	CONSTRAINT "FKe8ndxampleqt8jd24d64l9kk1" FOREIGN KEY("reglement_id") REFERENCES "t_reglement"("id")
);
CREATE TABLE IF NOT EXISTS "t_client" (
	"id"	integer NOT NULL,
	"archived"	integer DEFAULT 0,
	"archived_by"	varchar(255) DEFAULT NULL,
	"archived_on"	datetime(6) DEFAULT NULL,
	"created_by"	varchar(255) DEFAULT NULL,
	"created_on"	datetime(6) DEFAULT NULL,
	"updated_by"	varchar(255) DEFAULT NULL,
	"updated_on"	datetime(6) DEFAULT NULL,
	"adresse"	varchar(255) DEFAULT NULL,
	"age"	integer NOT NULL,
	"chiffre_affaire"	decimal(38, 2) DEFAULT NULL,
	"cin"	varchar(255) DEFAULT NULL,
	"date_naissance"	date DEFAULT NULL,
	"email"	varchar(255) DEFAULT NULL,
	"is_deleted"	integer DEFAULT 0,
	"matricule_fiscal"	varchar(255) DEFAULT NULL,
	"nom_prenom"	varchar(255) DEFAULT NULL,
	"num_assure_social"	varchar(255) DEFAULT NULL,
	"num_tel1"	varchar(255) DEFAULT NULL,
	"num_tel2"	varchar(255) DEFAULT NULL,
	"observations"	varchar(255) DEFAULT NULL,
	"pays"	varchar(255) DEFAULT NULL,
	"reference"	varchar(255) DEFAULT NULL,
	"sexe"	varchar(255) DEFAULT NULL,
	"solde"	decimal(38, 2) DEFAULT NULL,
	"ville"	varchar(255) DEFAULT NULL,
	"magasin_id"	integer DEFAULT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	CONSTRAINT "FKdtkf806a6wh620x576kwispbx" FOREIGN KEY("magasin_id") REFERENCES "t_magasin"("id")
);
CREATE TABLE IF NOT EXISTS "t_client_association" (
	"client_id"	integer NOT NULL,
	"associated_id"	integer NOT NULL,
	PRIMARY KEY("client_id","associated_id"),
	CONSTRAINT "FK6aosa3l3276e5lgpdtp4uv1go" FOREIGN KEY("associated_id") REFERENCES "t_client"("id"),
	CONSTRAINT "FKi4fja3mf0kdcum2qrcfdw3djn" FOREIGN KEY("client_id") REFERENCES "t_client"("id")
);
CREATE TABLE IF NOT EXISTS "t_facture" (
	"id"	integer NOT NULL,
	"archived"	integer DEFAULT 0,
	"archived_by"	varchar(255) DEFAULT NULL,
	"archived_on"	datetime(6) DEFAULT NULL,
	"created_by"	varchar(255) DEFAULT NULL,
	"created_on"	datetime(6) DEFAULT NULL,
	"updated_by"	varchar(255) DEFAULT NULL,
	"updated_on"	datetime(6) DEFAULT NULL,
	"date_facture"	date DEFAULT NULL,
	"is_deleted"	integer NOT NULL,
	"montanttva"	decimal(38, 2) DEFAULT NULL,
	"num"	varchar(255) DEFAULT NULL,
	"timbre"	integer NOT NULL,
	"totalfacture"	decimal(38, 2) DEFAULT NULL,
	"totalht"	decimal(38, 2) DEFAULT NULL,
	"totalttc"	decimal(38, 2) DEFAULT NULL,
	"client_id"	integer DEFAULT NULL,
	"magasin_id"	integer DEFAULT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	CONSTRAINT "FK4dpbi5bj91dswfgto7uqsmtq4" FOREIGN KEY("client_id") REFERENCES "t_client"("id"),
	CONSTRAINT "FK2qjia7vncaxbv10nf1vemnvha" FOREIGN KEY("magasin_id") REFERENCES "t_magasin"("id")
);
CREATE TABLE IF NOT EXISTS "t_facture_achat" (
	"id"	integer NOT NULL,
	"archived"	integer DEFAULT 0,
	"archived_by"	varchar(255) DEFAULT NULL,
	"archived_on"	datetime(6) DEFAULT NULL,
	"created_by"	varchar(255) DEFAULT NULL,
	"created_on"	datetime(6) DEFAULT NULL,
	"updated_by"	varchar(255) DEFAULT NULL,
	"updated_on"	datetime(6) DEFAULT NULL,
	"date_facture"	date DEFAULT NULL,
	"facture_status"	integer DEFAULT NULL,
	"fournisseur_id"	integer DEFAULT NULL,
	"is_deleted"	integer NOT NULL,
	"montanttva"	decimal(38, 2) DEFAULT NULL,
	"num_facture"	varchar(255) DEFAULT NULL,
	"timbre"	decimal(38, 2) DEFAULT NULL,
	"totalfacture"	decimal(38, 2) DEFAULT NULL,
	"totalht"	decimal(38, 2) DEFAULT NULL,
	"tva"	decimal(38, 2) DEFAULT NULL,
	"magasin_id"	integer DEFAULT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	CONSTRAINT "FK3l57hy4dalp0qi99luec1w4k4" FOREIGN KEY("fournisseur_id") REFERENCES "t_fournisseur"("id"),
	CONSTRAINT "FK1csmg5ani49pd2w2vahclygt2" FOREIGN KEY("magasin_id") REFERENCES "t_magasin"("id")
);
CREATE TABLE IF NOT EXISTS "t_fournisseur" (
	"id"	integer NOT NULL,
	"archived"	integer DEFAULT 0,
	"archived_by"	varchar(255) DEFAULT NULL,
	"archived_on"	datetime(6) DEFAULT NULL,
	"created_by"	varchar(255) DEFAULT NULL,
	"created_on"	datetime(6) DEFAULT NULL,
	"updated_by"	varchar(255) DEFAULT NULL,
	"updated_on"	datetime(6) DEFAULT NULL,
	"adresse"	varchar(255) DEFAULT NULL,
	"email"	varchar(255) DEFAULT NULL,
	"is_deleted"	integer DEFAULT 0,
	"matricule_fiscale"	varchar(255) DEFAULT NULL,
	"name"	varchar(255) DEFAULT NULL,
	"num_tel"	varchar(255) DEFAULT NULL,
	"magasin_id"	integer DEFAULT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	CONSTRAINT "FK68bqy7lvavx4wimun3poilwo5" FOREIGN KEY("magasin_id") REFERENCES "t_magasin"("id")
);
CREATE TABLE IF NOT EXISTS "t_inventaire" (
	"id"	integer NOT NULL,
	"archived"	integer DEFAULT 0,
	"archived_by"	varchar(255) DEFAULT NULL,
	"archived_on"	datetime(6) DEFAULT NULL,
	"created_by"	varchar(255) DEFAULT NULL,
	"created_on"	datetime(6) DEFAULT NULL,
	"updated_by"	varchar(255) DEFAULT NULL,
	"updated_on"	datetime(6) DEFAULT NULL,
	"actif"	integer NOT NULL,
	"date"	date DEFAULT NULL,
	"end_date"	date DEFAULT NULL,
	"is_confirmed_final"	integer DEFAULT 0,
	"is_confirmed_partiel"	integer DEFAULT 0,
	"is_deleted"	integer DEFAULT 0,
	"type"	integer DEFAULT NULL,
	"magasin_id"	integer DEFAULT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	CONSTRAINT "FK6n8acjt84yjskhtlxf81gybc2" FOREIGN KEY("magasin_id") REFERENCES "t_magasin"("id")
);
CREATE TABLE IF NOT EXISTS "t_journal" (
	"id"	integer NOT NULL,
	"archived"	integer DEFAULT 0,
	"archived_by"	varchar(255) DEFAULT NULL,
	"archived_on"	datetime(6) DEFAULT NULL,
	"created_by"	varchar(255) DEFAULT NULL,
	"created_on"	datetime(6) DEFAULT NULL,
	"updated_by"	varchar(255) DEFAULT NULL,
	"updated_on"	datetime(6) DEFAULT NULL,
	"date_description"	date DEFAULT NULL,
	"description"	varchar(255) DEFAULT NULL,
	"is_deleted"	integer DEFAULT 0,
	"facture_id"	integer DEFAULT NULL,
	"magasin_id"	integer DEFAULT NULL,
	"vente_id"	integer DEFAULT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	CONSTRAINT "FKrn0xvvh422kqriwo2g200mtma" FOREIGN KEY("facture_id") REFERENCES "t_facture"("id"),
	CONSTRAINT "FKdrfv7lxxnkvji5y7ytpv0yyjl" FOREIGN KEY("magasin_id") REFERENCES "t_magasin"("id"),
	CONSTRAINT "FKhsscvwhqnrwudi8njya4etj7x" FOREIGN KEY("vente_id") REFERENCES "t_vente"("id")
);
CREATE TABLE IF NOT EXISTS "t_l_inventaire" (
	"id"	integer NOT NULL,
	"archived"	integer DEFAULT 0,
	"archived_by"	varchar(255) DEFAULT NULL,
	"archived_on"	datetime(6) DEFAULT NULL,
	"created_by"	varchar(255) DEFAULT NULL,
	"created_on"	datetime(6) DEFAULT NULL,
	"updated_by"	varchar(255) DEFAULT NULL,
	"updated_on"	datetime(6) DEFAULT NULL,
	"calculated_qte"	integer NOT NULL,
	"changed"	integer NOT NULL,
	"is_deleted"	integer DEFAULT 0,
	"real_qte"	integer NOT NULL,
	"remarque"	varchar(255) DEFAULT NULL,
	"inventaire_id"	integer DEFAULT NULL,
	"magasin_id"	integer DEFAULT NULL,
	"produit_id"	integer DEFAULT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	CONSTRAINT "FKmvl0454y4io16ostby1mc62co" FOREIGN KEY("inventaire_id") REFERENCES "t_inventaire"("id"),
	CONSTRAINT "FK8sl83c0qk8c1pnogg9h57dw9l" FOREIGN KEY("magasin_id") REFERENCES "t_magasin"("id"),
	CONSTRAINT "FKl35hd708e9vfpluhda6n7i55x" FOREIGN KEY("produit_id") REFERENCES "produit"("id")
);
CREATE TABLE IF NOT EXISTS "t_lachat" (
	"id"	integer NOT NULL,
	"archived"	integer DEFAULT 0,
	"archived_by"	varchar(255) DEFAULT NULL,
	"archived_on"	datetime(6) DEFAULT NULL,
	"created_by"	varchar(255) DEFAULT NULL,
	"created_on"	datetime(6) DEFAULT NULL,
	"updated_by"	varchar(255) DEFAULT NULL,
	"updated_on"	datetime(6) DEFAULT NULL,
	"is_deleted"	integer DEFAULT 0,
	"montant_ht"	double NOT NULL,
	"pu"	decimal(38, 2) DEFAULT NULL,
	"qte"	integer NOT NULL,
	"reference_produit"	varchar(255) DEFAULT NULL,
	"remise"	float NOT NULL,
	"remise_cash"	decimal(38, 2) DEFAULT NULL,
	"type_produit"	text DEFAULT NULL,
	"achat_id"	integer DEFAULT NULL,
	"magasin_id"	integer DEFAULT NULL,
	"id_produit"	integer DEFAULT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	CONSTRAINT "FK7fddfcfp5wf5nl3m1wjxhsket" FOREIGN KEY("achat_id") REFERENCES "t_achat"("id"),
	CONSTRAINT "FKp63qt0dvkjr5i4295loocktx6" FOREIGN KEY("id_produit") REFERENCES "produit"("id"),
	CONSTRAINT "FKrrjslsw4f82qc2symmiamcatg" FOREIGN KEY("magasin_id") REFERENCES "t_magasin"("id")
);
CREATE TABLE IF NOT EXISTS "t_ligne_avoir_achat" (
	"id"	integer NOT NULL,
	"archived"	integer DEFAULT 0,
	"archived_by"	varchar(255) DEFAULT NULL,
	"archived_on"	datetime(6) DEFAULT NULL,
	"created_by"	varchar(255) DEFAULT NULL,
	"created_on"	datetime(6) DEFAULT NULL,
	"updated_by"	varchar(255) DEFAULT NULL,
	"updated_on"	datetime(6) DEFAULT NULL,
	"is_deleted"	integer DEFAULT 0,
	"qte"	integer NOT NULL,
	"avoir_achat_id"	integer DEFAULT NULL,
	"magasin_id"	integer DEFAULT NULL,
	"id_produit"	integer DEFAULT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	CONSTRAINT "FKcj1ykxg28rbl4jhcnii4ky7cp" FOREIGN KEY("avoir_achat_id") REFERENCES "t_avoir_achat"("id"),
	CONSTRAINT "FKf0xnnvrc4sg4xv613d8xbou6q" FOREIGN KEY("id_produit") REFERENCES "produit"("id"),
	CONSTRAINT "FKh4i9r77b3k4qa17b6iia9fawt" FOREIGN KEY("magasin_id") REFERENCES "t_magasin"("id")
);
CREATE TABLE IF NOT EXISTS "t_ligne_avoir_vente" (
	"id"	integer NOT NULL,
	"archived"	integer DEFAULT 0,
	"archived_by"	varchar(255) DEFAULT NULL,
	"archived_on"	datetime(6) DEFAULT NULL,
	"created_by"	varchar(255) DEFAULT NULL,
	"created_on"	datetime(6) DEFAULT NULL,
	"updated_by"	varchar(255) DEFAULT NULL,
	"updated_on"	datetime(6) DEFAULT NULL,
	"is_deleted"	integer DEFAULT 0,
	"qte"	integer NOT NULL,
	"avoir_vente_id"	integer DEFAULT NULL,
	"magasin_id"	integer DEFAULT NULL,
	"id_produit"	integer DEFAULT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	CONSTRAINT "FKsdj6vw0omkqd9n47voa7weot6" FOREIGN KEY("avoir_vente_id") REFERENCES "t_avoir_vente"("id"),
	CONSTRAINT "FKkrqvwh5b5omcqtrbturhxjyjg" FOREIGN KEY("id_produit") REFERENCES "produit"("id"),
	CONSTRAINT "FK1dxjgqbfmwy0ps2yi6sivi2oj" FOREIGN KEY("magasin_id") REFERENCES "t_magasin"("id")
);
CREATE TABLE IF NOT EXISTS "t_ligne_transfert" (
	"id"	integer NOT NULL,
	"archived"	integer DEFAULT 0,
	"archived_by"	varchar(255) DEFAULT NULL,
	"archived_on"	datetime(6) DEFAULT NULL,
	"created_by"	varchar(255) DEFAULT NULL,
	"created_on"	datetime(6) DEFAULT NULL,
	"updated_by"	varchar(255) DEFAULT NULL,
	"updated_on"	datetime(6) DEFAULT NULL,
	"is_deleted"	integer DEFAULT 0,
	"qte"	integer NOT NULL,
	"produit_id"	integer DEFAULT NULL,
	"transfert_id"	integer DEFAULT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	CONSTRAINT "FKf3xpjonemdwj9hxm2yejt03ad" FOREIGN KEY("produit_id") REFERENCES "produit"("id"),
	CONSTRAINT "FKmvry7vi7ngnmreyreteo39vor" FOREIGN KEY("transfert_id") REFERENCES "t_transfert"("id"),
	CONSTRAINT "FKnsoy12upvl16v57ujw4pnvlpi" FOREIGN KEY("transfert_id") REFERENCES "t_reglement"("id")
);
CREATE TABLE IF NOT EXISTS "t_lvente" (
	"id"	integer NOT NULL,
	"archived"	integer DEFAULT 0,
	"archived_by"	varchar(255) DEFAULT NULL,
	"archived_on"	datetime(6) DEFAULT NULL,
	"created_by"	varchar(255) DEFAULT NULL,
	"created_on"	datetime(6) DEFAULT NULL,
	"updated_by"	varchar(255) DEFAULT NULL,
	"updated_on"	datetime(6) DEFAULT NULL,
	"is_deleted"	integer DEFAULT 0,
	"montantttc"	decimal(38, 2) DEFAULT NULL,
	"prix_unitaire"	decimal(38, 2) DEFAULT NULL,
	"qte"	integer NOT NULL,
	"remise"	decimal(38, 2) DEFAULT NULL,
	"tva"	integer NOT NULL,
	"type_produit"	text DEFAULT NULL,
	"vision"	varchar(255) DEFAULT NULL,
	"magasin_id"	integer DEFAULT NULL,
	"id_produit"	integer DEFAULT NULL,
	"vente_id"	integer DEFAULT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	CONSTRAINT "FKkpcd8noddxr5p1kxlhibco2h4" FOREIGN KEY("id_produit") REFERENCES "produit"("id"),
	CONSTRAINT "FKdj5msyg6qbh5mm5qlo2u7bjat" FOREIGN KEY("magasin_id") REFERENCES "t_magasin"("id"),
	CONSTRAINT "FKt711a5u7rbjruntr7fh3bh4d5" FOREIGN KEY("vente_id") REFERENCES "t_vente"("id")
);
CREATE TABLE IF NOT EXISTS "t_magasin" (
	"id"	integer NOT NULL,
	"archived"	integer DEFAULT 0,
	"archived_by"	varchar(255) DEFAULT NULL,
	"archived_on"	datetime(6) DEFAULT NULL,
	"created_by"	varchar(255) DEFAULT NULL,
	"created_on"	datetime(6) DEFAULT NULL,
	"updated_by"	varchar(255) DEFAULT NULL,
	"updated_on"	datetime(6) DEFAULT NULL,
	"address"	varchar(255) DEFAULT NULL,
	"affilation"	varchar(255) DEFAULT NULL,
	"fax"	varchar(255) DEFAULT NULL,
	"mf"	varchar(255) DEFAULT NULL,
	"name"	varchar(255) DEFAULT NULL,
	"rc"	varchar(255) DEFAULT NULL,
	"rib"	varchar(255) DEFAULT NULL,
	"tel"	varchar(255) DEFAULT NULL,
	"magasin_principal_id"	integer DEFAULT NULL,
	"tenant_id"	integer DEFAULT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	CONSTRAINT "FKbbyqe0bvnxatggak72gx5oj8b" FOREIGN KEY("magasin_principal_id") REFERENCES "t_magasin"("id"),
	CONSTRAINT "FK39t6p7nsvlsgj5c0bh7x879sq" FOREIGN KEY("tenant_id") REFERENCES "t_tenant"("id")
);
CREATE TABLE IF NOT EXISTS "t_mesure" (
	"id"	integer NOT NULL,
	"archived"	integer DEFAULT 0,
	"archived_by"	varchar(255) DEFAULT NULL,
	"archived_on"	datetime(6) DEFAULT NULL,
	"created_by"	varchar(255) DEFAULT NULL,
	"created_on"	datetime(6) DEFAULT NULL,
	"updated_by"	varchar(255) DEFAULT NULL,
	"updated_on"	datetime(6) DEFAULT NULL,
	"d"	integer DEFAULT NULL,
	"hd"	integer DEFAULT NULL,
	"hg"	integer DEFAULT NULL,
	"is_deleted"	integer DEFAULT 0,
	"pd"	integer DEFAULT NULL,
	"pg"	integer DEFAULT NULL,
	"magasin_id"	integer DEFAULT NULL,
	"vente_id"	integer DEFAULT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	UNIQUE("vente_id"),
	CONSTRAINT "FKq5rvnl7cbif065wewx2pu9b9q" FOREIGN KEY("magasin_id") REFERENCES "t_magasin"("id"),
	CONSTRAINT "FKki0qhh97uyegg2quhtkcotkw2" FOREIGN KEY("vente_id") REFERENCES "t_vente"("id")
);
CREATE TABLE IF NOT EXISTS "t_ophtalmo" (
	"id"	integer NOT NULL,
	"archived"	integer DEFAULT 0,
	"archived_by"	varchar(255) DEFAULT NULL,
	"archived_on"	datetime(6) DEFAULT NULL,
	"created_by"	varchar(255) DEFAULT NULL,
	"created_on"	datetime(6) DEFAULT NULL,
	"updated_by"	varchar(255) DEFAULT NULL,
	"updated_on"	datetime(6) DEFAULT NULL,
	"adress"	varchar(255) DEFAULT NULL,
	"is_deleted"	integer DEFAULT 0,
	"nom_prenom"	varchar(255) DEFAULT NULL,
	"num_tel"	varchar(255) DEFAULT NULL,
	"magasin_id"	integer DEFAULT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	CONSTRAINT "FK7sjjfb7n9qw8mht7j2isbx81j" FOREIGN KEY("magasin_id") REFERENCES "t_magasin"("id")
);
CREATE TABLE IF NOT EXISTS "t_param" (
	"id"	integer NOT NULL,
	"archived"	integer DEFAULT 0,
	"archived_by"	varchar(255) DEFAULT NULL,
	"archived_on"	datetime(6) DEFAULT NULL,
	"created_by"	varchar(255) DEFAULT NULL,
	"created_on"	datetime(6) DEFAULT NULL,
	"updated_by"	varchar(255) DEFAULT NULL,
	"updated_on"	datetime(6) DEFAULT NULL,
	"is_deleted"	integer DEFAULT 0,
	"param_key"	varchar(255) DEFAULT NULL,
	"param_value"	varchar(255) DEFAULT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "t_puissance" (
	"id"	integer NOT NULL,
	"archived"	integer DEFAULT 0,
	"archived_by"	varchar(255) DEFAULT NULL,
	"archived_on"	datetime(6) DEFAULT NULL,
	"created_by"	varchar(255) DEFAULT NULL,
	"created_on"	datetime(6) DEFAULT NULL,
	"updated_by"	varchar(255) DEFAULT NULL,
	"updated_on"	datetime(6) DEFAULT NULL,
	"addd"	varchar(255) DEFAULT NULL,
	"addg"	varchar(255) DEFAULT NULL,
	"axedl"	varchar(255) DEFAULT NULL,
	"axedp"	varchar(255) DEFAULT NULL,
	"axegl"	varchar(255) DEFAULT NULL,
	"axegp"	varchar(255) DEFAULT NULL,
	"basedl"	varchar(255) DEFAULT NULL,
	"basedp"	varchar(255) DEFAULT NULL,
	"basegl"	varchar(255) DEFAULT NULL,
	"basegp"	varchar(255) DEFAULT NULL,
	"cyldl"	varchar(255) DEFAULT NULL,
	"cyldp"	varchar(255) DEFAULT NULL,
	"cylgl"	varchar(255) DEFAULT NULL,
	"cylgp"	varchar(255) DEFAULT NULL,
	"date"	date DEFAULT NULL,
	"is_deleted"	integer DEFAULT 0,
	"num"	varchar(255) DEFAULT NULL,
	"prismedl"	varchar(255) DEFAULT NULL,
	"prismedp"	varchar(255) DEFAULT NULL,
	"prismegl"	varchar(255) DEFAULT NULL,
	"prismegp"	varchar(255) DEFAULT NULL,
	"sphdl"	varchar(255) DEFAULT NULL,
	"sphdp"	varchar(255) DEFAULT NULL,
	"sphgl"	varchar(255) DEFAULT NULL,
	"sphgp"	varchar(255) DEFAULT NULL,
	"magasin_id"	integer DEFAULT NULL,
	"vente_id"	integer DEFAULT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	UNIQUE("vente_id"),
	CONSTRAINT "FK6o81x287krj08o5cymmxw9icg" FOREIGN KEY("magasin_id") REFERENCES "t_magasin"("id"),
	CONSTRAINT "FK2m60h8bmh4i0xsex4f87ecotf" FOREIGN KEY("vente_id") REFERENCES "t_vente"("id")
);
CREATE TABLE IF NOT EXISTS "t_reglement" (
	"id"	integer NOT NULL,
	"archived"	integer DEFAULT 0,
	"archived_by"	varchar(255) DEFAULT NULL,
	"archived_on"	datetime(6) DEFAULT NULL,
	"created_by"	varchar(255) DEFAULT NULL,
	"created_on"	datetime(6) DEFAULT NULL,
	"updated_by"	varchar(255) DEFAULT NULL,
	"updated_on"	datetime(6) DEFAULT NULL,
	"date_reglement"	date DEFAULT NULL,
	"designation"	varchar(255) DEFAULT NULL,
	"is_deleted"	integer DEFAULT 0,
	"montant_paye"	decimal(38, 2) DEFAULT NULL,
	"type"	integer DEFAULT NULL,
	"magasin_id"	integer DEFAULT NULL,
	"payment_mode_id"	integer DEFAULT NULL,
	"vente_id"	integer DEFAULT NULL,
	"num"	varchar(255) DEFAULT NULL,
	"destination_id"	integer DEFAULT NULL,
	"source_id"	integer DEFAULT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	CONSTRAINT "FK5g13ya2266no2nxvvv0xxc6i7" FOREIGN KEY("destination_id") REFERENCES "t_magasin"("id"),
	CONSTRAINT "FK27ush4p2oeqvnjpp4whk360yj" FOREIGN KEY("magasin_id") REFERENCES "t_magasin"("id"),
	CONSTRAINT "FKeullgak29mgjae3cgxs1en6gi" FOREIGN KEY("payment_mode_id") REFERENCES "payment_mode"("id"),
	CONSTRAINT "FKtc6u2kot4dvc5u983notmh539" FOREIGN KEY("source_id") REFERENCES "t_magasin"("id"),
	CONSTRAINT "FKd0wrqvtav1ogvqo34rl1a9afq" FOREIGN KEY("vente_id") REFERENCES "t_vente"("id")
);
CREATE TABLE IF NOT EXISTS "t_reglement_achat" (
	"id"	integer NOT NULL,
	"archived"	integer DEFAULT 0,
	"archived_by"	varchar(255) DEFAULT NULL,
	"archived_on"	datetime(6) DEFAULT NULL,
	"created_by"	varchar(255) DEFAULT NULL,
	"created_on"	datetime(6) DEFAULT NULL,
	"updated_by"	varchar(255) DEFAULT NULL,
	"updated_on"	datetime(6) DEFAULT NULL,
	"date_reglement"	date DEFAULT NULL,
	"is_deleted"	integer DEFAULT 0,
	"montant_paye"	decimal(38, 2) DEFAULT NULL,
	"achat_id"	integer DEFAULT NULL,
	"facture_achat_id"	integer DEFAULT NULL,
	"magasin_id"	integer DEFAULT NULL,
	"payment_mode_id"	integer DEFAULT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	CONSTRAINT "FKipkq3fyj14ikyvdb9wo5c6hox" FOREIGN KEY("achat_id") REFERENCES "t_achat"("id"),
	CONSTRAINT "FKrrvhohji3dqyyjkrv8aop0jct" FOREIGN KEY("facture_achat_id") REFERENCES "t_facture_achat"("id"),
	CONSTRAINT "FKr5yldlob90agdtv4rxpv8efaj" FOREIGN KEY("magasin_id") REFERENCES "t_magasin"("id"),
	CONSTRAINT "FK97qj4aflth758haynuu8gu4e2" FOREIGN KEY("payment_mode_id") REFERENCES "payment_mode"("id")
);
CREATE TABLE IF NOT EXISTS "t_tenant" (
	"id"	integer NOT NULL,
	"archived"	integer DEFAULT 0,
	"archived_by"	varchar(255) DEFAULT NULL,
	"archived_on"	datetime(6) DEFAULT NULL,
	"created_by"	varchar(255) DEFAULT NULL,
	"created_on"	datetime(6) DEFAULT NULL,
	"updated_by"	varchar(255) DEFAULT NULL,
	"updated_on"	datetime(6) DEFAULT NULL,
	"is_disabled"	integer DEFAULT 0,
	"name"	varchar(255) DEFAULT NULL,
	"picture"	mediumtext DEFAULT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "t_transfert" (
	"id"	integer NOT NULL,
	"archived"	integer DEFAULT 0,
	"archived_by"	varchar(255) DEFAULT NULL,
	"archived_on"	datetime(6) DEFAULT NULL,
	"created_by"	varchar(255) DEFAULT NULL,
	"created_on"	datetime(6) DEFAULT NULL,
	"updated_by"	varchar(255) DEFAULT NULL,
	"updated_on"	datetime(6) DEFAULT NULL,
	"date_transfert"	date DEFAULT NULL,
	"is_deleted"	integer NOT NULL,
	"is_delivered"	integer NOT NULL,
	"is_received"	integer NOT NULL,
	"num"	varchar(255) DEFAULT NULL,
	"destination_id"	integer DEFAULT NULL,
	"source_id"	integer DEFAULT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	CONSTRAINT "FKevk1ru95dn77hgsm3ernv8jv" FOREIGN KEY("destination_id") REFERENCES "t_magasin"("id"),
	CONSTRAINT "FKq7iga4l1ddegutxxviqhee3xu" FOREIGN KEY("source_id") REFERENCES "t_magasin"("id")
);
CREATE TABLE IF NOT EXISTS "t_vente" (
	"id"	integer NOT NULL,
	"archived"	integer DEFAULT 0,
	"archived_by"	varchar(255) DEFAULT NULL,
	"archived_on"	datetime(6) DEFAULT NULL,
	"created_by"	varchar(255) DEFAULT NULL,
	"created_on"	datetime(6) DEFAULT NULL,
	"updated_by"	varchar(255) DEFAULT NULL,
	"updated_on"	datetime(6) DEFAULT NULL,
	"date_vente"	date DEFAULT NULL,
	"facture_id"	integer DEFAULT NULL,
	"is_deleted"	integer DEFAULT 0,
	"montant_remise"	decimal(38, 2) DEFAULT NULL,
	"montant_rest"	decimal(38, 2) DEFAULT NULL,
	"num"	varchar(255) DEFAULT NULL,
	"num_fiche"	varchar(255) DEFAULT NULL,
	"remise"	decimal(38, 2) DEFAULT NULL,
	"total_vente"	decimal(38, 2) DEFAULT NULL,
	"totalttc"	decimal(38, 2) DEFAULT NULL,
	"client_id"	integer DEFAULT NULL,
	"magasin_id"	integer DEFAULT NULL,
	"ophtalmo_id"	integer DEFAULT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	CONSTRAINT "FKf91cfu8hcag4ynrww5upyy5ij" FOREIGN KEY("client_id") REFERENCES "t_client"("id"),
	CONSTRAINT "FKfl4814up6649h29ey6nhevt54" FOREIGN KEY("facture_id") REFERENCES "t_facture"("id"),
	CONSTRAINT "FKe8dxa3avjw7e8el6frgcbqctj" FOREIGN KEY("magasin_id") REFERENCES "t_magasin"("id"),
	CONSTRAINT "FKhpdf8fke0nql57wko3es0bw7i" FOREIGN KEY("ophtalmo_id") REFERENCES "t_ophtalmo"("id")
);
CREATE TABLE IF NOT EXISTS "t_visitclient" (
	"id"	integer NOT NULL,
	"archived"	integer DEFAULT 0,
	"archived_by"	varchar(255) DEFAULT NULL,
	"archived_on"	datetime(6) DEFAULT NULL,
	"created_by"	varchar(255) DEFAULT NULL,
	"created_on"	datetime(6) DEFAULT NULL,
	"updated_by"	varchar(255) DEFAULT NULL,
	"updated_on"	datetime(6) DEFAULT NULL,
	"date"	datetime(6) DEFAULT NULL,
	"is_deleted"	integer DEFAULT 0,
	"montantrecu"	decimal(38, 2) DEFAULT NULL,
	"client_id"	integer DEFAULT NULL,
	"magasin_id"	integer DEFAULT NULL,
	"vente_id"	integer DEFAULT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	CONSTRAINT "FKjbfp8ik1ti8dmeujvpm25058s" FOREIGN KEY("client_id") REFERENCES "t_client"("id"),
	CONSTRAINT "FKo3tglh0i5tniqv3ym0fj98808" FOREIGN KEY("magasin_id") REFERENCES "t_magasin"("id"),
	CONSTRAINT "FK38ohekax9gmc0wkp84q3ymerj" FOREIGN KEY("vente_id") REFERENCES "t_vente"("id")
);
CREATE TABLE IF NOT EXISTS "user" (
	"id"	integer NOT NULL,
	"archived"	integer DEFAULT 0,
	"archived_by"	varchar(255) DEFAULT NULL,
	"archived_on"	datetime(6) DEFAULT NULL,
	"created_by"	varchar(255) DEFAULT NULL,
	"created_on"	datetime(6) DEFAULT NULL,
	"updated_by"	varchar(255) DEFAULT NULL,
	"updated_on"	datetime(6) DEFAULT NULL,
	"email"	varchar(255) DEFAULT NULL,
	"first_name"	varchar(255) DEFAULT NULL,
	"image"	varchar(255) DEFAULT NULL,
	"is_deleted"	integer DEFAULT 0,
	"last_name"	varchar(255) DEFAULT NULL,
	"password"	varchar(255) DEFAULT NULL,
	"phone"	varchar(255) DEFAULT NULL,
	"token_expired"	integer NOT NULL,
	"username"	varchar(255) DEFAULT NULL,
	"verification_token"	varchar(255) DEFAULT NULL,
	"magasin_id"	integer DEFAULT NULL,
	UNIQUE("email"),
	PRIMARY KEY("id" AUTOINCREMENT),
	CONSTRAINT "FKls7nwvqmknij37ma0jjonyhjg" FOREIGN KEY("magasin_id") REFERENCES "t_magasin"("id")
);
CREATE TABLE IF NOT EXISTS "users_roles" (
	"user_id"	integer NOT NULL,
	"role_id"	integer NOT NULL,
	CONSTRAINT "FKt4v0rrweyk393bdgt107vdx0x" FOREIGN KEY("role_id") REFERENCES "role"("id"),
	CONSTRAINT "FKgd3iendaoyh04b95ykqise6qh" FOREIGN KEY("user_id") REFERENCES "user"("id")
);
CREATE INDEX IF NOT EXISTS "idx_produit_FK8ehkew7bg1x7dkjc7i1sm8yu7" ON "produit" (
	"fournisseur_id"
);
CREATE INDEX IF NOT EXISTS "idx_produit_FKothbgu2bn7oa29y8tfnodr33v" ON "produit" (
	"magasin_id"
);
CREATE INDEX IF NOT EXISTS "idx_roles_privileges_FK5yjwxw2gvfyu76j3rgqwo685u" ON "roles_privileges" (
	"privilege_id"
);
CREATE INDEX IF NOT EXISTS "idx_roles_privileges_FK9h2vewsqh8luhfq71xokh4who" ON "roles_privileges" (
	"role_id"
);
CREATE INDEX IF NOT EXISTS "idx_supplement_verre_FK2bia8pa41so92nf3ximm6myfn" ON "supplement_verre" (
	"magasin_id"
);
CREATE INDEX IF NOT EXISTS "idx_supplement_verre_FKo5hrwyk1bmoo511uykaophxey" ON "supplement_verre" (
	"verre_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_achat_FKeal7bbiru9r8c0fsm6c2nv85y" ON "t_achat" (
	"magasin_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_achat_FKh2mneutf839g6alax1moq3v07" ON "t_achat" (
	"fournisseur_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_achat_FKn91470vapn3x04ym894ew5l0d" ON "t_achat" (
	"facture_achat_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_avoir_achat_FK114i23vynv5ut2ltlndr9nd2l" ON "t_avoir_achat" (
	"fournisseur_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_avoir_achat_FKi1ij5jfn112g9ovl97uag624s" ON "t_avoir_achat" (
	"magasin_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_avoir_vente_FK6sfou6kshyyd8kub44vq6r72c" ON "t_avoir_vente" (
	"client_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_avoir_vente_FKqey2n1l99cfv07ldd45h67d5d" ON "t_avoir_vente" (
	"magasin_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_cheque_FKh40igp3o4m6dywc7y5j0kgrf9" ON "t_cheque" (
	"magasin_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_client_FKdtkf806a6wh620x576kwispbx" ON "t_client" (
	"magasin_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_client_association_FK6aosa3l3276e5lgpdtp4uv1go" ON "t_client_association" (
	"associated_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_facture_FK2qjia7vncaxbv10nf1vemnvha" ON "t_facture" (
	"magasin_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_facture_FK4dpbi5bj91dswfgto7uqsmtq4" ON "t_facture" (
	"client_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_facture_achat_FK1csmg5ani49pd2w2vahclygt2" ON "t_facture_achat" (
	"magasin_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_facture_achat_FK3l57hy4dalp0qi99luec1w4k4" ON "t_facture_achat" (
	"fournisseur_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_fournisseur_FK68bqy7lvavx4wimun3poilwo5" ON "t_fournisseur" (
	"magasin_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_inventaire_FK6n8acjt84yjskhtlxf81gybc2" ON "t_inventaire" (
	"magasin_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_journal_FKdrfv7lxxnkvji5y7ytpv0yyjl" ON "t_journal" (
	"magasin_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_journal_FKhsscvwhqnrwudi8njya4etj7x" ON "t_journal" (
	"vente_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_journal_FKrn0xvvh422kqriwo2g200mtma" ON "t_journal" (
	"facture_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_l_inventaire_FK8sl83c0qk8c1pnogg9h57dw9l" ON "t_l_inventaire" (
	"magasin_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_l_inventaire_FKl35hd708e9vfpluhda6n7i55x" ON "t_l_inventaire" (
	"produit_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_l_inventaire_FKmvl0454y4io16ostby1mc62co" ON "t_l_inventaire" (
	"inventaire_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_lachat_FK7fddfcfp5wf5nl3m1wjxhsket" ON "t_lachat" (
	"achat_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_lachat_FKrrjslsw4f82qc2symmiamcatg" ON "t_lachat" (
	"magasin_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_lachat_IDX54lstk0bm3onm2nwuy1mssyqb" ON "t_lachat" (
	"id_produit"
);
CREATE INDEX IF NOT EXISTS "idx_t_ligne_avoir_achat_FKcj1ykxg28rbl4jhcnii4ky7cp" ON "t_ligne_avoir_achat" (
	"avoir_achat_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_ligne_avoir_achat_FKh4i9r77b3k4qa17b6iia9fawt" ON "t_ligne_avoir_achat" (
	"magasin_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_ligne_avoir_achat_IDXl3ptc4n3kj57ky4a9bfohv2j9" ON "t_ligne_avoir_achat" (
	"id_produit"
);
CREATE INDEX IF NOT EXISTS "idx_t_ligne_avoir_vente_FK1dxjgqbfmwy0ps2yi6sivi2oj" ON "t_ligne_avoir_vente" (
	"magasin_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_ligne_avoir_vente_FKsdj6vw0omkqd9n47voa7weot6" ON "t_ligne_avoir_vente" (
	"avoir_vente_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_ligne_avoir_vente_IDXiaryi4phuvmy8gu9fa6li5w0x" ON "t_ligne_avoir_vente" (
	"id_produit"
);
CREATE INDEX IF NOT EXISTS "idx_t_ligne_transfert_FKf3xpjonemdwj9hxm2yejt03ad" ON "t_ligne_transfert" (
	"produit_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_ligne_transfert_FKmvry7vi7ngnmreyreteo39vor" ON "t_ligne_transfert" (
	"transfert_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_lvente_FKdj5msyg6qbh5mm5qlo2u7bjat" ON "t_lvente" (
	"magasin_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_lvente_FKkpcd8noddxr5p1kxlhibco2h4" ON "t_lvente" (
	"id_produit"
);
CREATE INDEX IF NOT EXISTS "idx_t_lvente_FKt711a5u7rbjruntr7fh3bh4d5" ON "t_lvente" (
	"vente_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_magasin_FK39t6p7nsvlsgj5c0bh7x879sq" ON "t_magasin" (
	"tenant_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_magasin_FKbbyqe0bvnxatggak72gx5oj8b" ON "t_magasin" (
	"magasin_principal_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_mesure_FKq5rvnl7cbif065wewx2pu9b9q" ON "t_mesure" (
	"magasin_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_ophtalmo_FK7sjjfb7n9qw8mht7j2isbx81j" ON "t_ophtalmo" (
	"magasin_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_puissance_FK6o81x287krj08o5cymmxw9icg" ON "t_puissance" (
	"magasin_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_reglement_FK27ush4p2oeqvnjpp4whk360yj" ON "t_reglement" (
	"magasin_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_reglement_FK5g13ya2266no2nxvvv0xxc6i7" ON "t_reglement" (
	"destination_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_reglement_FKd0wrqvtav1ogvqo34rl1a9afq" ON "t_reglement" (
	"vente_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_reglement_FKeullgak29mgjae3cgxs1en6gi" ON "t_reglement" (
	"payment_mode_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_reglement_FKtc6u2kot4dvc5u983notmh539" ON "t_reglement" (
	"source_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_reglement_achat_FK97qj4aflth758haynuu8gu4e2" ON "t_reglement_achat" (
	"payment_mode_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_reglement_achat_FKipkq3fyj14ikyvdb9wo5c6hox" ON "t_reglement_achat" (
	"achat_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_reglement_achat_FKr5yldlob90agdtv4rxpv8efaj" ON "t_reglement_achat" (
	"magasin_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_reglement_achat_FKrrvhohji3dqyyjkrv8aop0jct" ON "t_reglement_achat" (
	"facture_achat_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_transfert_FKevk1ru95dn77hgsm3ernv8jv" ON "t_transfert" (
	"destination_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_transfert_FKq7iga4l1ddegutxxviqhee3xu" ON "t_transfert" (
	"source_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_vente_FKe8dxa3avjw7e8el6frgcbqctj" ON "t_vente" (
	"magasin_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_vente_FKf91cfu8hcag4ynrww5upyy5ij" ON "t_vente" (
	"client_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_vente_FKfl4814up6649h29ey6nhevt54" ON "t_vente" (
	"facture_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_vente_FKhpdf8fke0nql57wko3es0bw7i" ON "t_vente" (
	"ophtalmo_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_visitclient_FK38ohekax9gmc0wkp84q3ymerj" ON "t_visitclient" (
	"vente_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_visitclient_FKjbfp8ik1ti8dmeujvpm25058s" ON "t_visitclient" (
	"client_id"
);
CREATE INDEX IF NOT EXISTS "idx_t_visitclient_FKo3tglh0i5tniqv3ym0fj98808" ON "t_visitclient" (
	"magasin_id"
);
CREATE INDEX IF NOT EXISTS "idx_user_FKls7nwvqmknij37ma0jjonyhjg" ON "user" (
	"magasin_id"
);
CREATE INDEX IF NOT EXISTS "idx_users_roles_FKgd3iendaoyh04b95ykqise6qh" ON "users_roles" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "idx_users_roles_FKt4v0rrweyk393bdgt107vdx0x" ON "users_roles" (
	"role_id"
);
COMMIT;
