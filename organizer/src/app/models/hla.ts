import { Patient } from 'src/app/models/patient';
import { ProteinClass } from './protein-class';

export class Hla {
  id: number;
  patient: Patient;
  proteinClass: ProteinClass;
  allele: number;

  constructor(
    id?: number ,
    patient?: Patient ,
    proteinClass?: ProteinClass ,
    allele?: number
  ) {
    this.id = id;
    this.patient = patient;
    this.proteinClass = proteinClass;
    this.allele = allele;
  }
}
