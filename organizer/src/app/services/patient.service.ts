import { Patient } from './../models/patient';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError, tap } from 'rxjs/operators';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class PatientService {

  constructor(private http : HttpClient) { }

  private baseUrl = 'http://localhost:8192/';
private url = this.baseUrl + 'api/patients';


index(): Observable<Patient[]> {

  return this.http.get<Patient[]>(this.url + '/all').pipe(
    tap((res) => {
      //localStorage.setItem('credentials' , credentials);
      return res;
    }),
    catchError((err: any) => {
      console.log(err);
      return throwError('PatientService.index(): Error retrieving todo list');
    })
  );
}
}
