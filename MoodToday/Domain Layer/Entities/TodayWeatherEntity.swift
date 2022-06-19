//
//  TodayWeatherEntity.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/05.
//

import Foundation

struct TodayWeatherEntity {
  var weatherList: [Weather]
  
  init(weatherList: [Weather] = []) {
    self.weatherList = weatherList
  }
}

struct Weather {
  var category: String
  var baseDate: String
  var baseTime: String
  var fcstDate: String
  var fcstTime: String
  var fcstValue: String
  
  
  
  func totalWindDirection() -> String {
    var direction: String = ""
    if category == "VEC" {
      let value = Int(floor(((Double(fcstValue)! + 22.5 * 0.5) / 22.5)))
      direction = WindDirection(rawValue: value)!.toWindDirection()
    }
    return direction
  }
}

enum WindDirection: Int {

  case NN = 0
  case NNE
  case NE
  case ENE
  case EE
  case ESE
  case SE
  case SSE
  case SS
  case SSW
  case SW
  case WSW
  case WW
  case WNW
  case NW
  case NNW
  case NNNN = 16
  
  func toWindDirection() -> String {
    switch self {
    case .NN, .NNNN:
      return "남"
    case .NNE, .NE:
      return "남동"
    case .ENE:
      return "동북"
    case .EE:
      return "동"
    case .ESE:
      return "동남"
    case .SE, .SSE:
      return "남동"
    case .SS:
      return "남"
    case .SSW, .SW:
      return "남서"
    case .WSW:
      return "서남"
    case .WW:
      return "서"
    case .WNW:
      return "서북"
    case .NW, .NNW:
      return "북서"
    }
  }
}
