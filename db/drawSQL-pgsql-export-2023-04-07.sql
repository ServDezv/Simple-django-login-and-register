CREATE TABLE "localitate"(
    "id" BIGINT NOT NULL,
    "nume" VARCHAR(100) NOT NULL,
    "judet" VARCHAR(100) NOT NULL,
    "auto" VARCHAR(5) NOT NULL,
    "lat" DOUBLE PRECISION NOT NULL,
    "lng" DOUBLE PRECISION NOT NULL
);
ALTER TABLE
    "localitate" ADD PRIMARY KEY("id");
COMMENT
ON COLUMN
    "localitate"."nume" IS 'Fara diacritice';
COMMENT
ON COLUMN
    "localitate"."auto" IS 'OT, BN, MH, MS, SV etc.';
COMMENT
ON COLUMN
    "localitate"."lat" IS 'Latitudinea';
COMMENT
ON COLUMN
    "localitate"."lng" IS 'Longitudinea';
CREATE TABLE "website_state"(
    "id" BIGINT NOT NULL,
    "stare" VARCHAR(100) NOT NULL
);
ALTER TABLE
    "website_state" ADD PRIMARY KEY("id");
COMMENT
ON COLUMN
    "website_state"."stare" IS 'Vom avea "Neacreditat", "În curs de acreditare", "Acreditat" + alte stări pe care le identificăm pe parcursul dezvoltării';
CREATE TABLE "website"(
    "id" BIGINT NOT NULL,
    "um_gazda" BIGINT NOT NULL,
    "um_detinator" BIGINT NOT NULL,
    "um_beneficiar" BIGINT NOT NULL,
    "url" VARCHAR(100) NOT NULL,
    "ip_public" VARCHAR(100) NOT NULL,
    "nume_isp" VARCHAR(100) NOT NULL,
    "stare" BIGINT NOT NULL
);
ALTER TABLE
    "website" ADD PRIMARY KEY("id");
CREATE INDEX "website_um_gazda_index" ON
    "website"("um_gazda");
CREATE INDEX "website_um_detinator_index" ON
    "website"("um_detinator");
CREATE INDEX "website_um_beneficiar_index" ON
    "website"("um_beneficiar");
CREATE INDEX "website_stare_index" ON
    "website"("stare");
CREATE TABLE "user_grad"(
    "id" BIGINT NOT NULL,
    "denumire_grad" VARCHAR(100) NOT NULL
);
ALTER TABLE
    "user_grad" ADD PRIMARY KEY("id");
CREATE TABLE "user"(
    "id" BIGINT NOT NULL,
    "grad" BIGINT NOT NULL,
    "nume" VARCHAR(100) NOT NULL,
    "prenume" VARCHAR(100) NOT NULL,
    "unitate" BIGINT NOT NULL,
    "rol" BIGINT NOT NULL,
    "email_intra" VARCHAR(100) NOT NULL,
    "email_inter" VARCHAR(100) NOT NULL,
    "telefon_rtp" VARCHAR(100) NOT NULL,
    "telefon_mobil" VARCHAR(100) NULL
);
ALTER TABLE
    "user" ADD PRIMARY KEY("id");
CREATE INDEX "user_grad_index" ON
    "user"("grad");
CREATE INDEX "user_unitate_index" ON
    "user"("unitate");
CREATE INDEX "user_rol_index" ON
    "user"("rol");
COMMENT
ON COLUMN
    "user"."email_intra" IS 'Va fi obținut din detaliile contului din Active Directory (autentificare LDAP)';
COMMENT
ON COLUMN
    "user"."telefon_mobil" IS 'Optional';
CREATE TABLE "um"(
    "id" BIGINT NOT NULL,
    "indicativ" VARCHAR(20) NOT NULL,
    "denumire" VARCHAR(100) NOT NULL,
    "localitate" BIGINT NOT NULL,
    "lat" DOUBLE PRECISION NULL,
    "lng" DOUBLE PRECISION NULL,
    "crisc" BOOLEAN NOT NULL DEFAULT '0'
);
ALTER TABLE
    "um" ADD PRIMARY KEY("id");
CREATE INDEX "um_localitate_index" ON
    "um"("localitate");
COMMENT
ON COLUMN
    "um"."lat" IS 'Latitudinea';
COMMENT
ON COLUMN
    "um"."lng" IS 'Longitudinea';
COMMENT
ON COLUMN
    "um"."crisc" IS 'By default = False; La înregistrarea UM-ului de către administrator, se va putea marca ca fiind True din UI';
CREATE TABLE "ssl_certificate"(
    "id" BIGINT NOT NULL,
    "website" BIGINT NOT NULL,
    "ca_semnatar" VARCHAR(100) NULL,
    "data_expirare" DATE NULL
);
ALTER TABLE
    "ssl_certificate" ADD PRIMARY KEY("id");
CREATE INDEX "ssl_certificate_website_index" ON
    "ssl_certificate"("website");
COMMENT
ON COLUMN
    "ssl_certificate"."website" IS 'One-to-many: Un site web poate avea un singur certificat SSL la un moment dat, dar un certificat SSL poate fi utilizat de mai multe site-uri web (ex., certificat wildcard)';
CREATE TABLE "website_history"(
    "id" BIGINT NOT NULL,
    "website" BIGINT NOT NULL,
    "data" DATE NOT NULL,
    "stare_veche" BIGINT NULL,
    "stare_noua" BIGINT NOT NULL
);
ALTER TABLE
    "website_history" ADD PRIMARY KEY("id");
CREATE INDEX "website_history_website_index" ON
    "website_history"("website");
COMMENT
ON COLUMN
    "website_history"."stare_veche" IS 'Inițial, va fi null și va trebui să tratăm în cod acest caz ca să nu generăm erori.';
CREATE TABLE "server_info"(
    "id" BIGINT NOT NULL,
    "website" BIGINT NOT NULL,
    "os_version" VARCHAR(100) NOT NULL,
    "cms_version" VARCHAR(100) NULL,
    "service_name" VARCHAR(100) NOT NULL,
    "service_version" VARCHAR(100) NOT NULL
);
ALTER TABLE
    "server_info" ADD PRIMARY KEY("id");
CREATE INDEX "server_info_website_index" ON
    "server_info"("website");
COMMENT
ON COLUMN
    "server_info"."os_version" IS 'Exemple: Ubuntu 20.04, Windows 21H2';
COMMENT
ON COLUMN
    "server_info"."cms_version" IS 'Poate fi null - vor fi site-uri web ce nu folosesc CMS';
COMMENT
ON COLUMN
    "server_info"."service_name" IS 'Exemple: Apache, NGINX, Microsoft IIS etc.';
CREATE TABLE "user_role"(
    "id" BIGINT NOT NULL,
    "nume" VARCHAR(100) NOT NULL,
    "alias" VARCHAR(100) NULL
);
ALTER TABLE
    "user_role" ADD PRIMARY KEY("id");
COMMENT
ON COLUMN
    "user_role"."nume" IS 'Poate fi "user", "webadmin", "administrator"';
COMMENT
ON COLUMN
    "user_role"."alias" IS 'La ''administrator'' alias-ul va fi ''auditor''; Câmpul este opțional';
ALTER TABLE
    "website" ADD CONSTRAINT "website_stare_foreign" FOREIGN KEY("stare") REFERENCES "website_state"("id");
ALTER TABLE
    "website" ADD CONSTRAINT "website_um_beneficiar_foreign" FOREIGN KEY("um_beneficiar") REFERENCES "um"("id");
ALTER TABLE
    "ssl_certificate" ADD CONSTRAINT "ssl_certificate_website_foreign" FOREIGN KEY("website") REFERENCES "website"("id");
ALTER TABLE
    "website_history" ADD CONSTRAINT "website_history_stare_veche_foreign" FOREIGN KEY("stare_veche") REFERENCES "website_state"("id");
ALTER TABLE
    "user" ADD CONSTRAINT "user_grad_foreign" FOREIGN KEY("grad") REFERENCES "user_grad"("id");
ALTER TABLE
    "server_info" ADD CONSTRAINT "server_info_website_foreign" FOREIGN KEY("website") REFERENCES "website"("id");
ALTER TABLE
    "website_history" ADD CONSTRAINT "website_history_stare_noua_foreign" FOREIGN KEY("stare_noua") REFERENCES "website_state"("id");
ALTER TABLE
    "website_history" ADD CONSTRAINT "website_history_website_foreign" FOREIGN KEY("website") REFERENCES "website"("id");
ALTER TABLE
    "website" ADD CONSTRAINT "website_um_gazda_foreign" FOREIGN KEY("um_gazda") REFERENCES "um"("id");
ALTER TABLE
    "user" ADD CONSTRAINT "user_unitate_foreign" FOREIGN KEY("unitate") REFERENCES "um"("id");
ALTER TABLE
    "um" ADD CONSTRAINT "um_localitate_foreign" FOREIGN KEY("localitate") REFERENCES "localitate"("id");
ALTER TABLE
    "website" ADD CONSTRAINT "website_um_detinator_foreign" FOREIGN KEY("um_detinator") REFERENCES "um"("id");
ALTER TABLE
    "user" ADD CONSTRAINT "user_rol_foreign" FOREIGN KEY("rol") REFERENCES "user_role"("id");