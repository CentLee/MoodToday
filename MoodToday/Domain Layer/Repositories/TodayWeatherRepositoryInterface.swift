//
//  TodayWeatherRepositoryInterface.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/06.
//

import Foundation
import RxSwift

protocol TodayWeatherRepositoryInterface {
  func fetchTodayWeather(requestValue: FetchTodayWeatherRequestValue) -> Observable<TodayWeatherEntity>
}
