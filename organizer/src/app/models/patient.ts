import { BloodType } from './blood-type';
export class Patient {

	  id: number;
    firstName: String;
	 lastName: String;
	 birthDate: String;
	 sex: String;
	 weightKg: number;
	 bloodType: BloodType;
   // Address address;
   // List<TransplantType> transplantTypes;

   constructor(
     id?: number,
     firstName?: String,
     lastName?: String,
     birthDate?: String,
     sex?: String,
     weightKg?: number,
     bloodType?: BloodType){


    this.id= id,
    this.firstName= firstName,
	 this.lastName= lastName ,
	 this.birthDate= birthDate ,
	 this.sex= sex,
   this.weightKg= weightKg,
   this.bloodType= bloodType
   }
}
