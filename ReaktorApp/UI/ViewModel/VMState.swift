//
//  VMState.swift
//  Reaktor
//
//  Created by Kirill Ivonin on 05/11/2022.
//

import Foundation

enum VMState: Equatable {
    case loading
    case completed
    case error(String)
}
