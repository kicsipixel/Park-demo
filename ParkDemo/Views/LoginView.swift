//
//  LoginView.swift
//  ParkDemo
//
//  Created by Szabolcs Tóth on 25.11.2025.
//  Copyright © 2025 Szabolcs Tóth. All rights reserved.
//

import SwiftUI

struct LoginView: View {
  // Private Properties
  @Environment(\.usersController) private var usersController: UsersController
  @State private var username = ""
  @State private var password = ""
  @State private var errorMessage: String?
  @State private var showErrorAlert = false

  // Properties
  @AppStorage("isAuthenticated") private var isAuthenticated: Bool = false
  @Binding var showLoginView: Bool

  var body: some View {
    content
      .padding()
      .alert("Error", isPresented: $showErrorAlert, presenting: errorMessage) { _ in
        Button("OK", role: .cancel) {}
      } message: { msg in
        Text(msg)
      }
  }

  @ViewBuilder
  var content: some View {
    VStack(spacing: 20) {
      // Logo
      Image("LogoImage")

      // Textfields
      TextField("E-mail", text: $username)
        .customTextFieldStyle(text: $username, image: "envelope")
      SecureField("Password", text: $password)
        .customSecureFieldStyle(password: $password)

      // Buttons
      HStack {
        Button("Login") {
          Task { await login() }
        }
        .buttonStyle(GreenRoundedButtonStyle())

        Button("Cancel") {
          showLoginView = false
        }
        .buttonStyle(InvertedGreenRoundedButtonStyle())
      }
    }
    .padding(.bottom, 50)
  }

  // Functions
  private func login() async {
    do {
      try await usersController.login(username: username, password: password)
      isAuthenticated = true
      showLoginView = false
    }
    catch {
      errorMessage = error.localizedDescription
      showErrorAlert = true
    }
  }
}

// MARK: - Preview
#Preview {
  LoginView(showLoginView: .constant(false))
}
