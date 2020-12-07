import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PaitentListComponent } from './components/paitent-list/paitent-list.component';

const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'patientList'},
  { path: 'patientList', component: PaitentListComponent },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
