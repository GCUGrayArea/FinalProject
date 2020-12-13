import { TransplantType } from './../models/transplant-type';
import { environment } from './../../environments/environment';
import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, throwError } from 'rxjs';
import { catchError, tap } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class TransplantTypeService {

  constructor( private http: HttpClient ) { }

  create( donorId: number , ttId: number ): Observable<TransplantType> {
    console.log( donorId + " , " + ttId );
    return this.http.post<TransplantType>( environment.baseUrl + 'api/donor/' + donorId + '/transtype/' + ttId, null )
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('DONOR ROLE CREATION FAILED');
        })
      );
  }

  delete( donorId: number , ttId: number ): Observable<boolean> {
    console.log( donorId + " , " + ttId );
    return this.http.delete<boolean>( environment.baseUrl + 'api/donor/' + donorId + '/transtype/' + ttId )
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('DONOR ROLE DELETION FAILED');
        })
      );
  }

  index(): Observable<TransplantType[]> {

    return this.http.get<TransplantType[]>( environment.baseUrl + 'api/transtype' ).pipe(
      tap((res) => {
        //localStorage.setItem('credentials' , credentials);
        return res;
      }),
      catchError((err: any) => {
        console.log(err);
        return throwError('TransplantTypeService.index(): Error retrieving patient list');
      })
    );
  }

}
