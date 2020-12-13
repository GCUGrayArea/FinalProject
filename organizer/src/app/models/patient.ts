import { TransplantType } from './transplant-type';
import { Address } from './address';
import { BloodType } from './blood-type';
import { Hla } from './hla';
export class Patient {

	id: number;
  firstName: String;
	lastName: String;
	birthDate: String;
	sex: String;
	weightKg: number;
	bloodType: BloodType;
	address: Address;
  transplantTypes: TransplantType[];
  hlaProteins: Hla[];


  constructor(
     id?: number,
     firstName?: String,
     lastName?: String,
     birthDate?: String,
     sex?: String,
     weightKg?: number,
     bloodType?: BloodType,
     address?:Address ,
     transplantTypes?: TransplantType[]) {
  this.id= id;
  this.firstName= firstName;
	this.lastName= lastName ;
	this.birthDate= birthDate ;
	this.sex= sex;
  this.weightKg= weightKg;
  this.bloodType= bloodType;
  this.address= address;
  this.transplantTypes = transplantTypes;
  }

  hlaCompatibility( donor: Patient ): number {
    let matches: number = 0;
    for ( let hla of this.hlaProteins ) {
      for ( let otherHla of donor.hlaProteins ) {
      console.log(hla.proteinClass.id);
      console.log(otherHla.proteinClass.id);
      console.log(hla.allele);
      console.log(otherHla.allele);
        if ( hla.proteinClass.id === otherHla.proteinClass.id && hla.allele === otherHla.allele ) {
          matches++;
          break;
        }
      }
    }
    console.log(matches);
    return matches;
  }

  public sortDonorsByHlaCompatibility( donors: Patient[] ): Patient[] {
    return donors.sort(
      ( a , b ) => {
        return (( this.hlaCompatibility(a) < this.hlaCompatibility(b) ) ? 1 : ( this.hlaCompatibility(a) > this.hlaCompatibility(b) ) ? -1 : 0);
      }
    )
  }
}
