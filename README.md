### Initial setup

Project contains:

- Podfile and Cartfile to configure depdendencies.

To apply them run following commands:

- ` pod install ` 


### Micro Architecture

Project uses MVVM as micro architecture. Root directory of app contains "Templates" folder for Generamba templates.

run `generamba gen [MODULE_NAME] swift_mvvm` - to generate a new module


### Commit style

Project is commitizen-friendly. All of the project commits follow the [`commitizen format`](https://gist.github.com/stephenparish/9941e89d80e2bc58a153#format-of-the-commit-message):

```
<type>(<optional_scope>): <subject>
<BLANK LINE>
<optional_body>
```

#### Examples

```
fix(transfers): fixed rerouting bug for cash by code transfer operation

Please see files cash.ts and cash.service.ts and take a look at new private methods. Make sure you understand new rerouting algorithm.
```

```
feat: implemented new authorization logic for trusted users
```

Note that `<scope>` is optional, but we highly encourage to include JIRA ticket ID, for example `ABC-777`.
Note: verbs are used in Past Tense

#### Action types and verb format

List of action types:

- `feat` - adding new functionality/logic
- `fix` - fixing functional bugs or non-functional defects
- `refactor` - refactoring source code
- `build` - editing build system, tooling scripts (e.g. - gradle, build phases, makefile etc)
- `docs` - creating/editing README, other docs or code comments
- `chore` - changes that are not bound by any action type listed above

Commit message should **describe some completed action**. There is no strict grammatic rule on sentence composing. 

Following commit messages are valid:

- `fix: fixed broken button height in payments`
- `feat(ABC-123): extended validation logic in transfer form`
- `refactor: all legacy methods are removed from some Service layer class`

* Make sure you run `npm install` at the beginning

Please use [`commitizen`](http://commitizen.github.io/cz-cli/) command-line tool for generating commit messages if you feel uncomfortable manually writing all these strongly-formatted messages (we all do).
After running `git add`, run `git cz` instead of regular commit command. You will be taken through message building steps.

* [Commitizen docs](http://commitizen.github.io/cz-cli)
*  [Extensive article in russian](https://anvilabs.co/blog/writing-practical-commit-messages/)
*  [Another article russian](https://habr.com/company/yandex/blog/431432/)


### Generamba module generation

Project uses generamba tool for new module boilerplate code generation. You should install it using `gem` or `brew` (make sure you have ruby and rvm installed).

If you want to create module "Something", then use:

` generamba gen Something swift_name ` - for NAME module

This will create a number of source+test files and add them automatically to `Source/Modules/`.

* [Generamba repo page](https://github.com/rambler-digital-solutions/Generamba)

### SwiftGen

Our team uses SwiftGen for resources: LocalizableStrings, Assets, AppConfigs. 

All info is in `swiftgen.yml` file. To add new resources modify it. Files are accesible in `mutually/Generated`

To lint and apply any modifications of `swiftgen.yml` file:
    run `swiftgen config lint` from command line tool,
    next run `swiftgen` to generate new outputs

* [SwiftGen repo page](https://github.com/SwiftGen/SwiftGen)

