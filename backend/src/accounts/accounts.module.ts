
import { Module } from '@nestjs/common';
import { PrismaModule } from '../prisma.module.js';

@Module({
  imports: [PrismaModule],
})
export class AccountsModule {}
