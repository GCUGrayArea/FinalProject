import { TestBed } from '@angular/core/testing';

import { TransplantTypeService } from './transplant-type.service';

describe('TransplantTypeService', () => {
  let service: TransplantTypeService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(TransplantTypeService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
