-- CreateSchema
CREATE SCHEMA IF NOT EXISTS "public";

-- CreateTable
CREATE TABLE "accounts_user" (
    "id" BIGSERIAL NOT NULL,
    "password" VARCHAR(128) NOT NULL,
    "last_login" TIMESTAMPTZ(6),
    "is_superuser" BOOLEAN NOT NULL,
    "username" VARCHAR(150) NOT NULL,
    "first_name" VARCHAR(150) NOT NULL,
    "last_name" VARCHAR(150) NOT NULL,
    "email" VARCHAR(254) NOT NULL,
    "is_staff" BOOLEAN NOT NULL,
    "is_active" BOOLEAN NOT NULL,
    "date_joined" TIMESTAMPTZ(6) NOT NULL,
    "role" VARCHAR(20) NOT NULL,

    CONSTRAINT "accounts_user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "accounts_user_groups" (
    "id" BIGSERIAL NOT NULL,
    "user_id" BIGINT NOT NULL,
    "group_id" INTEGER NOT NULL,

    CONSTRAINT "accounts_user_groups_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "accounts_user_user_permissions" (
    "id" BIGSERIAL NOT NULL,
    "user_id" BIGINT NOT NULL,
    "permission_id" INTEGER NOT NULL,

    CONSTRAINT "accounts_user_user_permissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "auth_group" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(150) NOT NULL,

    CONSTRAINT "auth_group_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "auth_group_permissions" (
    "id" BIGSERIAL NOT NULL,
    "group_id" INTEGER NOT NULL,
    "permission_id" INTEGER NOT NULL,

    CONSTRAINT "auth_group_permissions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "auth_permission" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "content_type_id" INTEGER NOT NULL,
    "codename" VARCHAR(100) NOT NULL,

    CONSTRAINT "auth_permission_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "django_admin_log" (
    "id" SERIAL NOT NULL,
    "action_time" TIMESTAMPTZ(6) NOT NULL,
    "object_id" TEXT,
    "object_repr" VARCHAR(200) NOT NULL,
    "action_flag" SMALLINT NOT NULL,
    "change_message" TEXT NOT NULL,
    "content_type_id" INTEGER,
    "user_id" BIGINT NOT NULL,

    CONSTRAINT "django_admin_log_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "django_content_type" (
    "id" SERIAL NOT NULL,
    "app_label" VARCHAR(100) NOT NULL,
    "model" VARCHAR(100) NOT NULL,

    CONSTRAINT "django_content_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "django_migrations" (
    "id" BIGSERIAL NOT NULL,
    "app" VARCHAR(255) NOT NULL,
    "name" VARCHAR(255) NOT NULL,
    "applied" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "django_migrations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "django_session" (
    "session_key" VARCHAR(40) NOT NULL,
    "session_data" TEXT NOT NULL,
    "expire_date" TIMESTAMPTZ(6) NOT NULL,

    CONSTRAINT "django_session_pkey" PRIMARY KEY ("session_key")
);

-- CreateTable
CREATE TABLE "tontines_participation" (
    "id" BIGSERIAL NOT NULL,
    "role" VARCHAR(12) NOT NULL,
    "status" VARCHAR(10) NOT NULL,
    "joined_at" TIMESTAMPTZ(6) NOT NULL,
    "tontine_id" BIGINT NOT NULL,
    "user_id" BIGINT NOT NULL,

    CONSTRAINT "tontines_participation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tontines_tontine" (
    "id" BIGSERIAL NOT NULL,
    "name" VARCHAR(150) NOT NULL,
    "description" TEXT NOT NULL,
    "contribution_amount" DECIMAL(12,2),
    "frequency" VARCHAR(20) NOT NULL,
    "status" VARCHAR(10) NOT NULL,
    "created_at" TIMESTAMPTZ(6) NOT NULL,
    "updated_at" TIMESTAMPTZ(6) NOT NULL,
    "created_by_id" BIGINT NOT NULL,

    CONSTRAINT "tontines_tontine_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "accounts_user_username_key" ON "accounts_user"("username");

-- CreateIndex
CREATE INDEX "accounts_user_username_6088629e_like" ON "accounts_user"("username");

-- CreateIndex
CREATE INDEX "accounts_user_groups_group_id_bd11a704" ON "accounts_user_groups"("group_id");

-- CreateIndex
CREATE INDEX "accounts_user_groups_user_id_52b62117" ON "accounts_user_groups"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "accounts_user_groups_user_id_group_id_59c0b32f_uniq" ON "accounts_user_groups"("user_id", "group_id");

-- CreateIndex
CREATE INDEX "accounts_user_user_permissions_permission_id_113bb443" ON "accounts_user_user_permissions"("permission_id");

-- CreateIndex
CREATE INDEX "accounts_user_user_permissions_user_id_e4f0a161" ON "accounts_user_user_permissions"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq" ON "accounts_user_user_permissions"("user_id", "permission_id");

-- CreateIndex
CREATE UNIQUE INDEX "auth_group_name_key" ON "auth_group"("name");

-- CreateIndex
CREATE INDEX "auth_group_name_a6ea08ec_like" ON "auth_group"("name");

-- CreateIndex
CREATE INDEX "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions"("group_id");

-- CreateIndex
CREATE INDEX "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions"("permission_id");

-- CreateIndex
CREATE UNIQUE INDEX "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions"("group_id", "permission_id");

-- CreateIndex
CREATE INDEX "auth_permission_content_type_id_2f476e4b" ON "auth_permission"("content_type_id");

-- CreateIndex
CREATE UNIQUE INDEX "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission"("content_type_id", "codename");

-- CreateIndex
CREATE INDEX "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log"("content_type_id");

-- CreateIndex
CREATE INDEX "django_admin_log_user_id_c564eba6" ON "django_admin_log"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type"("app_label", "model");

-- CreateIndex
CREATE INDEX "django_session_expire_date_a5c62663" ON "django_session"("expire_date");

-- CreateIndex
CREATE INDEX "django_session_session_key_c0390e0f_like" ON "django_session"("session_key");

-- CreateIndex
CREATE INDEX "tontines_participation_tontine_id_7199e5c6" ON "tontines_participation"("tontine_id");

-- CreateIndex
CREATE INDEX "tontines_participation_user_id_3a2e6c0f" ON "tontines_participation"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "unique_user_per_tontine" ON "tontines_participation"("tontine_id", "user_id");

-- CreateIndex
CREATE INDEX "tontines_tontine_created_by_id_3709caf1" ON "tontines_tontine"("created_by_id");

-- AddForeignKey
ALTER TABLE "accounts_user_groups" ADD CONSTRAINT "accounts_user_groups_group_id_bd11a704_fk_auth_group_id" FOREIGN KEY ("group_id") REFERENCES "auth_group"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "accounts_user_groups" ADD CONSTRAINT "accounts_user_groups_user_id_52b62117_fk_accounts_user_id" FOREIGN KEY ("user_id") REFERENCES "accounts_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "accounts_user_user_permissions" ADD CONSTRAINT "accounts_user_user_p_permission_id_113bb443_fk_auth_perm" FOREIGN KEY ("permission_id") REFERENCES "auth_permission"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "accounts_user_user_permissions" ADD CONSTRAINT "accounts_user_user_p_user_id_e4f0a161_fk_accounts_" FOREIGN KEY ("user_id") REFERENCES "accounts_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "auth_group_permissions" ADD CONSTRAINT "auth_group_permissio_permission_id_84c5c92e_fk_auth_perm" FOREIGN KEY ("permission_id") REFERENCES "auth_permission"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "auth_group_permissions" ADD CONSTRAINT "auth_group_permissions_group_id_b120cbf9_fk_auth_group_id" FOREIGN KEY ("group_id") REFERENCES "auth_group"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "auth_permission" ADD CONSTRAINT "auth_permission_content_type_id_2f476e4b_fk_django_co" FOREIGN KEY ("content_type_id") REFERENCES "django_content_type"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "django_admin_log" ADD CONSTRAINT "django_admin_log_content_type_id_c4bce8eb_fk_django_co" FOREIGN KEY ("content_type_id") REFERENCES "django_content_type"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "django_admin_log" ADD CONSTRAINT "django_admin_log_user_id_c564eba6_fk_accounts_user_id" FOREIGN KEY ("user_id") REFERENCES "accounts_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tontines_participation" ADD CONSTRAINT "tontines_participati_tontine_id_7199e5c6_fk_tontines_" FOREIGN KEY ("tontine_id") REFERENCES "tontines_tontine"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tontines_participation" ADD CONSTRAINT "tontines_participation_user_id_3a2e6c0f_fk_accounts_user_id" FOREIGN KEY ("user_id") REFERENCES "accounts_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tontines_tontine" ADD CONSTRAINT "tontines_tontine_created_by_id_3709caf1_fk_accounts_user_id" FOREIGN KEY ("created_by_id") REFERENCES "accounts_user"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

