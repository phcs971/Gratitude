//
//  RippedPaper.swift
//  gratitude
//
//  Created by Pedro Henrique Cordeiro Soares on 28/09/21.
//

import SwiftUI

struct RippedPaper<Child: View>: View {
    var color: GratitudeColor
    var leftRip: Bool
    var rightRip: Bool
    
    private let child: Child
    
    init(color: GratitudeColor = .White, leftRip: Bool = true, rightRip: Bool = true, @ViewBuilder child: () -> Child) {
        self.color = color
        self.leftRip = leftRip
        self.rightRip = rightRip
        self.child = child()
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            if self.leftRip {
                Image("Ripped Left")
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .foregroundColor(color.color)
            }
            ZStack {
                color.color
                child
            }
            if self.rightRip {
                Image("Ripped Right")
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .foregroundColor(color.color)
            }
        }
    }
}

struct RippedPaper_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView {
            
            RippedPaper() {
                Text("123")
            }.frame(width: 200, height: 64)
        }
            
    }
}
