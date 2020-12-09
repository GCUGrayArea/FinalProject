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
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { AboutComponent } from './components/about/about.component';
import { HomeComponent } from './components/home/home.component';
import { ErrorComponent } from './components/error/error.component';
import { RegisterComponent } from './components/register/register.component';
import { LoginComponent } from './components/login/login.component';
import { LogoutComponent } from './logout/logout.component';


@NgModule({
  declarations: [
    AppComponent,
    PaitentListComponent,
    TransplantRequestListComponent,
    NavBarComponent,
    AboutComponent,
    HomeComponent,
    ErrorComponent,
    RegisterComponent,
    LoginComponent,
<<<<<<< HEAD

=======
    LogoutComponent
>>>>>>> d7b75e58529b4728bee3e8c4476a2668b7fd773d
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    HttpClientModule,
    NgbModule
  ],
  providers: [TransplantRequestService, PatientService],
  bootstrap: [AppComponent]
})
export class AppModule { }
