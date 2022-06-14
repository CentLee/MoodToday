//
//  AgreementViewModel.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/14.
//

import Foundation
import RxSwift

protocol AgreementViewModelInput {
  func didAgree()
}

protocol AgreementViewModelOutput {
  var isUpdated: PublishSubject<Void> { get set }
}

protocol AgreementViewModelType: AgreementViewModelInput, AgreementViewModelOutput {
  var input: AgreementViewModelInput { get }
  var output: AgreementViewModelOutput { get }
}

final class AgreementViewModel: AgreementViewModelType {
  var input: AgreementViewModelInput { return self }
  var output: AgreementViewModelOutput { return self }
  
  private let useCase: UpdateUserLocationUseCaseInterface
  private let disposeBag: DisposeBag = DisposeBag()
  
  var isUpdated: PublishSubject<Void> = PublishSubject<Void>()
  
  init(useCase: UpdateUserLocationUseCaseInterface) {
    self.useCase = useCase
  }
}

extension AgreementViewModel {
  func didAgree() {
    //위치정보 동의시
    useCase.execute()
      .subscribe(onNext: { [weak self] isSuccess in
        guard let self = self, isSuccess else { return }
        self.isUpdated.onNext(())
      }).disposed(by: disposeBag)
  }
}
