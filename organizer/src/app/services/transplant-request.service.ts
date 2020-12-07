import { TransplantRequest } from './../models/transplant-request';
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { catchError } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class TransplantRequestService {
 private baseUrl = 'http://localhost:8192/';
    // private baseUrl = 'BookingsTracker/';
     // private baseUrl = 'BookingsTracker/';
    //  private baseUrl =environment.baseUrl;

  private url = this.baseUrl + 'api/transplant';

 index(): Observable<TransplantRequest[]> {
    return this.http.get<TransplantRequest[]>(this.url )
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('retrieval failed');
        })
      );
  }

  create(data: TransplantRequest): Observable<TransplantRequest> {
    return this.http.post<TransplantRequest>(this.url, data)
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('retrieval failed');
        })
      );
  }
  update(transplantRequest: TransplantRequest) {
    const httpOptions = {
      headers: {
        'Content-type': 'application/json'
      }
    };
    return this.http.put<TransplantRequest[]>(this.url + '/' + transplantRequest.id, transplantRequest, httpOptions).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('Transplant Service: Error retrieving todo list');
      })
    );
  }


  destroy(transplantRequestId: number): Observable<boolean> {
    return this.http.delete<boolean>(`${this.url}/${transplantRequestId}`).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('transplantService.destroy(): Error deleting todo');
      })
    );
  }

  constructor(
    private http: HttpClient
    //make sure client from @angular/common/http
    ) { }
}
