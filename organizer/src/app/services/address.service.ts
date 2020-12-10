import { AuthService } from './auth.service';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { throwError, Observable } from 'rxjs';
import { catchError, tap } from 'rxjs/operators';
import { environment } from 'src/environments/environment';
import { Address } from '../models/address';
import { Router } from '@angular/router';

@Injectable({
  providedIn: 'root'
})
export class AddressService {

  private url = environment.baseUrl + 'api/address';

  constructor( private http : HttpClient, private authService :AuthService, private router: Router ) { }

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
  update(address: Address, id: number) {
    const httpOptions = {
      headers: {
        'Content-type': 'application/json'
      }
    };
    return this.http.put<Address>(this.url + '/' + id, address, httpOptions).pipe(
      catchError((err: any) => {
        console.log(err);
        return throwError('PatientService: Error updating patient');
      })
    );
  }

  create(data): Observable<Address> {
    console.log(data)
    const credentials= this.authService.getCredentials();
    const httpOptions = {
      headers: new HttpHeaders({
         'Authorization': `Basic ${credentials}`,
         'X-Requested-With': 'XMLHttpRequest'
       })
      };
      if(!this.authService.checkLogin()){
        this.router.navigateByUrl('login')
      }
    return this.http.post<Address>(this.url, data, httpOptions)
      .pipe(
        catchError((err: any) => {
          console.log(err);
          return throwError('KABOOM');
        })
      );
  }
}
