import { TestBed } from '@angular/core/testing';

import { TransplantRequestService } from './transplant-request.service';

describe('TransplantRequestService', () => {
  let service: TransplantRequestService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(TransplantRequestService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
