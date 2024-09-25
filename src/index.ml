open Typedoc

let setup_option app =
  app
    |> Application.get_options
    |> Configuration.Options.addDeclaration "test"

let setup_injector application =
  let renderer = Application.get_renderer application
in
  renderer
    |> Renderer.get_hooks
    |> EventHooks.on
      "body.end"
      (fun (h) -> ignore h; JSX.createElement "nothing" Js.null)

let load application =
  setup_option application ;
  setup_injector application
