//
//  ParticularMatterAPI.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/19.
//

import Foundation
import Moya

enum ParticularMatterAPI {
  case todayParticularMatter(_ currentLocation: String = "")
  //현재 위치에 따른 날씨 데이터 api
}

extension ParticularMatterAPI: TargetType {
  var headers: [String : String]? {
    nil
  }
  
  var baseURL: URL {
    return getBaseUrl()
  }
  
  
  var path: String {
      switch self {
      case .todayParticularMatter(_):
          return ""
      }
  }
  
  var method: Moya.Method {
      switch self {
      case .todayParticularMatter(_):
          return .get
      }
  }
  
  var task: Task {
    switch self {
    case .todayParticularMatter(let currentLocation):
      iPrint(currentLocation)
      return .requestParameters(parameters: ["pageNo": 1, "numOfRows": 1,
                                             "returnType": "json", "dataTerm": "DAILY",
                                             "stationName": currentLocation, "ver": "1.0"],
                                encoding: URLEncoding.queryString)
    }
  }
}

extension ParticularMatterAPI {
  func getBaseUrl() -> URL {
    guard let infoDic : [String : Any] = Bundle.main.infoDictionary,
          let urlString: String = infoDic["PMAPIURL"] as? String,
          let serviceKey: String = infoDic["PMAuthKey"] as? String,
          let url = URL(string: "\(urlString)?serviceKey=\(serviceKey)") else { return URL(string: "")!}
    return url
  }
}

