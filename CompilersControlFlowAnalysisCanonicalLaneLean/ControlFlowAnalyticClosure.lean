import CompilersControlFlowAnalysisCanonicalLaneLean.ControlFlowAnalyticCertificate

/-!
# Control Flow Analytic Closure

This module states the admitted analytic closure theorem for the control flow
analysis package.
-/

namespace HautevilleHouse
namespace CompilersControlFlowAnalysisCanonicalLaneLean

def ControlFlowAdmittedAnalyticClosure : Prop :=
  ControlFlowAnalyticCertificateClosed sourceControlFlowAnalyticCertificate ∧
  ConstrainedTheoremClosure analyticAdmissibleClass

def UnrestrictedClassicalControlFlowBoundaryCarried : Prop :=
  formalizationCertificate.theoremBoundaryOpen = true ∧
  mathlibPDESubstrate.carriedBoundary ≠ ""

theorem control_flow_admitted_analytic_closure_checked : ControlFlowAdmittedAnalyticClosure := by
  exact And.intro source_control_flow_analytic_certificate_closed
    (constrained_theorem_closure analyticAdmissibleClass)

theorem unrestricted_classical_control_flow_boundary_carried_checked : UnrestrictedClassicalControlFlowBoundaryCarried := by
  exact And.intro rfl rfl

end CompilersControlFlowAnalysisCanonicalLaneLean
end HautevilleHouse