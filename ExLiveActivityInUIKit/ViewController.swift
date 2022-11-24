//
//  ViewController.swift
//  ExLiveActivityInUIKit
//
//  Created by 김종권 on 2022/11/24.
//

import UIKit

class ViewController: UIViewController {
  private let startButton = UIButton(type: .system)
  private let updateButton = UIButton(type: .system)
  private let stopButton = UIButton(type: .system)
  private let stackView = UIStackView()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    stackView.axis = .vertical
    stackView.translatesAutoresizingMaskIntoConstraints = false
    startButton.setTitle("Live Activity 시작", for: .normal)
    updateButton.setTitle("Live Activity 업데이트", for: .normal)
    stopButton.setTitle("Live Activity 중지", for: .normal)
    startButton.addTarget(self, action: #selector(start), for: .touchUpInside)
    updateButton.addTarget(self, action: #selector(update), for: .touchUpInside)
    stopButton.addTarget(self, action: #selector(stop), for: .touchUpInside)
    
    view.addSubview(stackView)
    [startButton, updateButton, stopButton]
      .forEach(stackView.addArrangedSubview(_:))
    
    NSLayoutConstraint.activate([
      stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
  
  @objc private func start() {
    LiveActivityManager.shared.start()
  }
  @objc private func update() {
    LiveActivityManager.shared.update(state: .init(value: (0...100).randomElement()!))
  }
  @objc private func stop() {
    LiveActivityManager.shared.stop()
  }
}
