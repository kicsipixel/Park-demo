//
//  CustomErrors.swift
//  ParkDemo
//
//  Created by Szabolcs Tóth on 25.11.2025.
//  Copyright © 2025 Szabolcs Tóth. All rights reserved.
//

import Foundation

enum AppError: LocalizedError {
    case loginFailed(String)
    case parkRequestFailed(String)
    case tokenExpired(String)

    var errorDescription: String? {
        switch self {
        case .loginFailed:
            return NSLocalizedString(
                "Login failed. Please, check your username and password.",
                comment: "Login failure"
            )
        case .parkRequestFailed:
            return NSLocalizedString(
                "Unable to load parks. Please try again later.",
                comment: "Park request failure"
            )
        case .tokenExpired:
            return NSLocalizedString(
                "Your session has expired. Please log in again.",
                comment: "Token expired"
            )
        }
    }

    var recoverySuggestion: String? {
        switch self {
        case .loginFailed:
            return NSLocalizedString(
                "Make sure your credentials are correct and try again.",
                comment: "Recovery suggestion for login failure"
            )
        case .parkRequestFailed:
            return NSLocalizedString(
                "Check your network connection or contact support if the issue persists.",
                comment: "Recovery suggestion for park request failure"
            )
        case .tokenExpired:
            return NSLocalizedString(
                "Log in again to refresh your session and continue.",
                comment: "Recovery suggestion for token expired"
            )
        }
    }
}

