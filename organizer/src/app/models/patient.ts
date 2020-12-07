import { Address } from './address';
import { BloodType } from './blood-type';
export class Patient {

	  id: number;
    firstName: String;
	 lastName: String;
	 birthDate: String;
	 sex: String;
	 weightKg: number;
	 bloodType: BloodType;
	 address: Address;
   // List<TransplantType> transplantTypes;

   constructor(
     id?: number,
     firstName?: String,
     lastName?: String,
     birthDate?: String,
     sex?: String,
     weightKg?: number,
     bloodType?: BloodType,
     address?:Address){


    this.id= id,
    this.firstName= firstName,
	 this.lastName= lastName ,
	 this.birthDate= birthDate ,
	 this.sex= sex,
   this.weightKg= weightKg,
   this.bloodType= bloodType,
   this.address= address
   }
}
