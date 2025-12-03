//
//  APIRouter.swift
//  ParkDemo
//
//  Created by Szabolcs Tóth on 26.11.2025.
//  Copyright © 2025 Szabolcs Tóth. All rights reserved.
//

import Foundation

/// HTTP methods
public enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"
}

/// During the testing `http` can be rquired. The production server uses `https`.
public enum HTTPScheme: String {
  case http
  case https
}

/// Protocol description.
public protocol API {
  var scheme: HTTPScheme { get }
  var baseURL: String { get }
  var port: Int? { get }
  var path: String { get }
  var method: HTTPMethod { get }
}

public enum ParkAPI: API {
  /// Verifies JWT token
  case verifyToken(path: String)
  /// Logins user
  case loginUser(path: String)
  /// Lists all parks
  case listParks(path: String)
  /// Creates park
  case createPark(path: String)

  /// Connecting to `127.0.0.1` will use `http`. Otherwise it is production and uses `https`.
  public var scheme: HTTPScheme {
    switch self {
    case .verifyToken,
      .loginUser,
      .listParks,
      .createPark:
      if isIPAddressNumeric(APIEndpoint.baseURL) {
        return .http
      }
      else {
        return .https
      }
    }
  }

  /// If test is needed, please use `APIEndPoint.swift`.
  public var baseURL: String {
    switch self {
    case .verifyToken,
      .loginUser,
      .listParks,
      .createPark:
      return APIEndpoint.baseURL
    }
  }

  /// Hummingbird test server used port: 8080.
  public var port: Int? {
    switch self {
    case .verifyToken,
      .loginUser,
      .listParks,
      .createPark:
      if APIEndpoint.baseURL == "127.0.0.1" {
        return 8080
      }
      else {
        return nil
      }
    }
  }

  /// APIEndpoints can be found here: ...
  public var path: String {
    switch self {
    case .verifyToken(let path):
      return "/api/v1/\(path)"
    case .loginUser(let path):
      return "/api/v1/\(path)"
    case .listParks(let path),
      .createPark(let path):
      return "/api/v1/\(path)"
    }
  }

  /// HTTPMethods can be found beside the APIEndpoints: ...
  public var method: HTTPMethod {
    switch self {
    case .verifyToken,
      .listParks:
      return .get
    case .loginUser,
      .createPark:
      return .post
    }
  }
}

/// Build url from components defined in APIRouter
public func buildULR(endpoint: API) -> URLComponents {
  var components = URLComponents()
  components.scheme = endpoint.scheme.rawValue
  components.host = endpoint.baseURL
  components.port = endpoint.port
  components.path = endpoint.path
  return components
}

/// Function to check if the IP address contains numbers only or it is a domain name.
func isIPAddressNumeric(_ string: String) -> Bool {
  let pattern = "^[0-9.]+$"
  return string.range(of: pattern, options: .regularExpression) != nil
}
