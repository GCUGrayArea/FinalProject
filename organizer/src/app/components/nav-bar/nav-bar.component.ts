import { Component, OnInit} from '@angular/core';

@Component({
  selector: 'app-nav-bar',
  templateUrl: './nav-bar.component.html',
  styleUrls: ['./nav-bar.component.css']
})
export class NavBarComponent implements OnInit {
  isCollapsed : boolean = true;

  constructor() { }

  loggedIn(): boolean {
    return localStorage.getItem('credentials') ? true : false;
  }

  ngOnInit(): void {
  }

}
