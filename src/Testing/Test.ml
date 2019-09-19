type single = {
  label: string;
  check: unit lazy_t;
}

type group = {
  name: string;
  tests: t list;
}

and t =
  | Single of single
  | Group of group
