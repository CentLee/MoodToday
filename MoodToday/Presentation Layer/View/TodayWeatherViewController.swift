//
//  TodayWeatherSummaryViewController.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/05.
//

import Foundation

final class TodayWeatherViewController: BaseViewController<TodayWeatherSummaryView> {
  
  fileprivate var todayWeatherView: TodayWeatherSummaryView {
    return self.view as! TodayWeatherSummaryView
  }
  private let viewModel: TodayWeatherViewModel!
  
  override func loadView() {
    self.view = TodayWeatherSummaryView()
  }

  convenience init(viewModel: TodayWeatherViewModel) {
    super.init()
    
    self.viewModel = viewModel
  }
  
  override func viewDidLoad() {
    print("dqw")
  }
}
