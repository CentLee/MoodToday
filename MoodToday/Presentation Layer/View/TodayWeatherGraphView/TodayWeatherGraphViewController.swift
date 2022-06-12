//
//  TodayWeatherGraphViewController.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/12.
//

import Foundation

final class TodayWeatherGraphViewController: BaseViewController<TodayWeatherGraphView> {
  fileprivate var graphView: TodayWeatherGraphView {
    return self.view as! TodayWeatherGraphView
  }
  
  private var viewModel: TodayWeatherViewModel? = nil
  
  override func loadView() {
    self.view = TodayWeatherGraphView()
  }
  
  override func viewDidLoad() {
    
  }
  
  convenience init(viewModel: TodayWeatherViewModel) {
    self.init()
    
    self.viewModel = viewModel
  }
  
}
