import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.css']
})
export class RegisterComponent implements OnInit {

  user: User = new User();

  constructor( private authService: AuthService , private router: Router ) { }
  ngOnInit(): void {
  }
  register( user: User ) {
    this.authService.register(user).subscribe(
      (good) => {
        this.authService.login(user.username , user.password).subscribe(
          (data) => {
            console.log("LOGIN SUCCESSFUL")
            this.router.navigateByUrl('todo');
          } ,
          (err) => {
            console.error("LOGIN FAILED");
            console.error(err);

          }

        )
      } ,
      (bad) => {
        console.error("REGISTRATION FAILED");
        console.error(bad);

      }
    );
  }
}
