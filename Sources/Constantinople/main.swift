import Commander
#if os(Linux) || os(FreeBSD)
import Glibc
#else
import Darwin.C
#endif

Group { group in

    let execute: (_ command: Command) -> Void = { command in
        do {
            try command.execute()
        } catch let error as ConstantinopleError {
            print("Failed with exit code \(error.code)")
            print()
            print("Reason: \(error.reason)")
            exit(error.code)
        } catch {
            print("*** TODO: Handle this case ***")
        }
    }

    let nameArgument = Argument<String>("name", description: "The name of your new package")
    let templateOption = Option<String>.init("templateUrl", default: CreateCommand.defaultTemplateUrl, flag: "u", description: "An optional custom template url (git)")
    group.command("create", nameArgument, templateOption) { name, template in
        let c = CreateCommand(libraryName: name, templateUrl: template.isEmpty ? nil : template)
        execute(c)
    }
}.run()
