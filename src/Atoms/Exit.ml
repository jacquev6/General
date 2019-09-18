#include "../Generated/Atoms/Exit.ml"

module Self = Foundations.Exit

include Self

module Tests = Tests_.Make(Self)(struct
end)(struct
    let tests = []
end)
