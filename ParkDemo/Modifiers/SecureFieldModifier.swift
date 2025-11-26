//
//  SecureFieldModifier.swift
//  ParkDemo
//
//  Created by Szabolcs Tóth on 26.11.2025.
//  Copyright © 2025 Szabolcs Tóth. All rights reserved.
//

import SwiftUI

struct CustomSecureFieldModifier: ViewModifier {

  // Private properties
  // Properties
  @Binding var password: String
  let image: String

  func body(content: Content) -> some View {
    HStack {
      Image(systemName: "\(image)")
        .foregroundStyle(password.isEmpty ? .accent.opacity(0.8) : .accent)
        .padding(.leading)

      content
        .foregroundStyle(.accent)
        .textInputAutocapitalization(.never)
        .padding(.vertical)
    }
    .overlay(
      RoundedRectangle(cornerRadius: 5)
        .stroke(password.isEmpty ? .accent.opacity(0.2) : .accent, lineWidth: 1)
    )
    .animation(.easeInOut(duration: 0.8), value: password.isEmpty)
    .background(password.isEmpty ? .accent.opacity(0.2) : .accent.opacity(0.05))
    .cornerRadius(5)
  }
}
