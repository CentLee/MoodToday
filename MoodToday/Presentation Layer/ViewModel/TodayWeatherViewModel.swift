//
//  TodayWeatherViewModel.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/05.
//

import Foundation
import RxSwift


protocol TodayWeatherViewModelInput {
  func didUpdateLocation(requestValue: FetchTodayWeatherRequestValue)
}

protocol TodayWeatherViewModelOutput {
  
}

protocol TodayWeatherViewModelType: TodayWeatherViewModelInput, TodayWeatherViewModelOutput {
  var input: TodayWeatherViewModelInput { get }
  var output: TodayWeatherViewModelOutput { get }
}


final class TodayWeatherViewModel: TodayWeatherViewModelType {
  var input: TodayWeatherViewModelInput { return self }
  var output: TodayWeatherViewModelOutput { return self }
  
  private let weatherUseCase: FetchTodayWeatherUseCaseInterface
  private let disposeBag: DisposeBag = DisposeBag()
  
  public init(weatherUseCase: FetchTodayWeatherUseCaseInterface) {
    self.weatherUseCase = weatherUseCase
  }
  
}

extension TodayWeatherViewModel {
  func didUpdateLocation(requestValue: FetchTodayWeatherRequestValue) {
    self.weatherUseCase.execute(requestValue: requestValue)
    //데이터 받아와서 뷰에 뿌려줄 형태로 변환한다.
    //그러고 아웃풋 데이터에 반영한다.
  }
}
