import { TransplantRequestListComponent } from './components/transplant-request-list/transplant-request-list.component';
import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PaitentListComponent } from './components/paitent-list/paitent-list.component';

const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'patient' },
  { path: 'transplantRequest', component: TransplantRequestListComponent },
  { path: 'patient', component: PaitentListComponent },
  // { path: '**', component: ErrorComponent }

];

@NgModule({
  imports: [RouterModule.forRoot(routes, {useHash: true})],
  exports: [RouterModule]
})
export class AppRoutingModule { }
