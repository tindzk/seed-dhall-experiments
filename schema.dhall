let DepFields = { organisation : Text, artefact : Text }

let WithVersion = { version : Text }

let Dep = < Java : DepFields ⩓ WithVersion | Scala : DepFields ⩓ WithVersion >

let ModuleFields =
      { root : Text, sources : List Text, deps : List Dep, scalaVersion : Text }

let WithJs = { scalaJsVersion : Text }

let WithNative = { scalaNativeVersion : Text }

let WithTestFrameworks = { testFrameworks : List Text }

let Module =
      < Jvm :
          ModuleFields
      | Js :
          ModuleFields ⩓ WithJs
      | Native :
          ModuleFields ⩓ WithNative
      | Shared :
          ModuleFields
      >

let TestModule =
      < Js :
          ModuleFields ⩓ WithJs ⩓ WithTestFrameworks
      | Jvm :
          ModuleFields ⩓ WithTestFrameworks
      | Native :
          ModuleFields ⩓ WithNative ⩓ WithTestFrameworks
      | Shared :
          ModuleFields ⩓ WithTestFrameworks
      >

let SimpleModule = { deps : List Dep, scalaVersion : Text }

in  { DepFields =
        DepFields
    , Dep =
        Dep
    , Module =
        Module
    , TestModule =
        TestModule
    , SimpleModule =
        SimpleModule
    , WithNative =
        WithNative
    , WithTestFrameworks =
        WithTestFrameworks
    }
