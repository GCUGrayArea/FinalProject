import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TransplantRequestListComponent } from './transplant-request-list.component';

describe('TransplantRequestListComponent', () => {
  let component: TransplantRequestListComponent;
  let fixture: ComponentFixture<TransplantRequestListComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ TransplantRequestListComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(TransplantRequestListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
