//
//  AgreementView.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/14.
//

import Foundation
import UIKit
import SwiftUI
import SnapKit
import Then

final class AgreementView: UIView {
  
  let containerView: UIView = UIView()
  
  lazy var headerTitle: UILabel = UILabel().then {
    $0.text = "약관동의 화면"
    $0.font = UIFont.boldSystemFont(ofSize: 30)
  }
  
  lazy var agreementIcon: UIImageView = UIImageView().then {
    $0.image = UIImage(named: "location")
  }
  
  lazy var agreementDescription: UITextView = UITextView().then {
    $0.isEditable = false
    $0.text = "날씨 및 미세먼지 정보를 제공받기 위하여 \n귀하의 현재 위치정보를 제공하는 데에 \n동의하시겠습니까?"
    $0.font = UIFont.systemFont(ofSize: 20)
    $0.textAlignment = .center
  }
  
  lazy var agreementButton: UIButton = UIButton().then {
    $0.setTitle("약관 동의", for: .normal)
    $0.backgroundColor = .black
    $0.setTitleColor(.white, for: .normal)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    defineView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    agreementButton.layer.cornerRadius = agreementButton.frame.height / 2
  }
}

extension AgreementView {
  private func defineView() {
    addSubview(containerView)
    [headerTitle, agreementIcon, agreementDescription, agreementButton]
      .forEach { containerView.addSubview($0) }
    
    containerView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    headerTitle.snp.makeConstraints { make in
      make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
      make.left.equalToSuperview().offset(20)
    }
    
    agreementIcon.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.centerY.equalToSuperview().multipliedBy(0.8)
    }
    
    agreementDescription.snp.makeConstraints { make in
      make.top.equalTo(agreementIcon.snp.bottom).offset(10)
      make.centerX.equalToSuperview()
      make.left.equalToSuperview().offset(20)
      make.right.equalToSuperview().offset(-20)
      make.height.equalTo(100)
    }
    
    agreementButton.snp.makeConstraints { make in
      make.height.equalTo(50)
      make.left.equalToSuperview().offset(20)
      make.right.equalToSuperview().offset(-20)
      make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-20)
    }
  }
}

struct AgreementPreview: PreviewProvider {
  static var previews: some View {
    Group {
      UIViewPreview { AgreementView() }
    }
  }
}
