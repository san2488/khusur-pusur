CREATE TABLE "categories" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "comments" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "content" varchar(255), "post_id" integer, "user_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "posts" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(255), "content" varchar(255), "category_id" integer, "user_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "user_sessions" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "ip_address" varchar(255), "path" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "salt" varchar(255), "encrypted_password" varchar(255), "email" varchar(255), "is_admin" boolean DEFAULT 'f', "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "votes" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "voteable_id" integer, "voteable_type" varchar(255), "user_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE INDEX "index_comments_on_post_id" ON "comments" ("post_id");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20120907191053');

INSERT INTO schema_migrations (version) VALUES ('20120907191117');

INSERT INTO schema_migrations (version) VALUES ('20120915060223');

INSERT INTO schema_migrations (version) VALUES ('20120915060251');

INSERT INTO schema_migrations (version) VALUES ('20120915060316');

INSERT INTO schema_migrations (version) VALUES ('20120915060420');