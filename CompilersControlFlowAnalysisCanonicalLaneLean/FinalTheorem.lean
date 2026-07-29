import canonicalLaneMathlib.AdmissibleClass
import CompilersControlFlowAnalysisCanonicalLaneLean.ControlFlowGraph
import CompilersControlFlowAnalysisCanonicalLaneLean.DataFlowAnalysis
import CompilersControlFlowAnalysisCanonicalLaneLean.LoopAnalysis
import CompilersControlFlowAnalysisCanonicalLaneLean.SSAConstruction
import CompilersControlFlowAnalysisCanonicalLaneLean.OptimizationCorrectness

namespace HautevilleHouse
namespace CompilersControlFlowAnalysisCanonicalLaneLean

def ConstrainedCFAClosure (A : AdmissibleClass) : Prop :=
  bridgeClosed A ∧ gateClosed A

theorem constrained_cfa_closure (A : AdmissibleClass) :
    ConstrainedCFAClosure A := by
  exact And.intro (bridge_from_admissible_class A) (gate_from_admissible_class A)

end CompilersControlFlowAnalysisCanonicalLaneLean
end HautevilleHouse