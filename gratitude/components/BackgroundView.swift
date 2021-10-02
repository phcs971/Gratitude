//
//  BackgroundView.swift
//  gratitude
//
//  Created by Pedro Henrique Cordeiro Soares on 28/09/21.
//

import SwiftUI

struct BackgroundView<Child: View>: View {
    private let child: Child
    
    init(@ViewBuilder child: () -> Child) {
        self.child = child()
    }
    
    var body: some View {
        child
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
            
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView {
            VStack {
                Text("Texto")
            }
        }
    }
}
