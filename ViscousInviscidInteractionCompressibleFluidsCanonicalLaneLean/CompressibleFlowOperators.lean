import ViscousInviscidInteractionCompressibleFluidsCanonicalLaneLean.MathlibObjects
import Mathlib.Data.Real.Basic

/-!
# Compressible Flow Operators

This module defines the analytic objects for viscous-inviscid interaction
compressible fluids: space, time, density, velocity, pressure, temperature,
and the operators for compressible Navier-Stokes and Euler equations.
-/

namespace HautevilleHouse
namespace ViscousInviscidInteractionCompressibleFluidsCanonicalLaneLean

abbrev Space3 := Fin 3 → ℝ
abbrev Time := ℝ
abbrev ScalarField := Time → Space3 → ℝ
abbrev VectorField := Time → Space3 → Space3

structure CompressibleFlowOperators where
  divergence : VectorField → ScalarField
  gradient : ScalarField → VectorField
  laplacian : VectorField → VectorField
  timeDerivative : VectorField → VectorField
  convectiveDerivative : VectorField → VectorField → VectorField
  pressureGradient : VectorField
  viscousStress : VectorField → VectorField
  heatFlux : ScalarField → VectorField
  massContinuity : ScalarField → VectorField → ScalarField
  energyEquation : ScalarField → VectorField → ScalarField → ScalarField
  stateEquation : ScalarField → ScalarField → ScalarField

structure CompressibleFlowState where
  density : ScalarField
  velocity : VectorField
  pressure : ScalarField
  temperature : ScalarField
  viscosity : ℝ
  thermalConductivity : ℝ
  specificHeatRatio : ℝ
  gasConstant : ℝ
  operators : CompressibleFlowOperators

def CompressibleNavierStokes (F : CompressibleFlowState) : Prop :=
  (F.operators.massContinuity F.density F.velocity = λ _ _ => 0) ∧
  (F.operators.timeDerivative F.velocity = 
    F.operators.convectiveDerivative F.velocity F.velocity + 
    F.operators.viscousStress F.velocity - 
    F.operators.pressureGradient) ∧
  (F.operators.energyEquation F.density F.velocity F.temperature = 
    F.operators.heatFlux F.temperature)

def EulerEquations (F : CompressibleFlowState) : Prop :=
  (F.operators.massContinuity F.density F.velocity = λ _ _ => 0) ∧
  (F.operators.timeDerivative F.velocity = 
    F.operators.convectiveDerivative F.velocity F.velocity - 
    F.operators.pressureGradient) ∧
  (F.operators.energyEquation F.density F.velocity F.temperature = λ _ _ => 0)

def IdealGasStateEquation (F : CompressibleFlowState) : Prop :=
  F.pressure = F.density * F.gasConstant * F.temperature

end ViscousInviscidInteractionCompressibleFluidsCanonicalLaneLean
end HautevilleHouse