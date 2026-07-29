import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace CompilersControlFlowAnalysisCanonicalLaneLean

structure Lattice (A : Type) where
  leq : A → A → Prop
  meet : A → A → A
  join : A → A → A
  top : A
  bot : A

def trivialLattice : Lattice Nat := {
  leq := λ a b => a ≤ b
  meet := λ a b => if a ≤ b then a else b
  join := λ a b => if a ≤ b then b else a
  top := 0
  bot := 0
}

structure AbstractDomain (A : Type) where
  lattice : Lattice A
  transfer : BasicBlock → A → A

def constPropDomain : AbstractDomain Nat := {
  lattice := trivialLattice
  transfer := λ _ a => a
}

structure FixedPointSolution (A : Type) where
  domain : AbstractDomain A
  mapping : BasicBlock → A
  consistency : Prop

def trivialSolution : FixedPointSolution Nat := {
  domain := constPropDomain
  mapping := λ _ => 0
  consistency := True
}

def DataFlowClosed (S : FixedPointSolution Nat) : Prop :=
  S.consistency ∧ (∀ b, S.domain.lattice.leq (S.mapping b) (S.domain.lattice.top))

theorem trivial_data_flow_closed : DataFlowClosed trivialSolution := by
  unfold DataFlowClosed trivialSolution constPropDomain trivialLattice
  simp

end CompilersControlFlowAnalysisCanonicalLaneLean
end HautevilleHouse