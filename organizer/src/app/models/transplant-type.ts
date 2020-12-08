export class TransplantType {
  id: number;
  organ: string;

  constructor(
    id?: number ,
    organ?: string
  ) {
    this.id = id;
    this.organ = organ;
  }
}
