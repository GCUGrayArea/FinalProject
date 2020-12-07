export class Address {

  id: number;
  street1: String;
  street2: String;
  city: String;
  state: String;
  zip: String;


 constructor(
  id?: number,
  street1?: String,
  street2?: String,
  city?: String,
  state?: String,
  zip?: String){

    this.id= id;
    this.street1= street1;
    this.street2 =street2;
    this.city= city;
    this.state=  state;
    this.zip= zip;
 }
}
