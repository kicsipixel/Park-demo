//
//  DetailsView.swift
//  ParkDemo
//
//  Created by Szabolcs Tóth on 26.11.2025.
//  Copyright © 2025 Szabolcs Tóth. All rights reserved.
//

import MapKit
import SwiftUI

struct DetailsView: View {
    // Properties
    let latitude: Double
    let longitude: Double
    let parkName: String
    
    // Computed property
    var cameraPosition: MapCameraPosition {
        .region(
            MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                latitudinalMeters: 1200,
                longitudinalMeters: 1200
            )
        )
    }
    
    var body: some View {
        ZStack {
            Color.accent.opacity(0.05).ignoresSafeArea()
            VStack {
                Map(initialPosition: cameraPosition) {
                    Marker(parkName, systemImage: "leaf", coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
                }.frame(height: UIScreen.main.bounds.height / 1.3)
                ZStack {
                    Circle()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.white)
                        .overlay {
                            Circle()
                                .stroke()
                        }
                       
                      
                 Image("LeafImage")
                        .foregroundStyle(.white)
                        .offset(x:5, y:5)
                }
                .offset(y: -50)
                
                VStack {
                    Text("\(parkName)")
                        .font(Font.body.bold())
                    
                    Text("\(latitude) - \(longitude)")
                        .font(Font.subheadline)
                        
                }
                .offset(y: -40)
            }
            .foregroundStyle(.accent)
        }
    }
}

// MARK: - Preview
#Preview {
    DetailsView(latitude: 50.09, longitude: 14.42, parkName: "Demo park")
}
