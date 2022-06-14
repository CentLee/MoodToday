//
//  AgreementViewController.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/14.
//

import Foundation
import RxSwift
import RxCocoa
import Then
import UIKit

final class AgreementViewController: BaseViewController<AgreementView> {
  fileprivate var agreementView: AgreementView {
    return self.view as! AgreementView
  }
  
  var viewModel: AgreementViewModel?
  private let disposeBag = DisposeBag()
  
  override func loadView() {
    self.view = AgreementView()
  }
  
  override func viewDidLoad() {
    self.view.backgroundColor = .white
    agreementView.agreementButton.rx.tap.asDriver()
      .drive(onNext: { [weak self] _ in
        guard let self = self,
              let viewModel = self.viewModel
        else { return }
        
        viewModel.input.didAgree()
      }).disposed(by: disposeBag)
    
    
//    LocationManager.shared.currentLocation
//      .subscribe(onNext: { location in
//        iPrint(location)
//      }).disposed(by: disposeBag)
    
    viewModel?.isUpdated.asDriver(onErrorJustReturn: ())
      .drive(onNext: { [weak self] _ in
        guard let self = self else { return }
        self.dismiss(animated: false) {
          let weatherVC = TodayWeatherContainerViewController(viewModel: AppDIContainer.shared.todayWeatherDependencies())
          self.view.window?.rootViewController = weatherVC
          self.view.window?.makeKeyAndVisible()
        }
      }).disposed(by: disposeBag)
  }
  
  convenience init(viewModel: AgreementViewModel) {
    self.init()
    
    self.viewModel = viewModel
  }
}
