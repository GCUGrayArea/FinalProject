import { ComponentFixture, TestBed } from '@angular/core/testing';

import { TransplantRequestComponent } from './transplant-request.component';

describe('TransplantRequestComponent', () => {
  let component: TransplantRequestComponent;
  let fixture: ComponentFixture<TransplantRequestComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ TransplantRequestComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(TransplantRequestComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
