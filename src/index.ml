let load application =
  let renderer = Typedoc.get_renderer application
in
Js.log renderer
