//
//  ButtonStyle.swift
//  ParkDemo
//
//  Created by Szabolcs Tóth on 26.11.2025.
//  Copyright © 2025 Szabolcs Tóth. All rights reserved.
//

import SwiftUI

// Regular button
struct GreenRoundedButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(.horizontal, 20)
      .padding(.vertical, 10)
      .background(
        RoundedRectangle(cornerRadius: 8)
          .fill(configuration.isPressed ? .accent.opacity(0.6) : .accent)
      )
      .foregroundColor(.white)
      .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
      .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
  }
}

// "Cancel" button
struct InvertedGreenRoundedButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(.horizontal, 20)
      .padding(.vertical, 10)
      .background(
        RoundedRectangle(cornerRadius: 8)
          .fill(configuration.isPressed ? .white.opacity(0.6) : .white)
      )
      .overlay(
        RoundedRectangle(cornerRadius: 8)
          .stroke(.accent, lineWidth: 1)
      )
      .foregroundColor(.accent)
      .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
      .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)

  }
}
