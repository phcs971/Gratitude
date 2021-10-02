//
//  SettingsView.swift
//  gratitude
//
//  Created by Pedro Henrique Cordeiro Soares on 28/09/21.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var vm = SettingsViewModel()
    @ObservedObject var settings = SettingsService.instance
    
    
    init() {
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        BackgroundView {
            List {
                Section(
                    header: Text("settings".localized())
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                ) {
                    Menu {
                        ForEach(settings.availableLanguages) { lang in
                            Button(lang.language, action: { settings.setLanguage(lang) })
                        }
                    } label: {
                        HStack {
                            Text("language".localized())
                            Spacer()
                            Text(settings.currentLanguage.language)
                                .foregroundColor(Color.gray)
                        }
                    }
                    .listRowBackground(Color.clear)
                    Toggle("show_notifications".localized(), isOn: $settings.showNotifications)
                        .listRowBackground(Color.clear)
                }
                Section(
                    header: Text("your_gratitudes".localized())
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                ) {
                    if !vm.gratitudes.isEmpty {
                        
                        ForEach(vm.gratitudes) {
                            GratitudeFieldView(viewModel: $0).listRowBackground(Color.clear)
                        }.onDelete(perform: vm.delete(at:))
                        
                        DeleteAllButton()
                            .listRowBackground(Color.clear)
                        
                    } else {
                        
                        Text("no_gratitudes".localized())
                            .listRowBackground(Color.clear)
                        
                    }
                    
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        }
        .environmentObject(vm)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { vm.gratitudeRepository.read() }
    }
}
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView { SettingsView() }.accentColor(.black)
    }
}
