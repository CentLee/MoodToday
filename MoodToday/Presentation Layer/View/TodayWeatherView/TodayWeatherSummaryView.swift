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
    $0.text = "서울특별시 동작구 신대방제2동"
  }
  
  lazy var temperatureTitle: UILabel = UILabel().then {
    $0.textColor = .black
    $0.text = "27.1"
    $0.font = UIFont.boldSystemFont(ofSize: 30)
  }
  
  lazy var weatherSummaryStackView: UIStackView = UIStackView().then {
    $0.axis = .horizontal
    $0.distribution = .fillEqually
    $0.spacing = 10
  }
  
  lazy var humidityStackView: TodayWeatherStackItemView = TodayWeatherStackItemView().then {
    $0.stackItemTitle.text = "습도"
    $0.stackItemSubTitle.text = "50%"
  }
  
  lazy var windyStackView: TodayWeatherStackItemView = TodayWeatherStackItemView().then {
    $0.stackItemTitle.text = "바람"
    $0.stackItemSubTitle.text = "남서 1.8 m/s"
  }
  
  lazy var rainStackView: TodayWeatherStackItemView = TodayWeatherStackItemView().then {
    $0.stackItemTitle.text = "강수량"
    $0.stackItemSubTitle.text = "- mm"
  }
  // under 미세먼지 뷰 추가 예정
  
  lazy var partiView: ParticulateMatterView = ParticulateMatterView().then {
    _ in
  }
  
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    //defineView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    defineView()
    self.layoutIfNeeded()
  }
}

extension TodayWeatherSummaryView {
  private func defineView() {
    addSubview(contentScrollView)
    contentScrollView.addSubview(containerView)
    //containerView.addSubview(contentScrollView)
    
    [headerView, temperatureTitle, weatherSummaryStackView].forEach { containerView.addSubview($0)}
    
    headerView.addSubview(locationTitle)
    
    [humidityStackView, windyStackView, rainStackView].forEach { weatherSummaryStackView.addArrangedSubview($0)}
    
    containerView.addSubview(partiView)
  
  

  
    contentScrollView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    containerView.snp.makeConstraints { make in
      make.width.equalToSuperview()
      make.edges.equalToSuperview()
    }
    
  
    headerView.snp.makeConstraints { make in
      make.top.left.right.equalToSuperview()
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
    
    partiView.snp.makeConstraints { make in
      make.top.equalTo(weatherSummaryStackView.snp.bottom).offset(50)
      make.size.equalTo(100)
      make.centerX.equalToSuperview()
    }
  }
}

struct TodayWeatherPrevier: PreviewProvider {
  static var previews: some View {
    Group {
      UIViewPreview { TodayWeatherSummaryView() }
    }
  }
}
