[
  # Show LSP diagnostics on cursor hover
  {
    event = [ "CursorHold" "CursorHoldI" ];
    callback.__raw = ''
      function()
        vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})
      end
    '';
  }
]
