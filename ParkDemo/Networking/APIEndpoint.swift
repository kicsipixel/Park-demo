//
//  APIEndpoint.swift
//  ParkDemo
//
//  Created by Szabolcs Tóth on 26.11.2025.
//  Copyright © 2025 Szabolcs Tóth. All rights reserved.
//

import Foundation

/// Your server IP address or domain.
/// Localhost (127.0.0.1) The port (8080) is handled in the APIRouter.swift.
public enum APIEndpoint {
    
    public static var baseURL = "127.0.0.1"
    
    /// Add base url without HTTP scheme. e.g. apple.com
    public static func setBaseURL(_ url: String) {
        self.baseURL = url
    }
}
