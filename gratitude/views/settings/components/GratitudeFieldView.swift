//
//  GratitudeFieldView.swift
//  gratitude
//
//  Created by Pedro Henrique Cordeiro Soares on 30/09/21.
//

import SwiftUI

struct GratitudeFieldView: View {
    @ObservedObject var viewModel: GratitudeViewModel
    @State private var showAlert = false
    
    var body: some View {
        HStack {
            if #available(iOS 15.0, *) {
                TextField("i_am_grateful".localized(), text: $viewModel.gratitude.text)
                    .onSubmit { viewModel.update() }
            } else {
                TextField("i_am_grateful".localized(), text: $viewModel.gratitude.text, onCommit:  { viewModel.update() })
            }
            Spacer()
            Button { viewModel.toggleColor()} label: {
                ColorSelectionView(color: viewModel.color, selectedColor: viewModel.color)
            }
            .frame(width: 32, height: 32)
        }

    }
}

struct GratitudeFieldView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            
        GratitudeFieldView(viewModel: GratitudeViewModel(GratitudeModel(text: "Teste")))
        }
    }
}
