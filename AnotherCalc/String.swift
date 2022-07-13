//
//  String.swift
//  LCARS_calculator
//
//  Created by Andy Lewis on 7/11/22.
//  Copyright © 2022 Andrew Lewis. All rights reserved.
//

import Foundation

// Thank you CryingHippo on StackOverflow: https://stackoverflow.com/a/38481180
extension String  {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
