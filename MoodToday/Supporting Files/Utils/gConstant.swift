//
//  gConstant.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/12.
//

import Foundation
import UIKit

public func iPrint(_ objects:Any... , filename:String = #file,_ line:Int = #line, _ funcname:String = #function){ //debuging Print
#if DEBUG
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "HH:mm:ss:SSS"
  let file = URL(string:filename)?.lastPathComponent.components(separatedBy: ".").first ?? ""
  print("💦info 🦋\(dateFormatter.string(from:Date())) 🌞\(file) 🍎line:\(line) 🌹\(funcname)🔥",terminator:"")
  for object in objects{
    print(object, terminator:"")
  }
  print("\n")
#endif
}

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
