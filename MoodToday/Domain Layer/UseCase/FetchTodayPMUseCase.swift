//
//  FetchTodayPMUseCase.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/19.
//

import Foundation
import RxSwift

protocol FetchTodayPMUseCaseInterface {
  func execute(stationName: String) -> Observable<TodayParticularMatterEntity>
}

//struct FetchTodayPMRequestValue {
//  let currentLocation: String
//}


final class FetchTodayPMUseCase: FetchTodayPMUseCaseInterface {
  private let repository: TodayParticularMatterRepositoryInterface
  
  public init(repository: TodayParticularMatterRepositoryInterface) {
    self.repository = repository
  }
  
  func execute(stationName: String) -> Observable<TodayParticularMatterEntity> {
    repository.fetchTodayParticularMatter(stationName: stationName)
  }
}

