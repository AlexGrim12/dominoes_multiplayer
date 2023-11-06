import 'package:flutter/material.dart';
import 'package:newton_particles/newton_particles.dart';

class Particle extends StatelessWidget {
  const Particle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Newton(
      // Add any kind of effects to your UI
      // For example:
      activeEffects: [
        RainEffect(
            particleConfiguration: ParticleConfiguration(
              shape: CircleShape(),
              size: const Size(5, 5),
              color: const SingleParticleColor(color: Colors.white),
            ),
            effectConfiguration: EffectConfiguration(
              distanceCurve: Curves.easeIn,
              fadeInCurve: Curves.easeIn,
              fadeOutCurve: Curves.easeIn,
              scaleCurve: Curves.easeIn,
              trail: StraightTrail(
                trailProgress: 0.5,
                trailWidth: 1,
              ),
            ))
      ],
    );
  }
}
