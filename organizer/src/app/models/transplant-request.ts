import { Patient } from './patient';

export class TransplantRequest {
  id: number;
  recipient: Patient;
  donor: Patient;
  //  organType: TransplantType;
  createdAt: String;


  constructor(
    id?: number,
    recipient?: Patient,
    donor?: Patient,
    //  organType: TransplantType;
    createdAt?: String) {

    this.id = id;
    this.recipient = recipient;
    this.donor = donor;
    //  organType: TransplantType;
    this.createdAt = createdAt;
  }
}


