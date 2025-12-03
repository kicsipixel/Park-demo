//
//  ParksViewModel.swift
//  ParkDemo
//
//  Created by Szabolcs Tóth on 25.11.2025.
//  Copyright © 2025 Szabolcs Tóth. All rights reserved.
//

import SwiftUI

@Observable @MainActor
final class ParkViewModel {
  // Properties
  var parks = [Park]()
  let networkManager: NetworkManager

  // Initializer
  init(networkManager: NetworkManager) {
    self.networkManager = NetworkManager(path: "parks")
  }

  func createPark(from parkRequest: ParkRequest) async throws {
    try await networkManager.createPark(from: parkRequest)
  }

  func listParks() async throws {
    parks = try await networkManager.listAllParks()
  }
}
