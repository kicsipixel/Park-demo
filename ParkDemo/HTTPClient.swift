//
//  HTTPClient.swift
//  ParkDemo
//
//  Created by Szabolcs Tóth on 25.11.2025.
//  Copyright © 2025 Szabolcs Tóth. All rights reserved.
//

import SwiftUI

struct HTTPClient {

  // MARK: - USERS
  // MARK: - login
  func login(username: String, password: String) async throws -> LoginResponse {
    // Build "username:password"
    let loginString = "\(username):\(password)"
    guard let loginData = loginString.data(using: .utf8) else {
      throw URLError(.badURL)
    }
    let base64LoginString = loginData.base64EncodedString()

    var request = URLRequest(
      url: URL(string: "http://localhost:8080/api/v1/users/login")!
    )
    request.httpMethod = "POST"
    request.addValue(
      "Basic \(base64LoginString)",
      forHTTPHeaderField: "Authorization"
    )

    let (data, response) = try await URLSession.shared.data(for: request)

    guard let httpResponse = response as? HTTPURLResponse else {
      throw URLError(.badServerResponse)
    }

    if httpResponse.statusCode == 200 {
      return try JSONDecoder().decode(LoginResponse.self, from: data)
    }
    else {
      // Decode error payload to extract message
      struct ServerError: Decodable {
        struct ErrorDetail: Decodable { let message: String }
        let error: ErrorDetail
      }

      if let serverError = try? JSONDecoder().decode(
        ServerError.self,
        from: data
      ) {
        throw AppError.loginFailed(serverError.error.message)
      }
      else {
        throw AppError.loginFailed("Unknown error occurred.")
      }
    }
  }

  // MARK: - verify token
  func verifyToken() async throws -> VerifyResponse {
    guard let url = URL(string: "http://localhost:8080/api/v1/users/verify") else {
      throw URLError(.badURL)
    }

    var request = URLRequest(url: url)
    if let token = Keychain<String>.get("jwttoken") {
      print(token)
      request.addValue(
        "Bearer \(token)",
        forHTTPHeaderField: "Authorization"
      )
    }

    let (data, response) = try await URLSession.shared.data(for: request)

    guard let httpResponse = response as? HTTPURLResponse else {
      throw URLError(.badServerResponse)
    }

    if httpResponse.statusCode == 200 {
      return try JSONDecoder().decode(VerifyResponse.self, from: data)
    }
    else {
      // Decode error payload to extract message
      struct ServerError: Decodable {
        struct ErrorDetail: Decodable { let message: String }
        let error: ErrorDetail
      }

      if let serverError = try? JSONDecoder().decode(ServerError.self, from: data) {
        throw AppError.tokenExpired(serverError.error.message)
      }
      else {
        throw AppError.tokenExpired("Unknown error occurred.")
      }
    }
  }

  // MARK: - PARKS
  // MARK: - lists parks
  func listAllParks() async throws -> [Park] {
    guard let url = URL(string: "http://localhost:8080/api/v1/parks") else {
      throw URLError(.badURL)
    }

    let request = URLRequest(url: url)

    let (data, response) = try await URLSession.shared.data(for: request)

    guard let httpResponse = response as? HTTPURLResponse else {
      throw URLError(.badServerResponse)
    }

    if httpResponse.statusCode == 200 {
      return try JSONDecoder().decode([Park].self, from: data)
    }
    else {
      // Decode error payload to extract message
      struct ServerError: Decodable {
        struct ErrorDetail: Decodable { let message: String }
        let error: ErrorDetail
      }

      if let serverError = try? JSONDecoder().decode(ServerError.self, from: data) {
        throw AppError.parkRequestFailed(serverError.error.message)
      }
      else {
        throw AppError.parkRequestFailed("Unknown error occurred.")
      }
    }
  }
}
