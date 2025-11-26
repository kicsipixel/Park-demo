//
//  ParkDemoApp.swift
//  ParkDemo
//
//  Created by Szabolcs Tóth on 25.11.2025.
//  Copyright © 2025 Szabolcs Tóth. All rights reserved.
//

import SwiftUI

@main
struct ParkDemoApp: App {
  // Private Properties
  private let usersController: UsersController
    @State private var parkViewModel = ParkViewModel(networkManager: NetworkManager(path: "parks"))

  // Initializer
  init() {
    usersController = UsersController(networkManager: NetworkManager(path: "parks"))
  }

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environment(\.usersController, usersController)
        .environment(parkViewModel)
    }
  }
}
