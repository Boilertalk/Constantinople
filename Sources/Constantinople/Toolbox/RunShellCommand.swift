//
//  RunShellCommand.swift
//  Constantinople
//
//  Created by Koray Koska on 11.04.18.
//

import Foundation

@discardableResult
func shell(_ args: String...) -> Int32 {
    let task = Process()
    task.launchPath = "/usr/bin/env"
    task.arguments = args

    task.launch()
    task.waitUntilExit()
    return task.terminationStatus
}
