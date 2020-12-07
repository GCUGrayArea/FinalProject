import { PatientService } from './services/patient.service';
import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { PaitentListComponent } from './components/paitent-list/paitent-list.component';
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { NavBarComponent } from './components/nav-bar/nav-bar.component';
import { TransplantRequestService } from './services/transplant-request.service';
import { TransplantRequestListComponent } from './components/transplant-request-list/transplant-request-list.component';


@NgModule({
  declarations: [
    AppComponent,
    PaitentListComponent,
    TransplantRequestListComponent,
    NavBarComponent,

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
