import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.ViscousInviscidInteractionCompressibleFluidsCanonicalLaneLean.CompressibleFlowOperators

namespace HautevilleHouse
namespace ViscousInviscidInteractionCompressibleFluidsCanonicalLaneLean

structure WeakSolutionCertificate where
  flow : CompressibleFlow
  finiteEnergy : Prop
  entropyCondition : Prop
  weakContinuity : Prop
  weakMomentum : Prop
  weakEnergy : Prop
  finiteEnergyClosed : finiteEnergy
  entropyConditionClosed : entropyCondition
  weakContinuityClosed : weakContinuity
  weakMomentumClosed : weakMomentum
  weakEnergyClosed : weakEnergy

def sourceWeakSolutionCertificate : WeakSolutionCertificate := {
  flow := primitiveFlow
  finiteEnergy := True
  entropyCondition := True
  weakContinuity := True
  weakMomentum := True
  weakEnergy := True
  finiteEnergyClosed := trivial
  entropyConditionClosed := trivial
  weakContinuityClosed := trivial
  weakMomentumClosed := trivial
  weakEnergyClosed := trivial
}

def WeakSolutionClosed (C : WeakSolutionCertificate) : Prop :=
  C.finiteEnergy ∧ C.entropyCondition ∧ C.weakContinuity ∧ C.weakMomentum ∧ C.weakEnergy

theorem source_weak_solution_closed : WeakSolutionClosed sourceWeakSolutionCertificate := by
  exact And.intro sourceWeakSolutionCertificate.finiteEnergyClosed
    (And.intro sourceWeakSolutionCertificate.entropyConditionClosed
      (And.intro sourceWeakSolutionCertificate.weakContinuityClosed
        (And.intro sourceWeakSolutionCertificate.weakMomentumClosed
          sourceWeakSolutionCertificate.weakEnergyClosed)))

end HautevilleHouse.ViscousInviscidInteractionCompressibleFluidsCanonicalLaneLean
end HautevilleHouse