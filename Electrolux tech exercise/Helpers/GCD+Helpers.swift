//
//  GCD+Helpers.swift
//  Electrolux tech exercise
//
//  Created by Igor Rudenko on 07.07.2021.
//

import Foundation

public func onMainThread(
  after seconds: Double = 0,
  completion: @escaping () -> Void)
{
  DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
    completion()
  }
}

public func onMainThread(
  after seconds: Double = 0,
  task: DispatchWorkItem)
{
  DispatchQueue.main.asyncAfter(
    deadline: .now() + seconds,
    execute: task
  )
}
