//
//  HomeLeadingIcon.swift
//  gratitude
//
//  Created by Pedro Henrique Cordeiro Soares on 30/09/21.
//

import SwiftUI

struct HomeLeadingIcon: View {
    @EnvironmentObject var vm: HomeViewModel
    var body: some View {
        if vm.isState(.Normal) {
            NavigationLink(destination: SettingsView()) { HomeLeadingIconImage() }  
        } else {
            Button { vm.setHomeState(.Normal) } label: { HomeLeadingIconImage() }
        }
    }
}

struct HomeLeadingIcon_Previews: PreviewProvider {
    static var previews: some View {
        HomeLeadingIcon()
    }
}
