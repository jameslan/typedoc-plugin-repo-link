type any = Any : 'a -> any [@@ocaml.boxed]

module Configuration = struct
  module Options = struct
    type t

    external addDeclaration : string -> (t[@mel.this]) -> unit = "addDeclaration" [@@mel.send]
  end
end

module EventHooks = struct
  type ('k, 'r) t
  external on : string -> ('k -> 'r) -> ?order:int -> (('k, 'r) t [@mel.this]) -> unit = "on" [@@mel.send]
end

module JSX = struct
  module Element = struct
    type t

    external get_tag : t -> string = "tag" [@@mel.get]
    external get_props : t -> any Js.dict Js.null = "props" [@@mel.get]
  end

  type element = Element.t

  external createElement : string -> any Js.dict Js.null -> element = "createElement" [@@mel.scope "JSX"] [@@mel.module "typedoc"]
end

module Models = struct
  module Reflection = struct
    type t
  end
end

module PageEvent = struct
  type 'a t
end

module DefaultThemeRenderContext = struct
  type t
  type toolbar =  Models.Reflection.t PageEvent.t -> JSX.element

  external set_toolbar : t -> toolbar -> unit = "toolbar" [@@mel.set]
  external get_toolbar : t -> toolbar = "toolbar" [@@mel.get]
end

module AbstractComponent = struct
  type t
end

module ParentalComponent = struct
  include AbstractComponent
  type t = AbstractComponent.t
  (* external get_component : t -> string ->  *)
end

module Renderer = struct
  include ParentalComponent
  type t = ParentalComponent.t

  external get_hooks : t -> (DefaultThemeRenderContext.t, JSX.element) EventHooks.t = "hooks" [@@mel.get]
end

module Application = struct
  include ParentalComponent
  type t = ParentalComponent.t

  external get_options : t -> Configuration.Options.t = "options" [@@mel.get]
  external get_renderer : t -> Renderer.t = "renderer" [@@mel.get]
end
