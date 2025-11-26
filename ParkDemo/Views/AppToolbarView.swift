//
//  AppToolbarView.swift
//  ParkDemo
//
//  Created by Szabolcs Tóth on 26.11.2025.
//  Copyright © 2025 Szabolcs Tóth. All rights reserved.
//

import SwiftUI

struct AppToolbarView: ToolbarContent {
    @Binding var isAuthenticated: Bool
    @Binding var errorMessage: String?
    @Binding var showErrorAlert: Bool
    @Binding var showLoginView: Bool
    @Binding var showAddParkView: Bool

    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            Button {
                if !isAuthenticated {
                    errorMessage = "Please log in to add a park."
                    showErrorAlert = true
                } else {
                    showAddParkView = true
                }
            } label: {
                Image(systemName: "plus")
                    .foregroundStyle(.accent)
            }

            Button {
                if !isAuthenticated {
                    showLoginView.toggle()
                }
            } label: {
                Image(systemName: isAuthenticated ? "lock.open" : "lock.fill")
                    .foregroundStyle(.accent)
            }
        }
    }
}

