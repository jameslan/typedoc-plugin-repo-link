type any = Any : 'a -> any [@@unboxed]
module Configuration = struct
  module Options = struct
    type t
    external addDeclaration : string -> unit = "addDeclaration" [@@mel.send.pipe: t]
  end
end
module EventHooks = struct
  type ('k, 'r) t
  external on : string -> ('k -> 'r) -> ?order:int -> unit = "on" [@@mel.send.pipe: ('k, 'r) t]
end

module DefaultThemeRenderContext = struct
  type t
end

module JSX = struct
  type element
  external createElement : string -> any Js.Dict.t Js.Null.t -> element = "createElement" [@@mel.scope "JSX"] [@@mel.module "typedoc"]
end

module AbstractComponent = struct
  type t
end
module ChildableComponent = struct
  include AbstractComponent
  type t = AbstractComponent.t
  (* external get_component : t -> string ->  *)
end

module Renderer = struct
  include ChildableComponent
  type t = ChildableComponent.t
  external get_hooks : t -> (DefaultThemeRenderContext.t, JSX.element) EventHooks.t = "hooks" [@@mel.get]
end

module Application = struct
  include ChildableComponent
  type t = ChildableComponent.t
  external get_options : t -> Configuration.Options.t = "options" [@@mel.get]
  external get_renderer : t -> Renderer.t = "renderer" [@@mel.get]
end

