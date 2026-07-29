import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace CompilersControlFlowAnalysisCanonicalLaneLean

structure BasicBlock where
  label : String
  instructions : List String
  successors : List String

def emptyBlock : BasicBlock := {
  label := "entry"
  instructions := []
  successors := []
}

structure ControlFlowGraph where
  blocks : List BasicBlock
  entry : String
  exit : String

def emptyCFG : ControlFlowGraph := {
  blocks := [emptyBlock]
  entry := "entry"
  exit := "entry"
}

structure DominatorTree where
  dom : BasicBlock → BasicBlock → Prop
  root : BasicBlock

def trivialDomTree : DominatorTree := {
  dom := λ b1 b2 => b1.label = b2.label
  root := emptyBlock
}

def CFGClosed (G : ControlFlowGraph) (D : DominatorTree) : Prop :=
  (∀ b ∈ G.blocks, b.label ≠ "") ∧ D.root.label = G.entry

theorem empty_cfg_closed : CFGClosed emptyCFG trivialDomTree := by
  unfold CFGClosed emptyCFG trivialDomTree emptyBlock
  simp

end CompilersControlFlowAnalysisCanonicalLaneLean
end HautevilleHouse