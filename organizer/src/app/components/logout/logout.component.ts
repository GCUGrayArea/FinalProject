import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
  selector: 'app-logout',
  templateUrl: './logout.component.html',
  styleUrls: ['./logout.component.css']
})
export class LogoutComponent implements OnInit {

  constructor( private router: Router ) {  }

  logout(): void {
    localStorage.removeItem('credentials');
    localStorage.removeItem('userRole');
    this.router.navigateByUrl('home');
  }

  ngOnInit(): void {
  }

}
