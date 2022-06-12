//
//  ParticulateMatterCircleView.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/12.
//

import Foundation
import UIKit


@IBDesignable
class ParticulateMatterCircleView: UIView
{
  @IBInspectable var mainColor: UIColor = UIColor.clear
  {
    didSet { print("mainColor was set here") }
  }
  @IBInspectable var ringColor: UIColor = UIColor.clear
  {
    didSet { print("bColor was set here") }
  }
  @IBInspectable var ringThickness: CGFloat = 4
  {
    didSet { print("ringThickness was set here") }
  }
  
  
  @IBInspectable var isSelected: Bool = true
  
  override func draw(_ rect: CGRect)
  {
    
    let dotPath = UIBezierPath(ovalIn: rect)
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = dotPath.cgPath
    shapeLayer.fillColor = mainColor.cgColor
    layer.addSublayer(shapeLayer)
    
    if (isSelected) { drawRingFittingInsideView(rect: rect) }
  }
  
  internal func drawRingFittingInsideView(rect: CGRect) {
    let hw: CGFloat = ringThickness / 2
    let circlePath = UIBezierPath(ovalIn: rect.insetBy(dx: hw, dy: hw))
    
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = circlePath.cgPath
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.strokeColor = ringColor.cgColor
    shapeLayer.lineWidth = ringThickness
    layer.addSublayer(shapeLayer)
    
    Measurement(value: 13/200, unit: <#T##Unit#>)
  }
}
