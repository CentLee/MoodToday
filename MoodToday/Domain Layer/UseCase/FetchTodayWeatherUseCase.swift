//
//  FetchTodayWeatherUseCase.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/06.
//

import Foundation
import RxSwift

protocol FetchTodayWeatherUseCaseInterface {
  func execute(requestValue: FetchTodayWeatherRequestValue) -> Observable<TodayWeatherEntity>
}

struct FetchTodayWeatherRequestValue {
  let currentTime: String
  let currentDate: String
  let gridX: String
  let girdY: String
}


final class FetchTodayWeatherUseCase: FetchTodayWeatherUseCaseInterface {
  private let repository: TodayWeatherRepositoryInterface
  
  public init(repository: TodayWeatherRepositoryInterface) {
    self.repository = repository
  }
  
  func execute(requestValue: FetchTodayWeatherRequestValue) -> Observable<TodayWeatherEntity> {
    repository.fetchTodayWeather(requestValue: requestValue)
  }
}
