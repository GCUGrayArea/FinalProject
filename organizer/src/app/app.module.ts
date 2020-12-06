import { PatientService } from './services/patient.service';
import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { TransplantRequestComponent } from './components/transplant-request/transplant-request.component';
import { PatientProfileComponent } from './components/patient-profile/patient-profile.component';
import { PaitentListComponent } from './components/paitent-list/paitent-list.component';
import { TransplantRequestListComponent } from './components/transplant-request-list/transplant-request-list.component';
import { TransplantRequestService } from './services/transplant-request.service';
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';

@NgModule({
  declarations: [
    AppComponent,
    TransplantRequestComponent,
    PatientProfileComponent,
    PaitentListComponent,
    TransplantRequestListComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    HttpClientModule
  ],
  providers: [TransplantRequestService, PatientService],
  bootstrap: [AppComponent]
})
export class AppModule { }
