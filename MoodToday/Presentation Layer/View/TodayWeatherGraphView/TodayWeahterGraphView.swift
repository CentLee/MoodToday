//
//  TodayWeahterGraphView.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/12.
//

import Foundation
import UIKit
import SwiftUI
import SnapKit
import Then
import Charts

final class TodayWeatherGraphView: UIView {
  
  let containerView: UIView = UIView()
  
  lazy var chartView: LineChartView = LineChartView().then {
    $0.tintColor = hexStringToUIColor(hex: "#42A3E1")
    $0.rightAxis.enabled = false
    $0.xAxis.labelPosition = .bottom
  
  }
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    defineView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension TodayWeatherGraphView {
  private func defineView() {
    addSubview(containerView)
    
    containerView.addSubview(chartView)
    
    containerView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    chartView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(20)
      make.left.equalToSuperview().offset(20)
      make.width.equalTo(1000)
      make.height.equalTo(300)
    }
  }
}
