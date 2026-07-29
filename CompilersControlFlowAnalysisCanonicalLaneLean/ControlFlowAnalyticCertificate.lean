import CompilersControlFlowAnalysisCanonicalLaneLean.RegularityEndpointLayer

/-!
# Control Flow Analytic Certificate

This module packages the local control flow analysis layer into one proof-carrying
certificate.
-/

namespace HautevilleHouse
namespace CompilersControlFlowAnalysisCanonicalLaneLean

structure ControlFlowAnalyticCertificate where
  substrate : MathlibPDESubstrate
  cfaOperatorsClosed : Prop
  dataflowLayerClosed : Prop
  fixpointLayerClosed : Prop
  interproceduralLayerClosed : Prop
  endpointLayerClosed : Prop
  canonicalCarriageImported : Prop
  cfaOperatorsClosedProof : cfaOperatorsClosed
  dataflowLayerClosedProof : dataflowLayerClosed
  fixpointLayerClosedProof : fixpointLayerClosed
  interproceduralLayerClosedProof : interproceduralLayerClosed
  endpointLayerClosedProof : endpointLayerClosed
  canonicalCarriageImportedProof : canonicalCarriageImported

def sourceControlFlowAnalyticCertificate : ControlFlowAnalyticCertificate := {
  substrate := mathlibPDESubstrate
  cfaOperatorsClosed := CFAEquationsClosed primitiveCFAConfig
  dataflowLayerClosed := DataflowEnvelopeClosed sourceDataflowEnvelope
  fixpointLayerClosed := FixpointGateClosed sourceFixpointGate
  interproceduralLayerClosed := InterproceduralClosed sourceInterproceduralCertificate
  endpointLayerClosed := RegularityEndpointClosed sourceRegularityEndpointCertificate
  canonicalCarriageImported := commonCoreProjectionLawAvailable ∧ commonCoreCarriageLawAvailable ∧ commonCoreIdempotenceAvailable
  cfaOperatorsClosedProof := primitive_cfa_equations_closed_checked
  dataflowLayerClosedProof := source_dataflow_envelope_closed
  fixpointLayerClosedProof := source_fixpoint_gate_closed
  interproceduralLayerClosedProof := source_interprocedural_closed
  endpointLayerClosedProof := source_regularity_endpoint_closed
  canonicalCarriageImportedProof := And.intro mathlib_common_core_projection_law_checked
    (And.intro mathlib_common_core_carriage_law_checked mathlib_common_core_idempotence_checked)
}

def ControlFlowAnalyticCertificateClosed (C : ControlFlowAnalyticCertificate) : Prop :=
  C.cfaOperatorsClosed ∧ C.dataflowLayerClosed ∧ C.fixpointLayerClosed ∧ C.interproceduralLayerClosed ∧ C.endpointLayerClosed ∧ C.canonicalCarriageImported

theorem source_control_flow_analytic_certificate_closed : ControlFlowAnalyticCertificateClosed sourceControlFlowAnalyticCertificate := by
  exact And.intro sourceControlFlowAnalyticCertificate.cfaOperatorsClosedProof
    (And.intro sourceControlFlowAnalyticCertificate.dataflowLayerClosedProof
      (And.intro sourceControlFlowAnalyticCertificate.fixpointLayerClosedProof
        (And.intro sourceControlFlowAnalyticCertificate.interproceduralLayerClosedProof
          (And.intro sourceControlFlowAnalyticCertificate.endpointLayerClosedProof
            sourceControlFlowAnalyticCertificate.canonicalCarriageImportedProof))))

end CompilersControlFlowAnalysisCanonicalLaneLean
end HautevilleHouse