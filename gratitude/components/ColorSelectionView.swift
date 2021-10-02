//
//  ColorSelectionView.swift
//  gratitude
//
//  Created by Pedro Henrique Cordeiro Soares on 29/09/21.
//

import SwiftUI

struct ColorSelectionView: View {
    var color: GratitudeColor
    var selectedColor: GratitudeColor
    var body: some View {
        ZStack {
            
            Circle()
                .foregroundColor(
                    .white.opacity(selectedColor == color ? 1 : 0.3)
                )
            Circle()
                .padding(.all, 4)
                .foregroundColor(color.color)
            Circle()
                .strokeBorder(.black.opacity(0.15))
                .padding(.all, 4)
        }
    }
}

struct ColorSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        let selected = GratitudeColor.Red
        BackgroundView {
            HStack {
                ColorSelectionView(color: .Blue, selectedColor: selected)
                ColorSelectionView(color: .White, selectedColor: selected)
                ColorSelectionView(color: .Red, selectedColor: selected)
            }.frame(height: 48)
        }
    }
}
