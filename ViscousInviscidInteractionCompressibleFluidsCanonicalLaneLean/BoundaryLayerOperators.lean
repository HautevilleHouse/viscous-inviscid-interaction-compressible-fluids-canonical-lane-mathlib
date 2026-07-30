import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.ViscousInviscidInteractionCompressibleFluidsCanonicalLaneLean.CompressibleFlowOperators

namespace HautevilleHouse
namespace ViscousInviscidInteractionCompressibleFluidsCanonicalLaneLean

structure BoundaryLayerOperators where
  innerDivergence : VectorField → ScalarField
  innerGradient : ScalarField → VectorField
  innerLaplacian : VectorField → VectorField
  outerDivergence : VectorField → ScalarField
  outerGradient : ScalarField → VectorField
  outerLaplacian : VectorField → VectorField
  matchingProjection : VectorField → VectorField
  matchingCondition : VectorField → VectorField → Prop
  matchingProjectionIdempotent : ∀ u, matchingProjection (matchingProjection u) = matchingProjection u

def primitiveBoundaryLayerOperators : BoundaryLayerOperators := {
  innerDivergence := fun _ => zeroScalarField
  innerGradient := fun _ => zeroVectorField
  innerLaplacian := fun u => u
  outerDivergence := fun _ => zeroScalarField
  outerGradient := fun _ => zeroVectorField
  outerLaplacian := fun u => u
  matchingProjection := fun u => u
  matchingCondition := fun _ _ => True
  matchingProjectionIdempotent := by intro u; rfl
}

structure BoundaryLayerFlow where
  innerFlow : CompressibleFlow
  outerFlow : CompressibleFlow
  boundaryLayerThickness : ℝ
  operators : BoundaryLayerOperators

def primitiveBoundaryLayerFlow : BoundaryLayerFlow := {
  innerFlow := primitiveFlow
  outerFlow := primitiveFlow
  boundaryLayerThickness := 0.01
  operators := primitiveBoundaryLayerOperators
}

def MatchingConditionProjected (F : BoundaryLayerFlow) : Prop :=
  F.operators.matchingCondition F.innerFlow.velocity F.outerFlow.velocity

def BoundaryLayerClosed (F : BoundaryLayerFlow) : Prop :=
  CompressibleNavierStokesClosed F.innerFlow ∧
  CompressibleNavierStokesClosed F.outerFlow ∧
  MatchingConditionProjected F

theorem primitive_boundary_layer_closed_checked : BoundaryLayerClosed primitiveBoundaryLayerFlow := by
  exact And.intro primitive_flow_compressible_navier_stokes_closed_checked
    (And.intro primitive_flow_compressible_navier_stokes_closed_checked trivial)

end HautevilleHouse.ViscousInviscidInteractionCompressibleFluidsCanonicalLaneLean
end HautevilleHouse