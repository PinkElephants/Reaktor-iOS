//
//  Bundle+Extensions.swift
//  ReaktorTests
//
//  Created by Kirill Ivonin on 04/11/22.
//

import Foundation
/// This exists as reference for the bundle extension
class PinnedTestClass { }

extension Bundle {
    static func jsonData(for localFileName: String) -> Data {
        let bundle = Bundle(for: PinnedTestClass.self)
        let url = bundle.url(forResource: localFileName, withExtension: "json")!
        return try! Data(contentsOf: url)
    }
}
