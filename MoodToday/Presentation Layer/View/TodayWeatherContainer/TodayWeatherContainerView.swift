//
//  TodayWeatherContainerView.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/12.
//

import Foundation
import UIKit
import SwiftUI
import SnapKit
import Then
import RxSwift
import RxCocoa

final class TodayWeatherContainerView: UIView {
  
  let containerView: UIView = UIView()
  
  lazy var headerTitle: UILabel = UILabel().then {
    $0.text = "오늘의 날씨"
    $0.font = UIFont.italicSystemFont(ofSize: 30)
  }
  
  lazy var todayWeatherSummarySegment: TodayWeatherSegmentView = TodayWeatherSegmentView().then {
    $0.segmentBut.tag = 0
    $0.segmentBut.setTitle("요약 뷰", for: .normal)
  }
  
  lazy var todayWeatherGraphSegment: TodayWeatherSegmentView = TodayWeatherSegmentView().then {
    $0.segmentBut.tag = 1
    $0.segmentBut.setTitle("차트 뷰", for: .normal)
  }
  
  let segmentStackView: UIStackView = UIStackView().then {
    $0.distribution = .fillEqually
    $0.axis = .horizontal
  }
  
  lazy var childContainerView: UIView = UIView().then {
    _ in
  }
  
  private let disposeBag = DisposeBag()
  
  var isSelectedSegment: PublishSubject<Int> = PublishSubject<Int>()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    defineView()
    bind()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension TodayWeatherContainerView {
  private func defineView() {
    
    addSubview(containerView)
    
    [headerTitle, segmentStackView, childContainerView].forEach { containerView.addSubview($0) }
    [todayWeatherSummarySegment, todayWeatherGraphSegment].forEach { segmentStackView.addArrangedSubview($0) }
    
    containerView.snp.makeConstraints { make in
      make.edges.equalTo(self.safeAreaLayoutGuide.snp.edges)
    }
    
    headerTitle.snp.makeConstraints { make in
      make.left.equalToSuperview().offset(20)
      make.top.equalToSuperview().offset(20)
    }
    
    segmentStackView.snp.makeConstraints { make in
      make.width.equalTo(164)
      make.height.equalTo(31)
      make.left.equalTo(headerTitle.snp.left)
      make.top.equalTo(headerTitle.snp.bottom).offset(20)
    }
    
    childContainerView.snp.makeConstraints { make in
      make.top.equalTo(segmentStackView.snp.bottom).offset(20)
      make.left.equalTo(headerTitle.snp.left)
      make.right.equalToSuperview().offset(-20)
      make.bottom.equalToSuperview()
    }
  }
  
  private func bind() {
    isSelectedSegment.asDriver(onErrorJustReturn: 0)
      .drive(onNext: { [weak self] segmentIndex in
        guard let self = self else { return }
        
        let flag = segmentIndex == 0 ? true : false
        
        self.todayWeatherSummarySegment.segmentBut.isSelected = flag
        self.todayWeatherGraphSegment.segmentBut.isSelected = !flag
        
        self.todayWeatherSummarySegment.segmentHighlightView.isHidden = !flag
        self.todayWeatherGraphSegment.segmentHighlightView.isHidden = flag
        
        
      }).disposed(by: disposeBag)
  }
}

struct TodayWeatherContainerPreview: PreviewProvider {
  static var previews: some View {
    Group {
      UIViewPreview { TodayWeatherContainerView() }
    }
  }
}
