//
//  HomeLeadingIconImage.swift
//  gratitude
//
//  Created by Pedro Henrique Cordeiro Soares on 30/09/21.
//

import SwiftUI

struct HomeLeadingIconImage: View {
    @EnvironmentObject var vm: HomeViewModel
    
    var image: String {
        get {
            switch vm.state {
            case .Add:
                return "xmark"
            case .Normal:
                return "line.horizontal.3"
            case .Read:
                return "chevron.backward"
            }
        }
    }
    
    var body: some View {
        Image(systemName: image)
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(.black)
    }
}

struct HomeLeadingIconImage_Previews: PreviewProvider {
    static var previews: some View {
        HomeLeadingIconImage()
    }
}
