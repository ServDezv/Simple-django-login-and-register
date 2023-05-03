Skip to content
Search or jump to…
Pull requests
Issues
Codespaces
Marketplace
Explore
 
@Radus1k 
ServDezv
/
Autorizare-web-2
Public
forked from ServDezv/Simple-django-login-and-register
Fork your own copy of ServDezv/Autorizare-web-2
Code
Pull requests
1
Actions
Projects
Security
Insights
Settings
Beta Try the new code view
Autorizare-web-2/db/drawSQL-pgsql-export-2023-04-07.sql
@ArtOfFugue66
ArtOfFugue66 [NO-ROLE]-[NO-PAGE]-[Actualizare commit history]
Latest commit e782eab yesterday
 History
 1 contributor
192 lines (192 sloc)  6.85 KB
 

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
    "um_gazda (FK)" BIGINT NOT NULL,
    "um_detinator (FK)" BIGINT NOT NULL,
    "um_beneficiar (FK)" BIGINT NOT NULL,
    "url" VARCHAR(100) NOT NULL,
    "ip_public" VARCHAR(100) NOT NULL,
    "nume_isp" VARCHAR(100) NOT NULL,
    "stare (FK)" BIGINT NOT NULL
);
ALTER TABLE
    "website" ADD PRIMARY KEY("id");
CREATE INDEX "website_um_gazda (fk)_index" ON
    "website"("um_gazda (FK)");
CREATE INDEX "website_um_detinator (fk)_index" ON
    "website"("um_detinator (FK)");
CREATE INDEX "website_um_beneficiar (fk)_index" ON
    "website"("um_beneficiar (FK)");
CREATE INDEX "website_stare (fk)_index" ON
    "website"("stare (FK)");
CREATE TABLE "user_grad"(
    "id" BIGINT NOT NULL,
    "denumire_grad" VARCHAR(100) NOT NULL
);
ALTER TABLE
    "user_grad" ADD PRIMARY KEY("id");
CREATE TABLE "user"(
    "id" BIGINT NOT NULL,
    "grad (FK)" BIGINT NOT NULL,
    "nume" VARCHAR(100) NOT NULL,
    "prenume" VARCHAR(100) NOT NULL,
    "unitate (FK)" BIGINT NOT NULL,
    "rol (FK)" BIGINT NOT NULL,
    "email_intra" VARCHAR(100) NOT NULL,
    "email_inter" VARCHAR(100) NOT NULL,
    "telefon_rtp" VARCHAR(100) NOT NULL,
    "telefon_mobil" VARCHAR(100) NULL
);
ALTER TABLE
    "user" ADD PRIMARY KEY("id");
CREATE INDEX "user_grad (fk)_index" ON
    "user"("grad (FK)");
CREATE INDEX "user_unitate (fk)_index" ON
    "user"("unitate (FK)");
CREATE INDEX "user_rol (fk)_index" ON
    "user"("rol (FK)");
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
    "localitate (FK)" BIGINT NOT NULL,
    "lat" DOUBLE PRECISION NULL,
    "lng" DOUBLE PRECISION NULL,
    "crisc" BOOLEAN NOT NULL DEFAULT '0'
);
ALTER TABLE
    "um" ADD PRIMARY KEY("id");
CREATE INDEX "um_localitate (fk)_index" ON
    "um"("localitate (FK)");
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
    "website (FK)" BIGINT NOT NULL,
    "ca_semnatar" VARCHAR(100) NULL,
    "data_expirare" DATE NULL
);
ALTER TABLE
    "ssl_certificate" ADD PRIMARY KEY("id");
CREATE INDEX "ssl_certificate_website (fk)_index" ON
    "ssl_certificate"("website (FK)");
COMMENT
ON COLUMN
    "ssl_certificate"."website (FK)" IS 'One-to-many: Un site web poate avea un singur certificat SSL la un moment dat, dar un certificat SSL poate fi utilizat de mai multe site-uri web (ex., certificat wildcard)';
CREATE TABLE "website_history"(
    "id" BIGINT NOT NULL,
    "website (FK)" BIGINT NOT NULL,
    "data" DATE NOT NULL,
    "stare_veche (FK)" BIGINT NULL,
    "stare_noua (FK)" BIGINT NOT NULL
);
ALTER TABLE
    "website_history" ADD PRIMARY KEY("id");
CREATE INDEX "website_history_website (fk)_index" ON
    "website_history"("website (FK)");
COMMENT
ON COLUMN
    "website_history"."stare_veche (FK)" IS 'Inițial, va fi null și va trebui să tratăm în cod acest caz ca să nu generăm erori.';
CREATE TABLE "server_info"(
    "id" BIGINT NOT NULL,
    "website (FK)" BIGINT NOT NULL,
    "os_version" VARCHAR(100) NOT NULL,
    "cms_version" VARCHAR(100) NULL,
    "service_name" VARCHAR(100) NOT NULL,
    "service_version" VARCHAR(100) NOT NULL
);
ALTER TABLE
    "server_info" ADD PRIMARY KEY("id");
CREATE INDEX "server_info_website (fk)_index" ON
    "server_info"("website (FK)");
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
    "website" ADD CONSTRAINT "website_stare (fk)_foreign" FOREIGN KEY("stare (FK)") REFERENCES "website_state"("id");
ALTER TABLE
    "website" ADD CONSTRAINT "website_um_beneficiar (fk)_foreign" FOREIGN KEY("um_beneficiar (FK)") REFERENCES "um"("id");
ALTER TABLE
    "ssl_certificate" ADD CONSTRAINT "ssl_certificate_website (fk)_foreign" FOREIGN KEY("website (FK)") REFERENCES "website"("id");
ALTER TABLE
    "website_history" ADD CONSTRAINT "website_history_stare_veche (fk)_foreign" FOREIGN KEY("stare_veche (FK)") REFERENCES "website_state"("id");
ALTER TABLE
    "user" ADD CONSTRAINT "user_grad (fk)_foreign" FOREIGN KEY("grad (FK)") REFERENCES "user_grad"("id");
ALTER TABLE
    "server_info" ADD CONSTRAINT "server_info_website (fk)_foreign" FOREIGN KEY("website (FK)") REFERENCES "website"("id");
ALTER TABLE
    "website_history" ADD CONSTRAINT "website_history_stare_noua (fk)_foreign" FOREIGN KEY("stare_noua (FK)") REFERENCES "website_state"("id");
ALTER TABLE
    "website_history" ADD CONSTRAINT "website_history_website (fk)_foreign" FOREIGN KEY("website (FK)") REFERENCES "website"("id");
ALTER TABLE
    "website" ADD CONSTRAINT "website_um_gazda (fk)_foreign" FOREIGN KEY("um_gazda (FK)") REFERENCES "um"("id");
ALTER TABLE
    "user" ADD CONSTRAINT "user_unitate (fk)_foreign" FOREIGN KEY("unitate (FK)") REFERENCES "um"("id");
ALTER TABLE
    "um" ADD CONSTRAINT "um_localitate (fk)_foreign" FOREIGN KEY("localitate (FK)") REFERENCES "localitate"("id");
ALTER TABLE
    "website" ADD CONSTRAINT "website_um_detinator (fk)_foreign" FOREIGN KEY("um_detinator (FK)") REFERENCES "um"("id");
ALTER TABLE
    "user" ADD CONSTRAINT "user_rol (fk)_foreign" FOREIGN KEY("rol (FK)") REFERENCES "user_role"("id");
Footer
© 2023 GitHub, Inc.
Footer navigation
Terms
Privacy
Security
Status
Docs
Contact GitHub
Pricing
API
Training
Blog
About
