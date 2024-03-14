Return-Path: <linux-kernel+bounces-103156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC30687BBAE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3C0B1F221CC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C67C6EB4E;
	Thu, 14 Mar 2024 11:06:47 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACAB6E61D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 11:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710414405; cv=none; b=vDUQ19mYhqf2MvhAR+pyom5jlLeYvt5c4oSVyLFIa6K6wRe/s55QOyDlZCez0/h4QUi54zCCT30JdemPSC7x3ku8TDj7LT107oEyHyjc9v0H9zLhWwiHvrY7vLU6G+wf+XGcnChp0dIKY9SS9uBnj/qTGZnUVoFBb2any1PJUOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710414405; c=relaxed/simple;
	bh=FG6FwWTjp5V0WTfnFO53+104tiEJ2HfIxm4APm2XliM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ix3FSyIA8ZaWAXY1OSE9nOO7Jb/G9vUPp5CZNdU8KXNBKfzXSk2WKst6nMwpWvCds12GKzUuBR55PEj6E9IecMK2s16B+dv20PMwzWNKW7nCb37xacFMyP7fAx+OEXTxi+SliCRQg/Jxt/36v6GSUrt1RIAUOO1wzPJ/kDndaf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a9e.versanet.de ([83.135.90.158] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rkiuu-0002NY-Vz; Thu, 14 Mar 2024 12:06:33 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-kernel@vger.kernel.org, Dominik Poggel <pog@iesy.com>
Cc: linux-rockchip@lists.infradead.org, Dominik Poggel <pog@iesy.com>
Subject: Re: [PATCH] arm64: dts: iesy: add support for iesy PX30 SoM OSM-S
Date: Thu, 14 Mar 2024 12:06:32 +0100
Message-ID: <4940305.Mh6RI2rZIc@diego>
In-Reply-To: <20240314104724.2118828-1-pog@iesy.com>
References:
 <24ff7347-650e-4b80-ac35-a8c535c76648.51c8ab6f-2707-4fec-b864-8eb3a5aaab63.30f275d7-a418-4d45-ac8a-361bf8ec9c61@emailsignatures365.codetwo.com>
 <24ff7347-650e-4b80-ac35-a8c535c76648.370f0e5d-ced9-4d8d-88a7-90f9b6de22dd.926b06c7-3860-4777-8a3b-3bb166474357@emailsignatures365.codetwo.com>
 <20240314104724.2118828-1-pog@iesy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Dominik,

Am Donnerstag, 14. M=E4rz 2024, 11:47:24 CET schrieb Dominik Poggel:
> This adds support for the iesy SoM iesy-rpx30-osm-sf and the matching
> evalboard iesy-rpx30-eva-mi.
>=20
> Signed-off-by: Dominik Poggel <pog@iesy.com>

please don't test your mailer setup on the unsuspecting public [aka me ;-) =
].

Mails to the Linux kernel lists are generally expected to be plain-text.
HTML mails like this one and the same from 11:37 make it impossible to
review.

I know this is somewhat hard to achieve with stuff like outlook, but for
example (some) kernel mailing lists reject html mails altogether.

Some general remarks already:
=2D patch subject: "arm64: dts: rockchip: add support for iesy PX30 SoM OSM=
=2DS"
=2D missing compatible in the board dts
=2D therefore probably also missing vendor-prefix - see [0]
=2D please add a separate patch that adds the compatible to the binding - s=
ee [1]
=2D alphabetical sorting ...
	"leds {"
  above
	"max9867-sound {"

	"&dsi {"
  above
	"&vopl {"
  etc
=2D please remove "confidentiality" footers (and company advertisement)
=2D use scripts/get_maintainer.pl to get the list of recipients
=2D use scripts/checkpatch.pl
=2D please use proper versioning ... like
	"[PATCH v2] ..."
  for subsequent changed versions


Thanks
Heiko


[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/devicetree/bindings/vendor-prefixes.yaml
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Df3ff1d12bb2f6ebdbd12f0cafc02fe170bad6e7f

> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../dts/rockchip/iesy-rpx30-eva-mi-v2.dts     | 711 ++++++++++++++++++
>  .../boot/dts/rockchip/iesy-rpx30-osm-sf.dtsi  | 374 +++++++++
>  3 files changed, 1086 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/iesy-rpx30-eva-mi-v2.dts
>  create mode 100644 arch/arm64/boot/dts/rockchip/iesy-rpx30-osm-sf.dtsi
>=20
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/=
rockchip/Makefile
> index f906a868b71a..d1ff29796d07 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D iesy-rpx30-eva-mi-v2.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D px30-evb.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D px30-engicam-px30-core-ctouch2.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) +=3D px30-engicam-px30-core-ctouch2-of10.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/iesy-rpx30-eva-mi-v2.dts b/arch=
/arm64/boot/dts/rockchip/iesy-rpx30-eva-mi-v2.dts
> new file mode 100644
> index 000000000000..4a0a83a1a999
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/iesy-rpx30-eva-mi-v2.dts
> @@ -0,0 +1,711 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Device Tree for iesy RPX30 EVA-MI V2.xx (Eval Kit)
> + *
> + * Copyright (c) 2022 iesy GmbH
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/display/drm_mipi_dsi.h>
> +#include <dt-bindings/net/mscc-phy-vsc8531.h>
> +#include "iesy-rpx30-osm-sf.dtsi"
> +
> +/ {
> +       model =3D "iesy RPX30 EVA-MI V2.xx (Eval Kit)";
> +
> +       /* regulator for USB OTG port */
> +       usb_a_vbus_regulator: regulator@1 {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "usb_a_vbus_regulator";
> +               regulator-min-microvolt =3D <5000000>;
> +               regulator-max-microvolt =3D <5000000>;
> +               gpio =3D <&gpio3 RK_PC0 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +       };
> +
> +       /* regulator for USB host port */
> +       usb_b_vbus_regulator: regulator@2 {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "usb_b_vbus_regulator";
> +               regulator-min-microvolt =3D <5000000>;
> +               regulator-max-microvolt =3D <5000000>;
> +               gpio =3D <&gpio3 RK_PC3 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +               regulator-always-on;
> +               regulator-boot-on;
> +       };
> +
> +       /* regulator for IMX219 camera */
> +       vdd1v2_imx219: regulator@3 {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "vdd1v2_imx219";
> +               regulator-min-microvolt =3D <1200000>;
> +               regulator-max-microvolt =3D <1200000>;
> +               gpio =3D <&gpio3 RK_PC7 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +               regulator-always-on;
> +               regulator-boot-on;
> +       };
> +
> +       /* regulator for SD Card on BB138 */
> +       vdd3v3_bb138: regulator@4 {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "vdd3v3_bb138";
> +               regulator-min-microvolt =3D <3300000>;
> +               regulator-max-microvolt =3D <3300000>;
> +               regulator-always-on;
> +               regulator-boot-on;
> +       };
> +
> +       /* BB138a: 8 GPIOs on Pin Header */
> +       header-gpios {
> +               compatible =3D "generic-uio";
> +               linux,uio-name =3D "header-gpios";
> +
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&pinctrl_gpio_a>;
> +       };
> +
> +       /* BB138a: MAX9867ETJ+ audio codec */
> +       max9867-sound {
> +               compatible =3D "simple-audio-card";
> +               simple-audio-card,name =3D "rockchip,max9867-codec";
> +               simple-audio-card,format =3D "i2s";
> +
> +               simple-audio-card,widgets =3D
> +                       "Speaker", "Jack",
> +                       "Microphone", "Mic";
> +               simple-audio-card,routing =3D
> +                       "Jack", "LOUT",
> +                       "Jack", "ROUT",
> +                       "Mic", "DMICL",
> +                       "Mic", "DMICR";
> +
> +               simple-audio-card,frame-master =3D <&cpudai>;
> +               simple-audio-card,bitclock-master =3D <&cpudai>;
> +
> +               status =3D "okay";
> +
> +               cpudai: simple-audio-card,cpu {
> +                       sound-dai =3D <&i2s1_2ch>;
> +                       dai-tdm-slot-num =3D <1>;
> +                       dai-tdm-slot-width =3D <16>;
> +               };
> +
> +               simple-audio-card,codec {
> +                       sound-dai =3D <&max9867>;
> +                       clocks =3D <&cru SCLK_I2S1_OUT>;
> +               };
> +       };
> +
> +       leds {
> +               compatible =3D "gpio-leds";
> +
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&pinctrl_leds_bb138>;
> +
> +               /* BB138a: green user led (LD4) */
> +               led@0 {
> +                       label =3D "USER_LED_00";
> +                       gpios =3D <&gpio3 RK_PA0 GPIO_ACTIVE_LOW>;
> +                       linux,default-trigger =3D "heartbeat";
> +               };
> +
> +               /* BB138a: yellow user led (LD9)) */
> +               led@1 {
> +                       label =3D "USER_LED_01";
> +                       gpios =3D <&gpio3 RK_PA1 GPIO_ACTIVE_LOW>;
> +                       default-state =3D "off";
> +               };
> +       };
> +
> +       user-buttons {
> +               compatible =3D "gpio-keys";
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +               autorepeat;
> +
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&pinctrl_buttons>;
> +
> +               /* BB138a: User-Button 1 */
> +               user-button-1 {
> +                       label =3D "User Button 1";
> +                       gpios =3D <&gpio3 RK_PA2 GPIO_ACTIVE_LOW>;
> +                       linux,code =3D <KEY_X>;
> +               };
> +
> +               /* BB138a: User-Button 2 */
> +               user-button-2 {
> +                       label =3D "User Button 2";
> +                       gpios =3D <&gpio3 RK_PA3 GPIO_ACTIVE_LOW>;
> +                       linux,code =3D <KEY_Z>;
> +               };
> +       };
> +};
> +
> +&gmac {
> +       phy-supply =3D <&vcc_phy>;
> +       phy-handle =3D <&gmac0_phy>;
> +       clock_in_out =3D "input";
> +       assigned-clocks =3D <&cru SCLK_GMAC>;
> +       assigned-clock-parents =3D <&cru SCLK_GMAC>;
> +       status =3D "okay";
> +
> +       gmdio0: gmac0_mdio {
> +               compatible =3D "snps,dwmac-mdio";
> +
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +
> +               /* BB138a: Ethernet PHY */
> +               gmac0_phy: ethernet-phy@0 {
> +                       compatible =3D "ethernet-phy-id0007.0570";
> +                       reg =3D <0x0>;
> +                       max-speed =3D <100>;
> +                       vsc8531,vddmac =3D <1800>;
> +                       vsc8531,edge-slowdown =3D <76>;
> +                       vsc8531,led-0-mode =3D <VSC8531_LINK_100_ACTIVITY=
>;
> +                       vsc8531,led-1-mode =3D <VSC8531_LINK_100_ACTIVITY=
>;
> +               };
> +       };
> +};
> +
> +&u2phy {
> +       status =3D "okay";
> +
> +       /* BB138a: USB2.0 Host PHY */
> +       u2phy_host: host-port {
> +               phy-supply =3D <&vcc3v0_pmu>;
> +               vbus-supply =3D <&usb_b_vbus_regulator>;
> +               status =3D "okay";
> +               pinctrl-0 =3D <&u2phy_host_pin>;
> +       };
> +
> +       /* BB138a: USB2.0 OTG PHY */
> +       u2phy_otg: otg-port {
> +               phy-supply =3D <&vcc3v0_pmu>;
> +               vbus-supply =3D <&usb_a_vbus_regulator>;
> +               status =3D "okay";
> +               pinctrl-0 =3D <&u2phy_otg_pin>;
> +       };
> +};
> +
> +&usb20_otg {
> +       dr_mode =3D "otg";
> +       status =3D "okay";
> +
> +       /* should be defined to avoid kernel log error */
> +       /* vusb_d: digital usb supply, 1.2V */
> +       /* vusb_q: analog usb supply, 1.1V */
> +       /* no further info available */
> +       /* vusb_d-supply =3D <???>; */
> +       /* vusb_a-supply =3D <???>; */
> +};
> +
> +&usb_host0_ehci {
> +       /*vbus-supply =3D <&usb_b_vbus_regulator>;*/
> +       status =3D "okay";
> +};
> +
> +&usb_host0_ohci {
> +       /*vbus-supply =3D <&usb_b_vbus_regulator>;*/
> +       status =3D "okay";
> +};
> +
> +&display_subsystem {
> +       status =3D "okay";
> +};
> +
> +/* ARM Mali GPU */
> +&gpu {
> +       mali-supply =3D <&vdd_logic>;
> +       shadercores-supply =3D <&vdd_logic>;
> +       status =3D "okay";
> +};
> +
> +/* Big Video Output Processor (VOPB) */
> +&vopb {
> +       status =3D "okay";
> +};
> +
> +&vopb_mmu {
> +       status =3D "okay";
> +};
> +
> +/* Little Video Output Processor (VOPL) */
> +&vopl {
> +       status =3D "disabled";
> +};
> +
> +&vopl_mmu {
> +       status =3D "disabled";
> +};
> +
> +/* Video Decoder Processing Unit (VDPU) */
> +&vdpu {
> +       status =3D "okay";
> +};
> +
> +/* Video Encoder Processing Unit (VEPU) */
> +&vepu {
> +       status =3D "okay";
> +};
> +
> +/* Display Serial Interface */
> +&dsi {
> +       status =3D "okay";
> +       rockchip,lane-rate =3D <891>;
> +
> +       panel@0 {
> +               compatible =3D "simple-panel-dsi";
> +               reg =3D <0>;
> +               power-supply =3D <&vcc3v3_lcd>;
> +               prepare-delay-ms =3D <2>;
> +               reset-delay-ms =3D <1>;
> +               init-delay-ms =3D <20>;
> +               enable-delay-ms =3D <120>;
> +               disable-delay-ms =3D <50>;
> +               unprepare-delay-ms =3D <20>;
> +
> +               width-mm =3D <68>;
> +               height-mm =3D <121>;
> +
> +               dsi,flags =3D <(MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO=
_BURST |
> +                                         MIPI_DSI_MODE_LPM | MIPI_DSI_MO=
DE_EOT_PACKET)>;
> +               dsi,format =3D <MIPI_DSI_FMT_RGB888>;
> +               dsi,lanes =3D <2>;
> +
> +               display-timings {
> +                       native-mode =3D <&timing2>;
> +
> +                       timing1: timing1 {
> +                               clock-frequency =3D <74250000>;
> +                               hactive =3D <1280>;
> +                               vactive =3D <720>;
> +                               hfront-porch =3D <110>;
> +                               hsync-len =3D <40>;
> +                               hback-porch =3D <220>;
> +                               vfront-porch =3D <5>;
> +                               vsync-len =3D <5>;
> +                               vback-porch =3D <20>;
> +                               hsync-active =3D <0>;
> +                               vsync-active =3D <0>;
> +                               de-active =3D <0>;
> +                               pixelclk-active =3D <0>;
> +                       };
> +
> +                       timing2: timing2 {
> +                               clock-frequency =3D <74250000>;
> +                               hactive =3D <1920>;
> +                               vactive =3D <1080>;
> +                               hfront-porch =3D <88>;
> +                               hsync-len =3D <44>;
> +                               hback-porch =3D <148>;
> +                               vfront-porch =3D <4>;
> +                               vsync-len =3D <5>;
> +                               vback-porch =3D <36>;
> +                               hsync-active =3D <0>;
> +                               vsync-active =3D <0>;
> +                               de-active =3D <0>;
> +                               pixelclk-active =3D <0>;
> +                       };
> +               };
> +
> +               ports {
> +                       #address-cells =3D <1>;
> +                       #size-cells =3D <0>;
> +
> +                       port@0 {
> +                               reg =3D <0>;
> +                               panel_in_dsi: endpoint {
> +                                       remote-endpoint =3D <&dsi_out_pan=
el>;
> +                               };
> +                       };
> +               };
> +
> +               /* should be defined to avoid kernel log errors */
> +               /* vsp-supply is positive voltage supply, vsn-supply is n=
egative voltage supply */
> +               /* will not be critical: is not even used in simple-panel=
 devicetree example */
> +               /* vsp-supply =3D <???>; */
> +               /* vsn-supply =3D <???>; */
> +       };
> +
> +       ports {
> +               #address-cells =3D <1>;
> +               #size-cells =3D <0>;
> +
> +               port@1 {
> +                       reg =3D <1>;
> +                       dsi_out_panel: endpoint {
> +                               remote-endpoint =3D <&panel_in_dsi>;
> +                       };
> +               };
> +       };
> +};
> +
> +&dsi_in_vopb {
> +       status =3D "okay";
> +};
> +
> +&dsi_in_vopl {
> +       status =3D "disabled";
> +};
> +
> +&video_phy {
> +       /* should be defined to avoid kernel log error */
> +       /* no further info about video phy supply available */
> +       /* phy-supply =3D "???"; */
> +       status =3D "okay";
> +};
> +
> +/* BB138a: UART_A on MicroBus and Pin Header */
> +&uart0 {
> +       status =3D "okay";
> +};
> +
> +/* BB138a: UART_B M.2 socket (not used) */
> +&uart1 {
> +       status =3D "okay";
> +};
> +
> +/* BB138a: PWM outputs on Pin Header */
> +&pwm0 {
> +       status =3D "okay";
> +};
> +
> +&pwm1 {
> +       status =3D "okay";
> +};
> +
> +&pwm2 {
> +       status =3D "okay";
> +};
> +
> +&pwm3 {
> +       status =3D "okay";
> +};
> +
> +/* BB138a: SAR ADC inputs */
> +&saradc {
> +       status =3D "okay";
> +       vref-supply =3D <&vcc1v8_soc>;
> +};
> +
> +/* BB138a: SD card connector */
> +&sdmmc {
> +       bus-width =3D <4>;
> +       cap-mmc-highspeed;
> +       cap-sd-highspeed;
> +       supports-sd;
> +       card-detect-delay =3D <800>;
> +       ignore-pm-notify;
> +       sd-uhs-sdr12;
> +       sd-uhs-sdr25;
> +       sd-uhs-sdr50;
> +       sd-uhs-sdr104;
> +       max-frequency =3D <135000000>;
> +       vqmmc-supply =3D <&vccio_sd>;
> +       vmmc-supply =3D <&vdd3v3_bb138>;
> +       status =3D "okay";
> +};
> +
> +&i2s1_2ch {
> +       pinctrl-0 =3D <&i2s1_2ch_mclk &i2s1_2ch_sclk &i2s1_2ch_lrck
> +                                &i2s1_2ch_sdi &i2s1_2ch_sdo>;
> +       status =3D "okay";
> +};
> +
> +&i2c0 {
> +       /* BB138a: LM75 sensor */
> +       sensor@4e {
> +               status =3D "okay";
> +               compatible =3D "lm75";
> +               reg =3D <0x4e>;
> +       };
> +
> +       /* BB138a: PFC85263 RTC */
> +       rtc@51 {
> +               status =3D "okay";
> +               compatible =3D "nxp,pcf85263";
> +               reg =3D <0x51>;
> +       };
> +
> +       /* BB138a: AT24C64D EEPROM */
> +       eeprom@53 {
> +               status =3D "okay";
> +               compatible =3D "atmel,24c64";
> +               reg =3D <0x53>;
> +               pagesize =3D <32>;
> +       };
> +};
> +
> +&i2c1 {
> +       status =3D "okay";
> +
> +       /* BB138a: HDMI to MIPI converter */
> +       lt8912@48 {
> +               compatible =3D "lontium,lt8912";
> +               reg =3D <0x48>;
> +               ddc-i2c-bus =3D <&i2c1>;
> +               /* driver needs a valid reset gpio to function */
> +               /* use not connected pin as dummy */
> +               reset-gpios =3D <&gpio3 RK_PD3 GPIO_ACTIVE_LOW>; /* n.c. =
*/
> +               status =3D "okay";
> +       };
> +
> +       /* BB138a: MAX9867ETJ+ audio codec */
> +       max9867: audio_codec@18 {
> +               #sound-dai-cells =3D <0>;
> +               compatible =3D "maxim,max9867";
> +               reg =3D <0x18>;
> +               status =3D "okay";
> +               assigned-clocks =3D <&cru SCLK_I2S1_OUT>;
> +               assigned-clock-parents =3D <&cru SCLK_I2S1_OUT>;
> +               assigned-clock-rates =3D <50000000>;
> +       };
> +};
> +
> +&spi0 {
> +       status =3D "okay";
> +
> +       spidev@0 {
> +          compatible =3D "linux,spidev";
> +          spi-max-frequency =3D <10000000>;
> +          reg =3D <0>;
> +       };
> +
> +       spidev@1 {
> +          compatible =3D "linux,spidev";
> +          spi-max-frequency =3D <10000000>;
> +          reg =3D <1>;
> +       };
> +};
> +
> +&spi1 {
> +       status =3D "okay";
> +
> +       // next line only for CM006 REV1.00
> +       cs-gpios =3D <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
> +
> +       spidev@0 {
> +          compatible =3D "linux,spidev";
> +          spi-max-frequency =3D <10000000>;
> +          reg =3D <0>;
> +       };
> +
> +       spidev@1 {
> +          compatible =3D "linux,spidev";
> +          spi-max-frequency =3D <10000000>;
> +          reg =3D <1>;
> +       };
> +};
> +
> +&power {
> +       pd_vi-supply =3D <&vdd_logic>;
> +       pd_vpu-supply =3D <&vdd_logic>;
> +       pd_gpu-supply =3D <&vdd_logic>;
> +       pd_usb-supply =3D <&vdd_logic>;
> +       pd_mmc_nand-supply =3D <&vdd_logic>;
> +       pd_vo-supply =3D <&vdd_logic>;
> +};
> +
> +&io_domains {
> +       status =3D "okay";
> +
> +       vccio1-supply =3D <&vcc1v8_dvp>;
> +       vccio2-supply =3D <&vccio_sd>;
> +       vccio3-supply =3D <&vcc1v8_dvp>;
> +       vccio4-supply =3D <&vcc1v8_dvp>;
> +       vccio5-supply =3D <&vcc1v8_dvp>;
> +       vccio6-supply =3D <&vcc1v8_soc>;
> +       pmuio1-supply =3D <&vcc3v0_pmu>;
> +       pmuio2-supply =3D <&vcc1v8_soc>;
> +};
> +
> +&pmu_io_domains {
> +       status =3D "okay";
> +
> +       pmuio1-supply =3D <&vcc3v0_pmu>;
> +       pmuio2-supply =3D <&vcc1v8_soc>;
> +};
> +
> +&pinctrl {
> +       headphone {
> +               hp_det: hp-det {
> +                       rockchip,pins =3D <2 RK_PB0 RK_FUNC_GPIO &pcfg_pu=
ll_down>;
> +               };
> +       };
> +
> +       leds {
> +               pinctrl_leds_bb138: pinctrl-leds-bb138 {
> +                       rockchip,pins =3D <3 RK_PA0 RK_FUNC_GPIO &pcfg_pu=
ll_none
> +                                                        3 RK_PA1 RK_FUNC=
_GPIO &pcfg_pull_none>;
> +               };
> +       };
> +
> +       i2c0 {
> +               i2c0_xfer: i2c0-xfer {
> +                       rockchip,pins =3D
> +                               <0 RK_PB0 1 &pcfg_pull_none_8ma>,
> +                               <0 RK_PB1 1 &pcfg_pull_none_8ma>;
> +               };
> +       };
> +
> +       i2c1 {
> +               i2c1_xfer: i2c1-xfer {
> +                       rockchip,pins =3D
> +                               <0 RK_PC2 1 &pcfg_pull_none_8ma>,
> +                               <0 RK_PC3 1 &pcfg_pull_none_8ma>;
> +               };
> +       };
> +
> +       i2c2 {
> +               i2c2_xfer: i2c2-xfer {
> +                       rockchip,pins =3D
> +                               <2 RK_PB7 2 &pcfg_pull_none_8ma>,
> +                               <2 RK_PC0 2 &pcfg_pull_none_8ma>;
> +               };
> +       };
> +
> +       gpiokeys {
> +               pinctrl_buttons: buttongrp {
> +                       rockchip,pins =3D <3 RK_PA2 RK_FUNC_GPIO &pcfg_pu=
ll_up>,
> +                                                       <3 RK_PA3 RK_FUNC=
_GPIO &pcfg_pull_up>;
> +               };
> +       };
> +
> +       uart0 {
> +               uart0_xfer: uart0-xfer {
> +                       rockchip,pins =3D
> +                               <0 RK_PB2 1 &pcfg_pull_none_2ma>,
> +                               <0 RK_PB3 1 &pcfg_pull_up>;
> +               };
> +
> +               uart0_rts: uart0-rts {
> +                       rockchip,pins =3D
> +                               <0 RK_PB5 1 &pcfg_pull_none_2ma>;
> +               };
> +       };
> +
> +       uart1 {
> +               uart1_xfer: uart1-xfer {
> +                       rockchip,pins =3D
> +                               <1 RK_PC1 1 &pcfg_pull_none_2ma>,
> +                               <1 RK_PC0 1 &pcfg_pull_up>;
> +               };
> +
> +               uart1_rts: uart1-rts {
> +                       rockchip,pins =3D
> +                               <1 RK_PC3 1 &pcfg_pull_none_2ma>;
> +               };
> +       };
> +
> +       gpio_bb138 {
> +               pinctrl_gpio_a: pinctrl-gpio-a {
> +                       rockchip,pins =3D
> +                               <1 RK_PC4 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
> +                               <1 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
> +                               <1 RK_PC6 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
> +                               <1 RK_PC7 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
> +                               <1 RK_PD0 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
> +                               <1 RK_PD1 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
> +                               <3 RK_PD0 RK_FUNC_GPIO &pcfg_pull_up_4ma>,
> +                               <3 RK_PD1 RK_FUNC_GPIO &pcfg_pull_up_4ma>;
> +               };
> +
> +               // ineffective at the moment, since not used by any object
> +               pinctrl_gpio_b: pinctrl-gpio-b {
> +                       rockchip,pins =3D
> +                               <3 RK_PA0 RK_FUNC_GPIO &pcfg_pull_none_2m=
a>,
> +                               <3 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none_2m=
a>,
> +                               <3 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up_2ma>,
> +                               <3 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up_2ma>,
> +                               <3 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up_2ma>,
> +                               <3 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up_2ma>,
> +                               <3 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up_2ma>,
> +                               <3 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up_2ma>;
> +               };
> +       };
> +
> +       pwm0 {
> +               pwm0_pin: pwm0-pin {
> +                       rockchip,pins =3D
> +                               <0 RK_PB7 1 &pcfg_pull_none_2ma>;
> +               };
> +       };
> +
> +       pwm1 {
> +               pwm1_pin: pwm1-pin {
> +                       rockchip,pins =3D
> +                               <0 RK_PC0 1 &pcfg_pull_none_2ma>;
> +               };
> +       };
> +
> +       pwm2 {
> +               pwm2_pin: pwm2-pin {
> +                       rockchip,pins =3D
> +                               <2 RK_PB5 1 &pcfg_pull_none_2ma>;
> +               };
> +       };
> +
> +       pwm3 {
> +               pwm3_pin: pwm3-pin {
> +                       rockchip,pins =3D
> +                               <0 RK_PC1 1 &pcfg_pull_none_2ma>;
> +               };
> +       };
> +
> +       spi0 {
> +               spi0_clk: spi0-clk {
> +                       rockchip,pins =3D
> +                               <1 RK_PB7 3 &pcfg_pull_up_4ma>;
> +               };
> +
> +               spi0_csn: spi0-csn {
> +                       rockchip,pins =3D
> +                               <1 RK_PB6 3 &pcfg_pull_up_4ma>;
> +               };
> +
> +               spi0_mosi: spi0-mosi {
> +                       rockchip,pins =3D
> +                               <1 RK_PB4 3 &pcfg_pull_up_4ma>;
> +               };
> +       };
> +
> +       spi1 {
> +               /* spi1.sdo */
> +               spi1_mosi: spi1-mosi {
> +                       rockchip,pins =3D
> +                               <3 RK_PB4 4 &pcfg_pull_none>;
> +               };
> +
> +               /* spi1.csn PIN E17 used! */
> +               spi1_csn: spi1-csn {
> +                       rockchip,pins =3D
> +                               <3 RK_PB0 4 &pcfg_pull_none>;
> +               };
> +
> +               spi1_clk: spi1-clk {
> +                       rockchip,pins =3D
> +                               <3 RK_PB7 4 &pcfg_pull_none>;
> +               };
> +       };
> +
> +       u2phy {
> +               u2phy_host_pin: host-port {
> +                       rockchip,pins =3D
> +                               <3 RK_PC3 1 &pcfg_pull_none_4ma>;
> +               };
> +
> +               u2phy_otg_pin: otg-port {
> +                       rockchip,pins =3D
> +                               <3 RK_PC0 1 &pcfg_pull_none_4ma>;
> +               };
> +       };
> +};
> +
> +/* DON'T PUT ANYTHING BELOW HERE.  PUT IT ABOVE PINCTRL */
> +/* DON'T PUT ANYTHING BELOW HERE.  PUT IT ABOVE PINCTRL */
> +/* DON'T PUT ANYTHING BELOW HERE.  PUT IT ABOVE PINCTRL */
> diff --git a/arch/arm64/boot/dts/rockchip/iesy-rpx30-osm-sf.dtsi b/arch/a=
rm64/boot/dts/rockchip/iesy-rpx30-osm-sf.dtsi
> new file mode 100644
> index 000000000000..f9a79b99c653
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/iesy-rpx30-osm-sf.dtsi
> @@ -0,0 +1,374 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Device Tree for iesy RPX30 OSM SF (OSM Module)
> + *
> + * Copyright (c) 2023 iesy GmbH
> + */
> +
> +#include "../rockchip/px30.dtsi"
> +
> +/ {
> +       model =3D "iesy RPX30 OSM SF (OSM Module)";
> +       compatible =3D "iesy,rpx30-osm-sf", "rockchip,px30";
> +
> +       aliases {
> +               mmc0 =3D &emmc;
> +               mmc1 =3D &sdmmc;
> +               mmc2 =3D &sdio;
> +       };
> +
> +       chosen {
> +               bootargs =3D "earlycon=3Duart8250,mmio32,0xff160000 conso=
le=3DttyFIQ0 rw root=3DPARTUUID=3D614e0000-0000 rootwait uio_pdrv_genirq.of=
_id=3Dgeneric-uio";
> +       };
> +
> +       fiq-debugger {
> +               compatible =3D "rockchip,fiq-debugger";
> +               rockchip,serial-id =3D <2>;
> +               rockchip,wake-irq =3D <0>;
> +               /* If enable uart uses irq instead of fiq */
> +               rockchip,irq-mode-enable =3D <1>;
> +               rockchip,baudrate =3D <115200>;  /* Only 115200 and 15000=
00 */
> +               interrupts =3D <GIC_SPI 127 IRQ_TYPE_LEVEL_LOW>;
> +               pinctrl-names =3D "default";
> +               pinctrl-0 =3D <&uart2m1_xfer>;
> +               status =3D "okay";
> +       };
> +
> +       charge-animation {
> +               compatible =3D "rockchip,uboot-charge";
> +               rockchip,uboot-charge-on =3D <0>;
> +               rockchip,android-charge-on =3D <1>;
> +               rockchip,uboot-low-power-voltage =3D <3500>;
> +               rockchip,screen-on-voltage =3D <3600>;
> +               status =3D "okay";
> +       };
> +
> +       vcc_phy: vcc-phy-regulator {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "vcc_phy";
> +               regulator-always-on;
> +               regulator-boot-on;
> +       };
> +
> +       vcc5v0_sys: vccsys {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "vcc5v0_sys";
> +               regulator-always-on;
> +               regulator-boot-on;
> +               regulator-min-microvolt =3D <5000000>;
> +               regulator-max-microvolt =3D <5000000>;
> +       };
> +};
> +
> +&cpu0 {
> +       cpu-supply =3D <&vdd_arm>;
> +};
> +
> +&cpu0_opp_table {
> +       rockchip,avs =3D <1>;
> +};
> +
> +/* DDR PHY Interface - used for DDR monitoring */
> +&dfi {
> +       status =3D "okay";
> +};
> +
> +/* Rockchip General Register File (GRF) */
> +&grf {
> +       io_domains: io-domains {
> +               /* should be defined to avoid kernel log error */
> +               /* but no further info about vccio-oscgpi for PX30 availa=
ble */
> +               /* vccio-oscgpi-supply =3D <???>; */
> +       };
> +};
> +
> +/* Dynamic Memory Controller */
> +&dmc {
> +       center-supply =3D <&vdd_logic>;
> +       auto-freq-en =3D <0>;
> +       status =3D "okay";
> +};
> +
> +&rng {
> +       status =3D "okay";
> +};
> +
> +/* eMMC on OSM module */
> +&emmc {
> +       bus-width =3D <8>;
> +       cap-mmc-highspeed;
> +       mmc-hs200-1_8v;
> +       supports-emmc;
> +       disable-wp;
> +       non-removable;
> +       num-slots =3D <1>;
> +       status =3D "okay";
> +
> +       vmmc-supply =3D <&vcc3v3_sys>;
> +       vqmmc-supply =3D <&vcc1v8_soc>;
> +};
> +
> +&i2c0 {
> +       status =3D "okay";
> +
> +       /* Power Management IC */
> +       rk809: pmic@20 {
> +               compatible =3D "rockchip,rk809";
> +               reg =3D <0x20>;
> +               interrupt-parent =3D <&gpio0>;
> +               interrupts =3D <7 IRQ_TYPE_LEVEL_LOW>;
> +               pinctrl-names =3D "default", "pmic-sleep",
> +                               "pmic-power-off", "pmic-reset";
> +               pinctrl-0 =3D <&pmic_int>;
> +               pinctrl-1 =3D <&soc_slppin_slp>, <&rk817_slppin_slp>;
> +               pinctrl-2 =3D <&soc_slppin_gpio>, <&rk817_slppin_pwrdn>;
> +               pinctrl-3 =3D <&soc_slppin_rst>, <&rk817_slppin_rst>;
> +               rockchip,system-power-controller;
> +               wakeup-source;
> +               #clock-cells =3D <1>;
> +               clock-output-names =3D "rk808-clkout1", "rk808-clkout2";
> +               //fb-inner-reg-idxs =3D <2>;
> +               /* 1: rst regs (default in codes), 0: rst the pmic */
> +               pmic-reset-func =3D <1>;
> +
> +               vcc1-supply =3D <&vcc5v0_sys>;
> +               vcc2-supply =3D <&vcc5v0_sys>;
> +               vcc3-supply =3D <&vcc5v0_sys>;
> +               vcc4-supply =3D <&vcc5v0_sys>;
> +               vcc5-supply =3D <&vcc3v3_sys>;
> +               vcc6-supply =3D <&vcc5v0_sys>;
> +               vcc7-supply =3D <&vcc3v3_sys>;
> +               vcc8-supply =3D <&vcc5v0_sys>;
> +               vcc9-supply =3D <&vcc5v0_sys>;
> +
> +               pwrkey {
> +                       status =3D "okay";
> +               };
> +
> +               pinctrl_rk8xx: pinctrl_rk8xx {
> +                       gpio-controller;
> +                       #gpio-cells =3D <2>;
> +
> +                       rk817_slppin_null: rk817_slppin_null {
> +                               pins =3D "gpio_slp";
> +                               function =3D "pin_fun0";
> +                       };
> +
> +                       rk817_slppin_slp: rk817_slppin_slp {
> +                               pins =3D "gpio_slp";
> +                               function =3D "pin_fun1";
> +                       };
> +
> +                       rk817_slppin_pwrdn: rk817_slppin_pwrdn {
> +                               pins =3D "gpio_slp";
> +                               function =3D "pin_fun2";
> +                       };
> +
> +                       rk817_slppin_rst: rk817_slppin_rst {
> +                               pins =3D "gpio_slp";
> +                               function =3D "pin_fun3";
> +                       };
> +               };
> +
> +               regulators {
> +                       /* SW1: 1V0 LOG */
> +                       vdd_logic: DCDC_REG1 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <900000>;
> +                               regulator-max-microvolt =3D <1100000>;
> +                               regulator-ramp-delay =3D <6001>;
> +                               regulator-initial-mode =3D <0x2>;
> +                               regulator-name =3D "vdd_logic";
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt =3D <=
950000>;
> +                               };
> +                       };
> +
> +                       /* SW2: 1V0 ARM */
> +                       vdd_arm: DCDC_REG2 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <950000>;
> +                               regulator-max-microvolt =3D <1350000>;
> +                               regulator-ramp-delay =3D <6001>;
> +                               regulator-initial-mode =3D <0x2>;
> +                               regulator-name =3D "vdd_arm";
> +                               regulator-state-mem {
> +                                       regulator-off-in-suspend;
> +                                       regulator-suspend-microvolt =3D <=
950000>;
> +                               };
> +                       };
> +
> +                       /* SW3: 1V2 DDR */
> +                       vcc_ddr: DCDC_REG3 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-name =3D "vcc_ddr";
> +                               regulator-initial-mode =3D <0x2>;
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                               };
> +                       };
> +
> +                       /* SW4: unused */
> +
> +                       /* SW5: 3V3 IO */
> +                       vcc3v3_sys: DCDC_REG5 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <3300000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +                               regulator-name =3D "vcc3v3_sys";
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt =3D <=
3300000>;
> +                               };
> +                       };
> +
> +                       /* LDO1: 1V0 LDO1 */
> +                       vcc_1v0: LDO_REG1 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <1000000>;
> +                               regulator-max-microvolt =3D <1000000>;
> +                               regulator-name =3D "vcc_1v0";
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt =3D <=
1000000>;
> +                               };
> +                       };
> +
> +                       /* LDO2: 1V8 IO1 */
> +                       vcc1v8_soc: LDO_REG2 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <1800000>;
> +
> +                               regulator-name =3D "vcc1v8_soc";
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt =3D <=
1800000>;
> +                               };
> +                       };
> +
> +                       /* LDO3: 1V0 LDO3 */
> +                       vdd1v0_soc: LDO_REG3 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <1000000>;
> +                               regulator-max-microvolt =3D <1000000>;
> +
> +                               regulator-name =3D "vcc1v0_soc";
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt =3D <=
1000000>;
> +                               };
> +                       };
> +
> +                       /* LDO4: 3V3 PMU */
> +                       vcc3v0_pmu: LDO_REG4 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <3300000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +
> +                               regulator-name =3D "vcc3v0_pmu";
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt =3D <=
3300000>;
> +
> +                               };
> +                       };
> +
> +                       /* LDO5: VCC SD */
> +                       vccio_sd: LDO_REG5 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <3300000>;
> +
> +                               regulator-name =3D "vccio_sd";
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt =3D <=
3300000>;
> +                               };
> +                       };
> +
> +                       /* LDO6: unused */
> +
> +                       /* LDO7: unused */
> +
> +                       /* LDO8: 1V8 IO2 */
> +                       vcc1v8_dvp: LDO_REG8 {
> +                               regulator-always-on;
> +                               regulator-boot-on;
> +                               regulator-min-microvolt =3D <1800000>;
> +                               regulator-max-microvolt =3D <1800000>;
> +
> +                               regulator-name =3D "vcc1v8_dvp";
> +                               regulator-state-mem {
> +                                       regulator-on-in-suspend;
> +                                       regulator-suspend-microvolt =3D <=
1800000>;
> +                               };
> +                       };
> +
> +                       /* LDO9: unused */
> +
> +                       /* Switch 1: unused */
> +
> +                       vcc3v3_lcd: SWITCH_REG2 {
> +                               regulator-name =3D "vcc3v3_lcd";
> +                       };
> +               };
> +       };
> +
> +       /* RTC on OSM module REV3.00 */
> +       rtc@68 {
> +               status =3D "okay";
> +               compatible =3D "adi,max31343";
> +               reg =3D <0x68>;
> +       };
> +
> +       /* CAT24C32 EEPROM on OSM module */
> +       eeprom@50 {
> +               status =3D "okay";
> +               compatible =3D "atmel,24c32";
> +               reg =3D <0x50>;
> +               pagesize =3D <32>;
> +       };
> +};
> +
> +&pinctrl {
> +       pmic {
> +               pmic_int: pmic_int {
> +                       rockchip,pins =3D
> +                               <0 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>;
> +               };
> +
> +               soc_slppin_gpio: soc_slppin_gpio {
> +                       rockchip,pins =3D
> +                               <0 RK_PA4 RK_FUNC_GPIO &pcfg_output_low>;
> +               };
> +
> +               soc_slppin_slp: soc_slppin_slp {
> +                       rockchip,pins =3D
> +                               <0 RK_PA4 1 &pcfg_pull_none>;
> +               };
> +
> +               soc_slppin_rst: soc_slppin_rst {
> +                       rockchip,pins =3D
> +                               <0 RK_PA4 2 &pcfg_pull_none>;
> +               };
> +       };
> +
> +       uart2-m1 {
> +               uart2m1_xfer: uart2m1-xfer {
> +                       rockchip,pins =3D
> +                               <2 RK_PB4 2 &pcfg_pull_up>,
> +                               <2 RK_PB6 2 &pcfg_pull_up_2ma>;
> +               };
> +       };
> +};
> --
> 2.44.0
>=20
>=20
>=20
> -------------------------------------------------------------------------=
=2D-------------------------------------------
>=20
> Immer gut informiert sein mit dem Product Development Blog (PDB)
>=20
>=20
> Bleiben Sie stets gut informiert =FCber unsere Computermodule der OSM Bau=
reihe und erhalten Sie aktuelle Informationen aus unserer Entwicklungsabtei=
lung.
> F=FCr weitere Informationen, als auch der M=F6glichkeit zu Registrierung,=
 nutzen Sie den nachfolgenden Link:
> https://news.iesy.com/registrierung-product-development-blog-pdb-iesy-gmb=
h=20
>=20
> Always be well informed with the Product Development Blog (PDB)
> Stay well informed about our computer modules of the OSM series and get t=
he latest information from our development department.
> For more information, as well as the possibility to register, please use =
the following link:
> https://news.iesy.com/en/registration-product-development-blog-pdb-iesy-g=
mbh=20
>=20
> -------------------------------------------------------------------------=
=2D-------------------------------------------
>=20
> Die in dieser E-Mail enthaltenen Informationen sind vertraulich und ledig=
lich f=FCr den Empf=E4nger bestimmt.
> Sollten Sie nicht der eigentliche Empf=E4nger sein, informieren Sie uns b=
itte umgehend und l=F6schen diese E-Mail.
>=20
> The information contained in this message is confidential and is intended=
 for the addressee only.
> If you are not the intended recipient, please inform us immediately and d=
elete this email.





