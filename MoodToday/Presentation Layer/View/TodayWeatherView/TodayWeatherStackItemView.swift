//
//  TodayWeatherStackItemView.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/10.
//

import Foundation
import UIKit
import SwiftUI
import SnapKit
import Then

final class TodayWeatherStackItemView: UIView {
  
  lazy var stackView: UIStackView = UIStackView().then {
    $0.axis = .vertical
    $0.distribution = .equalSpacing
    $0.alignment = .center
    $0.spacing = 10
  }
  
  lazy var stackItemMainStackView: UIStackView = UIStackView().then {
    $0.axis = .horizontal
    $0.distribution = .equalCentering
    $0.spacing = 5
  }
  
  
  lazy var stackItemTitle: UILabel = UILabel().then {
    $0.textColor = .black
  }
  lazy var stackItemImage: UIImageView = UIImageView().then {
    _ in
  }
  
  lazy var stackItemSubTitle: UILabel = UILabel().then {
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

extension TodayWeatherStackItemView {
  private func defineView() {
    addSubview(stackView)
    
    [stackItemMainStackView, stackItemSubTitle].forEach { stackView.addArrangedSubview($0) }
    [stackItemTitle, stackItemImage].forEach { stackItemMainStackView.addArrangedSubview($0) }
    
    stackView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  
  }
}
