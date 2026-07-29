import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace CompilersControlFlowAnalysisCanonicalLaneLean

structure PhiFunction where
  variable : String
  sources : List (BasicBlock × String)

def emptyPhi : PhiFunction := {
  variable := ""
  sources := []
}

structure SSAProgram where
  blocks : List BasicBlock
  phis : List PhiFunction
  defs : BasicBlock → List String
  uses : BasicBlock → List String

def trivialSSA : SSAProgram := {
  blocks := [emptyBlock]
  phis := []
  defs := λ _ => []
  uses := λ _ => []
}

def SSAClosed (P : SSAProgram) : Prop :=
  (∀ φ ∈ P.phis, φ.variable ≠ "") ∧
  (∀ b ∈ P.blocks, (P.defs b).length = 0 ∨ (P.uses b).length = 0)

theorem trivial_ssa_closed : SSAClosed trivialSSA := by
  unfold SSAClosed trivialSSA emptyBlock
  simp

def MinimalSSA (P : SSAProgram) : Prop :=
  SSAClosed P ∧
  (∀ b ∈ P.blocks, ∀ v ∈ P.defs b, v ∉ P.uses b)

theorem trivial_minimal_ssa : MinimalSSA trivialSSA := by
  unfold MinimalSSA
  constructor
  · exact trivial_ssa_closed
  · intro b hb v hv
    simp at hb hv

end CompilersControlFlowAnalysisCanonicalLaneLean
end HautevilleHouse