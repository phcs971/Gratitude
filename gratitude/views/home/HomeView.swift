//
//  HomeView.swift
//  gratitude
//
//  Created by Pedro Henrique Cordeiro Soares on 28/09/21.
//

import SwiftUI


struct HomeView: View {
    @ObservedObject var vm = HomeViewModel()
    
    @ObservedObject var jarViewModel = JarViewModel()
    
    var body: some View {
        return BackgroundView {
            VStack {
                HomeTopBarView()

                HomePaperView()
                
                if vm.isState(.Add) {
                    ColorPickerView()
                    
                    CreateGratitudeButton()
                }
                
                Spacer()
                
                JarButton().environmentObject(jarViewModel)
                
                if vm.canShowGratitude {
                    Text("tap_the_jar".localized())
                        .font(.custom("Noteworthy", size: 14))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 64)
                        .padding(.bottom, 24)
                        .transition(.move(edge: .bottom))
                }
            }
        }
        .environmentObject(vm)
        .navigationBarHidden(true)
        .onAppear { vm.gratitudeRepository.read() }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView { HomeView() }.accentColor(.black)
    }
}
