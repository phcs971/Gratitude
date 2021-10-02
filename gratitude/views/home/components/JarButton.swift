//
//  JarButton.swift
//  gratitude
//
//  Created by Pedro Henrique Cordeiro Soares on 30/09/21.
//

import SwiftUI

struct JarButton: View {
    @EnvironmentObject var vm: HomeViewModel
    
    var body: some View {
        Button { vm.setHomeState(.Read) } label: {
            JarView()
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
        }.disabled(!vm.canShowGratitude)
    }
}

struct JarButton_Previews: PreviewProvider {
    static var previews: some View {
        JarButton()
    }
}
