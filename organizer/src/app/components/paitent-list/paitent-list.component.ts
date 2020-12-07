import { Router } from '@angular/router';
import { PatientService } from './../../services/patient.service';
import { Component, OnInit } from '@angular/core';
import { Patient } from 'src/app/models/patient';

@Component({
  selector: 'app-paitent-list',
  templateUrl: './paitent-list.component.html',
  styleUrls: ['./paitent-list.component.css']
})
export class PaitentListComponent implements OnInit {
  patients: Patient[] = [];
  selected = null;
  id = null;
  constructor(private patientService: PatientService, private router: Router) { }

  ngOnInit(): void {
    this.reload();

  }

  reload(): void {
    this.patientService.index().subscribe(
      data => {
        this.patients = data;
      },
      fail => {
        console.error('PatientListComponent.reload(): error getting patients');
        console.error(fail);
      }
    );
  }
  findById(id) {
    if (!isNaN(id)) {
      this.patientService.show(id).subscribe(
        (patient) => {
          this.selected = patient;
          this.reload();
        },
        (err) => {
          // TODO: If todo doesn't exist, forward to not found page
          console.log('patient ' + id + ' not found.');
          this.router.navigateByUrl('notFound');
        }
      );
    }
    else {
      this.router.navigateByUrl('invalidId');
    }
    this.id = null;


  }





  displayPatient(patient: Patient) {
    this.selected = patient;
  }
  displayTable(): void {
    this.selected = null;
  }
}
