//
//  WeatherAPI.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/06.
//

import Foundation
import Moya

enum WeatherAPI {
  case todayWeather(_ gridX: String = "", _ gridY: String = "",
                    _ currentTime: String = "", _ currentDate: String = "")
  //현재 위치에 따른 날씨 데이터 api
  
}

extension WeatherAPI: TargetType {
  var baseURL: URL {
    return getBaseUrl()
  }
  
  
  var path: String {
      switch self {
      case .todayWeather(_, _, _, _):
          return ""
      }
  }
  
  var method: Moya.Method {
      switch self {
      case .todayWeather(_, _, _, _):
          return .get
      }
  }
  
  var task: Task {
    switch self {
    case .todayWeather(let gridX, let gridY, let currentTime, let currentDate):
      return .requestParameters(parameters: ["pageNo": 1, "numOfRows": 288,
                                             "dataType": "JSON", "base_date": currentDate,
                                             "base_time": currentTime, "nx": gridX,
                                             "ny": gridY],
                                encoding: URLEncoding.queryString)
    }
  }
}

extension WeatherAPI {
  func getBaseUrl() -> URL {
    guard let infoDic : [String : Any] = Bundle.main.infoDictionary,
          let urlString: String = infoDic["APIURL"] as? String,
          let serviceKey: String = infoDic["AuthKey"] as? String
          let url = URL(string: "\(urlString)?serviceKey=\(serviceKey)") else { return URL(string: "")!}
    return url
  }
}
