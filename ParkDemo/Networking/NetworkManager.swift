//
//  NetworkManager.swift
//  ParkDemo
//
//  Created by Szabolcs Tóth on 26.11.2025.
//  Copyright © 2025 Szabolcs Tóth. All rights reserved.
//

import Foundation

public final class NetworkManager {
  ///
  /// Give the server specific path
  /// e.g. "parks" for /api/v1/parks
  ///
  let path: String

  public init(path: String) {
    self.path = path
  }

  // MARK: - USERS
  // MARK: - verify token
  func verifyToken() async throws -> VerifyResponse {
    let endpoint = ParkAPI.listParks(path: "users/verify")
    let components = buildULR(endpoint: endpoint)

    guard let url = components.url else {
      throw AppError.invalidURL
    }

    var request = URLRequest(url: url)
    if let token = Keychain<String>.get("jwttoken") {

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

  // MARK: - login
  func login(username: String, password: String) async throws -> LoginResponse {
    // Build "username:password"
    let loginString = "\(username):\(password)"

    print(loginString)
    guard let loginData = loginString.data(using: .utf8) else {
      throw URLError(.badURL)
    }
    let base64LoginString = loginData.base64EncodedString()

    let endpoint = ParkAPI.loginUser(path: "users/login")
    let components = buildULR(endpoint: endpoint)

    guard let url = components.url else {
      throw AppError.invalidURL
    }

    var request = URLRequest(url: url)
    request.httpMethod = endpoint.method.rawValue
    request.addValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")

    let (data, response) = try await URLSession.shared.data(for: request)

    guard let httpResponse = response as? HTTPURLResponse else {
      throw URLError(.badServerResponse)
    }

    if httpResponse.statusCode == 200 {
      return try JSONDecoder().decode(LoginResponse.self, from: data)
    }
    else {
      print(httpResponse.statusCode)
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

  // MARK: - PARKS
  // MARK: - lists parks
  func listAllParks() async throws -> [Park] {
    let endpoint = ParkAPI.listParks(path: self.path)
    let components = buildULR(endpoint: endpoint)

    guard let url = components.url else {
      throw AppError.invalidURL
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
