//
//  UpdateUserLocationUseCase.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/14.
//

import Foundation
import RxSwift

protocol UpdateUserLocationUseCaseInterface {
  func execute() -> Observable<Bool>
}

final class UpdateUserLocationUseCase: UpdateUserLocationUseCaseInterface {

  let repository: UserLocationRepositoryInterface
  
  public init(repository: UserLocationRepositoryInterface) {
    self.repository = repository
  }
  
  func execute() -> Observable<Bool> {
    repository.updateUserLocation()
  }
}
