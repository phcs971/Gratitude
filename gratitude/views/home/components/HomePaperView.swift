//
//  HomePaperView.swift
//  gratitude
//
//  Created by Pedro Henrique Cordeiro Soares on 30/09/21.
//

import SwiftUI

struct HomePaperView: View {
    @EnvironmentObject var vm: HomeViewModel
    
    var body: some View {
        RippedPaper(color: vm.rippedColor, rightRip: !vm.isState(.Normal)) { HomePaperChildView() }
        .frame(minWidth: 0, maxWidth: vm.isState(.Normal) ? 80 : .infinity, minHeight: 64, maxHeight: 64)
        .clipped()
        .shadow(color: .black.opacity(0.25), radius: 8, x: -2, y: 2)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 64, maxHeight: 64, alignment: .trailing)
        .padding(.bottom, 12)
        .padding(.horizontal, vm.isState(.Normal) ? 0 : 32)
        .transition(.move(edge: .trailing))
    }
}

struct HomePaperView_Previews: PreviewProvider {
    static var previews: some View {
        HomePaperView()
    }
}
