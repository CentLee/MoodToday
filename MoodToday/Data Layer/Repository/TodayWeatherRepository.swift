//
//  TodayWeatherRepository.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/06.
//

import Foundation
import Moya
import RxMoya

final class TodayWeatherRepository: TodayWeatherRepositoryInterface {
  
  let provider = MoyaProvider<WeatherAPI>()
  
  func fetchTodayWeather(requestValue: FetchTodayWeatherRequestValue) {
//    provider.rx.request(.todayWeather(requestValue.gridX, requestValue.girdY,
//                                      requestValue.currentTime, requestValue.currentDate))
//    .subscribe { event in
//      switch event {
//      case .success(let response):
//        break
//      case .failure(let error):
//        print(error.localizedDescription)
//      }
//    }
    
  }
}
