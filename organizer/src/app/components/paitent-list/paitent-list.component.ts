import { AddressService } from './../../services/address.service';
import { BloodType } from './../../models/blood-type';
import { Router } from '@angular/router';
import { PatientService } from './../../services/patient.service';
import { Component, OnInit } from '@angular/core';
import { Patient } from 'src/app/models/patient';
import { NgbModal, ModalDismissReasons } from '@ng-bootstrap/ng-bootstrap';
import { Address } from 'src/app/models/address';

@Component({
  selector: 'app-paitent-list',
  templateUrl: './paitent-list.component.html',
  styleUrls: ['./paitent-list.component.css']
})
export class PaitentListComponent implements OnInit {
  closeResult: string;
  patients: Patient[] = [];
  selected = null;
  id = null;
  newPatient= new Patient();
  bloodTypes: BloodType[] = [
    new BloodType(1, 'A', true),
    new BloodType(2, 'A', false),
    new BloodType(3, 'B', true),
    new BloodType(4, 'B', false),
    new BloodType(5, 'X', true),
    new BloodType(6, 'X', false),
    new BloodType(7, 'O', true),
    new BloodType(8, 'O', false)
  ];
  selectedType = new BloodType();
  filtered = false;
  editPatient = new Patient();
  newAddress= new Address();

  constructor(private patientService: PatientService, private router: Router, private modalService: NgbModal, private addressService: AddressService) { }

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




  loggedIn(): boolean {
    return localStorage.getItem('credentials') ? true : false;
  }

  adminActive(): boolean {
    return localStorage.getItem('userRole') === 'admin';
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
  open(content) {
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
  onSubmit(patient : Patient, address: Address) {
    this.addressService.create(address).subscribe(
      data =>{
        this.newAddress = data;
      },
      err => console.error('Observer got an error: ' + err)
      )
      this.newPatient.address = this.newAddress;
      this.patientService.create(patient).subscribe(
        data => {
          this.reload();
        },
        err => console.error('Observer got an error: ' + err)
        );

      this.modalService.dismissAll(); //dismiss the modal
      this.newPatient = new Patient();

  }

  updatePatient(patient: Patient) {
    // this.todos[todo.id - 1] = Object.assign({}, todo);
    // this.selected = Object.assign({}, todo);
    this.patientService.update(patient, this.selected.id).subscribe(
      (good) => {
        this.reload();
        if (this.selected != null) {
          this.selected = Object.assign({}, patient);
        }
      },
      (bad) => {
        console.error(bad);
      }
    );
    this.modalService.dismissAll(); //dismiss the modal
    this.editPatient = null;
  }

  openDelete(targetModal, patient: Patient) {
    this.modalService.open(targetModal, {
      backdrop: 'static',
      size: 'lg'
    });
  }

  deletePatient(id: number) {
    this.patientService.destroy(id).subscribe(
      (good) => {
        this.reload();
      },
      (bad) => {
        console.error(bad);
      }
    );
    this.selected=null;
  }

setNewPatientBloodType(){
  this.newPatient.bloodType= this.selectedType;
}

setEditPatientBloodType(){
  this.editPatient.bloodType= this.selectedType;
}
}

