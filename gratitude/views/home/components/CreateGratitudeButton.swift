//
//  CreateGratitudeButton.swift
//  gratitude
//
//  Created by Pedro Henrique Cordeiro Soares on 30/09/21.
//

import SwiftUI

struct CreateGratitudeButton: View {
    @EnvironmentObject var vm: HomeViewModel
    var body: some View {
        Button {
            vm.createGratitude()
        } label: {
            Text("confirm".localized())
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 48, maxHeight: 48, alignment: .center)
                .background( Color.appPurple )
                .cornerRadius(12)
                .shadow(radius: 8)
                .padding(.horizontal, 32)
                .padding(.bottom, 8)
        }.disabled(vm.newGratitudeViewModel.text.isEmpty)
    }
}

struct CreateGratitudeButton_Previews: PreviewProvider {
    static var previews: some View {
        CreateGratitudeButton()
    }
}
