//
//  ConstantinopleError.swift
//  Constantinople
//
//  Created by Koray Koska on 11.04.18.
//

import Foundation

protocol ConstantinopleError: Error {

    var reason: String { get }
    var code: Int32 { get }
}
