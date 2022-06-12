//
//  TodayWeatherSegmentView.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/12.
//

import Foundation
import UIKit
import SnapKit
import Then

final class TodayWeatherSegmentView: UIView {
  let containerView: UIView = UIView()
  
  lazy var segmentBut: UIButton = UIButton().then {
    $0.setTitleColor(hexStringToUIColor(hex: "#C3C3C5"), for: .normal)
    $0.setTitleColor(hexStringToUIColor(hex: "#16B9C5"), for: .selected)
  }
  lazy var segmentHighlightView: UIView = UIView().then {
    $0.backgroundColor = hexStringToUIColor(hex: "#16B9C5")
    $0.layer.cornerRadius = 1.5
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.backgroundColor = .clear
    
    defineView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
extension TodayWeatherSegmentView {
  private func defineView() {
    addSubview(containerView)
    
    [segmentBut, segmentHighlightView].forEach { containerView.addSubview($0) }
    
    containerView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    segmentBut.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    segmentHighlightView.snp.makeConstraints { make in
      make.left.right.bottom.equalToSuperview()
      make.height.equalTo(3)
    }
  }
}
