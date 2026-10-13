
import { Module } from '@nestjs/common';
import { AppController } from './app.controller.js';
import { AppService } from './app.service.js';
import { PrismaModule } from './prisma.module.js';
import { AccountsModule } from './accounts/accounts.module.js';
import { TontinesModule } from './tontines/tontines.module.js';
import { ParticipationsModule } from './participations/participations.module.js';

@Module({
  imports: [
    PrismaModule,
    AccountsModule,
    TontinesModule,
    ParticipationsModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
