CREATE TABLE CHROMOSOME(
num INT NOT NULL,
taille_c INT NOT NULL,
CONSTRAINT pk_chromosome PRIMARY KEY(num));

CREATE TABLE FAMILLE(
id_f VARCHAR(30),
nb_copie INT NOT NULL,
type_f VARCHAR(30),
CONSTRAINT pk_famille PRIMARY KEY(id_f));

CREATE TABLE COPIETRANS(
id_t VARCHAR(30),
dbt_t INT NOT NULL,
fin_t INT NOT NULL,
sens_c VARCHAR(30),
id_f VARCHAR(30),
type VARCHAR(30),
taille_t VARCHAR(30),
annotations VARCHAR(30),
CONSTRAINT pk_copietrans PRIMARY KEY(id_t),
CONSTRAINT fk_famille FOREIGN KEY(id_f) REFERENCES FAMILLE(id_f));

CREATE TABLE GENE(
id_g VARCHAR(30),
dbt_g INT NOT NULL,
fin_g INT NOT NULL,
sens_g VARCHAR(30),
CONSTRAINT pk_gene PRIMARY KEY(id_g)) ;


CREATE TABLE ALIGNEMENT(
ID BIGSERIAL PRIMARY KEY,
id_cop1 VARCHAR(30) NOT NULL,
id_cop2 VARCHAR(30) NOT NULL,
percent FLOAT,
longueur_al INT NOT NULL,
mismatch INT,
gap INT,
q_start INT,
q_end INT,
s_star INT,
s_end INT,
CONSTRAINT fk_alignement2 FOREIGN KEY(id_cop2) REFERENCES COPIETRANS(id_t));

CREATE TABLE GENESURCHROMO(
num INT NOT NULL,
id_g VARCHAR(30),
CONSTRAINT fk_chromosome FOREIGN KEY(num) REFERENCES CHROMOSOME(num),
CONSTRAINT fk_gene FOREIGN KEY(id_g) REFERENCES GENE(id_g),
CONSTRAINT pk_genesurchromo PRIMARY KEY(num, id_g));

CREATE TABLE COPIETSURCHROMO(
id_t VARCHAR(30),
num INT NOT NULL,
CONSTRAINT pk_copietsurchromo PRIMARY KEY(num, id_t),
CONSTRAINT fk_chromosome1 FOREIGN KEY(num) REFERENCES CHROMOSOME(num),
CONSTRAINT fk_copietrans FOREIGN KEY(id_t) REFERENCES COPIETRANS(id_t));

copy chromosome from '/home/fnrs/Bureau/ProjetBI/fichierbd/X.tsv';
copy gene from '/home/fnrs/Bureau/ProjetBI/fichierbd/dico.tsv';
copy famille from '/home/fnrs/Bureau/ProjetBI/fichierbd/family2.tsv';
copy copietrans from '/home/fnrs/Bureau/ProjetBI/fichierbd/copie_3.tsv';

CREATE TABLE temp (id_cop1 VARCHAR(30), id_cop2 VARCHAR(30) NOT NULL,
percent FLOAT, longueur_al INT NOT NULL, mismatch INT, gap INT, q_start INT, q_end INT, s_star INT, s_end INT);
COPY temp FROM '/home/fnrs/Bureau/ProjetBI/fichierbd/ATCOPIA30_4.blast';
INSERT INTO ALIGNEMENT SELECT nextval('alignement_id_seq'),* FROM temp;
DROP TABLE temp;