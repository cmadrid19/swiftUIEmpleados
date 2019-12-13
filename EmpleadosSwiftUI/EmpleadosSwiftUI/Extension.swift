//
//  Extension.swift
//  EmpleadosSwiftUI
//
//  Created by Dev1 on 13/09/2019.
//  Copyright © 2019 Dev1. All rights reserved.
//

import Foundation

extension Encodable {
    var dictionary: [String:Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String:Any] ?? [:]
    }
}
