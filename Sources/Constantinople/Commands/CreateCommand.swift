//
//  CreateCommand.swift
//  Constantinople
//
//  Created by Koray Koska on 10.04.18.
//

import Foundation

struct CreateCommand: Command {

    let libraryName: String

    init(libraryName: String) {
        self.libraryName = libraryName
    }

    func execute() throws {
    }
}
