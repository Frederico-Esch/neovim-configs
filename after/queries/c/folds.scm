(
  (preproc_call
    directive: (_) @_dir
    argument: (_) @_arg_begin
    (#eq? @_arg_begin "region")) @_beg_region
  (_)*  @inner
  (preproc_call
    directive: (_) @_dir
    argument: (_) @_arg_end
    (#eq? @_arg_end "endregion")
    ) @_end_region
  (#eq? @_dir "#pragma")
  (#make-range! "fold" @_beg_region @_end_region)
)
