local nm_ok, nm = pcall(require, "neo-minimap")

if not nm_ok then
  return
end

-- typescript && typescriptreact
nm.set("zi", "typescriptreact", { -- press `zi` to open the minimap, in `typescriptreact` files
  query = [[
;; query
((function_declaration) @cap) ;; matches function declarations
((arrow_function) @cap) ;; matches arrow functions
  ]],
  width = 90,
  height = 22,
})

nm.set("zi", "typescript", { -- press `zi` to open the minimap, in `typescript` files
  query = [[
;; query
((variable_declarator) @cap)
((function_declaration) @cap) ;; matches function declarations
((arrow_function) @cap) ;; matches arrow functions
  ]],
  width = 90,
  height = 22,
})
