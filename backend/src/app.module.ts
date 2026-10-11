
import { Module } from '@nestjs/common';
import { AppController } from './app.controller.js';
import { AppService } from './app.service.js';
import { PrismaService } from './prisma.service.js';
import { AccountsModule } from './accounts/accounts.module.js';
import { TontinesModule } from './tontines/tontines.module.js';
import { ParticipationsModule } from './participations/participations.module.js';

@Module({
  imports: [AccountsModule, TontinesModule, ParticipationsModule],
  controllers: [AppController],
  providers: [AppService, PrismaService],
})
export class AppModule {}
