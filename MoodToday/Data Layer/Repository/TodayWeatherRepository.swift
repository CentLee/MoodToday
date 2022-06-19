//
//  TodayWeatherRepository.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/06.
//

import Foundation
import Moya
import RxMoya
import RxSwift

final class TodayWeatherRepository: TodayWeatherRepositoryInterface {
  
  let provider = MoyaProvider<WeatherAPI>()
  
  func fetchTodayWeather(requestValue: FetchTodayWeatherRequestValue) -> Observable<TodayWeatherEntity> {
    return
      provider.rx.request(.todayWeather(requestValue.gridX, requestValue.girdY,
                                        requestValue.currentTime, requestValue.currentDate))
      .map { response -> TodayWeatherEntity in
        
        let decoder = JSONDecoder()
        iPrint(requestValue.currentTime)
        guard !response.data.isEmpty else { return TodayWeatherEntity.init(weatherList: []) }
        var data = try decoder.decode(WeatherResponseDTO.self, from: response.data).toDomain()
//        data.weatherList = data.weatherList.filter { $0.fcstDate >= requestValue.currentDate || $0.fcstTime >= requestValue.currentTime }
        return data

      }.asObservable()
  }
}
