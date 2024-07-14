//
//  SearchView.swift
//  Pokemon
//
//  Created by Adjogbe  Tejiri on 14/07/2024.
//

import SwiftUI

struct SearchField: View {
    @Binding var text: String
    let label: String
    var body: some View {
        ZStack {
            HStack {
                TextField(text: $text) { Text(label) }
                    .padding(.all, 18)
                Spacer()
                HStack(spacing: 0) {
                    Divider()
                        .frame(width: 1.5, height: 30)
                        .overlay(.grey)
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.grey)
                        .padding()
                }
            }
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(style: .init(lineWidth: 2))
                    .foregroundStyle(.grey)
            }
        }
    }
    
}

#Preview {
    SearchField(text: .constant("Hello"), label: "Enter Name")
}

