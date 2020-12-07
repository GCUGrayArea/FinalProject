export class BloodType {
  id: number;
  bloodGroup: String;
 rh: boolean;

// Address address;
// List<TransplantType> transplantTypes;

constructor(
  id?: number,
  bloodGroup?: String,
 rh?: boolean){

  this.id= id,
  this.bloodGroup= bloodGroup;
 this.rh= rh;
 }
}
