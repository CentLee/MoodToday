//
//  WeatherResponseDTO.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/05.
//

import Foundation

struct WeatherResponseDTO: Decodable {
  
  
  func toDomain() -> TodayWeatheEntity {
    return .init()
  }
}
