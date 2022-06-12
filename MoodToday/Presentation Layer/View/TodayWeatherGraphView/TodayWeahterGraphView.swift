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

final class TodayWeatherGraphView: UIView {
  
  let containerView: UIView = UIView()
  
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
    
    containerView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}
