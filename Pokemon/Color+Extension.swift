//
//  Color+Extension.swift
//  Pokemon
//
//  Created by Adjogbe  Tejiri on 14/07/2024.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

extension Color {
    static func colorForType(_ type: String) -> Color {
        switch type {
        case "normal":
            return Color(hex: "AAA67F")
        case "fire":
            return Color(hex: "F57D31")
        case "water":
            return Color(hex: "6493EB")
        case "grass":
            return Color(hex: "74CB48")
        case "poison":
            return Color(hex: "A43E9E")
        case "bug":
            return Color(hex: "A7B723")
        case "flying":
            return Color(hex: "A891EC")
        case "electric":
            return Color(hex: "F9CF30")
        case "ghost":
            return Color(hex: "70559B")
        case "psychic":
            return Color(hex: "FB5584")
        case "stell":
            return Color(hex: "B7B9D0")
        case "rock":
            return Color(hex: "B69E31")
        default:
            return Color.black
        }
    }
}

