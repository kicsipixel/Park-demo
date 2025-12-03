//
//  AddParkView.swift
//  ParkDemo
//
//  Created by Szabolcs Tóth on 26.11.2025.
//  Copyright © 2025 Szabolcs Tóth. All rights reserved.
//

import SwiftUI

struct AddParkView: View {
  // Private Properies
  @Environment(ParkViewModel.self) private var parkViewModel
  @State private var parkName = ""
  @State private var latitudeText = ""
  @State private var longitudeText = ""

  // Properties
  @Environment(\.dismiss) var dismiss

  var latitude: Double {
    Double(latitudeText) ?? 0.0
  }

  var longitude: Double {
    Double(longitudeText) ?? 0.0
  }

  var body: some View {
    ZStack {
      // Background
      Color.accent.opacity(0.05).ignoresSafeArea()

      // Content
      VStack(spacing: 20) {
        // Logo
        Image("LogoImage")

        // Textfields
        // Park name text field
        TextField("Park name", text: $parkName)
          .customTextFieldStyle(text: $parkName, image: "map")

        // Coordinates
        VStack {
          // Latittude text field
          TextField("Latitude", text: $latitudeText)
            .keyboardType(.decimalPad)
            .modifier(CustomTextFieldModifier(text: $latitudeText, image: "mappin"))

          // Longitude text field
          TextField("Longitude", text: $longitudeText)
            .keyboardType(.decimalPad)
            .modifier(CustomTextFieldModifier(text: $longitudeText, image: "mappin.and.ellipse"))
        }
        .keyboardType(.decimalPad)

        HStack(spacing: 20) {
          // Add button
          Button {
            Task {
              try await parkViewModel.createPark(
                from: ParkRequest(details: ParkRequest.Details(name: parkName), coordinates: ParkRequest.Coordinates(latitude: latitude, longitude: longitude))
              )
                
                try await parkViewModel.listParks()
                dismiss()
            }
          } label: {
            Text("Add")
          }
          .buttonStyle(GreenRoundedButtonStyle())

          // Cancel Button
          Button {
            dismiss()
          } label: {
            Text("Cancel")
          }
          .buttonStyle(InvertedGreenRoundedButtonStyle())
        }
      }
      .padding()
    }
  }
}

// MARK: - Preview
#Preview {
  AddParkView()
    .environment(ParkViewModel(networkManager: NetworkManager(path: "parks")))
}
