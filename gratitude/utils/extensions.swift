//
//  extensions.swift
//  gratitude
//
//  Created by Pedro Henrique Cordeiro Soares on 01/10/21.
//

import Foundation
import SwiftUI

extension Bundle {
    public static func localizedBundle() -> Bundle? {
        if let path = Bundle.main.path(forResource: SettingsService.instance.language, ofType: "lproj") {
            return Bundle(path: path)
        }
        return .main
    }
}

extension String {
    func localized() -> String { NSLocalizedString(self, tableName: nil, bundle: .localizedBundle() ?? .main, value: "", comment: "") }
    
    func localizeWithFormat(arguments: CVarArg...) -> String { String(format: self.localized(), arguments: arguments) }
}

extension NavigationLink where Label == EmptyView, Destination == EmptyView {

   /// Useful in cases where a `NavigationLink` is needed but there should not be
   /// a destination. e.g. for programmatic navigation.
   static var empty: NavigationLink {
       self.init(destination: EmptyView(), label: { EmptyView() })
   }
}
