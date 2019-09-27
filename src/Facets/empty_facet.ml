module Tests_beta(Testing: Testing) = struct
  include Tests_alpha(Testing)

  include MakeMakers(functor (M: Testable.S0) -> functor (E: Examples.S0 with type t := M.t) -> struct
    let tests = []
  end)
end
