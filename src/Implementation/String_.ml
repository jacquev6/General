include Foundations.String_

module Tests = struct
  open Testing

  module Examples = struct
    let repr = [
      ("foo", "\"foo\"");
      ("bar\"baz", "\"bar\\\"baz\"");
    ]

    let equal = [
      ["foo"];
    ]

    let different = [
      ("foo", "bar");
    ]

    let ordered = [
      ["aaaa"; "aaaaa"; "aaaab"; "ab"; "b"];
    ]
  end

  let test = "String" >:: [
    (let module T = Concepts.Able.Tests.Make0(Foundations.String_)(Examples) in T.test);
  ]
end
