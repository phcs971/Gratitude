//
//  ColorPickerView.swift
//  gratitude
//
//  Created by Pedro Henrique Cordeiro Soares on 30/09/21.
//

import SwiftUI

struct ColorPickerView: View {
    @EnvironmentObject var vm: HomeViewModel
    
    var body: some View {
        HStack {
            ForEach(GratitudeColor.allCases) { color in
                Button { vm.setNewColor(color) } label: {
                    ColorSelectionView(color: color, selectedColor: vm.newGratitudeViewModel.color)
                }
            }
        }
        .frame(height: 48)
        .padding(.horizontal, 32)
        .padding(.bottom, 8)
    }
}

struct ColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView()
    }
}
