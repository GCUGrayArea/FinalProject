import { PatientService } from './../../services/patient.service';
import { Component, OnInit } from '@angular/core';
import { Patient } from 'src/app/models/patient';
import { TransplantRequest } from 'src/app/models/transplant-request';
import { TransplantRequestService } from 'src/app/services/transplant-request.service';

@Component({
  selector: 'app-transplant-request-list',
  templateUrl: './transplant-request-list.component.html',
  styleUrls: ['./transplant-request-list.component.css']
})
export class TransplantRequestListComponent implements OnInit {


  transplantRequest: TransplantRequest[] =[];
  selected: TransplantRequest = null;
  newTransplantRequest: TransplantRequest = new TransplantRequest();
  updatedTransplantRequest: TransplantRequest = null;
  viableDonors : Patient[] = [];


  constructor(
    private tSvc: TransplantRequestService,
    private patientService: PatientService) { }

  ngOnInit(): void {
    this.loadTransplantRequest();
    // this.averageDuration();
  }

  loadTransplantRequest(): void{
    this.tSvc.index().subscribe(
      data=>{this.transplantRequest=data;
      console.log('TransplantRequestListComponent.loadTransplantRequest(): transplantRequest retrieved');
      },

      err=>{
        console.error('TransplantRequestListComponent.loadTransplantRequest(): retreive failed');
console.log(err);

      });

  }


  addTransplantRequest(addedRequest: TransplantRequest) {
    this.tSvc.create(addedRequest).subscribe(
      data=>{this.loadTransplantRequest();
        console.log('TransplantRequestListComponent.loadTransplantRequest(): transplantRequest retrieved');
        },

        err=>{
          console.error('TransplantRequestListComponent.loadTransplantRequest(): retreive failed');
  console.log(err);

        });
        this.newTransplantRequest = new TransplantRequest();
        this.selected=null;
    }

  displayTodo(todo) {
    this.selected = todo;
  }

  updateTransplantRequest(transplantRequest: TransplantRequest) {
    // this.todos[todo.id - 1] = Object.assign({}, todo);
    // this.selected = Object.assign({}, todo);
    this.tSvc.update(transplantRequest).subscribe(
      (good) => {
        this.loadTransplantRequest();
        if (this.selected != null) {
          this.selected = Object.assign({}, transplantRequest);
        }
      },
      (bad) => {
        console.error(bad);
      }
    );
    this.updatedTransplantRequest = null;
  }

  deleteTransplantRequest(id) {
    this.tSvc.destroy(id).subscribe(
      (good) => {
        this.loadTransplantRequest();
      },
      (bad) => {
        console.error(bad);
      }
    );
    this.selected=null;
  }

  setUpdatedTransplantRequest() {
    this.updatedTransplantRequest = Object.assign({}, this.selected);
  }
  loadViableDonors(tr:TransplantRequest){
    this.patientService.indexViableDonors(tr).subscribe(
      data => {
        this.viableDonors = data;
      },
      fail => {
        console.error('PatientListComponent.reload(): error getting patients');
        console.error(fail);
      }
    );
  }
}
