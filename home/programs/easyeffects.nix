_:
{
  services.easyeffects.enable = true;
  services.easyeffects.preset = "microphone";

  home.file.".config/easyeffects/input/microphone.json" = {
    text = ''
      {
          "input": {
              "blocklist": [],
              "compressor": {
                  "attack": 20.0,
                  "boost-amount": 6.0,
                  "boost-threshold": -72.0,
                  "bypass": false,
                  "hpf-frequency": 10.0,
                  "hpf-mode": "off",
                  "input-gain": 0.0,
                  "knee": -6.0,
                  "lpf-frequency": 20000.0,
                  "lpf-mode": "off",
                  "makeup": 0.0,
                  "mode": "Downward",
                  "output-gain": 0.0,
                  "ratio": 4.0,
                  "release": 100.0,
                  "release-threshold": -120.0,
                  "sidechain": {
                      "lookahead": 0.0,
                      "mode": "RMS",
                      "preamp": 0.0,
                      "reactivity": 10.0,
                      "source": "Middle",
                      "type": "Feed-forward"
                  },
                  "threshold": -12.0
              },
              "deesser": {
                  "bypass": false,
                  "detection": "RMS",
                  "f1-freq": 6000.0,
                  "f1-level": 0.0,
                  "f2-freq": 4500.0,
                  "f2-level": 12.0,
                  "f2-q": 1.0,
                  "input-gain": 0.0,
                  "laxity": 15,
                  "makeup": 0.0,
                  "mode": "Wide",
                  "output-gain": 0.0,
                  "ratio": 3.0,
                  "sc-listen": false,
                  "threshold": -18.0
              },
              "filter": {
                  "bypass": false,
                  "frequency": 80.0,
                  "inertia": 20.0,
                  "input-gain": 0.0,
                  "mode": "12dB/oct Highpass",
                  "output-gain": 0.0,
                  "resonance": -3.0
              },
              "gate": {
                  "attack": 5.0,
                  "bypass": false,
                  "curve-threshold": -24.0,
                  "curve-zone": -6.0,
                  "hpf-frequency": 10.0,
                  "hpf-mode": "off",
                  "hysteresis": false,
                  "hysteresis-threshold": -12.0,
                  "hysteresis-zone": -6.0,
                  "input-gain": 0.0,
                  "lpf-frequency": 20000.0,
                  "lpf-mode": "off",
                  "makeup": 0.0,
                  "output-gain": 0.0,
                  "reduction": 0.0,
                  "release": 100.0,
                  "sidechain": {
                      "input": "Internal",
                      "lookahead": 0.0,
                      "mode": "RMS",
                      "preamp": 0.0,
                      "reactivity": 10.0,
                      "source": "Middle"
                  }
              },
              "limiter": {
                  "alr": false,
                  "alr-attack": 5.0,
                  "alr-knee": 0.0,
                  "alr-release": 50.0,
                  "attack": 5.0,
                  "bypass": false,
                  "dithering": "None",
                  "external-sidechain": false,
                  "gain-boost": true,
                  "input-gain": 0.0,
                  "lookahead": 5.0,
                  "mode": "Herm Thin",
                  "output-gain": 0.0,
                  "oversampling": "None",
                  "release": 5.0,
                  "sidechain-preamp": 0.0,
                  "stereo-link": 100.0,
                  "threshold": -1.0
              },
              "plugins_order": [
                  "gate",
                  "compressor",
                  "filter",
                  "deesser",
                  "rnnoise",
                  "limiter"
              ],
              "rnnoise": {
                  "bypass": false,
                  "input-gain": 0.0,
                  "model-path": "",
                  "output-gain": 0.0
              }
          }
      }
    '';
  };
}
