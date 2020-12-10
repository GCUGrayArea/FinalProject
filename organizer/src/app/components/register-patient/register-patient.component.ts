import { PatientService } from './../../services/patient.service';
import { Component, OnInit } from '@angular/core';
import { Patient } from 'src/app/models/patient';
import { Router } from '@angular/router';

@Component({
  selector: 'app-register-patient',
  templateUrl: './register-patient.component.html',
  styleUrls: ['./register-patient.component.css']
})
export class RegisterPatientComponent implements OnInit {

  newPatient: Patient = new Patient();

  constructor( private patientService: PatientService , private router: Router ) { }

  ngOnInit(): void {
  }

  register( patient: Patient ) {
    this.patientService.create(patient).subscribe(
      (good) => {
        this.patientService.create(patient).subscribe(
          (data) => {
            console.log("PATIENT CREATION SUCCESSFUL")
            this.router.navigateByUrl('home');
          } ,
          (err) => {
            console.error("PATIENT CREATION FAILED");
            console.error(err);

          }

        )
      } ,
      (bad) => {
        console.error("REGISTRATION FAILED");
        console.error(bad);

      }
    );
  }

}
