//
//  TodayWeatherView.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/06.
//

import Foundation
import UIKit
import SnapKit
import SwiftUI
import Then

final class TodayWeatherSummaryView: UIView {
  
  let containerView: UIView = UIView()
  
  lazy var contentScrollView: UIScrollView = UIScrollView().then {
    _ in
  }
  
  lazy var headerView: UIView = UIView().then {
    $0.backgroundColor = .lightGray
  }
  lazy var locationTitle: UILabel = UILabel().then {
    $0.textColor = .black
  }
  
  lazy var temperatureTitle: UILabel = UILabel().then {
    $0.textColor = .black
  }
  
  lazy var weatherSummaryStackView: UIStackView = UIStackView().then {
    $0.axis = .horizontal
    $0.distribution = .fillEqually
  }
  
  let humidityStackView: TodayWeatherStackItemView = TodayWeatherStackItemView()
  
  let windyStackView: TodayWeatherStackItemView = TodayWeatherStackItemView()
  
  let rainStackView: TodayWeatherStackItemView = TodayWeatherStackItemView()
  // under 미세먼지 뷰 추가 예정
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    defineView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension TodayWeatherSummaryView {
  private func defineView() {
    addSubview(containerView)
    containerView.addSubview(contentScrollView)
    
    [headerView, temperatureTitle, weatherSummaryStackView].forEach { contentScrollView.addSubview($0)}
    
    headerView.addSubview(locationTitle)
    
    [humidityStackView, windyStackView, rainStackView].forEach { weatherSummaryStackView.addArrangedSubview($0)}
    
    
    containerView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    contentScrollView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    headerView.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.leading.equalToSuperview()
      make.trailing.equalToSuperview()
      make.height.equalTo(50)
    }
    locationTitle.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
    
    temperatureTitle.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalTo(headerView.snp.bottom).offset(20)
    }
    
    weatherSummaryStackView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.top.equalTo(temperatureTitle.snp.bottom).offset(30)
      make.height.equalTo(50)
    }
  }
}

struct TodayWeatherPrevier: PreviewProvider {
  static var previews: some View {
    Group {
      UIViewPreview(TodayWeatherView())
    }
  }
}
