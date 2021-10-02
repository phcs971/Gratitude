//
//  HomeTopBarView.swift
//  gratitude
//
//  Created by Pedro Henrique Cordeiro Soares on 30/09/21.
//

import SwiftUI

struct HomeTopBarView: View {
    @EnvironmentObject var vm: HomeViewModel
    var body: some View {
        HStack(alignment: .top) {
            HomeLeadingIcon()
                .frame(width: 32)
                .padding(.horizontal, 24)
            
            Spacer()
            
            if !vm.isState(.Normal) {
                Text("i_am_grateful".localized())
                    .font(.custom("Noteworthy", size: 18))
                    .fontWeight(.bold)
            }
            
            Spacer()
            
            HomeLeadingIconImage()
                .frame(width: 32)
                .padding(.horizontal, 24)
                .opacity(0)
            
        }
        .padding(.vertical, 16)
    }
}

struct HomeTopBarView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTopBarView()
    }
}
