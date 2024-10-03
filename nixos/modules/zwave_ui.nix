{...}: {

  virtualisation.oci-containers = {
    containers.zwave_ui = {
      volumes = [ "/var/lib/zwavejs/store:/usr/src/app/store" ];
      image = "zwavejs/zwave-js-ui:latest";
      ports = [ "3003:3000" "8091:8091" ];
      autoStart = true;
      extraOptions = [
        "--privileged"
        "--device=/dev/serial/by-id/usb-Silicon_Labs_CP2102N_USB_to_UART_Bridge_Controller_c20e71c99174ec11b89da55019c2d21c-if00-port0:/dev/zwave"
      ];
    };
  };
}
