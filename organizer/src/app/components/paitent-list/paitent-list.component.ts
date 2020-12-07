import { BloodType } from './../../models/blood-type';
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
  bloodTypes: BloodType[] = [
    new BloodType(1, 'A', true),
    new BloodType(2, 'A', false),
    new BloodType(3, 'B', true),
    new BloodType(4, 'B', false),
    new BloodType(5, 'X', true),
    new BloodType(6, 'X', false),
    new BloodType(7, 'O', true),
    new BloodType(8, 'O', false)
  ]
  selectedType = new BloodType();
  filtered = false;
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
    console.log(id);

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
  findByBloodTypeId(id) {
    console.log(id);
    this.patients = [];
    if (!isNaN(id)) {
      this.patientService.showByBloodTypeId(id).subscribe(
        data => {
          this.patients = data;
        },
        fail => {
          console.error('PatientListComponent.reload(): error getting patients');
          console.error(fail);
        }
      );
    }
    else {
      this.router.navigateByUrl('invalidId');
    }
    this.id = null;
    this.filtered = true;

  }





  displayPatient(patient: Patient) {
    this.selected = patient;
  }
  displayTable(): void {
    this.selected = null;
    this.reload();
    this.filtered =false;
  }
  selectBloodType(id) {
    console.log(id);
    console.log(this.selectedType);

    this.selectedType = null;
    for (var i = 0; i < this.bloodTypes.length; i++) {
      if (this.bloodTypes[i].id == id) {
        this.selectedType = this.bloodTypes[i];
      }
    }
  }
}

