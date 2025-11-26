//
//  UsersController.swift
//  ParkDemo
//
//  Created by Szabolcs Tóth on 25.11.2025.
//  Copyright © 2025 Szabolcs Tóth. All rights reserved.
//

import SwiftUI

struct UsersController {
  // Properties
  let httpClient: HTTPClient

  func login(username: String, password: String) async throws {
    let response = try await httpClient.login(username: username, password: password)
    if let token = response.token {
      Keychain.set(token, forKey: "jwttoken")
    }
  }

  func verifyToken() async throws -> Bool {
      let response = try await httpClient.verifyToken()
      return response.name != nil
  }
}
