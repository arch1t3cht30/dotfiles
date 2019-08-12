syn match texSpecialChar '\\%'         contained conceal cchar=%
syn match texMathSymbol  '\\naturals'  contained conceal cchar=ℕ
syn match texMathSymbol  '\\integers'  contained conceal cchar=ℤ
syn match texMathSymbol  '\\rationals' contained conceal cchar=ℚ
syn match texMathSymbol  '\\reals'     contained conceal cchar=ℝ
syn match texMathSymbol  '\\complexes' contained conceal cchar=ℂ

syn match texMathSymbol '\\sqrt'       contained conceal cchar=√
