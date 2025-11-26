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
  // Private Properties
  let httpClient: HTTPClient

  // Properties
  var parks = [Park]()

  // Initializer
  init(httpClient: HTTPClient) {
    self.httpClient = httpClient
  }

  func createPark(from: ParkRequest) async throws {
    //        let body = ParkRequest(
    //            details: .init(name: "Letenské sady- 2"),
    //            coordinates: .init(longitude: 4.4202892, latitude: 50.0959721)
    //        )
    //
    //        var request = URLRequest(
    //            url: URL(string: "http://localhost:8080/api/v1/parks")!
    //        )
    //        request.httpMethod = "POST"
    //        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    //
    //        if let token = Keychain<String>.get("jwttoken") {
    //            request.addValue(
    //                "Bearer \(token)",
    //                forHTTPHeaderField: "Authorization"
    //            )
    //        }
    //
    //        request.httpBody = try JSONEncoder().encode(body)
    //
    //        let (_, _) = try await URLSession.shared.data(for: request)
  }

  func listParks() async throws {
    parks = try await httpClient.listAllParks()
  }
}
