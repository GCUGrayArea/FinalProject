export class User {
  firstName: string;
  lastName: string;
  username: string;
  password: string;
  role: string

  constructor(
    firstName?: string ,
    lastName?: string ,
    username?: string ,
    password?: string ,
    role?: string
  ) {
    this.username = username;
    this.password = password;
    this.role = role;
  }
}
