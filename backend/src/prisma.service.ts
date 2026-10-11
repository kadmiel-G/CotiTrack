
import { Injectable, OnModuleDestroy, OnModuleInit } from '@nestjs/common';
import { PrismaClient } from '../generated/prisma/client.js';
import { PrismaPg } from '@prisma/adapter-pg';

@Injectable()
export class PrismaService
  extends PrismaClient
  implements OnModuleInit, OnModuleDestroy
{
  constructor() {
    const { DB_NAME, DB_USER, DB_PASSWORD, DB_HOST, DB_PORT } = process.env;

if (!DB_NAME || !DB_USER || !DB_PASSWORD || !DB_HOST || !DB_PORT) {
  throw new Error('Configuration PostgreSQL incomplète.');
}

const connectionString = new URL(
  `postgresql://${encodeURIComponent(DB_USER)}:${encodeURIComponent(DB_PASSWORD)}@${DB_HOST}:${DB_PORT}/${encodeURIComponent(DB_NAME)}`,
).toString();

    if (!connectionString) {
      throw new Error('La variable DATABASE_URL est absente.');
    }

    const adapter = new PrismaPg({ connectionString });

    super({ adapter });
  }
  async onModuleInit() {
  await this.$connect();

const result = await this.$queryRaw<{ current_database: string }[]>`
    SELECT current_database()
  `;

  console.log('Connexion PostgreSQL réussie. Base :', result[0].current_database);
}
  async onModuleDestroy() {
    await this.$disconnect();
  }
}
