//
//  ParticularMatterResponseDTO.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/19.
//

import Foundation

struct ParticularMatterResponseDTO: Decodable {
  var response: ParticularMatterJSONResponseDTO
  
  
  func toDomain() -> TodayParticularMatterEntity {
    return .init(pmList: self.response.body.items.map { $0.toDomain() })
  }
}

struct ParticularMatterJSONResponseDTO: Decodable {
  var header: ParticularMatterJSONHeaderDTO
  var body: ParticularMatterJSONBodyDTO
}

struct ParticularMatterJSONHeaderDTO: Decodable {
  var resultCode: String
  var resultMsg: String
}

struct ParticularMatterJSONBodyDTO: Decodable {
  var totalCount: Int
  var items: [ParticularMatterDTO]
}

struct ParticularMatterDTO: Decodable {
  var ultraPmValue: String
  var pmValue: String
  var dataTime: String
  
  enum CodingKeys: String, CodingKey {
    case ultraPMValue = "pm10Value"
    case pmValue = "pm25Value"
    case dataTime
  }
  
  init(from decoder: Decoder) throws {
      let values = try decoder.container(keyedBy: CodingKeys.self)
      ultraPmValue = try values.decode(String.self, forKey: .ultraPMValue)
      pmValue = try values.decode(String.self, forKey: .pmValue)
      dataTime = try values.decode(String.self, forKey: .dataTime)
  }
  
  func toDomain() -> ParticularMatter {
    return .init(dataTime: dataTime, ultraPmValue: Int(ultraPmValue)!, pmValue: Int(pmValue)!)
  }
}

