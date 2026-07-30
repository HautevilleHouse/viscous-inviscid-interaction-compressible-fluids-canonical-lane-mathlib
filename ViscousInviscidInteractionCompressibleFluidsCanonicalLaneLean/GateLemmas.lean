import ViscousInviscidInteractionCompressibleFluidsCanonicalLaneLean.BridgeLemmas

namespace HautevilleHouse
namespace ViscousInviscidInteractionCompressibleFluidsCanonicalLaneLean

def gateClosed (A : AdmissibleClass) : Prop :=
  A.endpointSatisfied ∨ A.remainderRecorded

theorem gate_from_admissible_class (A : AdmissibleClass) :
    gateClosed A := by
  exact A.gateWitness

end ViscousInviscidInteractionCompressibleFluidsCanonicalLaneLean
end HautevilleHouse