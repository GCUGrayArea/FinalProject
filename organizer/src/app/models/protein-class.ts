export class ProteinClass {
  id: number;
  proteinClass: string;
  description: string;

  constructor(
    id?: number ,
    proteinClass?: string ,
    description?: string
  ) {
    this.id = id;
    this.proteinClass = proteinClass;
    this.description = description;
  }
}
