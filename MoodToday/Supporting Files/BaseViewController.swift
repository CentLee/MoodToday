//
//  BaseViewController.swift
//  MoodToday
//
//  Created by 이창화 on 2022/06/05.
//

import Foundation
import UIKit

class BaseViewController<View: UIView>: UIViewController {
  // MARK: UI
  
  lazy var contentView = View()
  
  // MARK: View Life Cycle
  
  override func loadView() {
    self.view = self.contentView
  }
}
