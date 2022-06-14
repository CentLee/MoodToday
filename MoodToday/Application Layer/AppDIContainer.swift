//
//  AppDIContainer.swift
//  MoodToday
//
//  Created by 이창화 on 2022/05/28.
//

import Foundation

final class AppDIContainer {
  static let shared: AppDIContainer = AppDIContainer()
  
  public func todayWeatherDependencies() -> TodayWeatherViewModel {
    let useCase = FetchTodayWeatherUseCase(repository: TodayWeatherRepository())
    
    let viewModel = TodayWeatherViewModel(weatherUseCase: useCase)
    
    return viewModel
  }
  
  public func userLocationDependencies() -> AgreementViewModel {
    let useCase = UpdateUserLocationUseCase(repository: UserLocationRepository())
    
    let viewModel = AgreementViewModel(useCase: useCase)
    
    return viewModel
  }
}
