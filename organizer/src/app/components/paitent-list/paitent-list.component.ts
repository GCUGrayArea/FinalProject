import { PatientService } from './../../services/patient.service';
import { Component, OnInit } from '@angular/core';
import { Patient } from 'src/app/models/patient';

@Component({
  selector: 'app-paitent-list',
  templateUrl: './paitent-list.component.html',
  styleUrls: ['./paitent-list.component.css']
})
export class PaitentListComponent implements OnInit {
patients : Patient[] = [];
  constructor(private patientService: PatientService) { }

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

}
