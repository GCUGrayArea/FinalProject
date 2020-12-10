import { environment } from './../../environments/environment';
import { TransplantRequest } from 'src/app/models/transplant-request';
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

private url = environment.baseUrl + 'api/patients';


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
indexViableDonors(tr: TransplantRequest): Observable<Patient[]> {

  return this.http.get<Patient[]>(`${this.url}/transplant-type/${tr.organType.organ}/blood-type/${tr.recipient.bloodType.id}`).pipe(
    // tap((res) => {
    //   //localStorage.setItem('credentials' , credentials);
    //  return res;
    // }),
    catchError((err: any) => {
      console.log(err);
      return throwError('PatientService.index(): Error retrieving todo list');
    })
  );
}


show(id : number): Observable<Patient>{
    // const credentials= this.authService.getCredentials();
    // const httpOptions = {
    //   headers: new HttpHeaders({
    //      'Authorization': `Basic ${credentials}`,
    //      'X-Requested-With': 'XMLHttpRequest'
    //    })
    //   };
    //   if(!this.authService.checkLogin()){
    //     this.router.navigateByUrl('login')
    //   }
    return this.http.get<Patient>(`${this.url}/${id}`).pipe(
      tap((res) => {
        //localStorage.setItem('credentials' , credentials);
        return res;
      }),
      catchError((err: any) => {
        console.log(err);
        return throwError('TodoService.index(): Error retrieving todo list');
      })
    );
  }
showByBloodTypeId(id : number): Observable<Patient[]>{
    // const credentials= this.authService.getCredentials();
    // const httpOptions = {
    //   headers: new HttpHeaders({
    //      'Authorization': `Basic ${credentials}`,
    //      'X-Requested-With': 'XMLHttpRequest'
    //    })
    //   };
    //   if(!this.authService.checkLogin()){
    //     this.router.navigateByUrl('login')
    //   }
    return this.http.get<Patient[]>(`${this.url}/blood-type/${id}`).pipe(
      tap((res) => {
        //localStorage.setItem('credentials' , credentials);
        return res;
      }),
      catchError((err: any) => {
        console.log(err);
        return throwError('TodoService.index(): Error retrieving todo list');
      })
    );
  }

  create(data): Observable<Patient> {
    console.log(data)
    return this.http.post<Patient>(this.url, data)
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('KABOOM');
        })
      );
  }

}
