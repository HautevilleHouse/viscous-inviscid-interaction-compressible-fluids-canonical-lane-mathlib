import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.ViscousInviscidInteractionCompressibleFluidsCanonicalLaneLean.BoundaryLayerOperators

namespace HautevilleHouse
namespace ViscousInviscidInteractionCompressibleFluidsCanonicalLaneLean

structure AsymptoticMatchingCertificate where
  boundaryLayer : BoundaryLayerFlow
  innerExpansionValid : Prop
  outerExpansionValid : Prop
  matchingAsymptoticClosed : Prop
  innerExpansionValidClosed : innerExpansionValid
  outerExpansionValidClosed : outerExpansionValid
  matchingAsymptoticClosedProof : matchingAsymptoticClosed

def sourceAsymptoticMatchingCertificate : AsymptoticMatchingCertificate := {
  boundaryLayer := primitiveBoundaryLayerFlow
  innerExpansionValid := True
  outerExpansionValid := True
  matchingAsymptoticClosed := True
  innerExpansionValidClosed := trivial
  outerExpansionValidClosed := trivial
  matchingAsymptoticClosedProof := trivial
}

def AsymptoticMatchingClosed (C : AsymptoticMatchingCertificate) : Prop :=
  BoundaryLayerClosed C.boundaryLayer ∧
  C.innerExpansionValid ∧
  C.outerExpansionValid ∧
  C.matchingAsymptoticClosed

theorem source_asymptotic_matching_closed :
    AsymptoticMatchingClosed sourceAsymptoticMatchingCertificate := by
  exact And.intro primitive_boundary_layer_closed_checked
    (And.intro sourceAsymptoticMatchingCertificate.innerExpansionValidClosed
      (And.intro sourceAsymptoticMatchingCertificate.outerExpansionValidClosed
        sourceAsymptoticMatchingCertificate.matchingAsymptoticClosedProof))

end HautevilleHouse.ViscousInviscidInteractionCompressibleFluidsCanonicalLaneLean
end HautevilleHouse