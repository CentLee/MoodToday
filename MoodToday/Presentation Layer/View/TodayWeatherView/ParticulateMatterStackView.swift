//
//  ParticularMatterStackView.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/13.
//

import Foundation
import SnapKit
import UIKit
import Then

final class ParticulateMatterStackView: UIView {
  
  let containerView: UIView = UIView()
  
  lazy var particulateMatterStackView: UIStackView = UIStackView().then {
    $0.axis = .vertical
    $0.distribution = .equalSpacing
    $0.spacing = 10
    $0.alignment = .center
  }
  
  lazy var circleView: ParticulateMatterCircleView = ParticulateMatterCircleView().then {
    $0.mainColor = .clear
    $0.ringColor = .blue.withAlphaComponent(0.5)
    $0.ringThickness = 4
  }
  
  lazy var mainTitle: UILabel = UILabel().then {
    $0.numberOfLines = 2
    $0.textAlignment = .center
    $0.text = "14\n㎍/m³"
  }
  
  lazy var particulateMatterCircleView: UIView = UIView().then {
    _ in
  }
  
  lazy var particulateMatterNameView: UILabel = UILabel().then {
    $0.textColor = .black
  }
  
  lazy var particulateMatterConcentrationStateView: UILabel = UILabel().then {
    $0.textColor = .black
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    defineView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
extension ParticulateMatterStackView {
  private func defineView() {
    addSubview(containerView)
    //containerView.addSubview(particulateMatterStackView)
    
    [particulateMatterCircleView, particulateMatterNameView, particulateMatterConcentrationStateView]
      .forEach { containerView.addSubview($0) }
    [circleView, mainTitle].forEach { particulateMatterCircleView.addSubview($0) }
    
    
    containerView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
//    particulateMatterStackView.snp.makeConstraints { make in
//      make.edges.equalToSuperview()
//    }
    
    particulateMatterCircleView.snp.makeConstraints { make in
      make.size.equalTo(30)
      make.top.equalToSuperview()
      make.centerX.equalToSuperview()
    }
    
    circleView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    mainTitle.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
    
    particulateMatterNameView.snp.makeConstraints { make in
      make.top.equalTo(particulateMatterCircleView.snp.bottom).offset(30)
      make.centerX.equalToSuperview()
    }
    
    particulateMatterConcentrationStateView.snp.makeConstraints { make in
      make.top.equalTo(particulateMatterNameView.snp.bottom).offset(5)
      make.centerX.equalToSuperview()
    }
  }
}
