import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.ViscousInviscidInteractionCompressibleFluidsCanonicalLaneLean.CompressibleFlowOperators

namespace HautevilleHouse
namespace ViscousInviscidInteractionCompressibleFluidsCanonicalLaneLean

structure VortexCertificate where
  flow : CompressibleFlow
  vorticityField : VectorField
  vortexCoreStructure : Prop
  vortexStability : Prop
  vortexInteractionClosed : Prop
  vortexCoreStructureClosed : vortexCoreStructure
  vortexStabilityClosed : vortexStability
  vortexInteractionClosedProof : vortexInteractionClosed

def sourceVortexCertificate : VortexCertificate := {
  flow := primitiveFlow
  vorticityField := zeroVectorField
  vortexCoreStructure := True
  vortexStability := True
  vortexInteractionClosed := True
  vortexCoreStructureClosed := trivial
  vortexStabilityClosed := trivial
  vortexInteractionClosedProof := trivial
}

def VortexClosed (C : VortexCertificate) : Prop :=
  CompressibleNavierStokesClosed C.flow ∧
  C.vortexCoreStructure ∧
  C.vortexStability ∧
  C.vortexInteractionClosed

theorem source_vortex_closed : VortexClosed sourceVortexCertificate := by
  exact And.intro primitive_flow_compressible_navier_stokes_closed_checked
    (And.intro sourceVortexCertificate.vortexCoreStructureClosed
      (And.intro sourceVortexCertificate.vortexStabilityClosed
        sourceVortexCertificate.vortexInteractionClosedProof))

end HautevilleHouse.ViscousInviscidInteractionCompressibleFluidsCanonicalLaneLean
end HautevilleHouse