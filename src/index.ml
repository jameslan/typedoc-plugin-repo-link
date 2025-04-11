open Typedoc

let setup_option app =
  app
    |> Application.get_options
    |> Configuration.Options.addDeclaration "test"

let toolbar (origin_toolbar: DefaultThemeRenderContext.toolbar) =
  let new_toolbar props =
    let toolbar_element = origin_toolbar props
    in
      toolbar_element
  in
    new_toolbar

let setup_injector app =
  app
    |> Application.get_renderer
    |> Renderer.get_hooks
    |> EventHooks.on
        "body.begin"
        (fun (context) ->
          let new_toolbar = context |> DefaultThemeRenderContext.get_toolbar |> toolbar
          in
            DefaultThemeRenderContext.set_toolbar context new_toolbar;
            JSX.createElement "" Js.null
        )

let load application =
  setup_option application ;
  setup_injector application
