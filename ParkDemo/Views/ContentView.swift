//
//  ContentView.swift
//  ParkDemo
//
//  Created by Szabolcs Tóth on 25.11.2025.
//  Copyright © 2025 Szabolcs Tóth. All rights reserved.
//

import SwiftUI

struct ContentView: View {
  @Environment(ParkViewModel.self) private var parkViewModel
  @Environment(\.usersController) private var usersController: UsersController
  @AppStorage("isAuthenticated") private var isAuthenticated: Bool = false
  @State private var errorMessage: String?
  @State private var showErrorAlert = false
  @State private var showLoginView: Bool = false
  @State private var showAddParkView: Bool = false

  var body: some View {
    content
      .task {
        do {
          try await parkViewModel.listParks()
          isAuthenticated = try await usersController.verifyToken()
        }
        catch {
          errorMessage = error.localizedDescription
          showErrorAlert = true
        }
      }
      .alert("Error happened", isPresented: $showErrorAlert) {
        Button("Got it!", role: .cancel) {}
      } message: {
        if let message = errorMessage {
          Text(message)
        }
      }
      .fullScreenCover(isPresented: $showAddParkView) {
        AddParkView()
      }
  }

  @ViewBuilder
  var content: some View {
    ZStack {

      // MARK: - Main content
      NavigationStack {
        ZStack {
          // Background color
          Color.accent.opacity(0.05).ignoresSafeArea()

          Group {
            if parkViewModel.parks.count > 0 {
              VStack {
                // Logo
                Image("LogoImage")

                // List view
                ListView(parks: parkViewModel.parks, isAuthenticated: $isAuthenticated, errorMessage: $errorMessage, showErrorAlert: $showErrorAlert, showLoginView: $showLoginView)
              }
            }
            else {
              Image("BackgroundImage")
            }
          }
          .toolbar {
            AppToolbarView(
              isAuthenticated: $isAuthenticated,
              errorMessage: $errorMessage,
              showErrorAlert: $showErrorAlert,
              showLoginView: $showLoginView,
              showAddParkView: $showAddParkView
            )
          }
        }
      }

      // MARK: - Overlay when not authenticated
      if showLoginView {
        ZStack {
          BlurView(style: .light)
            .opacity(0.95)
            .ignoresSafeArea()

          LoginView(showLoginView: $showLoginView)
        }
        .transition(.opacity)
      }
    }
    .animation(.easeInOut(duration: 1), value: showLoginView)
  }
}

// MARK: - Preview
#Preview {
  ContentView()
    .environment(ParkViewModel(networkManager: NetworkManager(path: "parks")))
}
