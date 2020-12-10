import { TransplantRequest } from './../models/transplant-request';
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, throwError } from 'rxjs';
import { catchError, tap } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class TransplantRequestService {
 private baseUrl = 'http://localhost:8192/';


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
 indexByApprovalStatus(status: string): Observable<TransplantRequest[]> {
    return this.http.get<TransplantRequest[]>(this.url + '/status/'+ status)
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
  update(transplantRequest: TransplantRequest, ) {
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
  showOrganType(id : number): Observable<TransplantRequest[]>{
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
    return this.http.get<TransplantRequest[]>(`${this.url}/organ/${id}`).pipe(
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
  indexDonorIsNull(): Observable<TransplantRequest[]> {
    return this.http.get<TransplantRequest[]>(this.url + '/unmatched'  )
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('retrieval failed');
        })
      );
  }

  constructor(
    private http: HttpClient
    //make sure client from @angular/common/http
    ) { }
}
