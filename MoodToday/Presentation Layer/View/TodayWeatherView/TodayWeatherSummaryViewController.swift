//
//  TodayWeatherSummaryViewController.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/05.
//

import Foundation

final class TodayWeatherSummaryViewController: BaseViewController<TodayWeatherSummaryView> {
  
  fileprivate var todayWeatherView: TodayWeatherSummaryView {
    return self.view as! TodayWeatherSummaryView
  }
  
  private var viewModel: TodayWeatherViewModel! = nil
  
  override func loadView() {
    self.view = TodayWeatherSummaryView()
  }

  convenience init(viewModel: TodayWeatherViewModel) {
    self.init()
    
    self.viewModel = viewModel
  }
  
  override func viewDidLoad() {
    print("dqw")
    
    todayWeatherView.particulateMatterView.circleView.ringColor = .gray
  }
}
