//
//  ListView.swift
//  ParkDemo
//
//  Created by Szabolcs Tóth on 26.11.2025.
//  Copyright © 2025 Szabolcs Tóth. All rights reserved.
//

import SwiftUI

struct ListView: View {
  // Private Properties
  @Environment(ParkViewModel.self) private var parkViewModel
  // Properties
  let parks: [Park]
  @Binding var isAuthenticated: Bool
  @Binding var errorMessage: String?
  @Binding var showErrorAlert: Bool
  @Binding var showLoginView: Bool

  var body: some View {
    content
  }

  @ViewBuilder
  var content: some View {
    List {
      ForEach(parks, id: \.id) { park in
        NavigationLink {
          DetailsView(latitude: Double(park.coordinates.latitude), longitude: Double(park.coordinates.longitude), parkName: park.details.name)
        } label: {
          VStack {
            HStack {
              Image("LeafImage")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
              Text(park.details.name)
                .font(.headline)
            }
          }
        }
      }
      .foregroundStyle(.accent)
      .listRowBackground(Color.accent.opacity(0.05))
      .listRowSeparatorTint(.accent.opacity(0.3))
    }
    .refreshable {
        Task {
            try? await parkViewModel.listParks()
        }
    }
    .scrollContentBackground(.hidden)
    .listStyle(.grouped)
  }
}

// MARK: - Preview
#Preview {
  ListView(parks: [Park](), isAuthenticated: .constant(false), errorMessage: .constant(""), showErrorAlert: .constant(false), showLoginView: .constant(false))
    .environment(ParkViewModel(networkManager: NetworkManager(path: "parks")))
}
