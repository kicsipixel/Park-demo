//
//  ParkRequest.swift
//  ParkDemo
//
//  Created by Szabolcs Tóth on 25.11.2025.
//  Copyright © 2025 Szabolcs Tóth. All rights reserved.
//

import Foundation

struct ParkRequest: Codable {
    struct Details: Codable {
        let name: String
    }
    struct Coordinates: Codable {
        let latitude: Double
        let longitude: Double
    }

    let details: Details
    let coordinates: Coordinates
    
    init(details: Details, coordinates: Coordinates) {
        self.details = details
        self.coordinates = coordinates
    }
}
