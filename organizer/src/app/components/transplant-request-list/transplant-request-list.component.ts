
import { TransplantType } from './../../models/transplant-type';
import { PatientService } from './../../services/patient.service';
import { Component, OnInit } from '@angular/core';
import { Patient } from 'src/app/models/patient';
import { TransplantRequest } from 'src/app/models/transplant-request';
import { TransplantRequestService } from 'src/app/services/transplant-request.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-transplant-request-list',
  templateUrl: './transplant-request-list.component.html',
  styleUrls: ['./transplant-request-list.component.css']
})
export class TransplantRequestListComponent implements OnInit {


  transplantRequests: TransplantRequest[] =[];
  selected: TransplantRequest = null;
  newTransplantRequest: TransplantRequest = new TransplantRequest();
  updatedTransplantRequest: TransplantRequest = null;
  viableDonors : Patient[] = [];
  selectedType =null;
  organTypes: TransplantType[] = [
    new TransplantType(1, 'bonemarrow'),
    new TransplantType(2, 'kidney'),
    new TransplantType(3, 'teeth'),
  ];
  filtered = false;
  patientToAdd =new Patient()

  constructor(
    private tSvc: TransplantRequestService,
    private patientService: PatientService,
    private router: Router) { }

  ngOnInit(): void {
    this.loadTransplantRequest();
    // this.averageDuration();
  }

  loadTransplantRequest(): void{
    this.tSvc.index().subscribe(
      data=>{
          data.forEach(tr =>{
           const p : Patient = new Patient();
           Object.assign(p, tr.recipient);
           tr.recipient = p;
          })

        this.transplantRequests=data;
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
        console.log(tr);
        console.log(tr.recipient);

        this.viableDonors = tr.recipient.sortDonorsByHlaCompatibility(data);
      },
      fail => {
        console.error('TRComponent.reload(): error getting patients');
        console.error(fail);
      }
    );
  }

  selectOrganType(id) {
    console.log(id);
    console.log(this.selectedType);

    this.selectedType = null;
    for (var i = 0; i < this.organTypes.length; i++) {
      if (this.organTypes[i].id == id) {
        this.selectedType = this.organTypes[i];
      }
    }
  }
  findByOrgan(id) {
    console.log(id);
    this.transplantRequests = [];
    if (!isNaN(id)) {
      this.tSvc.showOrganType(id).subscribe(
        data => {
          this.transplantRequests = data;
        },
        fail => {
          console.error('TRListComponent.reload(): error getting patients');
          console.error(fail);
        }
      );
    }
    else {
      this.router.navigateByUrl('invalidId');
    }
    // this.id = null;
    this.filtered = true;

  }
  displayTable(): void {
    this.selected = null;
    this.loadTransplantRequest();
    this.filtered =false;
  }
  setDonor(p){
    this.patientToAdd = p;
    this.selected.donor=this.patientToAdd;
    this.selected.approvalStatus = 'pending';
    this.updateTransplantRequest(this.selected);
 }
 chooseBackground(tr) {

  if (tr.approvalStatus == 'denied') {
    return 'denied';
  } else if (tr.approvalStatus == 'pending') {
    return 'pending';
  } else if(tr.approvalStatus == 'approved'){
    return 'approved';
  }
}
findByDonorIsNull(){
  this.tSvc.indexDonorIsNull().subscribe(
    data=>{
        data.forEach(tr =>{
         const p : Patient = new Patient();
         Object.assign(p, tr.recipient);
         tr.recipient = p;
        })

      this.transplantRequests=data;
    console.log('TransplantRequestListComponent.loadTransplantRequest(): transplantRequest retrieved');
    },

    err=>{
      console.error('TransplantRequestListComponent.loadTransplantRequest(): retreive failed');
console.log(err);

    });


}
}
