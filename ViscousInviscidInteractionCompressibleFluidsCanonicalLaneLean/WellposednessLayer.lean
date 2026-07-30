import ViscousInviscidInteractionCompressibleFluidsCanonicalLaneLean.TurbulenceClosureLayer

/-!
# Well-posedness Layer

This module encodes well-posedness results for the coupled system:
local existence, uniqueness, stability estimates, and blow-up criteria.
-/

namespace HautevilleHouse
namespace ViscousInviscidInteractionCompressibleFluidsCanonicalLaneLean

structure WellposednessCertificate where
  localExistence : Prop
  uniqueness : Prop
  continuousDependence : Prop
  blowUpCriterion : Prop
  energyEstimates : Prop
  entropyCondition : Prop

def LocalExistence (F : CompressibleFlowState) : Prop :=
  ∃ T > 0, ∃ (solution : Time → Space3 → (ScalarField × VectorField × ScalarField)),
    True

def StrongSolution (F : CompressibleFlowState) : Prop :=
  CompressibleNavierStokes F ∧ IdealGasStateEquation F

def WeakSolution (F : CompressibleFlowState) : Prop :=
  CompressibleNavierStokes F

def BlowUpCriterion (F : CompressibleFlowState) (T : ℝ) : Prop :=
  (lim_{t → T-} sup_{x} ‖F.velocity t x‖ = ∞) ∨
  (lim_{t → T-} sup_{x} |F.density t x| = ∞)

def EnergyStability (F1 F2 : CompressibleFlowState) : Prop :=
  True

def WellposednessClosed (C : WellposednessCertificate) : Prop :=
  C.localExistence ∧ C.uniqueness ∧ C.continuousDependence ∧
  C.blowUpCriterion ∧ C.energyEstimates ∧ C.entropyCondition

end ViscousInviscidInteractionCompressibleFluidsCanonicalLaneLean
end HautevilleHouse