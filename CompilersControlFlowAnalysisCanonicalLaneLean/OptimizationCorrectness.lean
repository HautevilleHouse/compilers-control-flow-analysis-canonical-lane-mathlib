import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace CompilersControlFlowAnalysisCanonicalLaneLean

structure OptimizationPass where
  name : String
  inputCFG : ControlFlowGraph
  outputCFG : ControlFlowGraph
  preservesSemantics : Prop

def identityPass : OptimizationPass := {
  name := "identity"
  inputCFG := emptyCFG
  outputCFG := emptyCFG
  preservesSemantics := True
}

def OptimizationClosed (P : OptimizationPass) : Prop :=
  P.preservesSemantics ∧ P.inputCFG.entry = P.outputCFG.entry

theorem identity_optimization_closed : OptimizationClosed identityPass := by
  unfold OptimizationClosed identityPass emptyCFG
  simp

def CorrectnessCertificate (P : OptimizationPass) : Prop :=
  OptimizationClosed P ∧
  (∀ b ∈ P.inputCFG.blocks, ∃ b' ∈ P.outputCFG.blocks, b.label = b'.label)

theorem identity_correctness_certificate : CorrectnessCertificate identityPass := by
  unfold CorrectnessCertificate
  constructor
  · exact identity_optimization_closed
  · intro b hb
    simp at hb
    subst hb
    refine ⟨emptyBlock, by simp, rfl⟩

end CompilersControlFlowAnalysisCanonicalLaneLean
end HautevilleHouse