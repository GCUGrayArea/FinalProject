import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { throwError, Observable } from 'rxjs';
import { catchError, tap } from 'rxjs/operators';
import { environment } from 'src/environments/environment';
import { Address } from '../models/address';

@Injectable({
  providedIn: 'root'
})
export class AddressService {

  private url = environment.baseUrl + 'api/address';

  constructor( private http : HttpClient ) { }

  show(id : number): Observable<Address>{
    return this.http.get<Address>(`${this.url}/${id}`).pipe(
      tap((res) => {
        return res;
      }),
      catchError((err: any) => {
        console.log(err);
        return throwError('TodoService.index(): Error retrieving todo list');
      })
    );
  }

  create(data): Observable<Address> {
    console.log(data)
    return this.http.post<Address>(this.url, data)
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('KABOOM');
        })
      );
  }
}
