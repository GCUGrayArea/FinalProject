export class Patient {

	  id: number;
    firstName: String;
	 lastName: String;
	 birthDate: String;
	 sex: String;
	 weightKg: number;
	// BloodType bloodType;
	// Address address;
	// List<TransplantType> transplantTypes;

  constructor(
    id?: number,
    firstName?: String,
	 lastName?: String,
	 birthDate?: String,
	 sex?: String,
	 weightKg?: number){

    this.id= id,
    this.firstName= firstName,
	 this.lastName= lastName ,
	 this.birthDate= birthDate ,
	 this.sex= sex,
	 this.weightKg= weightKg
   }
}
