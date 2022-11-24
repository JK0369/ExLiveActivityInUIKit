//
//  LiveActivityManager.swift
//  ExLiveActivityInUIKit
//
//  Created by 김종권 on 2022/11/24.
//

import SwiftUI
import ActivityKit

final class LiveActivityManager: ObservableObject {
  static let shared = LiveActivityManager()
  
  @Published var activity: Activity<JakeAttributes>?
  
  private init() {}
  
  func start() {
    guard activity == nil else { return }
    let attributes = JakeAttributes(name: "jake")
    let contentState = JakeAttributes.ContentState(value: 5)
    
    do {
      let activity = try Activity<JakeAttributes>.request(
        attributes: attributes,
        contentState: contentState
      )
      print(activity)
    } catch {
      print(error)
    }
  }
  
  func update(state: JakeAttributes.ContentState) {
    Task {
      let updateContentState = JakeAttributes.ContentState(value: state.value)
      for activity in Activity<JakeAttributes>.activities {
        await activity.update(using: updateContentState)
      }
    }
  }
  
  func stop() {
    Task {
      for activity in Activity<JakeAttributes>.activities {
        await activity.end(dismissalPolicy: .immediate)
      }
    }
  }
}
