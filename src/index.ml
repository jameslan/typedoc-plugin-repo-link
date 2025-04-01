open Typedoc

let setup_option app =
  app
    |> Application.get_options
    |> Configuration.Options.addDeclaration "test"

let toolbar (origin_toolbar: DefaultThemeRenderContext.toolbar) (context: DefaultThemeRenderContext.t) (props: Models.Reflection.t PageEvent.t) =
  let toolbar_element = origin_toolbar context props
in
  Js.log(toolbar_element);
  toolbar_element

let setup_injector application =
  let renderer = Application.get_renderer application
in
  renderer
    |> Renderer.get_hooks
    |> EventHooks.on
        "body.begin"
        (fun (context) ->
          (* let origin_toolbar = DefaultThemeRenderContext.get_toolbar context
        in *)
          let new_toolbar = context |> DefaultThemeRenderContext.get_toolbar |> toolbar
        in
          DefaultThemeRenderContext.set_toolbar context new_toolbar;
          JSX.createElement "" Js.null
        )

let load application =
  setup_option application ;
  setup_injector application
