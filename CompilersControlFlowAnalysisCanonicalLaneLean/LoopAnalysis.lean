import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace CompilersControlFlowAnalysisCanonicalLaneLean

structure NaturalLoop where
  header : BasicBlock
  body : List BasicBlock
  backEdges : List (BasicBlock × BasicBlock)

def trivialLoop : NaturalLoop := {
  header := emptyBlock
  body := [emptyBlock]
  backEdges := [(emptyBlock, emptyBlock)]
}

structure LoopNestingTree where
  loops : List NaturalLoop
  parent : NaturalLoop → Option NaturalLoop

def trivialNesting : LoopNestingTree := {
  loops := [trivialLoop]
  parent := λ _ => none
}

def LoopClosed (L : NaturalLoop) : Prop :=
  L.header ∈ L.body ∧ (∀ (e : BasicBlock × BasicBlock) ∈ L.backEdges, e.2 = L.header)

theorem trivial_loop_closed : LoopClosed trivialLoop := by
  unfold LoopClosed trivialLoop emptyBlock
  simp

def NestingWellFormed (T : LoopNestingTree) : Prop :=
  ∀ L ∈ T.loops, LoopClosed L

theorem trivial_nesting_well_formed : NestingWellFormed trivialNesting := by
  unfold NestingWellFormed trivialNesting
  intro L hL
  simp at hL
  subst hL
  exact trivial_loop_closed

end CompilersControlFlowAnalysisCanonicalLaneLean
end HautevilleHouse