//
//  String+localized.swift
//  AdiChallenge
//
//  Created by Magdy Kamal on 26/03/2021.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
