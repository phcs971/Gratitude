//
//  HomePaperChildView.swift
//  gratitude
//
//  Created by Pedro Henrique Cordeiro Soares on 30/09/21.
//

import SwiftUI

struct HomePaperChildView: View {
    @EnvironmentObject var vm: HomeViewModel
    var body: some View {
        switch vm.state {
        case .Normal:
            Button { vm.setHomeState(.Add) } label: {
                Image(systemName: "plus")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
            }.disabled(!vm.isState(.Normal))
        case .Add:
            TextField("type_here".localized(), text: $vm.newGratitudeViewModel.gratitude.text)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .font(.custom("Noteworthy", size: 18))
        case .Read:
            Text(vm.showGratitudeViewModel.text)
                .multilineTextAlignment(.center)
                .font(.custom("Noteworthy", size: 18))
        }
    }
}

struct HomePaperChildView_Previews: PreviewProvider {
    static var previews: some View {
        HomePaperChildView()
    }
}
