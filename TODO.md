# Emacs config modernization

## 1. Minibuffer completion
Replace ido + flx-ido + ido-completing-read+ + ido-vertical-mode + smex with:
- [ ] vertico — vertical completion UI, builds on Emacs's native completing-read
- [ ] orderless — flexible matching (type words in any order)
- [ ] marginalia — shows descriptions next to candidates (docstrings, file sizes, etc.)
- [ ] consult — enhanced search, buffer switch, recent files, grep

## 2. Code completion
Replace company with:
- [ ] corfu — lighter popup completion, uses Emacs's built-in completion-at-point (CAPF)

## 3. Syntax checking
Replace flycheck + flycheck-inline + flycheck-pos-tip with:
- [ ] flymake (built-in) — LSP feeds diagnostics into it automatically

## 4. Undo
Replace undo-tree with:
- [ ] vundo — tree visualization when you want it, no corruption risk
