//
//  WeatherResponseDTO.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/05.
//

import Foundation


struct WeatherResponseDTO: Decodable {
  var response: WeatherJSONResponseDTO
}

extension WeatherResponseDTO {
  struct WeatherJSONResponseDTO: Decodable {
    var header: WeatherJSONHeader
    var body: WeatherJSONBody
  }
  
  struct WeatherJSONHeader: Decodable {
    var resultCode: String
    var resultMsg: String
  }
  
  struct WeatherJSONBody: Decodable {
    var dataType: String
    var items: WeatherItemsDTO
  }
  
  struct WeatherItemsDTO: Decodable {
    var item: [WeatherDTO]
  }
  
  struct WeatherDTO: Decodable {
    var category: String
    var baseDate: String
    var baseTime: String
    var fcstDate: String
    var fcstTime: String
    var fcstValue: String
    
    func toDomain() -> Weather {
      return .init(category: category, baseDate: baseDate, baseTime: baseTime,
                   fcstDate: fcstDate, fcstTime: fcstTime, fcstValue: fcstValue)
    }
  }
  
  func toDomain() -> TodayWeatherEntity {
    return .init(weatherList: self.response.body.items.item.map { $0.toDomain() })
  }
}
