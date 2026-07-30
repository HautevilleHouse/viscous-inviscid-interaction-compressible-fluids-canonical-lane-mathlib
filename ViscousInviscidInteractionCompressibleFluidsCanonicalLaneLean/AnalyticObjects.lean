import canonicalLaneMathlib.AdmissibleClass
import Mathlib.Data.Real.Basic

namespace HautevilleHouse
namespace ViscousInviscidInteractionCompressibleFluidsCanonicalLaneLean

abbrev Space3 := Fin 3 → ℝ
abbrev Time := ℝ
abbrev ScalarField := Time → Space3 → ℝ
abbrev VectorField := Time → Space3 → Space3

def zeroScalarField : ScalarField := fun _ _ => 0
def zeroVectorField : VectorField := fun _ _ _ => 0

structure InteractionOperators where
  divergence : VectorField → ScalarField
  gradient : ScalarField → VectorField
  laplacian : VectorField → VectorField
  timeDerivative : VectorField → VectorField
  transport : VectorField → VectorField
  viscousStress : VectorField → VectorField
  inviscidFlux : VectorField → VectorField
  interactionCoupling : VectorField → VectorField → VectorField

def primitiveInteractionOperators : InteractionOperators := {
  divergence := fun _ => zeroScalarField
  gradient := fun _ => zeroVectorField
  laplacian := fun u => u
  timeDerivative := fun _ => zeroVectorField
  transport := fun _ => zeroVectorField
  viscousStress := fun u => u
  inviscidFlux := fun u => u
  interactionCoupling := fun u v => u
}

structure CompressibleFlow where
  velocity : VectorField
  density : ScalarField
  pressure : ScalarField
  viscosity : ℝ
  operators : InteractionOperators

def primitiveCompressibleFlow : CompressibleFlow := {
  velocity := zeroVectorField
  density := zeroScalarField
  pressure := zeroScalarField
  viscosity := 1
  operators := primitiveInteractionOperators
}

def DivergenceFree (F : CompressibleFlow) : Prop :=
  F.operators.divergence F.velocity = zeroScalarField

def ViscousInviscidBalance (F : CompressibleFlow) : Prop :=
  F.operators.timeDerivative F.velocity = F.operators.laplacian F.velocity

def InteractionClosed (F : CompressibleFlow) : Prop :=
  DivergenceFree F ∧ ViscousInviscidBalance F

theorem primitive_flow_divergence_free_checked : DivergenceFree primitiveCompressibleFlow := by
  unfold DivergenceFree primitiveCompressibleFlow primitiveInteractionOperators zeroScalarField
  rfl

theorem primitive_flow_viscous_inviscid_balance_checked : ViscousInviscidBalance primitiveCompressibleFlow := by
  unfold ViscousInviscidBalance primitiveCompressibleFlow primitiveInteractionOperators zeroVectorField
  rfl

theorem primitive_flow_interaction_closed_checked : InteractionClosed primitiveCompressibleFlow := by
  exact And.intro primitive_flow_divergence_free_checked primitive_flow_viscous_inviscid_balance_checked

end ViscousInviscidInteractionCompressibleFluidsCanonicalLaneLean
end HautevilleHouse