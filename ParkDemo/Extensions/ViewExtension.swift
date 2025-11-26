//
//  ViewExtension.swift
//  ParkDemo
//
//  Created by Szabolcs Tóth on 26.11.2025.
//  Copyright © 2025 Szabolcs Tóth. All rights reserved.
//

import SwiftUI

extension View {
    func customTextFieldStyle(text: Binding<String>, image: String) -> some View {
        self.modifier(CustomTextFieldModifier(text: text, image: image))
    }
    
    func customSecureFieldStyle(password: Binding<String>) -> some View {
        self.modifier(CustomSecureFieldModifier(password: password, image: "key"))
    }
}
