import { Patient } from './patient';
import { TransplantType } from './transplant-type';

export class TransplantRequest {
  index() {
    throw new Error('Method not implemented.');
  }
  create(addedRequest: TransplantRequest) {
    throw new Error('Method not implemented.');
  }
  update(transplantRequest: TransplantRequest) {
    throw new Error('Method not implemented.');
  }
  destroy(id: any) {
    throw new Error('Method not implemented.');
  }
  id: number;
  recipient: Patient;
  donor: Patient;
   organType: TransplantType;
  createdAt: String;
  approvalStatus: string;


  constructor(
    id?: number,
    recipient?: Patient,
    donor?: Patient,
     organType?: TransplantType,
    createdAt?: String,
    approvalStatus?: string
    ) {

    this.id = id;
    this.recipient = recipient;
    this.donor = donor;
     this.organType= organType;
    this.createdAt = createdAt;
    this.approvalStatus= approvalStatus;

  }
}


