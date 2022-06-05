//
//  TodayWeatherEntity.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/05.
//

import Foundation

struct TodayWeatherEntity {
  
  //현재 날씨 요청 시각
  var currentDate: String
  var currentTime: String
  var weatherList: [Weather]
}

extension TodayWeatherEntity {
  struct Weather {
    var category: String
    var baseDate: String
    var baseTime: String
    var fcstDate: String
    var fcstTime: String
    var fcstValue: String
  }
}

