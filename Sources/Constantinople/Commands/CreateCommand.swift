//
//  CreateCommand.swift
//  Constantinople
//
//  Created by Koray Koska on 10.04.18.
//

import Foundation
import Clibgit2
import PathKit

struct CreateCommand: Command {

    static let defaultTemplateUrl = "https://github.com/CocoaPods/pod-template"

    let libraryName: String
    let templateUrl: String

    enum Error: ConstantinopleError {

        case cloneFailed(reason: String, code: Int32)

        var reason: String {
            switch self {
            case .cloneFailed(let reason, _):
                return reason
            }
        }

        var code: Int32 {
            switch self {
            case .cloneFailed(_, let code):
                return code
            }
        }
    }

    init(libraryName: String, templateUrl: String? = nil) {
        self.libraryName = libraryName
        self.templateUrl = templateUrl ?? CreateCommand.defaultTemplateUrl
    }

    func execute() throws {
        // Initialize libgit2
        git_libgit2_init()
        defer {
            // Shutdown libgit2 global state
            git_libgit2_shutdown()
        }

        // Run git clone
        print("Cloning `\(self.templateUrl)` into `\(self.libraryName)`.")

        var repo: OpaquePointer? = nil
        let templateUrl = self.templateUrl.cString(using: .utf8)
        let libraryName = self.libraryName.cString(using: .utf8)
        guard git_clone(&repo, templateUrl, libraryName, nil) == 0 else {
            throw Error.cloneFailed(reason: String(cString: giterr_last().pointee.message), code: -1)
        }
        git_repository_free(repo)

        // Configure template
        print("Configuring \(self.libraryName)...")
        let path = Path.current + Path(self.libraryName)
        path.chdir {
            if Path("configure").exists {
                shell("./configure", self.libraryName)
            } else {
                print("Warning: Template does not have a configuration file.")
            }
        }
    }
}
