//
//  ParticulateMatterView.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/12.
//

import Foundation
import SnapKit
import UIKit
import Then
import SwiftUI


final class ParticulateMatterView: UIView {
  
  lazy var containerView: ParticulateMatterCircleView = ParticulateMatterCircleView().then {
    $0.mainColor = .clear
    $0.ringColor = .blue.withAlphaComponent(0.5)
    $0.ringThickness = 4
  }
  
  lazy var mainTitle: UILabel = UILabel().then {
    $0.numberOfLines = 2
    $0.textAlignment = .center
    $0.text = "14\n㎍/m³"
  }
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    
    defineView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    //circular draw
    
    
   
  }
}
extension ParticulateMatterView {
  private func defineView() {
    addSubview(containerView)
    
    containerView.addSubview(mainTitle)
    
    containerView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    mainTitle.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
    
    //drawCircle()
  }
  
  private func drawCircle() {
    let circleLayer = CAShapeLayer()
    
    let center = CGPoint (x: containerView.frame.size.width / 2, y: containerView.frame.size.height / 2)
    let circleRadius = containerView.frame.size.width / 2
    let circlePath = UIBezierPath(arcCenter: center, radius: circleRadius, startAngle: CGFloat(M_PI), endAngle: CGFloat(M_PI * 4), clockwise: true)
    circleLayer.path = circlePath.cgPath
    circleLayer.strokeColor = UIColor.red.cgColor
    circleLayer.fillColor = UIColor.clear.cgColor
    circleLayer.lineWidth = 8
    circleLayer.strokeStart = 0
    circleLayer.strokeEnd  = 1
    containerView.layer.insertSublayer(circleLayer, below: containerView.layer)
  }
}

struct ParticulateMatterPreview: PreviewProvider {
  static var previews: some View {
    Group {
      UIViewPreview { ParticulateMatterView() }
    }
  }
}
