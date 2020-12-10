import { TestBed } from '@angular/core/testing';

import { HlaService } from './hla.service';

describe('HlaService', () => {
  let service: HlaService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(HlaService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
