
import { TransplantType } from './../../models/transplant-type';
import { PatientService } from './../../services/patient.service';
import { Component, OnInit } from '@angular/core';
import { Patient } from 'src/app/models/patient';
import { TransplantRequest } from 'src/app/models/transplant-request';
import { TransplantRequestService } from 'src/app/services/transplant-request.service';
import { Router } from '@angular/router';
import { NgbModal, ModalDismissReasons } from '@ng-bootstrap/ng-bootstrap';

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
  organTypes: TransplantType[] = [
    new TransplantType(1, 'bonemarrow'),
    new TransplantType(2, 'kidney'),
    new TransplantType(3, 'liver'),
  ];
  selectedType = this.organTypes[0];
  filtered = false;
  patientToAdd =new Patient()
  approvalStatus =  ['pending', 'approved', 'denied']
  status=null;
  review : TransplantRequest= null;
  closeResult: string;


  constructor(
    private tSvc: TransplantRequestService,
    private patientService: PatientService,
    private router: Router,
    private modalService: NgbModal) { }

  ngOnInit(): void {
    this.loadTransplantRequest();
    // this.averageDuration();
  }

  adminActive(): boolean {
    return localStorage.getItem('userRole') === 'admin' ;

  }

  approved(): boolean {
    return this.selected.approvalStatus === 'approved';
  }

  loadTransplantRequest(): void {
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
      this.filtered=false;
      this.viableDonors=null;

  }
  loadByApprovalStatus(status){
    this.tSvc.indexByApprovalStatus(status).subscribe(
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
      this.filtered = true;

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
  selectStatus(status: string) {


    this.selectedType = null;
    for (var i = 0; i < this.organTypes.length; i++) {
      if (this.approvalStatus[i] == status) {
        this.status = this.approvalStatus[i];
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
    this.selectedType =null;

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
 chooseDonor(hla : number) {

  if (hla == 6) {
    return 'approved';
  } else if (hla == 5) {
    return 'pending';
  } else if(hla < 5){
    return 'denied';
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
this.filtered = true;

}
open(content, tRequest) {
  this.review= tRequest;
  console.log(this.review);
  this.modalService.open(content, { ariaLabelledBy: 'modal-basic-title' }).result.then((result) => {
    this.closeResult = `Closed with: ${result}`;
  }, (reason) => {
    this.closeResult = `Dismissed ${this.getDismissReason(reason)}`;
  });
}
private getDismissReason(reason: any): string {
  if (reason === ModalDismissReasons.ESC) {
    return 'by pressing ESC';
  } else if (reason === ModalDismissReasons.BACKDROP_CLICK) {
    return 'by clicking on a backdrop';
  } else {
    return `with: ${reason}`;
  }
}
onSubmit(tr : TransplantRequest, id: number) {
  this.review.approvalStatus = this.status;
  this.tSvc.update(tr).subscribe(
    data => {
      this.loadTransplantRequest();
    },
    err => console.error('Observer got an error: ' + err)
    );

    this.modalService.dismissAll(); //dismiss the modal


}
setStatus(status){
  this.selectedType = null;
    for (var i = 0; i < this.organTypes.length; i++) {
      if (this.approvalStatus[i] == status) {
        this.status = this.approvalStatus[i];
      }
    }
}
}
