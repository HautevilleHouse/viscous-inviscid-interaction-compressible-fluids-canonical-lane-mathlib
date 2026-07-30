import ViscousInviscidInteractionCompressibleFluidsCanonicalLaneLean.GateLemmas

namespace HautevilleHouse
namespace ViscousInviscidInteractionCompressibleFluidsCanonicalLaneLean

def ConstrainedViscousInviscidClosure (A : AdmissibleClass) : Prop :=
  bridgeClosed A ∧ gateClosed A

theorem constrained_viscous_inviscid_endgame (A : AdmissibleClass) :
    ConstrainedViscousInviscidClosure A := by
  exact And.intro (bridge_from_admissible_class A) (gate_from_admissible_class A)

end ViscousInviscidInteractionCompressibleFluidsCanonicalLaneLean
end HautevilleHouse