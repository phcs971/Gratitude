//
//  DeleteAllButton.swift
//  gratitude
//
//  Created by Pedro Henrique Cordeiro Soares on 30/09/21.
//

import SwiftUI

struct DeleteAllButton: View {
    @EnvironmentObject var vm: SettingsViewModel
    @State private var showAlert = false
    
    var body: some View {
        Button { showAlert.toggle() } label: { Text("delete_all".localized())
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 48, maxHeight: 48, alignment: .center)
                .background( Color.red )
                .cornerRadius(12)
                .padding(.top, 8)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("are_you_sure".localized()),
                        message: Text("delete_forever".localized()),
                        primaryButton: .destructive(Text("yes".localized()), action: vm.deleteAll),
                        secondaryButton: .cancel()
                    )
                }
        }
    }
}

struct DeleteAllButton_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAllButton()
    }
}
