//
//  JarView.swift
//  gratitude
//
//  Created by Pedro Henrique Cordeiro Soares on 30/09/21.
//

import SwiftUI
import SpriteKit

struct JarView: View {
    @EnvironmentObject var viewModel: JarViewModel
    
    var body: some View {
        SpriteView(scene: viewModel.scene, options: [.allowsTransparency])
            .aspectRatio(400 / 582, contentMode: .fit)
            .background(Color.clear)
            .padding()
    }
}

struct JarView_Previews: PreviewProvider {
    static var previews: some View {
        JarView().environmentObject(JarViewModel())
    }
}
