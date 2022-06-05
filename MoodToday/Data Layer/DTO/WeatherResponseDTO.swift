//
//  WeatherResponseDTO.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/05.
//

import Foundation


struct WeatherResponseDTO: Decodable {
  
  var currentDate: String
  var currentTime: String
  var weatherList: [WeatherDTO]
}

extension WeatherResponseDTO {
  struct WeatherDTO: Decodable {
    var category: String
    var baseDate: String
    var baseTime: String
    var fcstDate: String
    var fcstTime: String
    var fcstValue: String
  }
  func toDomain() {
    //시간별 데이터가 고정값이 카테고리별로 1개씩 총 12개 존재한다.
    //12개씩 끊어서 배열로 기상데이터를 만들어서 엔티티로 값을 전달한다.
    //return .init()
  }
}

