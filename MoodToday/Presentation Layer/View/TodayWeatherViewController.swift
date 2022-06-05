//
//  TodayWeatherSummaryViewController.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/05.
//

import Foundation

final class TodayWeatherViewController: BaseViewController<TodayWeatherView> {
  
  fileprivate var todayWeatherView: TodayWeatherView {
    return self.view as! TodayWeatherView
  }
  private let viewModel: TodayWeatherViewModel!
  
  override func loadView() {
    self.view = TodayWeatherView()
  }

  convenience init(viewModel: TodayWeatherViewModel) {
    super.init()
    
    self.viewModel = viewModel
  }
  
  override func viewDidLoad() {
    print("dqw")
  }
}
