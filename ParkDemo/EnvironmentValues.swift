//
//  EnvironmentValues.swift
//  ParkDemo
//
//  Created by Szabolcs Tóth on 25.11.2025.
//  Copyright © 2025 Szabolcs Tóth. All rights reserved.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var usersController = UsersController(httpClient: HTTPClient())
}
