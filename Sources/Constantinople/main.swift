import Commander

Group { group in

    let execute: (_ command: Command) -> Void = { command in
        do {
            try command.execute()
        } catch {
            print("*** TODO: Handle this case ***")
        }
    }

    group.command("create", Argument<String>("name", description: "The name of your new package")) { name in
        let c = CreateCommand(libraryName: name)
        execute(c)
    }
}.run()
