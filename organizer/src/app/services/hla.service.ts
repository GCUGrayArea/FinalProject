import { environment } from './../../environments/environment';
import { Injectable } from '@angular/core';
import { Hla } from '../models/hla';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class HlaService {

  constructor( private http : HttpClient ) { }

  postUrlForPatient( patientId: number ) {
    return environment.baseUrl + 'api/patients/' + patientId + '/hla';
  }

  create(data, patientId: number ): Observable<Hla> {
    console.log(data)
    return this.http.post<Hla>( this.postUrlForPatient( patientId ) , data)
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('HLA RECORD CREATION FAILED');
        })
      );
  }

  createList(data, patientId: number ): Observable<Hla> {
    console.log(data)
    return this.http.post<Hla>( this.postUrlForPatient( patientId ) + '/all' , data)
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('HLA CREATION FAILED');
        })
      );
  }

}
