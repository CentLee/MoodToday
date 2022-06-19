//
//  TodayParticularMatterEntity.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/19.
//

import Foundation
import UIKit

struct TodayParticularMatterEntity {
  let pmList: [ParticularMatter]
  
  init(pmList: [ParticularMatter] = []) {
    self.pmList = pmList
  }
}

struct ParticularMatter {
  let dataTime: String
  let ultraPmValue: Int
  let pmValue: Int
  
  func toPmData() -> (UIColor, String) {
    switch self.pmValue {
    case 0...30:
      return (hexStringToUIColor(hex: "#42A3E1"), "좋음")
    case 31...80:
      return (hexStringToUIColor(hex: "#6DBB7E"), "보통")
    case 81...150:
      return (hexStringToUIColor(hex: "#E6A160"), "나쁨")
    case 151...300:
      return (hexStringToUIColor(hex: "#D33F33"), "매우 나쁨")
    default:
      return (UIColor.clear, "")
    }
  }
  
  func toUpmData() -> (UIColor, String) {
    switch self.ultraPmValue {
    case 0...15:
      return (hexStringToUIColor(hex: "#42A3E1"), "좋음")
    case 16...35:
      return (hexStringToUIColor(hex: "#6DBB7E"), "보통")
    case 36...75:
      return (hexStringToUIColor(hex: "#E6A160"), "나쁨")
    case 76...200:
      return (hexStringToUIColor(hex: "#D33F33"), "매우 나쁨")
    default:
      return (UIColor.clear, "")
    }
  }
}
