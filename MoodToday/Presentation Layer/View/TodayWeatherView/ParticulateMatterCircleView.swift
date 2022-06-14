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
  @IBInspectable var progressValue: Double = 0.0
  {
    didSet { print("progressValue was set here")}
  }
  
  @IBInspectable var isSelected: Bool = true
  
  let progressLayer = CAShapeLayer()
  
  override func draw(_ rect: CGRect)
  {
    drawRingFittingInsideView(rect: rect)
  }
  
  internal func drawRingFittingInsideView(rect: CGRect) {
    let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0),
                                    radius: 30, startAngle: -.pi / 2, endAngle: 3 * .pi / 2, clockwise: true)
    let shapeLayer = CAShapeLayer()
    shapeLayer.path = circularPath.cgPath
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.strokeColor = ringColor.cgColor
    shapeLayer.lineWidth = ringThickness
    layer.addSublayer(shapeLayer)

    progressLayer.path = circularPath.cgPath
    progressLayer.fillColor = UIColor.clear.cgColor
    progressLayer.strokeColor = UIColor.blue.cgColor
    progressLayer.strokeEnd = 0.0
    progressLayer.lineWidth = 6
    layer.addSublayer(progressLayer)
    
    setProgressWithAnimation(duration: 0.5, value: progressValue/100.0)
  }
  
  func setProgressWithAnimation(duration: TimeInterval, value: Double) {
     let animation = CABasicAnimation(keyPath: "strokeEnd")
     animation.duration = duration
     animation.fromValue = 0
     animation.toValue = value
    animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
    progressLayer.strokeEnd = CGFloat(value)
    progressLayer.add(animation, forKey: "animateprogress")
  }
  
}
