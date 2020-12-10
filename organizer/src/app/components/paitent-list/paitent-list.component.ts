import { HlaService } from './../../services/hla.service';
import { AddressService } from './../../services/address.service';
import { BloodType } from './../../models/blood-type';
import { Router } from '@angular/router';
import { PatientService } from './../../services/patient.service';
import { Component, OnInit } from '@angular/core';
import { Patient } from 'src/app/models/patient';
import { NgbModal, ModalDismissReasons } from '@ng-bootstrap/ng-bootstrap';
import { Address } from 'src/app/models/address';
import { Hla } from 'src/app/models/hla';
import { ProteinClass } from 'src/app/models/protein-class';

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
  newPatient = new Patient();
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
  newAddress = new Address();
  editAddress = new Address();
  hla: Hla[];
  selectedHla : Hla = new Hla();
  proteinClasses = [ "A" , "B" , "C" , "D" , "E" , "F" ];

  constructor(private patientService: PatientService, private router: Router, private modalService: NgbModal, private addressService: AddressService, private hlaService: HlaService ) { }

  ngOnInit(): void {
    this.reload();

  }
  initHla() {
    this.hla = [];
    for (let i = 0; i < 6; i++) {
      let hla = new Hla();
      hla.proteinClass = new ProteinClass(i + 1);
      hla.allele = 1;
      this.hla.push(hla);
    }
  }

  arrayZeroToFive() {
    return Array.from({length: 6}, (x, i) => i);
  }


  setProteinClassValue( position: number , value: number ) {
    console.log(position + "," + value);
    this.hla[position].allele = value;
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
    this.filtered = false;
  }
  selectBloodType(id , patient: Patient ) {
    // console.log(id);
    patient.bloodType = this.bloodTypes[id - 1];
  }


  open(content) {

    Object.assign(this.editPatient, this.selected)
    Object.assign(this.editAddress, this.selected.address)
    this.modalService.open(content, { ariaLabelledBy: 'modal-basic-title' }).result.then((result) => {
      this.closeResult = `Closed with: ${result}`;
    }, (reason) => {
      this.closeResult = `Dismissed ${this.getDismissReason(reason)}`;
    });
  }
  openCreate(content) {
    this.initHla()
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
  onSubmit(patient: Patient, address: Address, hlaList: Hla[] ) {

  //Nested calls required to ensure that requests occur one after the other,
  //iff the previous one (on which it depends) succeeded. Patient POST guaranteed
  //not to work anyway if address POST hasn't happened, and HLA POST guaranteed to fail
  //if patient POST hasn't already happened. Requests *need* to happen in order, and
  //without nesting the second and third start before the first has finished.

  //First call, posts new address record
    this.addressService.create(address).subscribe(
      data => {
        patient.address = data;
        //Second call, after creating address, posts updated patient
        //so address is non-null
        this.patientService.create(patient).subscribe(
          data1 => {
            // this.reload();
            patient = data1;
            //Third and final call: if patient POST succeeded POSTS their
            //HLA records to server and associates them with patient
            this.hlaService.createList( hlaList , patient.id ).subscribe(
              data2 => {
                this.newPatient.hlaProteins = data2;
              } ,
              err2 => { console.error('Observer got an error: ' + err2 ); }
            );
          },
          err1 => console.error('Observer got an error: ' + err1)
        );
      },
      err => console.error('Observer got an error: ' + err)
    );

    console.log(patient);

    this.modalService.dismissAll(); //dismiss the modal
    this.newPatient = new Patient();
  }

  updatePatient(patient: Patient) {

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
    this.editPatient = new Patient();

  }
  updateAddress(address: Address, id: number, patient: Patient) {

    this.addressService.update(address, id).subscribe(
      (good) => {
        this.reload();
        this.selected = Object.assign({}, patient);
        this.selected.address = this.editAddress;
        this.editAddress = new Address();

      },
      (bad) => {
        console.error(bad);
      }
    );
    this.modalService.dismissAll(); //dismiss the modal

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
    this.selected = null;
  }

}

