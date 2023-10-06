Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185BF7BB651
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjJFLU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbjJFLUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:20:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5456113;
        Fri,  6 Oct 2023 04:19:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B6EC433D9;
        Fri,  6 Oct 2023 11:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696591196;
        bh=uA7ckFf8Gg/sDkFMnQA5Ldx3mvkKY9SfVQbj1YIEvFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GVRY5ItzL+165lLRf01YMQ2ve2lOQmodgefySiZ3j8ICQCo122EH2Plc3g9y2FGzz
         cDM0VIuKz0mS9HHYZUEHVlZ/5Kxyuvwe5Wnxx9OayJLW7Q/WllrW8i5xQahCZb+em0
         ttzaFtNBNybrz3lswDGsfDBwKZNbGF/yIZAgxci0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.134
Date:   Fri,  6 Oct 2023 13:19:43 +0200
Message-ID: <2023100643-fidelity-scrunch-5d2b@gregkh>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <2023100643-change-onset-3796@gregkh>
References: <2023100643-change-onset-3796@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index b6e42a131235..9800b8d6046a 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 133
+SUBLEVEL = 134
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index f6ec85d58dd1..f53695ecbb78 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree Source for AM33XX SoC
  *
  * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/bus/ti-sysc.h>
diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
index de33c4f89f33..cb316135bc7c 100644
--- a/arch/arm/boot/dts/am3517.dtsi
+++ b/arch/arm/boot/dts/am3517.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree Source for am3517 SoC
  *
  * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include "omap3.dtsi"
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 61a1d88f9df6..8613355bbd5e 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree Source for AM4372 SoC
  *
  * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/bus/ti-sysc.h>
diff --git a/arch/arm/boot/dts/artpec6-devboard.dts b/arch/arm/boot/dts/artpec6-devboard.dts
index d20d95359b28..042a9cc920c6 100644
--- a/arch/arm/boot/dts/artpec6-devboard.dts
+++ b/arch/arm/boot/dts/artpec6-devboard.dts
@@ -1,10 +1,5 @@
-/*
- * Axis ARTPEC-6 development board.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0-only
+// Axis ARTPEC-6 development board.
 
 /dts-v1/;
 #include "artpec6.dtsi"
diff --git a/arch/arm/boot/dts/dm814x.dtsi b/arch/arm/boot/dts/dm814x.dtsi
index 7702e048e110..379abf90c765 100644
--- a/arch/arm/boot/dts/dm814x.dtsi
+++ b/arch/arm/boot/dts/dm814x.dtsi
@@ -1,8 +1,4 @@
-/*
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0-only
 
 #include <dt-bindings/bus/ti-sysc.h>
 #include <dt-bindings/clock/dm814.h>
diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
index a9e7274806f4..ce62f1fa1faf 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -1,8 +1,4 @@
-/*
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0-only
 
 #include <dt-bindings/bus/ti-sysc.h>
 #include <dt-bindings/clock/dm816.h>
diff --git a/arch/arm/boot/dts/dra62x.dtsi b/arch/arm/boot/dts/dra62x.dtsi
index cc4878aaa8ea..cfefa670515c 100644
--- a/arch/arm/boot/dts/dra62x.dtsi
+++ b/arch/arm/boot/dts/dra62x.dtsi
@@ -1,8 +1,4 @@
-/*
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0-only
 
 #include "dm814x.dtsi"
 
diff --git a/arch/arm/boot/dts/dra7-dspeve-thermal.dtsi b/arch/arm/boot/dts/dra7-dspeve-thermal.dtsi
index e75569383dd8..747ff0db90c7 100644
--- a/arch/arm/boot/dts/dra7-dspeve-thermal.dtsi
+++ b/arch/arm/boot/dts/dra7-dspeve-thermal.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree Source for DRA7x SoC DSPEVE thermal
  *
  * Copyright (C) 2016 Texas Instruments Incorporated - https://www.ti.com/
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/thermal/thermal.h>
diff --git a/arch/arm/boot/dts/dra7-iva-thermal.dtsi b/arch/arm/boot/dts/dra7-iva-thermal.dtsi
index a7077321613f..0a31313065df 100644
--- a/arch/arm/boot/dts/dra7-iva-thermal.dtsi
+++ b/arch/arm/boot/dts/dra7-iva-thermal.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree Source for DRA7x SoC IVA thermal
  *
  * Copyright (C) 2016 Texas Instruments Incorporated - https://www.ti.com/
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/thermal/thermal.h>
diff --git a/arch/arm/boot/dts/imx6q-gk802.dts b/arch/arm/boot/dts/imx6q-gk802.dts
index ccc2487d47ca..2fda68f9d3f6 100644
--- a/arch/arm/boot/dts/imx6q-gk802.dts
+++ b/arch/arm/boot/dts/imx6q-gk802.dts
@@ -1,10 +1,5 @@
-/*
- * Copyright (C) 2013 Philipp Zabel
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2013 Philipp Zabel
 
 /dts-v1/;
 #include <dt-bindings/gpio/gpio.h>
diff --git a/arch/arm/boot/dts/motorola-mapphone-common.dtsi b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
index a4423ff0df39..67c68c61ae02 100644
--- a/arch/arm/boot/dts/motorola-mapphone-common.dtsi
+++ b/arch/arm/boot/dts/motorola-mapphone-common.dtsi
@@ -614,12 +614,12 @@ &rng_target {
 /* Configure pwm clock source for timers 8 & 9 */
 &timer8 {
 	assigned-clocks = <&abe_clkctrl OMAP4_TIMER8_CLKCTRL 24>;
-	assigned-clock-parents = <&sys_clkin_ck>;
+	assigned-clock-parents = <&sys_32k_ck>;
 };
 
 &timer9 {
 	assigned-clocks = <&l4_per_clkctrl OMAP4_TIMER9_CLKCTRL 24>;
-	assigned-clock-parents = <&sys_clkin_ck>;
+	assigned-clock-parents = <&sys_32k_ck>;
 };
 
 /*
diff --git a/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi b/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
index ded7e8fec9eb..9cf52650f073 100644
--- a/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
+++ b/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
@@ -8,9 +8,9 @@
 
 / {
 	vddvario: regulator-vddvario {
-		  compatible = "regulator-fixed";
-		  regulator-name = "vddvario";
-		  regulator-always-on;
+		compatible = "regulator-fixed";
+		regulator-name = "vddvario";
+		regulator-always-on;
 	};
 
 	vdd33a: regulator-vdd33a {
diff --git a/arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi b/arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi
index e7534fe9c53c..bc8961f3690f 100644
--- a/arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi
+++ b/arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi
@@ -12,9 +12,9 @@
 
 / {
 	vddvario: regulator-vddvario {
-		  compatible = "regulator-fixed";
-		  regulator-name = "vddvario";
-		  regulator-always-on;
+		compatible = "regulator-fixed";
+		regulator-name = "vddvario";
+		regulator-always-on;
 	};
 
 	vdd33a: regulator-vdd33a {
diff --git a/arch/arm/boot/dts/omap2.dtsi b/arch/arm/boot/dts/omap2.dtsi
index 5750ca1233cc..afabb36a8ac1 100644
--- a/arch/arm/boot/dts/omap2.dtsi
+++ b/arch/arm/boot/dts/omap2.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree Source for OMAP2 SoC
  *
  * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/bus/ti-sysc.h>
diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
index bb529a2a295d..821da51cb870 100644
--- a/arch/arm/boot/dts/omap2420.dtsi
+++ b/arch/arm/boot/dts/omap2420.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree Source for OMAP2420 SoC
  *
  * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include "omap2.dtsi"
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index 23115ba61bc0..b9a9e6e45266 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree Source for OMAP243x SoC
  *
  * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include "omap2.dtsi"
diff --git a/arch/arm/boot/dts/omap3-cm-t3517.dts b/arch/arm/boot/dts/omap3-cm-t3517.dts
index 3b8349094baa..f25c0a84a190 100644
--- a/arch/arm/boot/dts/omap3-cm-t3517.dts
+++ b/arch/arm/boot/dts/omap3-cm-t3517.dts
@@ -11,12 +11,12 @@ / {
 	model = "CompuLab CM-T3517";
 	compatible = "compulab,omap3-cm-t3517", "ti,am3517", "ti,omap3";
 
-	vmmc:  regulator-vmmc {
-                compatible = "regulator-fixed";
-                regulator-name = "vmmc";
-                regulator-min-microvolt = <3300000>;
-                regulator-max-microvolt = <3300000>;
-        };
+	vmmc: regulator-vmmc {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
 
 	wl12xx_vmmc2: wl12xx_vmmc2 {
 		compatible = "regulator-fixed";
diff --git a/arch/arm/boot/dts/omap3-cpu-thermal.dtsi b/arch/arm/boot/dts/omap3-cpu-thermal.dtsi
index 1ed837859374..4d2684e4ae06 100644
--- a/arch/arm/boot/dts/omap3-cpu-thermal.dtsi
+++ b/arch/arm/boot/dts/omap3-cpu-thermal.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree Source for OMAP3 SoC CPU thermal
  *
  * Copyright (C) 2017 Texas Instruments Incorporated - https://www.ti.com/
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/thermal/thermal.h>
@@ -15,8 +12,7 @@ cpu_thermal: cpu_thermal {
 	polling-delay = <1000>; /* milliseconds */
 	coefficients = <0 20000>;
 
-			/* sensor       ID */
-	thermal-sensors = <&bandgap     0>;
+	thermal-sensors = <&bandgap>;
 
 	cpu_trips: trips {
 		cpu_alert0: cpu_alert {
diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index bb5e00b36d8d..465e0c0ebe56 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -332,7 +332,7 @@ OMAP3_CORE1_IOPAD(0x2106, PIN_OUTPUT | MUX_MODE0)   /* dss_data21.dss_data21 */
 			OMAP3_CORE1_IOPAD(0x2108, PIN_OUTPUT | MUX_MODE0)   /* dss_data22.dss_data22 */
 			OMAP3_CORE1_IOPAD(0x210a, PIN_OUTPUT | MUX_MODE0)   /* dss_data23.dss_data23 */
 		>;
-       };
+	};
 
 	gps_pins: pinmux_gps_pins {
 		pinctrl-single,pins = <
@@ -866,8 +866,8 @@ &mcbsp4 { /* GSM voice PCM */
 };
 
 &hdqw1w {
-        pinctrl-names = "default";
-        pinctrl-0 = <&hdq_pins>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdq_pins>;
 };
 
 /* image signal processor within OMAP3 SoC */
diff --git a/arch/arm/boot/dts/omap3-ldp.dts b/arch/arm/boot/dts/omap3-ldp.dts
index 9c6a92724590..b898e2f6f41d 100644
--- a/arch/arm/boot/dts/omap3-ldp.dts
+++ b/arch/arm/boot/dts/omap3-ldp.dts
@@ -301,5 +301,5 @@ &usb_otg_hs {
 
 &vaux1 {
 	/* Needed for ads7846 */
-        regulator-name = "vcc";
+	regulator-name = "vcc";
 };
diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index d40c3d2c4914..fdd929bc65d7 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -236,27 +236,27 @@ gpmc_pins: pinmux_gpmc_pins {
 		pinctrl-single,pins = <
 
 			/* address lines */
-                        OMAP3_CORE1_IOPAD(0x207a, PIN_OUTPUT | MUX_MODE0)       /* gpmc_a1.gpmc_a1 */
-                        OMAP3_CORE1_IOPAD(0x207c, PIN_OUTPUT | MUX_MODE0)       /* gpmc_a2.gpmc_a2 */
-                        OMAP3_CORE1_IOPAD(0x207e, PIN_OUTPUT | MUX_MODE0)       /* gpmc_a3.gpmc_a3 */
+			OMAP3_CORE1_IOPAD(0x207a, PIN_OUTPUT | MUX_MODE0)       /* gpmc_a1.gpmc_a1 */
+			OMAP3_CORE1_IOPAD(0x207c, PIN_OUTPUT | MUX_MODE0)       /* gpmc_a2.gpmc_a2 */
+			OMAP3_CORE1_IOPAD(0x207e, PIN_OUTPUT | MUX_MODE0)       /* gpmc_a3.gpmc_a3 */
 
 			/* data lines, gpmc_d0..d7 not muxable according to TRM */
-                        OMAP3_CORE1_IOPAD(0x209e, PIN_INPUT | MUX_MODE0)        /* gpmc_d8.gpmc_d8 */
-                        OMAP3_CORE1_IOPAD(0x20a0, PIN_INPUT | MUX_MODE0)        /* gpmc_d9.gpmc_d9 */
-                        OMAP3_CORE1_IOPAD(0x20a2, PIN_INPUT | MUX_MODE0)        /* gpmc_d10.gpmc_d10 */
-                        OMAP3_CORE1_IOPAD(0x20a4, PIN_INPUT | MUX_MODE0)        /* gpmc_d11.gpmc_d11 */
-                        OMAP3_CORE1_IOPAD(0x20a6, PIN_INPUT | MUX_MODE0)        /* gpmc_d12.gpmc_d12 */
-                        OMAP3_CORE1_IOPAD(0x20a8, PIN_INPUT | MUX_MODE0)        /* gpmc_d13.gpmc_d13 */
-                        OMAP3_CORE1_IOPAD(0x20aa, PIN_INPUT | MUX_MODE0)        /* gpmc_d14.gpmc_d14 */
-                        OMAP3_CORE1_IOPAD(0x20ac, PIN_INPUT | MUX_MODE0)        /* gpmc_d15.gpmc_d15 */
+			OMAP3_CORE1_IOPAD(0x209e, PIN_INPUT | MUX_MODE0)        /* gpmc_d8.gpmc_d8 */
+			OMAP3_CORE1_IOPAD(0x20a0, PIN_INPUT | MUX_MODE0)        /* gpmc_d9.gpmc_d9 */
+			OMAP3_CORE1_IOPAD(0x20a2, PIN_INPUT | MUX_MODE0)        /* gpmc_d10.gpmc_d10 */
+			OMAP3_CORE1_IOPAD(0x20a4, PIN_INPUT | MUX_MODE0)        /* gpmc_d11.gpmc_d11 */
+			OMAP3_CORE1_IOPAD(0x20a6, PIN_INPUT | MUX_MODE0)        /* gpmc_d12.gpmc_d12 */
+			OMAP3_CORE1_IOPAD(0x20a8, PIN_INPUT | MUX_MODE0)        /* gpmc_d13.gpmc_d13 */
+			OMAP3_CORE1_IOPAD(0x20aa, PIN_INPUT | MUX_MODE0)        /* gpmc_d14.gpmc_d14 */
+			OMAP3_CORE1_IOPAD(0x20ac, PIN_INPUT | MUX_MODE0)        /* gpmc_d15.gpmc_d15 */
 
 			/*
 			 * gpmc_ncs0, gpmc_nadv_ale, gpmc_noe, gpmc_nwe, gpmc_wait0 not muxable
 			 * according to TRM. OneNAND seems to require PIN_INPUT on clock.
 			 */
-                        OMAP3_CORE1_IOPAD(0x20b0, PIN_OUTPUT | MUX_MODE0)       /* gpmc_ncs1.gpmc_ncs1 */
-                        OMAP3_CORE1_IOPAD(0x20be, PIN_INPUT | MUX_MODE0)        /* gpmc_clk.gpmc_clk */
-		>;
+			OMAP3_CORE1_IOPAD(0x20b0, PIN_OUTPUT | MUX_MODE0)       /* gpmc_ncs1.gpmc_ncs1 */
+			OMAP3_CORE1_IOPAD(0x20be, PIN_INPUT | MUX_MODE0)        /* gpmc_clk.gpmc_clk */
+			>;
 	};
 
 	i2c1_pins: pinmux_i2c1_pins {
@@ -738,12 +738,12 @@ tpa6130a2: tpa6130a2@60 {
 
 	si4713: si4713@63 {
 		compatible = "silabs,si4713";
-                reg = <0x63>;
+		reg = <0x63>;
 
-                interrupts-extended = <&gpio2 21 IRQ_TYPE_EDGE_FALLING>; /* 53 */
-                reset-gpios = <&gpio6 3 GPIO_ACTIVE_HIGH>; /* 163 */
-                vio-supply = <&vio>;
-                vdd-supply = <&vaux1>;
+		interrupts-extended = <&gpio2 21 IRQ_TYPE_EDGE_FALLING>; /* 53 */
+		reset-gpios = <&gpio6 3 GPIO_ACTIVE_HIGH>; /* 163 */
+		vio-supply = <&vio>;
+		vdd-supply = <&vaux1>;
 	};
 
 	bq24150a: bq24150a@6b {
diff --git a/arch/arm/boot/dts/omap3-zoom3.dts b/arch/arm/boot/dts/omap3-zoom3.dts
index 0482676d1830..ce58b1f208e8 100644
--- a/arch/arm/boot/dts/omap3-zoom3.dts
+++ b/arch/arm/boot/dts/omap3-zoom3.dts
@@ -23,9 +23,9 @@ memory@80000000 {
 	};
 
 	vddvario: regulator-vddvario {
-		  compatible = "regulator-fixed";
-		  regulator-name = "vddvario";
-		  regulator-always-on;
+		compatible = "regulator-fixed";
+		regulator-name = "vddvario";
+		regulator-always-on;
 	};
 
 	vdd33a: regulator-vdd33a {
@@ -84,28 +84,28 @@ OMAP3_CORE1_IOPAD(0x21d0, PIN_INPUT_PULLUP | MUX_MODE3)	/* mcspi1_cs1.sdmmc3_cmd
 
 	uart1_pins: pinmux_uart1_pins {
 		pinctrl-single,pins = <
-                        OMAP3_CORE1_IOPAD(0x2180, PIN_INPUT | MUX_MODE0)		/* uart1_cts.uart1_cts */
-                        OMAP3_CORE1_IOPAD(0x217e, PIN_OUTPUT | MUX_MODE0)		/* uart1_rts.uart1_rts */
-                        OMAP3_CORE1_IOPAD(0x2182, WAKEUP_EN | PIN_INPUT | MUX_MODE0) /* uart1_rx.uart1_rx */
-                        OMAP3_CORE1_IOPAD(0x217c, PIN_OUTPUT | MUX_MODE0)		/* uart1_tx.uart1_tx */
+			OMAP3_CORE1_IOPAD(0x2180, PIN_INPUT | MUX_MODE0)		/* uart1_cts.uart1_cts */
+			OMAP3_CORE1_IOPAD(0x217e, PIN_OUTPUT | MUX_MODE0)		/* uart1_rts.uart1_rts */
+			OMAP3_CORE1_IOPAD(0x2182, WAKEUP_EN | PIN_INPUT | MUX_MODE0) /* uart1_rx.uart1_rx */
+			OMAP3_CORE1_IOPAD(0x217c, PIN_OUTPUT | MUX_MODE0)		/* uart1_tx.uart1_tx */
 		>;
 	};
 
 	uart2_pins: pinmux_uart2_pins {
 		pinctrl-single,pins = <
-                        OMAP3_CORE1_IOPAD(0x2174, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart2_cts.uart2_cts */
-                        OMAP3_CORE1_IOPAD(0x2176, PIN_OUTPUT | MUX_MODE0)		/* uart2_rts.uart2_rts */
-                        OMAP3_CORE1_IOPAD(0x217a, PIN_INPUT | MUX_MODE0)		/* uart2_rx.uart2_rx */
-                        OMAP3_CORE1_IOPAD(0x2178, PIN_OUTPUT | MUX_MODE0)		/* uart2_tx.uart2_tx */
+			OMAP3_CORE1_IOPAD(0x2174, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart2_cts.uart2_cts */
+			OMAP3_CORE1_IOPAD(0x2176, PIN_OUTPUT | MUX_MODE0)		/* uart2_rts.uart2_rts */
+			OMAP3_CORE1_IOPAD(0x217a, PIN_INPUT | MUX_MODE0)		/* uart2_rx.uart2_rx */
+			OMAP3_CORE1_IOPAD(0x2178, PIN_OUTPUT | MUX_MODE0)		/* uart2_tx.uart2_tx */
 		>;
 	};
 
 	uart3_pins: pinmux_uart3_pins {
 		pinctrl-single,pins = <
-                        OMAP3_CORE1_IOPAD(0x219a, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* uart3_cts_rctx.uart3_cts_rctx */
-                        OMAP3_CORE1_IOPAD(0x219c, PIN_OUTPUT | MUX_MODE0)		/* uart3_rts_sd.uart3_rts_sd */
-                        OMAP3_CORE1_IOPAD(0x219e, PIN_INPUT | MUX_MODE0)		/* uart3_rx_irrx.uart3_rx_irrx */
-                        OMAP3_CORE1_IOPAD(0x21a0, PIN_OUTPUT | MUX_MODE0)		/* uart3_tx_irtx.uart3_tx_irtx */
+			OMAP3_CORE1_IOPAD(0x219a, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* uart3_cts_rctx.uart3_cts_rctx */
+			OMAP3_CORE1_IOPAD(0x219c, PIN_OUTPUT | MUX_MODE0)		/* uart3_rts_sd.uart3_rts_sd */
+			OMAP3_CORE1_IOPAD(0x219e, PIN_INPUT | MUX_MODE0)		/* uart3_rx_irrx.uart3_rx_irrx */
+			OMAP3_CORE1_IOPAD(0x21a0, PIN_OUTPUT | MUX_MODE0)		/* uart3_tx_irtx.uart3_tx_irtx */
 		>;
 	};
 
@@ -205,22 +205,22 @@ wlcore: wlcore@2 {
 };
 
 &uart1 {
-       pinctrl-names = "default";
-       pinctrl-0 = <&uart1_pins>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
 };
 
 &uart2 {
-       pinctrl-names = "default";
-       pinctrl-0 = <&uart2_pins>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
 };
 
 &uart3 {
-       pinctrl-names = "default";
-       pinctrl-0 = <&uart3_pins>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
 };
 
 &uart4 {
-       status = "disabled";
+	status = "disabled";
 };
 
 &usb_otg_hs {
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 64b7e6fddd1b..825075ff0e34 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree Source for OMAP3 SoC
  *
  * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/bus/ti-sysc.h>
diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/omap34xx.dtsi
index 8b8451399784..2eb73ae7ef3e 100644
--- a/arch/arm/boot/dts/omap34xx.dtsi
+++ b/arch/arm/boot/dts/omap34xx.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree Source for OMAP34xx/OMAP35xx SoC
  *
  * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/bus/ti-sysc.h>
diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
index 22b33098b1a2..32ac7924a130 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree Source for OMAP3 SoC
  *
  * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/bus/ti-sysc.h>
diff --git a/arch/arm/boot/dts/omap4-cpu-thermal.dtsi b/arch/arm/boot/dts/omap4-cpu-thermal.dtsi
index 03d054b2bf9a..d484ec1e4fd8 100644
--- a/arch/arm/boot/dts/omap4-cpu-thermal.dtsi
+++ b/arch/arm/boot/dts/omap4-cpu-thermal.dtsi
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree Source for OMAP4/5 SoC CPU thermal
  *
  * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
  * Contact: Eduardo Valentin <eduardo.valentin@ti.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/thermal/thermal.h>
@@ -15,21 +12,24 @@ cpu_thermal: cpu_thermal {
 	polling-delay-passive = <250>; /* milliseconds */
 	polling-delay = <1000>; /* milliseconds */
 
-			/* sensor       ID */
-        thermal-sensors = <&bandgap     0>;
+	/*
+	 * See 44xx files for single sensor addressing, omap5 and dra7 need
+	 * also sensor ID for addressing.
+	 */
+	thermal-sensors = <&bandgap     0>;
 
 	cpu_trips: trips {
-                cpu_alert0: cpu_alert {
-                        temperature = <100000>; /* millicelsius */
-                        hysteresis = <2000>; /* millicelsius */
-                        type = "passive";
-                };
-                cpu_crit: cpu_crit {
-                        temperature = <125000>; /* millicelsius */
-                        hysteresis = <2000>; /* millicelsius */
-                        type = "critical";
-                };
-        };
+		cpu_alert0: cpu_alert {
+			temperature = <100000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "passive";
+		};
+		cpu_crit: cpu_crit {
+			temperature = <125000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "critical";
+		};
+	};
 
 	cpu_cooling_maps: cooling-maps {
 		map0 {
diff --git a/arch/arm/boot/dts/omap443x.dtsi b/arch/arm/boot/dts/omap443x.dtsi
index 8466161197ae..2104170fe2cd 100644
--- a/arch/arm/boot/dts/omap443x.dtsi
+++ b/arch/arm/boot/dts/omap443x.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree Source for OMAP443x SoC
  *
  * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include "omap4.dtsi"
@@ -72,6 +69,7 @@ abb_iva: regulator-abb-iva {
 };
 
 &cpu_thermal {
+	thermal-sensors = <&bandgap>;
 	coefficients = <0 20000>;
 };
 
diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts/omap4460.dtsi
index 3d6db1db94e0..a6764750d447 100644
--- a/arch/arm/boot/dts/omap4460.dtsi
+++ b/arch/arm/boot/dts/omap4460.dtsi
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree Source for OMAP4460 SoC
  *
  * Copyright (C) 2012 Texas Instruments Incorporated - https://www.ti.com/
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 #include "omap4.dtsi"
 
@@ -82,6 +79,7 @@ abb_iva: regulator-abb-iva {
 };
 
 &cpu_thermal {
+	thermal-sensors = <&bandgap>;
 	coefficients = <348 (-9301)>;
 };
 
diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5-cm-t54.dts
index e62ea8b6d53f..af288d63a26a 100644
--- a/arch/arm/boot/dts/omap5-cm-t54.dts
+++ b/arch/arm/boot/dts/omap5-cm-t54.dts
@@ -84,36 +84,36 @@ led1 {
 	};
 
 	lcd0: display {
-                compatible = "startek,startek-kd050c", "panel-dpi";
-                label = "lcd";
-
-                pinctrl-names = "default";
-                pinctrl-0 = <&lcd_pins>;
-
-                enable-gpios = <&gpio8 3 GPIO_ACTIVE_HIGH>;
-
-                panel-timing {
-                        clock-frequency = <33000000>;
-                        hactive = <800>;
-                        vactive = <480>;
-                        hfront-porch = <40>;
-                        hback-porch = <40>;
-                        hsync-len = <43>;
-                        vback-porch = <29>;
-                        vfront-porch = <13>;
-                        vsync-len = <3>;
-                        hsync-active = <0>;
-                        vsync-active = <0>;
-                        de-active = <1>;
-                        pixelclk-active = <1>;
-                };
-
-                port {
-                        lcd_in: endpoint {
-                                remote-endpoint = <&dpi_lcd_out>;
-                        };
-                };
-        };
+		compatible = "startek,startek-kd050c", "panel-dpi";
+		label = "lcd";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&lcd_pins>;
+
+		enable-gpios = <&gpio8 3 GPIO_ACTIVE_HIGH>;
+
+		panel-timing {
+			clock-frequency = <33000000>;
+			hactive = <800>;
+			vactive = <480>;
+			hfront-porch = <40>;
+			hback-porch = <40>;
+			hsync-len = <43>;
+			vback-porch = <29>;
+			vfront-porch = <13>;
+			vsync-len = <3>;
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <1>;
+			pixelclk-active = <1>;
+		};
+
+		port {
+			lcd_in: endpoint {
+				remote-endpoint = <&dpi_lcd_out>;
+			};
+		};
+	};
 
 	hdmi0: connector0 {
 		compatible = "hdmi-connector";
@@ -644,8 +644,8 @@ &usbhsehci {
 };
 
 &usb3 {
-       extcon = <&extcon_usb3>;
-       vbus-supply = <&smps10_out1_reg>;
+	extcon = <&extcon_usb3>;
+	vbus-supply = <&smps10_out1_reg>;
 };
 
 &cpu0 {
diff --git a/arch/arm/boot/dts/omap5-core-thermal.dtsi b/arch/arm/boot/dts/omap5-core-thermal.dtsi
index 02e76338bfbc..e0d8e39a0014 100644
--- a/arch/arm/boot/dts/omap5-core-thermal.dtsi
+++ b/arch/arm/boot/dts/omap5-core-thermal.dtsi
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree Source for OMAP543x SoC CORE thermal
  *
  * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
  * Contact: Eduardo Valentin <eduardo.valentin@ti.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/thermal/thermal.h>
diff --git a/arch/arm/boot/dts/omap5-gpu-thermal.dtsi b/arch/arm/boot/dts/omap5-gpu-thermal.dtsi
index bf8fa9372e57..1b4b7d9136c8 100644
--- a/arch/arm/boot/dts/omap5-gpu-thermal.dtsi
+++ b/arch/arm/boot/dts/omap5-gpu-thermal.dtsi
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree Source for OMAP543x SoC GPU thermal
  *
  * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
  * Contact: Eduardo Valentin <eduardo.valentin@ti.com>
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #include <dt-bindings/thermal/thermal.h>
diff --git a/arch/arm/boot/dts/orion5x-lacie-d2-network.dts b/arch/arm/boot/dts/orion5x-lacie-d2-network.dts
index 422958d13d42..03471d30bfd9 100644
--- a/arch/arm/boot/dts/orion5x-lacie-d2-network.dts
+++ b/arch/arm/boot/dts/orion5x-lacie-d2-network.dts
@@ -1,10 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2014 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
  * Copyright (C) 2009 Simon Guinot <sguinot@lacie.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
index 0043e0040153..f17e25ac98dd 100644
--- a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
+++ b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
@@ -1,10 +1,5 @@
-/*
- * Copyright (C) 2012 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2012 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
 
 /*
  * TODO: add Orion USB device port init when kernel.org support is added.
diff --git a/arch/arm/boot/dts/orion5x-maxtor-shared-storage-2.dts b/arch/arm/boot/dts/orion5x-maxtor-shared-storage-2.dts
index 0ca6208a267d..d57859998350 100644
--- a/arch/arm/boot/dts/orion5x-maxtor-shared-storage-2.dts
+++ b/arch/arm/boot/dts/orion5x-maxtor-shared-storage-2.dts
@@ -1,10 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2014 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
  * Copyright (C) Sylver Bruneau <sylver.bruneau@googlemail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 /dts-v1/;
diff --git a/arch/arm/boot/dts/orion5x-mv88f5181.dtsi b/arch/arm/boot/dts/orion5x-mv88f5181.dtsi
index f667012b26ca..819f9efb7058 100644
--- a/arch/arm/boot/dts/orion5x-mv88f5181.dtsi
+++ b/arch/arm/boot/dts/orion5x-mv88f5181.dtsi
@@ -1,10 +1,5 @@
-/*
- * Copyright (C) 2016 Jamie Lentin <jm@lentin.co.uk>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2016 Jamie Lentin <jm@lentin.co.uk>
 
 #include "orion5x.dtsi"
 
diff --git a/arch/arm/boot/dts/orion5x-mv88f5182.dtsi b/arch/arm/boot/dts/orion5x-mv88f5182.dtsi
index d1ed71c60209..86b87fb26dc9 100644
--- a/arch/arm/boot/dts/orion5x-mv88f5182.dtsi
+++ b/arch/arm/boot/dts/orion5x-mv88f5182.dtsi
@@ -1,10 +1,5 @@
-/*
- * Copyright (C) 2014 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2014 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
 
 #include "orion5x.dtsi"
 
diff --git a/arch/arm/boot/dts/orion5x-netgear-wnr854t.dts b/arch/arm/boot/dts/orion5x-netgear-wnr854t.dts
index ea081afa469d..4f4888ec9138 100644
--- a/arch/arm/boot/dts/orion5x-netgear-wnr854t.dts
+++ b/arch/arm/boot/dts/orion5x-netgear-wnr854t.dts
@@ -1,10 +1,5 @@
-/*
- * Copyright (C) 2016 Jamie Lentin <jm@lentin.co.uk>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2016 Jamie Lentin <jm@lentin.co.uk>
 
 /dts-v1/;
 
diff --git a/arch/arm/boot/dts/orion5x-rd88f5182-nas.dts b/arch/arm/boot/dts/orion5x-rd88f5182-nas.dts
index 487324f7c54e..fd78aa02a3c5 100644
--- a/arch/arm/boot/dts/orion5x-rd88f5182-nas.dts
+++ b/arch/arm/boot/dts/orion5x-rd88f5182-nas.dts
@@ -1,10 +1,5 @@
-/*
- * Copyright (C) 2014 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2014 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
 
 /dts-v1/;
 
diff --git a/arch/arm/boot/dts/orion5x.dtsi b/arch/arm/boot/dts/orion5x.dtsi
index 61e631b3fd8b..2d41f5c166ee 100644
--- a/arch/arm/boot/dts/orion5x.dtsi
+++ b/arch/arm/boot/dts/orion5x.dtsi
@@ -1,10 +1,5 @@
-/*
- * Copyright (C) 2012 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2012 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
 
 #define MBUS_ID(target,attributes) (((target) << 24) | ((attributes) << 16))
 
diff --git a/arch/arm/include/asm/hardware/cache-aurora-l2.h b/arch/arm/include/asm/hardware/cache-aurora-l2.h
index 39769ffa0051..9694808ee97c 100644
--- a/arch/arm/include/asm/hardware/cache-aurora-l2.h
+++ b/arch/arm/include/asm/hardware/cache-aurora-l2.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * AURORA shared L2 cache controller support
  *
@@ -5,10 +6,6 @@
  *
  * Yehuda Yitschak <yehuday@marvell.com>
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef __ASM_ARM_HARDWARE_AURORA_L2_H
diff --git a/arch/arm/include/asm/hardware/cache-feroceon-l2.h b/arch/arm/include/asm/hardware/cache-feroceon-l2.h
index 12e1588dc4f1..eb2e7b7f70a8 100644
--- a/arch/arm/include/asm/hardware/cache-feroceon-l2.h
+++ b/arch/arm/include/asm/hardware/cache-feroceon-l2.h
@@ -1,13 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * arch/arm/include/asm/hardware/cache-feroceon-l2.h
  *
  * Copyright (C) 2008 Marvell Semiconductor
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 extern void __init feroceon_l2_init(int l2_wt_override);
 extern int __init feroceon_of_init(void);
-
diff --git a/arch/arm/include/asm/hardware/cache-tauros2.h b/arch/arm/include/asm/hardware/cache-tauros2.h
index 295e2e40151b..4e493facaa31 100644
--- a/arch/arm/include/asm/hardware/cache-tauros2.h
+++ b/arch/arm/include/asm/hardware/cache-tauros2.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * arch/arm/include/asm/hardware/cache-tauros2.h
  *
  * Copyright (C) 2008 Marvell Semiconductor
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #define CACHE_TAUROS2_PREFETCH_ON	(1 << 0)
diff --git a/arch/arm/mach-davinci/board-da830-evm.c b/arch/arm/mach-davinci/board-da830-evm.c
index 823c9cc98f18..d820161445fa 100644
--- a/arch/arm/mach-davinci/board-da830-evm.c
+++ b/arch/arm/mach-davinci/board-da830-evm.c
@@ -1,13 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * TI DA830/OMAP L137 EVM board
  *
  * Author: Mark A. Greer <mgreer@mvista.com>
  * Derived from: arch/arm/mach-davinci/board-dm644x-evm.c
  *
- * 2007, 2009 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2007, 2009 (c) MontaVista Software, Inc.
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index 7f7f6bae21c2..1601a74261a6 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * TI DA850/OMAP-L138 EVM board
  *
@@ -6,10 +7,7 @@
  * Derived from: arch/arm/mach-davinci/board-da830-evm.c
  * Original Copyrights follow:
  *
- * 2007, 2009 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2007, 2009 (c) MontaVista Software, Inc.
  */
 #include <linux/console.h>
 #include <linux/delay.h>
diff --git a/arch/arm/mach-davinci/board-dm355-evm.c b/arch/arm/mach-davinci/board-dm355-evm.c
index 3c5a9e3c128a..debc912b133f 100644
--- a/arch/arm/mach-davinci/board-dm355-evm.c
+++ b/arch/arm/mach-davinci/board-dm355-evm.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * TI DaVinci EVM board support
  *
  * Author: Kevin Hilman, Deep Root Systems, LLC
  *
- * 2007 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2007 (c) MontaVista Software, Inc.
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/arch/arm/mach-davinci/board-dm355-leopard.c b/arch/arm/mach-davinci/board-dm355-leopard.c
index e475b2113e70..7c8307d590a4 100644
--- a/arch/arm/mach-davinci/board-dm355-leopard.c
+++ b/arch/arm/mach-davinci/board-dm355-leopard.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * DM355 leopard board support
  *
  * Based on board-dm355-evm.c
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/arch/arm/mach-davinci/board-dm644x-evm.c b/arch/arm/mach-davinci/board-dm644x-evm.c
index cce3a621eb20..92a92c4cef72 100644
--- a/arch/arm/mach-davinci/board-dm644x-evm.c
+++ b/arch/arm/mach-davinci/board-dm644x-evm.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * TI DaVinci EVM board support
  *
  * Author: Kevin Hilman, MontaVista Software, Inc. <source@mvista.com>
  *
- * 2007 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2007 (c) MontaVista Software, Inc.
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/arch/arm/mach-davinci/board-dm646x-evm.c b/arch/arm/mach-davinci/board-dm646x-evm.c
index ee91d81ebbfd..c62815535b86 100644
--- a/arch/arm/mach-davinci/board-dm646x-evm.c
+++ b/arch/arm/mach-davinci/board-dm646x-evm.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * TI DaVinci DM646X EVM board
  *
@@ -5,11 +6,6 @@
  * Copyright (C) 2006 Texas Instruments.
  *
  * (C) 2007-2008, MontaVista Software, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- *
  */
 
 /**************************************************************************
@@ -873,4 +869,3 @@ MACHINE_START(DAVINCI_DM6467TEVM, "DaVinci DM6467T EVM")
 	.init_late	= davinci_init_late,
 	.dma_zone_size	= SZ_128M,
 MACHINE_END
-
diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
index 2127969beb96..a36365edfe20 100644
--- a/arch/arm/mach-davinci/board-mityomapl138.c
+++ b/arch/arm/mach-davinci/board-mityomapl138.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Critical Link MityOMAP-L138 SoM
  *
  * Copyright (C) 2010 Critical Link LLC - https://www.criticallink.com
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of
- * any kind, whether express or implied.
  */
 
 #define pr_fmt(fmt) "MityOMAPL138: " fmt
diff --git a/arch/arm/mach-davinci/board-neuros-osd2.c b/arch/arm/mach-davinci/board-neuros-osd2.c
index b4843f68bb57..ae0bce8655b4 100644
--- a/arch/arm/mach-davinci/board-neuros-osd2.c
+++ b/arch/arm/mach-davinci/board-neuros-osd2.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Neuros Technologies OSD2 board support
  *
@@ -18,10 +19,6 @@
  *
  * For more information please refer to
  * 		http://wiki.neurostechnology.com/index.php/OSD_2.0_HD
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 88df8011a4e6..f3e85d16f56a 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Hawkboard.org based on TI's OMAP-L138 Platform
  *
  * Initial code: Syed Mohammed Khasim
  *
  * Copyright (C) 2009 Texas Instruments Incorporated - https://www.ti.com
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of
- * any kind, whether express or implied.
  */
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/arch/arm/mach-davinci/common.c b/arch/arm/mach-davinci/common.c
index ae61d19f9b3a..5c2760723fcf 100644
--- a/arch/arm/mach-davinci/common.c
+++ b/arch/arm/mach-davinci/common.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Code commons to all DaVinci SoCs.
  *
  * Author: Mark A. Greer <mgreer@mvista.com>
  *
- * 2009 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2009 (c) MontaVista Software, Inc.
  */
 #include <linux/module.h>
 #include <linux/io.h>
diff --git a/arch/arm/mach-davinci/cpuidle.h b/arch/arm/mach-davinci/cpuidle.h
index 0d9193aefab5..976d43073597 100644
--- a/arch/arm/mach-davinci/cpuidle.h
+++ b/arch/arm/mach-davinci/cpuidle.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * TI DaVinci cpuidle platform support
  *
  * 2009 (C) Texas Instruments, Inc. https://www.ti.com/
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 #ifndef _MACH_DAVINCI_CPUIDLE_H
 #define _MACH_DAVINCI_CPUIDLE_H
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 018ab4b549f1..cd07415dc535 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * TI DA830/OMAP L137 chip specific setup
  *
  * Author: Mark A. Greer <mgreer@mvista.com>
  *
- * 2009 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2009 (c) MontaVista Software, Inc.
  */
 #include <linux/clk-provider.h>
 #include <linux/clk/davinci.h>
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 68156e7239a6..aedf020b62ed 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * TI DA850/OMAP-L138 chip specific setup
  *
@@ -6,10 +7,7 @@
  * Derived from: arch/arm/mach-davinci/da830.c
  * Original Copyrights follow:
  *
- * 2009 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2009 (c) MontaVista Software, Inc.
  */
 
 #include <linux/clk-provider.h>
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 5de72d2fa8f0..a49151bf37c4 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * TI DaVinci DM355 chip specific setup
  *
  * Author: Kevin Hilman, Deep Root Systems, LLC
  *
- * 2007 (c) Deep Root Systems, LLC. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2007 (c) Deep Root Systems, LLC.
  */
 
 #include <linux/clk-provider.h>
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 24988939ae46..f9b82a6a1630 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * TI DaVinci DM644x chip specific setup
  *
  * Author: Kevin Hilman, Deep Root Systems, LLC
  *
- * 2007 (c) Deep Root Systems, LLC. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2007 (c) Deep Root Systems, LLC.
  */
 
 #include <linux/clk-provider.h>
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 4ffd028ed997..d85d8e9e1371 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * TI DaVinci DM646x chip specific setup
  *
  * Author: Kevin Hilman, Deep Root Systems, LLC
  *
- * 2007 (c) Deep Root Systems, LLC. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2007 (c) Deep Root Systems, LLC.
  */
 
 #include <linux/clk-provider.h>
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 139b83de011d..772b51e0ac5e 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -1,12 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Header for code common to all DaVinci machines.
  *
  * Author: Kevin Hilman, MontaVista Software, Inc. <source@mvista.com>
  *
- * 2007 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2007 (c) MontaVista Software, Inc.
  */
 
 #ifndef __ARCH_ARM_MACH_DAVINCI_COMMON_H
diff --git a/arch/arm/mach-davinci/include/mach/cputype.h b/arch/arm/mach-davinci/include/mach/cputype.h
index 1fc84e21664d..81de85757a93 100644
--- a/arch/arm/mach-davinci/include/mach/cputype.h
+++ b/arch/arm/mach-davinci/include/mach/cputype.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * DaVinci CPU type detection
  *
@@ -8,10 +9,7 @@
  * compiled in to the kernel, the macros return 0 so that
  * resulting code can be optimized out.
  *
- * 2009 (c) Deep Root Systems, LLC. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2009 (c) Deep Root Systems, LLC.
  */
 #ifndef _ASM_ARCH_CPU_H
 #define _ASM_ARCH_CPU_H
diff --git a/arch/arm/mach-davinci/include/mach/da8xx.h b/arch/arm/mach-davinci/include/mach/da8xx.h
index 1618b30661a9..f138f6d33d4a 100644
--- a/arch/arm/mach-davinci/include/mach/da8xx.h
+++ b/arch/arm/mach-davinci/include/mach/da8xx.h
@@ -1,12 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Chip specific defines for DA8XX/OMAP L1XX SoC
  *
  * Author: Mark A. Greer <mgreer@mvista.com>
  *
- * 2007, 2009-2010 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2007, 2009-2010 (c) MontaVista Software, Inc.
  */
 #ifndef __ASM_ARCH_DAVINCI_DA8XX_H
 #define __ASM_ARCH_DAVINCI_DA8XX_H
diff --git a/arch/arm/mach-davinci/include/mach/hardware.h b/arch/arm/mach-davinci/include/mach/hardware.h
index 16bb42291d39..7848b6a240b4 100644
--- a/arch/arm/mach-davinci/include/mach/hardware.h
+++ b/arch/arm/mach-davinci/include/mach/hardware.h
@@ -1,12 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Hardware definitions common to all DaVinci family processors
  *
  * Author: Kevin Hilman, Deep Root Systems, LLC
  *
- * 2007 (c) Deep Root Systems, LLC. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2007 (c) Deep Root Systems, LLC.
  */
 #ifndef __ASM_ARCH_HARDWARE_H
 #define __ASM_ARCH_HARDWARE_H
diff --git a/arch/arm/mach-davinci/include/mach/serial.h b/arch/arm/mach-davinci/include/mach/serial.h
index d4b4aa87964f..85fda53ffd20 100644
--- a/arch/arm/mach-davinci/include/mach/serial.h
+++ b/arch/arm/mach-davinci/include/mach/serial.h
@@ -1,12 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * DaVinci serial device definitions
  *
  * Author: Kevin Hilman, MontaVista Software, Inc. <source@mvista.com>
  *
- * 2007 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2007 (c) MontaVista Software, Inc.
  */
 #ifndef __ASM_ARCH_SERIAL_H
 #define __ASM_ARCH_SERIAL_H
diff --git a/arch/arm/mach-davinci/mux.c b/arch/arm/mach-davinci/mux.c
index 6a2ff0a654a5..0d8ac2f93661 100644
--- a/arch/arm/mach-davinci/mux.c
+++ b/arch/arm/mach-davinci/mux.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Utility to set the DAVINCI MUX register from a table in mux.h
  *
@@ -8,10 +9,7 @@
  *
  * Written by Tony Lindgren
  *
- * 2007 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2007 (c) MontaVista Software, Inc.
  *
  * Copyright (C) 2008 Texas Instruments.
  */
diff --git a/arch/arm/mach-davinci/mux.h b/arch/arm/mach-davinci/mux.h
index 5aad1e7dd210..558b9c1b32c0 100644
--- a/arch/arm/mach-davinci/mux.h
+++ b/arch/arm/mach-davinci/mux.h
@@ -1,12 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Pin-multiplex helper macros for TI DaVinci family devices
  *
  * Author: Vladimir Barinov, MontaVista Software, Inc. <source@mvista.com>
  *
- * 2007 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2007 (c) MontaVista Software, Inc.
  *
  * Copyright (C) 2008 Texas Instruments.
  */
diff --git a/arch/arm/mach-davinci/pm_domain.c b/arch/arm/mach-davinci/pm_domain.c
index e251fd593bfd..6b21d5bd999c 100644
--- a/arch/arm/mach-davinci/pm_domain.c
+++ b/arch/arm/mach-davinci/pm_domain.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Runtime PM support code for DaVinci
  *
  * Author: Kevin Hilman
  *
  * Copyright (C) 2012 Texas Instruments, Inc.
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/init.h>
 #include <linux/pm_runtime.h>
diff --git a/arch/arm/mach-dove/bridge-regs.h b/arch/arm/mach-dove/bridge-regs.h
index ace0b0bfbf11..6fbc152d0950 100644
--- a/arch/arm/mach-dove/bridge-regs.h
+++ b/arch/arm/mach-dove/bridge-regs.h
@@ -1,10 +1,5 @@
-/*
- * Mbus-L to Mbus Bridge Registers
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Mbus-L to Mbus Bridge Registers */
 
 #ifndef __ASM_ARCH_BRIDGE_REGS_H
 #define __ASM_ARCH_BRIDGE_REGS_H
diff --git a/arch/arm/mach-dove/cm-a510.c b/arch/arm/mach-dove/cm-a510.c
index 9f25c993d863..beb532537c22 100644
--- a/arch/arm/mach-dove/cm-a510.c
+++ b/arch/arm/mach-dove/cm-a510.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-dove/cm-a510.c
  *
@@ -5,10 +6,6 @@
  * Konstantin Sinyuk <kostyas@compulab.co.il>
  *
  * Based on Marvell DB-MV88AP510-BP Development Board Setup
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index dbe970e37895..cd4ae7e4768d 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-dove/common.c
  *
  * Core functions for Marvell Dove 88AP510 System On Chip
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/clk-provider.h>
diff --git a/arch/arm/mach-dove/common.h b/arch/arm/mach-dove/common.h
index 1d725224d146..57ebc413d68c 100644
--- a/arch/arm/mach-dove/common.h
+++ b/arch/arm/mach-dove/common.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * arch/arm/mach-dove/common.h
  *
  * Core functions for Marvell Dove 88AP510 System On Chip
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef __ARCH_DOVE_COMMON_H
diff --git a/arch/arm/mach-dove/dove-db-setup.c b/arch/arm/mach-dove/dove-db-setup.c
index 418ab21b9d9b..d5bf54040577 100644
--- a/arch/arm/mach-dove/dove-db-setup.c
+++ b/arch/arm/mach-dove/dove-db-setup.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-dove/dove-db-setup.c
  *
  * Marvell DB-MV88AP510-BP Development Board Setup
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-dove/dove.h b/arch/arm/mach-dove/dove.h
index 320ed1696abd..e5054e3b0b78 100644
--- a/arch/arm/mach-dove/dove.h
+++ b/arch/arm/mach-dove/dove.h
@@ -1,10 +1,5 @@
-/*
- * Generic definitions for Marvell Dove 88AP510 SoC
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Generic definitions for Marvell Dove 88AP510 SoC */
 
 #ifndef __ASM_ARCH_DOVE_H
 #define __ASM_ARCH_DOVE_H
diff --git a/arch/arm/mach-dove/irq.c b/arch/arm/mach-dove/irq.c
index 31ccbcee2627..0c851a11183d 100644
--- a/arch/arm/mach-dove/irq.c
+++ b/arch/arm/mach-dove/irq.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-dove/irq.c
  *
  * Dove IRQ handling.
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/init.h>
 #include <linux/irq.h>
diff --git a/arch/arm/mach-dove/irqs.h b/arch/arm/mach-dove/irqs.h
index a0742179faff..5467098c7042 100644
--- a/arch/arm/mach-dove/irqs.h
+++ b/arch/arm/mach-dove/irqs.h
@@ -1,10 +1,5 @@
-/*
- * IRQ definitions for Marvell Dove 88AP510 SoC
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* IRQ definitions for Marvell Dove 88AP510 SoC */
 
 #ifndef __ASM_ARCH_IRQS_H
 #define __ASM_ARCH_IRQS_H
diff --git a/arch/arm/mach-dove/mpp.c b/arch/arm/mach-dove/mpp.c
index 6acd8488bb05..93cb137da5f8 100644
--- a/arch/arm/mach-dove/mpp.c
+++ b/arch/arm/mach-dove/mpp.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-dove/mpp.c
  *
  * MPP functions for Marvell Dove SoCs
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-dove/pcie.c b/arch/arm/mach-dove/pcie.c
index ee91ac6b5ebf..cff5c77aa7a6 100644
--- a/arch/arm/mach-dove/pcie.c
+++ b/arch/arm/mach-dove/pcie.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-dove/pcie.c
  *
  * PCIe functions for Marvell Dove 88AP510 SoC
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-dove/pm.h b/arch/arm/mach-dove/pm.h
index 01267746d707..a4c3aba1e2d0 100644
--- a/arch/arm/mach-dove/pm.h
+++ b/arch/arm/mach-dove/pm.h
@@ -1,8 +1,4 @@
-/*
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
+/* SPDX-License-Identifier: GPL-2.0-only */
 
 #ifndef __ASM_ARCH_PM_H
 #define __ASM_ARCH_PM_H
diff --git a/arch/arm/mach-lpc18xx/board-dt.c b/arch/arm/mach-lpc18xx/board-dt.c
index fdcee78d1bc4..4729eb83401a 100644
--- a/arch/arm/mach-lpc18xx/board-dt.c
+++ b/arch/arm/mach-lpc18xx/board-dt.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree board file for NXP LPC18xx/43xx
  *
  * Copyright (C) 2015 Joachim Eastwood <manabian@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <asm/mach/arch.h>
diff --git a/arch/arm/mach-lpc32xx/pm.c b/arch/arm/mach-lpc32xx/pm.c
index b27fa1b9f56c..2572bd89a5e8 100644
--- a/arch/arm/mach-lpc32xx/pm.c
+++ b/arch/arm/mach-lpc32xx/pm.c
@@ -1,13 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-lpc32xx/pm.c
  *
  * Original authors: Vitaly Wool, Dmitry Chigirev <source@mvista.com>
  * Modified by Kevin Wells <kevin.wells@nxp.com>
  *
- * 2005 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2005 (c) MontaVista Software, Inc.
  */
 
 /*
diff --git a/arch/arm/mach-lpc32xx/suspend.S b/arch/arm/mach-lpc32xx/suspend.S
index 3f0a8282ef6f..a95c5e0e4038 100644
--- a/arch/arm/mach-lpc32xx/suspend.S
+++ b/arch/arm/mach-lpc32xx/suspend.S
@@ -1,13 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * arch/arm/mach-lpc32xx/suspend.S
  *
  * Original authors: Dmitry Chigirev, Vitaly Wool <source@mvista.com>
  * Modified by Kevin Wells <kevin.wells@nxp.com>
  *
- * 2005 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2005 (c) MontaVista Software, Inc.
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
diff --git a/arch/arm/mach-mv78xx0/bridge-regs.h b/arch/arm/mach-mv78xx0/bridge-regs.h
index 2f54e1753d45..d57ac967c4b3 100644
--- a/arch/arm/mach-mv78xx0/bridge-regs.h
+++ b/arch/arm/mach-mv78xx0/bridge-regs.h
@@ -1,8 +1,4 @@
-/*
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
+/* SPDX-License-Identifier: GPL-2.0-only */
 
 #ifndef __ASM_ARCH_BRIDGE_REGS_H
 #define __ASM_ARCH_BRIDGE_REGS_H
diff --git a/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c b/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
index e112f2e7cc9a..9aa765d4cdc8 100644
--- a/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
+++ b/arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-mv78xx0/buffalo-wxl-setup.c
  *
  * Buffalo WXL (Terastation Duo) Setup routines
  *
  * sebastien requiem <sebastien@requiem.fr>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-mv78xx0/common.c b/arch/arm/mach-mv78xx0/common.c
index dd762d1b083f..461a68945c26 100644
--- a/arch/arm/mach-mv78xx0/common.c
+++ b/arch/arm/mach-mv78xx0/common.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-mv78xx0/common.c
  *
  * Core functions for Marvell MV78xx0 SoCs
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-mv78xx0/common.h b/arch/arm/mach-mv78xx0/common.h
index 6889af26077d..d8c6c2400e27 100644
--- a/arch/arm/mach-mv78xx0/common.h
+++ b/arch/arm/mach-mv78xx0/common.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * arch/arm/mach-mv78xx0/common.h
  *
  * Core functions for Marvell MV78xx0 SoCs
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef __ARCH_MV78XX0_COMMON_H
diff --git a/arch/arm/mach-mv78xx0/db78x00-bp-setup.c b/arch/arm/mach-mv78xx0/db78x00-bp-setup.c
index cf16e08d4cf5..da633a33a0c1 100644
--- a/arch/arm/mach-mv78xx0/db78x00-bp-setup.c
+++ b/arch/arm/mach-mv78xx0/db78x00-bp-setup.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-mv78xx0/db78x00-bp-setup.c
  *
  * Marvell DB-78x00-BP Development Board Setup
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-mv78xx0/irq.c b/arch/arm/mach-mv78xx0/irq.c
index 788569e960e1..da7a219e2ef5 100644
--- a/arch/arm/mach-mv78xx0/irq.c
+++ b/arch/arm/mach-mv78xx0/irq.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-mv78xx0/irq.c
  *
  * MV78xx0 IRQ handling.
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/gpio.h>
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-mv78xx0/irqs.h b/arch/arm/mach-mv78xx0/irqs.h
index 67e0fe730a13..12b357d383d8 100644
--- a/arch/arm/mach-mv78xx0/irqs.h
+++ b/arch/arm/mach-mv78xx0/irqs.h
@@ -1,10 +1,5 @@
-/*
- * IRQ definitions for Marvell MV78xx0 SoCs
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* IRQ definitions for Marvell MV78xx0 SoCs */
 
 #ifndef __ASM_ARCH_IRQS_H
 #define __ASM_ARCH_IRQS_H
diff --git a/arch/arm/mach-mv78xx0/mpp.c b/arch/arm/mach-mv78xx0/mpp.c
index 72843c02e95a..aff0e612cbba 100644
--- a/arch/arm/mach-mv78xx0/mpp.c
+++ b/arch/arm/mach-mv78xx0/mpp.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-mv78x00/mpp.c
  *
  * MPP functions for Marvell MV78x00 SoCs
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/gpio.h>
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-mv78xx0/mpp.h b/arch/arm/mach-mv78xx0/mpp.h
index 3752302ae2ee..47db52f45546 100644
--- a/arch/arm/mach-mv78xx0/mpp.h
+++ b/arch/arm/mach-mv78xx0/mpp.h
@@ -1,12 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * linux/arch/arm/mach-mv78xx0/mpp.h -- Multi Purpose Pins
  *
- *
  * sebastien requiem <sebastien@requiem.fr>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef __MV78X00_MPP_H
diff --git a/arch/arm/mach-mv78xx0/mv78xx0.h b/arch/arm/mach-mv78xx0/mv78xx0.h
index c1a9a1d1b295..3f19bef7d7ac 100644
--- a/arch/arm/mach-mv78xx0/mv78xx0.h
+++ b/arch/arm/mach-mv78xx0/mv78xx0.h
@@ -1,10 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Generic definitions for Marvell MV78xx0 SoC flavors:
  *  MV781x0 and MV782x0.
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef __ASM_ARCH_MV78XX0_H
diff --git a/arch/arm/mach-mv78xx0/pcie.c b/arch/arm/mach-mv78xx0/pcie.c
index 636d84b40466..c07f1641179b 100644
--- a/arch/arm/mach-mv78xx0/pcie.c
+++ b/arch/arm/mach-mv78xx0/pcie.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-mv78xx0/pcie.c
  *
  * PCIe functions for Marvell MV78xx0 SoCs
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c b/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c
index 308ab71ec822..80ca8b1a81de 100644
--- a/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c
+++ b/arch/arm/mach-mv78xx0/rd78x00-masa-setup.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-mv78x00/rd78x00-masa-setup.c
  *
  * Marvell RD-78x00-mASA Development Board Setup
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-mvebu/armada-370-xp.h b/arch/arm/mach-mvebu/armada-370-xp.h
index 09413b678409..c96ecdafe31f 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.h
+++ b/arch/arm/mach-mvebu/armada-370-xp.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Generic definitions for Marvell Armada_370_XP SoCs
  *
@@ -6,10 +7,6 @@
  * Lior Amsalem <alior@marvell.com>
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef __MACH_ARMADA_370_XP_H
diff --git a/arch/arm/mach-mvebu/board-v7.c b/arch/arm/mach-mvebu/board-v7.c
index d2df5ef9382b..fd5d0c8ff695 100644
--- a/arch/arm/mach-mvebu/board-v7.c
+++ b/arch/arm/mach-mvebu/board-v7.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Device Tree support for Armada 370 and XP platforms.
  *
@@ -6,10 +7,6 @@
  * Lior Amsalem <alior@marvell.com>
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index 49e3c8d20c2f..883dab1b54f3 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Coherency fabric (Aurora) support for Armada 370, 375, 38x and XP
  * platforms.
@@ -8,10 +9,6 @@
  * Gregory Clement <gregory.clement@free-electrons.com>
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
  * The Armada 370, 375, 38x and XP SOCs have a coherency fabric which is
  * responsible for ensuring hardware coherency between all CPUs and between
  * CPUs and I/O masters. This file initializes the coherency fabric and
diff --git a/arch/arm/mach-mvebu/coherency.h b/arch/arm/mach-mvebu/coherency.h
index 6067f14263f7..cae866ab4867 100644
--- a/arch/arm/mach-mvebu/coherency.h
+++ b/arch/arm/mach-mvebu/coherency.h
@@ -1,14 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * arch/arm/mach-mvebu/include/mach/coherency.h
  *
- *
  * Coherency fabric (Aurora) support for Armada 370 and XP platforms.
  *
  * Copyright (C) 2012 Marvell
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef __MACH_370_XP_COHERENCY_H
diff --git a/arch/arm/mach-mvebu/coherency_ll.S b/arch/arm/mach-mvebu/coherency_ll.S
index a3a64bf97250..eb81656e32d4 100644
--- a/arch/arm/mach-mvebu/coherency_ll.S
+++ b/arch/arm/mach-mvebu/coherency_ll.S
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Coherency fabric: low level functions
  *
@@ -5,10 +6,6 @@
  *
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
  * This file implements the assembly function to add a CPU to the
  * coherency fabric. This function is called by each of the secondary
  * CPUs during their early boot in an SMP kernel, this why this
diff --git a/arch/arm/mach-mvebu/common.h b/arch/arm/mach-mvebu/common.h
index 6b775492cfad..fbfa3c4f30df 100644
--- a/arch/arm/mach-mvebu/common.h
+++ b/arch/arm/mach-mvebu/common.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Core functions for Marvell System On Chip
  *
@@ -6,10 +7,6 @@
  * Lior Amsalem <alior@marvell.com>
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef __ARCH_MVEBU_COMMON_H
diff --git a/arch/arm/mach-mvebu/cpu-reset.c b/arch/arm/mach-mvebu/cpu-reset.c
index f33a31c6aff8..66b6c0c6ce1d 100644
--- a/arch/arm/mach-mvebu/cpu-reset.c
+++ b/arch/arm/mach-mvebu/cpu-reset.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (C) 2014 Marvell
  *
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #define pr_fmt(fmt) "mvebu-cpureset: " fmt
diff --git a/arch/arm/mach-mvebu/dove.c b/arch/arm/mach-mvebu/dove.c
index d076c5771adc..c938ba725d3e 100644
--- a/arch/arm/mach-mvebu/dove.c
+++ b/arch/arm/mach-mvebu/dove.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-mvebu/dove.c
  *
  * Marvell Dove 88AP510 System On Chip FDT Board
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/init.h>
diff --git a/arch/arm/mach-mvebu/headsmp-a9.S b/arch/arm/mach-mvebu/headsmp-a9.S
index b093a196e801..df723cf85cae 100644
--- a/arch/arm/mach-mvebu/headsmp-a9.S
+++ b/arch/arm/mach-mvebu/headsmp-a9.S
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * SMP support: Entry point for secondary CPUs of Marvell EBU
  * Cortex-A9 based SOCs (Armada 375 and Armada 38x).
@@ -6,10 +7,6 @@
  *
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/linkage.h>
diff --git a/arch/arm/mach-mvebu/headsmp.S b/arch/arm/mach-mvebu/headsmp.S
index 2c4032e368ba..f05c59dad32a 100644
--- a/arch/arm/mach-mvebu/headsmp.S
+++ b/arch/arm/mach-mvebu/headsmp.S
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * SMP support: Entry point for secondary CPUs
  *
@@ -7,10 +8,6 @@
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
  * This file implements the assembly entry point for secondary CPUs in
  * an SMP kernel. The only thing we need to do is to add the CPU to
  * the coherency fabric by writing to 2 registers. Currently the base
diff --git a/arch/arm/mach-mvebu/kirkwood.c b/arch/arm/mach-mvebu/kirkwood.c
index 06b1706595f4..8ff34753e760 100644
--- a/arch/arm/mach-mvebu/kirkwood.c
+++ b/arch/arm/mach-mvebu/kirkwood.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright 2012 (C), Jason Cooper <jason@lakedaemon.net>
  *
  * arch/arm/mach-mvebu/kirkwood.c
  *
  * Flattened Device Tree board initialization
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/clk.h>
diff --git a/arch/arm/mach-mvebu/kirkwood.h b/arch/arm/mach-mvebu/kirkwood.h
index 89f3d1f51643..15135994ce2f 100644
--- a/arch/arm/mach-mvebu/kirkwood.h
+++ b/arch/arm/mach-mvebu/kirkwood.h
@@ -1,12 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * arch/arm/mach-mvebu/kirkwood.h
  *
  * Generic definitions for Marvell Kirkwood SoC flavors:
  * 88F6180, 88F6192 and 88F6281.
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #define KIRKWOOD_REGS_PHYS_BASE	0xf1000000
diff --git a/arch/arm/mach-mvebu/mvebu-soc-id.c b/arch/arm/mach-mvebu/mvebu-soc-id.c
index a99434bcee84..f436c7b8c7ae 100644
--- a/arch/arm/mach-mvebu/mvebu-soc-id.c
+++ b/arch/arm/mach-mvebu/mvebu-soc-id.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * ID and revision information for mvebu SoCs
  *
@@ -5,10 +6,6 @@
  *
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
  * All the mvebu SoCs have information related to their variant and
  * revision that can be read from the PCI control register. This is
  * done before the PCI initialization to avoid any conflict. Once the
diff --git a/arch/arm/mach-mvebu/mvebu-soc-id.h b/arch/arm/mach-mvebu/mvebu-soc-id.h
index e124a0b82a3e..225649b2288a 100644
--- a/arch/arm/mach-mvebu/mvebu-soc-id.h
+++ b/arch/arm/mach-mvebu/mvebu-soc-id.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Marvell EBU SoC ID and revision definitions.
  *
  * Copyright (C) 2014 Marvell Semiconductor
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef __LINUX_MVEBU_SOC_ID_H
diff --git a/arch/arm/mach-mvebu/platsmp-a9.c b/arch/arm/mach-mvebu/platsmp-a9.c
index d715dec1c197..785ee2af5baa 100644
--- a/arch/arm/mach-mvebu/platsmp-a9.c
+++ b/arch/arm/mach-mvebu/platsmp-a9.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Symmetric Multi Processing (SMP) support for Marvell EBU Cortex-A9
  * based SOCs (Armada 375/38x).
@@ -6,10 +7,6 @@
  *
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/init.h>
diff --git a/arch/arm/mach-mvebu/platsmp.c b/arch/arm/mach-mvebu/platsmp.c
index c130497dc6cc..18384ea6862c 100644
--- a/arch/arm/mach-mvebu/platsmp.c
+++ b/arch/arm/mach-mvebu/platsmp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Symmetric Multi Processing (SMP) support for Armada XP
  *
@@ -8,10 +9,6 @@
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
  * The Armada XP SoC has 4 ARMv7 PJ4B CPUs running in full HW coherency
  * This file implements the routines for preparing the SMP infrastructure
  * and waking up the secondary CPUs
diff --git a/arch/arm/mach-mvebu/pm-board.c b/arch/arm/mach-mvebu/pm-board.c
index 070552511699..7fa1806acd65 100644
--- a/arch/arm/mach-mvebu/pm-board.c
+++ b/arch/arm/mach-mvebu/pm-board.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Board-level suspend/resume support.
  *
  * Copyright (C) 2014-2015 Marvell
  *
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/delay.h>
diff --git a/arch/arm/mach-mvebu/pm.c b/arch/arm/mach-mvebu/pm.c
index c487be61d6d8..b149d9b77505 100644
--- a/arch/arm/mach-mvebu/pm.c
+++ b/arch/arm/mach-mvebu/pm.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Suspend/resume support. Currently supporting Armada XP only.
  *
  * Copyright (C) 2014 Marvell
  *
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/cpu_pm.h>
diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 73d5d72dfc3e..af27a7156675 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Power Management Service Unit(PMSU) support for Armada 370/XP platforms.
  *
@@ -7,10 +8,6 @@
  * Gregory Clement <gregory.clement@free-electrons.com>
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
  * The Armada 370 and Armada XP SOCs have a power management service
  * unit which is responsible for powering down and waking up CPUs and
  * other SOC units
diff --git a/arch/arm/mach-mvebu/pmsu.h b/arch/arm/mach-mvebu/pmsu.h
index ea79269c2702..1e847388e8dd 100644
--- a/arch/arm/mach-mvebu/pmsu.h
+++ b/arch/arm/mach-mvebu/pmsu.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Power Management Service Unit (PMSU) support for Armada 370/XP platforms.
  *
  * Copyright (C) 2012 Marvell
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef __MACH_MVEBU_PMSU_H
diff --git a/arch/arm/mach-mvebu/pmsu_ll.S b/arch/arm/mach-mvebu/pmsu_ll.S
index 7aae9a25cfeb..f7d21385fd88 100644
--- a/arch/arm/mach-mvebu/pmsu_ll.S
+++ b/arch/arm/mach-mvebu/pmsu_ll.S
@@ -1,12 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Copyright (C) 2014 Marvell
  *
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
  * Gregory Clement <gregory.clement@free-electrons.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/linkage.h>
diff --git a/arch/arm/mach-mvebu/system-controller.c b/arch/arm/mach-mvebu/system-controller.c
index 04d9ebe6a90a..48224b6ed6dc 100644
--- a/arch/arm/mach-mvebu/system-controller.c
+++ b/arch/arm/mach-mvebu/system-controller.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * System controller support for Armada 370, 375 and XP platforms.
  *
@@ -7,10 +8,6 @@
  * Gregory CLEMENT <gregory.clement@free-electrons.com>
  * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
  * The Armada 370, 375 and Armada XP SoCs have a range of
  * miscellaneous registers, that do not belong to a particular device,
  * but rather provide system-level features. This basic
diff --git a/arch/arm/mach-omap1/include/mach/mtd-xip.h b/arch/arm/mach-omap1/include/mach/mtd-xip.h
index d09b2bc4920f..b163b8a65605 100644
--- a/arch/arm/mach-omap1/include/mach/mtd-xip.h
+++ b/arch/arm/mach-omap1/include/mach/mtd-xip.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * MTD primitives for XIP support. Architecture specific functions.
  *
@@ -5,10 +6,7 @@
  *
  * Author: Vladimir Barinov <vbarinov@embeddedalley.com>
  *
- * (c) 2005 MontaVista Software, Inc.  This file is licensed under the
- * terms of the GNU General Public License version 2.  This program is
- * licensed "as is" without any warranty of any kind, whether express or
- * implied.
+ * (c) 2005 MontaVista Software, Inc.
  */
 
 #ifndef __ARCH_OMAP_MTD_XIP_H__
diff --git a/arch/arm/mach-omap1/pm_bus.c b/arch/arm/mach-omap1/pm_bus.c
index 667c1637ff91..c04619ac0631 100644
--- a/arch/arm/mach-omap1/pm_bus.c
+++ b/arch/arm/mach-omap1/pm_bus.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Runtime PM support code for OMAP1
  *
  * Author: Kevin Hilman, Deep Root Systems, LLC
  *
  * Copyright (C) 2010 Texas Instruments, Inc.
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -43,4 +40,3 @@ static int __init omap1_pm_runtime_init(void)
 	return 0;
 }
 core_initcall(omap1_pm_runtime_init);
-
diff --git a/arch/arm/mach-omap2/prcm43xx.h b/arch/arm/mach-omap2/prcm43xx.h
index 899da0ae9800..31860ffd28ab 100644
--- a/arch/arm/mach-omap2/prcm43xx.h
+++ b/arch/arm/mach-omap2/prcm43xx.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * AM43x PRCM defines
  *
  * Copyright (C) 2013 Texas Instruments Incorporated - https://www.ti.com/
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #ifndef __ARCH_ARM_MACH_OMAP2_PRCM_43XX_H
diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 86f1ac4c2412..ea02d40405c4 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * OMAP Voltage Controller (VC) interface
  *
  * Copyright (C) 2011 Texas Instruments, Inc.
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/kernel.h>
 #include <linux/delay.h>
@@ -895,4 +892,3 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	else if (cpu_is_omap44xx())
 		omap4_vc_init_channel(voltdm);
 }
-
diff --git a/arch/arm/mach-orion5x/board-d2net.c b/arch/arm/mach-orion5x/board-d2net.c
index a89376a5cd92..0297e302d7bc 100644
--- a/arch/arm/mach-orion5x/board-d2net.c
+++ b/arch/arm/mach-orion5x/board-d2net.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-orion5x/board-d2net.c
  *
  * LaCie d2Network and Big Disk Network NAS setup
  *
  * Copyright (C) 2009 Simon Guinot <sguinot@lacie.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-orion5x/board-dt.c b/arch/arm/mach-orion5x/board-dt.c
index 3f651df3a71c..be47492c6640 100644
--- a/arch/arm/mach-orion5x/board-dt.c
+++ b/arch/arm/mach-orion5x/board-dt.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright 2012 (C), Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
  *
  * arch/arm/mach-orion5x/board-dt.c
  *
  * Flattened Device Tree board initialization
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-orion5x/board-rd88f5182.c b/arch/arm/mach-orion5x/board-rd88f5182.c
index b7b0f52f4c0a..596601367989 100644
--- a/arch/arm/mach-orion5x/board-rd88f5182.c
+++ b/arch/arm/mach-orion5x/board-rd88f5182.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-orion5x/rd88f5182-setup.c
  *
  * Marvell Orion-NAS Reference Design Setup
  *
  * Maintainer: Ronen Shitrit <rshitrit@marvell.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/gpio.h>
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-orion5x/bridge-regs.h b/arch/arm/mach-orion5x/bridge-regs.h
index 305598eaaee1..fe85bc5b131f 100644
--- a/arch/arm/mach-orion5x/bridge-regs.h
+++ b/arch/arm/mach-orion5x/bridge-regs.h
@@ -1,10 +1,5 @@
-/*
- * Orion CPU Bridge Registers
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Orion CPU Bridge Registers */
 
 #ifndef __ASM_ARCH_BRIDGE_REGS_H
 #define __ASM_ARCH_BRIDGE_REGS_H
diff --git a/arch/arm/mach-orion5x/common.c b/arch/arm/mach-orion5x/common.c
index 7bcb41137bbf..2e711b7252c6 100644
--- a/arch/arm/mach-orion5x/common.c
+++ b/arch/arm/mach-orion5x/common.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-orion5x/common.c
  *
  * Core functions for Marvell Orion 5x SoCs
  *
  * Maintainer: Tzachi Perelstein <tzachi@marvell.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-orion5x/db88f5281-setup.c b/arch/arm/mach-orion5x/db88f5281-setup.c
index 39eae10ac8de..fe1a4cef1ba2 100644
--- a/arch/arm/mach-orion5x/db88f5281-setup.c
+++ b/arch/arm/mach-orion5x/db88f5281-setup.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-orion5x/db88f5281-setup.c
  *
  * Marvell Orion-2 Development Board Setup
  *
  * Maintainer: Tzachi Perelstein <tzachi@marvell.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/gpio.h>
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-orion5x/irq.c b/arch/arm/mach-orion5x/irq.c
index ac4af2283bef..5b076eefe2b4 100644
--- a/arch/arm/mach-orion5x/irq.c
+++ b/arch/arm/mach-orion5x/irq.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-orion5x/irq.c
  *
  * Core IRQ functions for Marvell Orion System On Chip
  *
  * Maintainer: Tzachi Perelstein <tzachi@marvell.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/gpio.h>
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-orion5x/irqs.h b/arch/arm/mach-orion5x/irqs.h
index 506c8e0b30c4..a70c47cfa6bc 100644
--- a/arch/arm/mach-orion5x/irqs.h
+++ b/arch/arm/mach-orion5x/irqs.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * IRQ definitions for Orion SoC
  *
  *  Maintainer: Tzachi Perelstein <tzachi@marvell.com>
- *
- *  This file is licensed under the terms of the GNU General Public
- *  License version 2. This program is licensed "as is" without any
- *  warranty of any kind, whether express or implied.
  */
 
 #ifndef __ASM_ARCH_IRQS_H
diff --git a/arch/arm/mach-orion5x/kurobox_pro-setup.c b/arch/arm/mach-orion5x/kurobox_pro-setup.c
index 83d43cff4bd7..acba06618080 100644
--- a/arch/arm/mach-orion5x/kurobox_pro-setup.c
+++ b/arch/arm/mach-orion5x/kurobox_pro-setup.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-orion5x/kurobox_pro-setup.c
  *
  * Maintainer: Ronen Shitrit <rshitrit@marvell.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/gpio.h>
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-orion5x/ls_hgl-setup.c b/arch/arm/mach-orion5x/ls_hgl-setup.c
index 47ba6e0502f5..af07f617465f 100644
--- a/arch/arm/mach-orion5x/ls_hgl-setup.c
+++ b/arch/arm/mach-orion5x/ls_hgl-setup.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-orion5x/ls_hgl-setup.c
  *
  * Maintainer: Zhu Qingsen <zhuqs@cn.fujitsu.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-orion5x/mpp.c b/arch/arm/mach-orion5x/mpp.c
index 19ef18594415..b9855dce6ba0 100644
--- a/arch/arm/mach-orion5x/mpp.c
+++ b/arch/arm/mach-orion5x/mpp.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-orion5x/mpp.c
  *
  * MPP functions for Marvell Orion 5x SoCs
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-orion5x/net2big-setup.c b/arch/arm/mach-orion5x/net2big-setup.c
index bf6be4cfd238..695cc683cd83 100644
--- a/arch/arm/mach-orion5x/net2big-setup.c
+++ b/arch/arm/mach-orion5x/net2big-setup.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-orion5x/net2big-setup.c
  *
  * LaCie 2Big Network NAS setup
  *
  * Copyright (C) 2009 Simon Guinot <sguinot@lacie.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
@@ -432,4 +429,3 @@ MACHINE_START(NET2BIG, "LaCie 2Big Network")
 	.fixup		= tag_fixup_mem32,
 	.restart	= orion5x_restart,
 MACHINE_END
-
diff --git a/arch/arm/mach-orion5x/orion5x.h b/arch/arm/mach-orion5x/orion5x.h
index 2b66120fba86..26f1ccb8cb28 100644
--- a/arch/arm/mach-orion5x/orion5x.h
+++ b/arch/arm/mach-orion5x/orion5x.h
@@ -1,12 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * Generic definitions of Orion SoC flavors:
  *  Orion-1, Orion-VoIP, Orion-NAS, Orion-2, and Orion-1-90.
  *
  * Maintainer: Tzachi Perelstein <tzachi@marvell.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef __ASM_ARCH_ORION5X_H
diff --git a/arch/arm/mach-orion5x/pci.c b/arch/arm/mach-orion5x/pci.c
index 76951bfbacf5..fa62add8cf8a 100644
--- a/arch/arm/mach-orion5x/pci.c
+++ b/arch/arm/mach-orion5x/pci.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-orion5x/pci.c
  *
  * PCI and PCIe functions for Marvell Orion System On Chip
  *
  * Maintainer: Tzachi Perelstein <tzachi@marvell.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
index c65ab7db36ad..432fc8357d9e 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c
  *
  * Marvell Orion-VoIP FXO Reference Design Setup
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/gpio.h>
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
index 76b8138d9d79..d4b1a9c3cd36 100644
--- a/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-orion5x/rd88f5181l-ge-setup.c
  *
  * Marvell Orion-VoIP GE Reference Design Setup
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/gpio.h>
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-orion5x/rd88f5182-setup.c b/arch/arm/mach-orion5x/rd88f5182-setup.c
index fe3e67c81fb8..6ffcfc6445e2 100644
--- a/arch/arm/mach-orion5x/rd88f5182-setup.c
+++ b/arch/arm/mach-orion5x/rd88f5182-setup.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-orion5x/rd88f5182-setup.c
  *
  * Marvell Orion-NAS Reference Design Setup
  *
  * Maintainer: Ronen Shitrit <rshitrit@marvell.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/gpio.h>
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
index 5f388a1ed1e4..93f74fd6b4da 100644
--- a/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
+++ b/arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-orion5x/rd88f6183-ap-ge-setup.c
  *
  * Marvell Orion-1-90 AP GE Reference Design Setup
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/gpio.h>
 #include <linux/kernel.h>
diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
index a39764faf2a0..af810e7ccd79 100644
--- a/arch/arm/mach-orion5x/ts78xx-setup.c
+++ b/arch/arm/mach-orion5x/ts78xx-setup.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-orion5x/ts78xx-setup.c
  *
  * Maintainer: Alexander Clouter <alex@digriz.org.uk>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/arch/arm/mach-orion5x/wnr854t-setup.c b/arch/arm/mach-orion5x/wnr854t-setup.c
index 83589a28a491..e5f327054dd3 100644
--- a/arch/arm/mach-orion5x/wnr854t-setup.c
+++ b/arch/arm/mach-orion5x/wnr854t-setup.c
@@ -1,10 +1,5 @@
-/*
- * arch/arm/mach-orion5x/wnr854t-setup.c
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0-only
+// arch/arm/mach-orion5x/wnr854t-setup.c
 #include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/arch/arm/mach-orion5x/wrt350n-v2-setup.c b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
index cea08d4a2597..e6a2da6662df 100644
--- a/arch/arm/mach-orion5x/wrt350n-v2-setup.c
+++ b/arch/arm/mach-orion5x/wrt350n-v2-setup.c
@@ -1,10 +1,5 @@
-/*
- * arch/arm/mach-orion5x/wrt350n-v2-setup.c
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
+// SPDX-License-Identifier: GPL-2.0-only
+// arch/arm/mach-orion5x/wrt350n-v2-setup.c
 #include <linux/gpio.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/arch/arm/mach-pxa/eseries.c b/arch/arm/mach-pxa/eseries.c
index f37c44b6139d..b9e235cb5a07 100644
--- a/arch/arm/mach-pxa/eseries.c
+++ b/arch/arm/mach-pxa/eseries.c
@@ -1,13 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Hardware definitions for the Toshiba eseries PDAs
  *
  * Copyright (c) 2003 Ian Molton <spyro@f2s.com>
- *
- * This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
  */
 
 #include <linux/clkdev.h>
diff --git a/arch/arm/mach-pxa/standby.S b/arch/arm/mach-pxa/standby.S
index eab1645bb4ad..60d0d14d4a0f 100644
--- a/arch/arm/mach-pxa/standby.S
+++ b/arch/arm/mach-pxa/standby.S
@@ -1,12 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * PXA27x standby mode
  *
  * Author: David Burrage
  *
- * 2005 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2005 (c) MontaVista Software, Inc.
  */
 
 #include <linux/linkage.h>
diff --git a/arch/arm/mach-spear/generic.h b/arch/arm/mach-spear/generic.h
index 8ec2b92dca19..43b7996ab754 100644
--- a/arch/arm/mach-spear/generic.h
+++ b/arch/arm/mach-spear/generic.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * spear machine family generic header file
  *
  * Copyright (C) 2009-2012 ST Microelectronics
  * Rajeev Kumar <rajeev-dlh.kumar@st.com>
  * Viresh Kumar <vireshk@kernel.org>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef __MACH_GENERIC_H
diff --git a/arch/arm/mach-spear/include/mach/misc_regs.h b/arch/arm/mach-spear/include/mach/misc_regs.h
index cfaf7c665b58..12a789bd896e 100644
--- a/arch/arm/mach-spear/include/mach/misc_regs.h
+++ b/arch/arm/mach-spear/include/mach/misc_regs.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * arch/arm/mach-spear3xx/include/mach/misc_regs.h
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2009 ST Microelectronics
  * Viresh Kumar <vireshk@kernel.org>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef __MACH_MISC_REGS_H
diff --git a/arch/arm/mach-spear/include/mach/spear.h b/arch/arm/mach-spear/include/mach/spear.h
index 5ed841ccf8a3..432efd407c76 100644
--- a/arch/arm/mach-spear/include/mach/spear.h
+++ b/arch/arm/mach-spear/include/mach/spear.h
@@ -1,13 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * SPEAr3xx/6xx Machine family specific definition
  *
  * Copyright (C) 2009,2012 ST Microelectronics
  * Rajeev Kumar<rajeev-dlh.kumar@st.com>
  * Viresh Kumar <vireshk@kernel.org>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef __MACH_SPEAR_H
diff --git a/arch/arm/mach-spear/pl080.c b/arch/arm/mach-spear/pl080.c
index b4529f3e0ee9..35c929de4675 100644
--- a/arch/arm/mach-spear/pl080.c
+++ b/arch/arm/mach-spear/pl080.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/plat-spear/pl080.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2012 ST Microelectronics
  * Viresh Kumar <vireshk@kernel.org>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/amba/pl08x.h>
diff --git a/arch/arm/mach-spear/pl080.h b/arch/arm/mach-spear/pl080.h
index 608dec6725ae..3732d940dbfb 100644
--- a/arch/arm/mach-spear/pl080.h
+++ b/arch/arm/mach-spear/pl080.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
  * arch/arm/plat-spear/include/plat/pl080.h
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2012 ST Microelectronics
  * Viresh Kumar <vireshk@kernel.org>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #ifndef __PLAT_PL080_H
diff --git a/arch/arm/mach-spear/restart.c b/arch/arm/mach-spear/restart.c
index b4342155a783..01f529675629 100644
--- a/arch/arm/mach-spear/restart.c
+++ b/arch/arm/mach-spear/restart.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/plat-spear/restart.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2009 ST Microelectronics
  * Viresh Kumar <vireshk@kernel.org>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 #include <linux/io.h>
 #include <linux/amba/sp810.h>
diff --git a/arch/arm/mach-spear/spear1310.c b/arch/arm/mach-spear/spear1310.c
index a7d4f136836f..020b27e65aea 100644
--- a/arch/arm/mach-spear/spear1310.c
+++ b/arch/arm/mach-spear/spear1310.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-spear13xx/spear1310.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2012 ST Microelectronics
  * Viresh Kumar <vireshk@kernel.org>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #define pr_fmt(fmt) "SPEAr1310: " fmt
diff --git a/arch/arm/mach-spear/spear1340.c b/arch/arm/mach-spear/spear1340.c
index a212af90c0bc..a391f154eff9 100644
--- a/arch/arm/mach-spear/spear1340.c
+++ b/arch/arm/mach-spear/spear1340.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-spear13xx/spear1340.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2012 ST Microelectronics
  * Viresh Kumar <vireshk@kernel.org>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #define pr_fmt(fmt) "SPEAr1340: " fmt
diff --git a/arch/arm/mach-spear/spear13xx.c b/arch/arm/mach-spear/spear13xx.c
index 74d1ca2a529a..64087046dfff 100644
--- a/arch/arm/mach-spear/spear13xx.c
+++ b/arch/arm/mach-spear/spear13xx.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-spear13xx/spear13xx.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2012 ST Microelectronics
  * Viresh Kumar <vireshk@kernel.org>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #define pr_fmt(fmt) "SPEAr13xx: " fmt
diff --git a/arch/arm/mach-spear/spear300.c b/arch/arm/mach-spear/spear300.c
index 325b89579be1..490df8aaad90 100644
--- a/arch/arm/mach-spear/spear300.c
+++ b/arch/arm/mach-spear/spear300.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-spear3xx/spear300.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2009-2012 ST Microelectronics
  * Viresh Kumar <vireshk@kernel.org>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #define pr_fmt(fmt) "SPEAr300: " fmt
diff --git a/arch/arm/mach-spear/spear310.c b/arch/arm/mach-spear/spear310.c
index 59e173dc85cf..5ca325fc1b82 100644
--- a/arch/arm/mach-spear/spear310.c
+++ b/arch/arm/mach-spear/spear310.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-spear3xx/spear310.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2009-2012 ST Microelectronics
  * Viresh Kumar <vireshk@kernel.org>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #define pr_fmt(fmt) "SPEAr310: " fmt
diff --git a/arch/arm/mach-spear/spear320.c b/arch/arm/mach-spear/spear320.c
index 926d5a243238..991de88dfe4d 100644
--- a/arch/arm/mach-spear/spear320.c
+++ b/arch/arm/mach-spear/spear320.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-spear3xx/spear320.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2009-2012 ST Microelectronics
  * Viresh Kumar <vireshk@kernel.org>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #define pr_fmt(fmt) "SPEAr320: " fmt
diff --git a/arch/arm/mach-spear/spear3xx.c b/arch/arm/mach-spear/spear3xx.c
index f83321d5e353..cdaa41900a39 100644
--- a/arch/arm/mach-spear/spear3xx.c
+++ b/arch/arm/mach-spear/spear3xx.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-spear3xx/spear3xx.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2009-2012 ST Microelectronics
  * Viresh Kumar <vireshk@kernel.org>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #define pr_fmt(fmt) "SPEAr3xx: " fmt
diff --git a/arch/arm/mach-spear/spear6xx.c b/arch/arm/mach-spear/spear6xx.c
index c5fc110134ba..11eb64a36980 100644
--- a/arch/arm/mach-spear/spear6xx.c
+++ b/arch/arm/mach-spear/spear6xx.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mach-spear6xx/spear6xx.c
  *
@@ -7,10 +8,6 @@
  * Rajeev Kumar<rajeev-dlh.kumar@st.com>
  *
  * Copyright 2012 Stefan Roese <sr@denx.de>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/amba/pl08x.h>
diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
index d1fdb6066f7b..6baf952fa902 100644
--- a/arch/arm/mach-spear/time.c
+++ b/arch/arm/mach-spear/time.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/plat-spear/time.c
  *
  * Copyright (C) 2010 ST Microelectronics
  * Shiraz Hashim<shiraz.linux.kernel@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/clk.h>
diff --git a/arch/arm/mm/cache-feroceon-l2.c b/arch/arm/mm/cache-feroceon-l2.c
index 5c1b7a7b9af6..25dbd84a1aaf 100644
--- a/arch/arm/mm/cache-feroceon-l2.c
+++ b/arch/arm/mm/cache-feroceon-l2.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mm/cache-feroceon-l2.c - Feroceon L2 cache controller support
  *
  * Copyright (C) 2008 Marvell Semiconductor
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
  * References:
  * - Unified Layer 2 Cache for Feroceon CPU Cores,
  *   Document ID MV-S104858-00, Rev. A, October 23 2007.
diff --git a/arch/arm/mm/cache-tauros2.c b/arch/arm/mm/cache-tauros2.c
index 88255bea65e4..b1e1aba602f7 100644
--- a/arch/arm/mm/cache-tauros2.c
+++ b/arch/arm/mm/cache-tauros2.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * arch/arm/mm/cache-tauros2.c - Tauros2 L2 cache controller support
  *
  * Copyright (C) 2008 Marvell Semiconductor
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
  * References:
  * - PJ1 CPU Core Datasheet,
  *   Document ID MV-S104837-01, Rev 0.7, January 24 2008.
diff --git a/arch/mips/alchemy/devboards/db1000.c b/arch/mips/alchemy/devboards/db1000.c
index 50de86eb8784..3183df60ad33 100644
--- a/arch/mips/alchemy/devboards/db1000.c
+++ b/arch/mips/alchemy/devboards/db1000.c
@@ -164,6 +164,7 @@ static struct platform_device db1x00_audio_dev = {
 
 /******************************************************************************/
 
+#ifdef CONFIG_MMC_AU1X
 static irqreturn_t db1100_mmc_cd(int irq, void *ptr)
 {
 	mmc_detect_change(ptr, msecs_to_jiffies(500));
@@ -369,6 +370,7 @@ static struct platform_device db1100_mmc1_dev = {
 	.num_resources	= ARRAY_SIZE(au1100_mmc1_res),
 	.resource	= au1100_mmc1_res,
 };
+#endif /* CONFIG_MMC_AU1X */
 
 /******************************************************************************/
 
@@ -432,8 +434,10 @@ static struct platform_device *db1x00_devs[] = {
 
 static struct platform_device *db1100_devs[] = {
 	&au1100_lcd_device,
+#ifdef CONFIG_MMC_AU1X
 	&db1100_mmc0_dev,
 	&db1100_mmc1_dev,
+#endif
 };
 
 int __init db1000_dev_setup(void)
diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
index 76080c71a2a7..f521874ebb07 100644
--- a/arch/mips/alchemy/devboards/db1200.c
+++ b/arch/mips/alchemy/devboards/db1200.c
@@ -326,6 +326,7 @@ static struct platform_device db1200_ide_dev = {
 
 /**********************************************************************/
 
+#ifdef CONFIG_MMC_AU1X
 /* SD carddetects:  they're supposed to be edge-triggered, but ack
  * doesn't seem to work (CPLD Rev 2).  Instead, the screaming one
  * is disabled and its counterpart enabled.  The 200ms timeout is
@@ -584,6 +585,7 @@ static struct platform_device pb1200_mmc1_dev = {
 	.num_resources	= ARRAY_SIZE(au1200_mmc1_res),
 	.resource	= au1200_mmc1_res,
 };
+#endif /* CONFIG_MMC_AU1X */
 
 /**********************************************************************/
 
@@ -751,7 +753,9 @@ static struct platform_device db1200_audiodma_dev = {
 static struct platform_device *db1200_devs[] __initdata = {
 	NULL,		/* PSC0, selected by S6.8 */
 	&db1200_ide_dev,
+#ifdef CONFIG_MMC_AU1X
 	&db1200_mmc0_dev,
+#endif
 	&au1200_lcd_dev,
 	&db1200_eth_dev,
 	&db1200_nand_dev,
@@ -762,7 +766,9 @@ static struct platform_device *db1200_devs[] __initdata = {
 };
 
 static struct platform_device *pb1200_devs[] __initdata = {
+#ifdef CONFIG_MMC_AU1X
 	&pb1200_mmc1_dev,
+#endif
 };
 
 /* Some peripheral base addresses differ on the PB1200 */
diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
index ca71e5ed51ab..c965d0007481 100644
--- a/arch/mips/alchemy/devboards/db1300.c
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -450,6 +450,7 @@ static struct platform_device db1300_ide_dev = {
 
 /**********************************************************************/
 
+#ifdef CONFIG_MMC_AU1X
 static irqreturn_t db1300_mmc_cd(int irq, void *ptr)
 {
 	disable_irq_nosync(irq);
@@ -632,6 +633,7 @@ static struct platform_device db1300_sd0_dev = {
 	.resource	= au1300_sd0_res,
 	.num_resources	= ARRAY_SIZE(au1300_sd0_res),
 };
+#endif /* CONFIG_MMC_AU1X */
 
 /**********************************************************************/
 
@@ -776,8 +778,10 @@ static struct platform_device *db1300_dev[] __initdata = {
 	&db1300_5waysw_dev,
 	&db1300_nand_dev,
 	&db1300_ide_dev,
+#ifdef CONFIG_MMC_AU1X
 	&db1300_sd0_dev,
 	&db1300_sd1_dev,
+#endif
 	&db1300_lcd_dev,
 	&db1300_ac97_dev,
 	&db1300_i2s_dev,
diff --git a/arch/parisc/include/asm/ropes.h b/arch/parisc/include/asm/ropes.h
index 8e51c775c80a..62399c7ea94a 100644
--- a/arch/parisc/include/asm/ropes.h
+++ b/arch/parisc/include/asm/ropes.h
@@ -86,6 +86,9 @@ struct sba_device {
 	struct ioc		ioc[MAX_IOC];
 };
 
+/* list of SBA's in system, see drivers/parisc/sba_iommu.c */
+extern struct sba_device *sba_list;
+
 #define ASTRO_RUNWAY_PORT	0x582
 #define IKE_MERCED_PORT		0x803
 #define REO_MERCED_PORT		0x804
diff --git a/arch/parisc/kernel/drivers.c b/arch/parisc/kernel/drivers.c
index e7ee0c0c91d3..8f12b9f318ae 100644
--- a/arch/parisc/kernel/drivers.c
+++ b/arch/parisc/kernel/drivers.c
@@ -924,9 +924,9 @@ static __init void qemu_header(void)
 	pr_info("#define PARISC_MODEL \"%s\"\n\n",
 			boot_cpu_data.pdc.sys_model_name);
 
+	#define p ((unsigned long *)&boot_cpu_data.pdc.model)
 	pr_info("#define PARISC_PDC_MODEL 0x%lx, 0x%lx, 0x%lx, "
 		"0x%lx, 0x%lx, 0x%lx, 0x%lx, 0x%lx, 0x%lx\n\n",
-	#define p ((unsigned long *)&boot_cpu_data.pdc.model)
 		p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7], p[8]);
 	#undef p
 
diff --git a/arch/parisc/kernel/irq.c b/arch/parisc/kernel/irq.c
index e6cc38ef6945..5d9044e65a1a 100644
--- a/arch/parisc/kernel/irq.c
+++ b/arch/parisc/kernel/irq.c
@@ -386,7 +386,7 @@ union irq_stack_union {
 	volatile unsigned int lock[1];
 };
 
-DEFINE_PER_CPU(union irq_stack_union, irq_stack_union) = {
+static DEFINE_PER_CPU(union irq_stack_union, irq_stack_union) = {
 		.slock = { 1,1,1,1 },
 	};
 #endif
diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 91a3be14808b..affb03f56a7e 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -478,11 +478,13 @@ void thread_change_pc(struct task_struct *tsk, struct pt_regs *regs)
 	struct arch_hw_breakpoint *info;
 	int i;
 
+	preempt_disable();
+
 	for (i = 0; i < nr_wp_slots(); i++) {
 		if (unlikely(tsk->thread.last_hit_ubp[i]))
 			goto reset;
 	}
-	return;
+	goto out;
 
 reset:
 	regs_set_return_msr(regs, regs->msr & ~MSR_SE);
@@ -491,6 +493,9 @@ void thread_change_pc(struct task_struct *tsk, struct pt_regs *regs)
 		__set_breakpoint(i, info);
 		tsk->thread.last_hit_ubp[i] = NULL;
 	}
+
+out:
+	preempt_enable();
 }
 
 static bool is_larx_stcx_instr(int type)
@@ -605,6 +610,11 @@ static void handle_p10dd1_spurious_exception(struct arch_hw_breakpoint **info,
 	}
 }
 
+/*
+ * Handle a DABR or DAWR exception.
+ *
+ * Called in atomic context.
+ */
 int hw_breakpoint_handler(struct die_args *args)
 {
 	bool err = false;
@@ -731,6 +741,8 @@ NOKPROBE_SYMBOL(hw_breakpoint_handler);
 
 /*
  * Handle single-step exceptions following a DABR hit.
+ *
+ * Called in atomic context.
  */
 static int single_step_dabr_instruction(struct die_args *args)
 {
@@ -788,6 +800,8 @@ NOKPROBE_SYMBOL(single_step_dabr_instruction);
 
 /*
  * Handle debug exception notifications.
+ *
+ * Called in atomic context.
  */
 int hw_breakpoint_exceptions_notify(
 		struct notifier_block *unused, unsigned long val, void *data)
diff --git a/arch/powerpc/kernel/hw_breakpoint_constraints.c b/arch/powerpc/kernel/hw_breakpoint_constraints.c
index 675d1f66ab72..a541e3b75547 100644
--- a/arch/powerpc/kernel/hw_breakpoint_constraints.c
+++ b/arch/powerpc/kernel/hw_breakpoint_constraints.c
@@ -140,8 +140,13 @@ void wp_get_instr_detail(struct pt_regs *regs, struct ppc_inst *instr,
 			 int *type, int *size, unsigned long *ea)
 {
 	struct instruction_op op;
+	int err;
 
-	if (__get_user_instr(*instr, (void __user *)regs->nip))
+	pagefault_disable();
+	err = __get_user_instr(*instr, (void __user *)regs->nip);
+	pagefault_enable();
+
+	if (err)
 		return;
 
 	analyse_instr(&op, regs, *instr);
diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 1816f560a465..284ccc90fb11 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -1431,7 +1431,7 @@ static int h_24x7_event_init(struct perf_event *event)
 	}
 
 	domain = event_get_domain(event);
-	if (domain >= HV_PERF_DOMAIN_MAX) {
+	if (domain  == 0 || domain >= HV_PERF_DOMAIN_MAX) {
 		pr_devel("invalid domain %d\n", domain);
 		return -EINVAL;
 	}
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 0d2c5fe84141..6322a08edbba 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2414,7 +2414,7 @@ static void __init srso_select_mitigation(void)
 
 	switch (srso_cmd) {
 	case SRSO_CMD_OFF:
-		return;
+		goto pred_cmd;
 
 	case SRSO_CMD_MICROCODE:
 		if (has_microcode) {
@@ -2692,7 +2692,7 @@ static ssize_t srso_show_state(char *buf)
 
 	return sysfs_emit(buf, "%s%s\n",
 			  srso_strings[srso_mitigation],
-			  (cpu_has_ibpb_brtype_microcode() ? "" : ", no microcode"));
+			  boot_cpu_has(X86_FEATURE_IBPB_BRTYPE) ? "" : ", no microcode");
 }
 
 static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr,
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3151c08bb54a..01c4f8f45b83 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1172,7 +1172,7 @@ static const struct x86_cpu_id cpu_vuln_blacklist[] __initconst = {
 	VULNBL_AMD(0x15, RETBLEED),
 	VULNBL_AMD(0x16, RETBLEED),
 	VULNBL_AMD(0x17, RETBLEED | SMT_RSB | SRSO),
-	VULNBL_HYGON(0x18, RETBLEED | SMT_RSB),
+	VULNBL_HYGON(0x18, RETBLEED | SMT_RSB | SRSO),
 	VULNBL_AMD(0x19, SRSO),
 	{}
 };
diff --git a/arch/xtensa/boot/Makefile b/arch/xtensa/boot/Makefile
index a65b7a9ebff2..d8b0fadf429a 100644
--- a/arch/xtensa/boot/Makefile
+++ b/arch/xtensa/boot/Makefile
@@ -9,8 +9,7 @@
 
 
 # KBUILD_CFLAGS used when building rest of boot (takes effect recursively)
-KBUILD_CFLAGS	+= -fno-builtin -Iarch/$(ARCH)/boot/include
-HOSTFLAGS	+= -Iarch/$(ARCH)/boot/include
+KBUILD_CFLAGS	+= -fno-builtin
 
 subdir-y	:= lib
 targets		+= vmlinux.bin vmlinux.bin.gz
diff --git a/arch/xtensa/boot/lib/zmem.c b/arch/xtensa/boot/lib/zmem.c
index e3ecd743c515..b89189355122 100644
--- a/arch/xtensa/boot/lib/zmem.c
+++ b/arch/xtensa/boot/lib/zmem.c
@@ -4,13 +4,14 @@
 /* bits taken from ppc */
 
 extern void *avail_ram, *end_avail;
+void gunzip(void *dst, int dstlen, unsigned char *src, int *lenp);
 
-void exit (void)
+static void exit(void)
 {
   for (;;);
 }
 
-void *zalloc(unsigned size)
+static void *zalloc(unsigned int size)
 {
         void *p = avail_ram;
 
diff --git a/arch/xtensa/include/asm/core.h b/arch/xtensa/include/asm/core.h
index a4e40166ff4b..0fa3649649e9 100644
--- a/arch/xtensa/include/asm/core.h
+++ b/arch/xtensa/include/asm/core.h
@@ -6,6 +6,10 @@
 
 #include <variant/core.h>
 
+#ifndef XCHAL_HAVE_DIV32
+#define XCHAL_HAVE_DIV32 0
+#endif
+
 #ifndef XCHAL_HAVE_EXCLUSIVE
 #define XCHAL_HAVE_EXCLUSIVE 0
 #endif
diff --git a/arch/xtensa/platforms/iss/network.c b/arch/xtensa/platforms/iss/network.c
index 1270de83435e..e8491ac0d5b9 100644
--- a/arch/xtensa/platforms/iss/network.c
+++ b/arch/xtensa/platforms/iss/network.c
@@ -204,7 +204,7 @@ static int tuntap_write(struct iss_net_private *lp, struct sk_buff **skb)
 	return simc_write(lp->tp.info.tuntap.fd, (*skb)->data, (*skb)->len);
 }
 
-unsigned short tuntap_protocol(struct sk_buff *skb)
+static unsigned short tuntap_protocol(struct sk_buff *skb)
 {
 	return eth_type_trans(skb, skb->dev);
 }
@@ -477,7 +477,7 @@ static int iss_net_change_mtu(struct net_device *dev, int new_mtu)
 	return -EINVAL;
 }
 
-void iss_net_user_timer_expire(struct timer_list *unused)
+static void iss_net_user_timer_expire(struct timer_list *unused)
 {
 }
 
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index acc028414ee9..3147b2e6cd8c 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -50,7 +50,8 @@ enum board_ids {
 	/* board IDs by feature in alphabetical order */
 	board_ahci,
 	board_ahci_ign_iferr,
-	board_ahci_mobile,
+	board_ahci_low_power,
+	board_ahci_no_debounce_delay,
 	board_ahci_nomsi,
 	board_ahci_noncq,
 	board_ahci_nosntf,
@@ -135,13 +136,20 @@ static const struct ata_port_info ahci_port_info[] = {
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
-	[board_ahci_mobile] = {
+	[board_ahci_low_power] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_IS_MOBILE),
 		.flags		= AHCI_FLAG_COMMON,
 		.pio_mask	= ATA_PIO4,
 		.udma_mask	= ATA_UDMA6,
 		.port_ops	= &ahci_ops,
 	},
+	[board_ahci_no_debounce_delay] = {
+		.flags		= AHCI_FLAG_COMMON,
+		.link_flags	= ATA_LFLAG_NO_DEBOUNCE_DELAY,
+		.pio_mask	= ATA_PIO4,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &ahci_ops,
+	},
 	[board_ahci_nomsi] = {
 		AHCI_HFLAGS	(AHCI_HFLAG_NO_MSI),
 		.flags		= AHCI_FLAG_COMMON,
@@ -268,13 +276,13 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x2924), board_ahci }, /* ICH9 */
 	{ PCI_VDEVICE(INTEL, 0x2925), board_ahci }, /* ICH9 */
 	{ PCI_VDEVICE(INTEL, 0x2927), board_ahci }, /* ICH9 */
-	{ PCI_VDEVICE(INTEL, 0x2929), board_ahci_mobile }, /* ICH9M */
-	{ PCI_VDEVICE(INTEL, 0x292a), board_ahci_mobile }, /* ICH9M */
-	{ PCI_VDEVICE(INTEL, 0x292b), board_ahci_mobile }, /* ICH9M */
-	{ PCI_VDEVICE(INTEL, 0x292c), board_ahci_mobile }, /* ICH9M */
-	{ PCI_VDEVICE(INTEL, 0x292f), board_ahci_mobile }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x2929), board_ahci_low_power }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x292a), board_ahci_low_power }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x292b), board_ahci_low_power }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x292c), board_ahci_low_power }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x292f), board_ahci_low_power }, /* ICH9M */
 	{ PCI_VDEVICE(INTEL, 0x294d), board_ahci }, /* ICH9 */
-	{ PCI_VDEVICE(INTEL, 0x294e), board_ahci_mobile }, /* ICH9M */
+	{ PCI_VDEVICE(INTEL, 0x294e), board_ahci_low_power }, /* ICH9M */
 	{ PCI_VDEVICE(INTEL, 0x502a), board_ahci }, /* Tolapai */
 	{ PCI_VDEVICE(INTEL, 0x502b), board_ahci }, /* Tolapai */
 	{ PCI_VDEVICE(INTEL, 0x3a05), board_ahci }, /* ICH10 */
@@ -284,9 +292,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x3b23), board_ahci }, /* PCH AHCI */
 	{ PCI_VDEVICE(INTEL, 0x3b24), board_ahci }, /* PCH RAID */
 	{ PCI_VDEVICE(INTEL, 0x3b25), board_ahci }, /* PCH RAID */
-	{ PCI_VDEVICE(INTEL, 0x3b29), board_ahci_mobile }, /* PCH M AHCI */
+	{ PCI_VDEVICE(INTEL, 0x3b29), board_ahci_low_power }, /* PCH M AHCI */
 	{ PCI_VDEVICE(INTEL, 0x3b2b), board_ahci }, /* PCH RAID */
-	{ PCI_VDEVICE(INTEL, 0x3b2c), board_ahci_mobile }, /* PCH M RAID */
+	{ PCI_VDEVICE(INTEL, 0x3b2c), board_ahci_low_power }, /* PCH M RAID */
 	{ PCI_VDEVICE(INTEL, 0x3b2f), board_ahci }, /* PCH AHCI */
 	{ PCI_VDEVICE(INTEL, 0x19b0), board_ahci_pcs7 }, /* DNV AHCI */
 	{ PCI_VDEVICE(INTEL, 0x19b1), board_ahci_pcs7 }, /* DNV AHCI */
@@ -309,9 +317,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x19cE), board_ahci_pcs7 }, /* DNV AHCI */
 	{ PCI_VDEVICE(INTEL, 0x19cF), board_ahci_pcs7 }, /* DNV AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1c02), board_ahci }, /* CPT AHCI */
-	{ PCI_VDEVICE(INTEL, 0x1c03), board_ahci_mobile }, /* CPT M AHCI */
+	{ PCI_VDEVICE(INTEL, 0x1c03), board_ahci_low_power }, /* CPT M AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1c04), board_ahci }, /* CPT RAID */
-	{ PCI_VDEVICE(INTEL, 0x1c05), board_ahci_mobile }, /* CPT M RAID */
+	{ PCI_VDEVICE(INTEL, 0x1c05), board_ahci_low_power }, /* CPT M RAID */
 	{ PCI_VDEVICE(INTEL, 0x1c06), board_ahci }, /* CPT RAID */
 	{ PCI_VDEVICE(INTEL, 0x1c07), board_ahci }, /* CPT RAID */
 	{ PCI_VDEVICE(INTEL, 0x1d02), board_ahci }, /* PBG AHCI */
@@ -320,29 +328,29 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x2826), board_ahci }, /* PBG RAID */
 	{ PCI_VDEVICE(INTEL, 0x2323), board_ahci }, /* DH89xxCC AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1e02), board_ahci }, /* Panther Point AHCI */
-	{ PCI_VDEVICE(INTEL, 0x1e03), board_ahci_mobile }, /* Panther M AHCI */
+	{ PCI_VDEVICE(INTEL, 0x1e03), board_ahci_low_power }, /* Panther M AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1e04), board_ahci }, /* Panther Point RAID */
 	{ PCI_VDEVICE(INTEL, 0x1e05), board_ahci }, /* Panther Point RAID */
 	{ PCI_VDEVICE(INTEL, 0x1e06), board_ahci }, /* Panther Point RAID */
-	{ PCI_VDEVICE(INTEL, 0x1e07), board_ahci_mobile }, /* Panther M RAID */
+	{ PCI_VDEVICE(INTEL, 0x1e07), board_ahci_low_power }, /* Panther M RAID */
 	{ PCI_VDEVICE(INTEL, 0x1e0e), board_ahci }, /* Panther Point RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c02), board_ahci }, /* Lynx Point AHCI */
-	{ PCI_VDEVICE(INTEL, 0x8c03), board_ahci_mobile }, /* Lynx M AHCI */
+	{ PCI_VDEVICE(INTEL, 0x8c03), board_ahci_low_power }, /* Lynx M AHCI */
 	{ PCI_VDEVICE(INTEL, 0x8c04), board_ahci }, /* Lynx Point RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c05), board_ahci_mobile }, /* Lynx M RAID */
+	{ PCI_VDEVICE(INTEL, 0x8c05), board_ahci_low_power }, /* Lynx M RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c06), board_ahci }, /* Lynx Point RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c07), board_ahci_mobile }, /* Lynx M RAID */
+	{ PCI_VDEVICE(INTEL, 0x8c07), board_ahci_low_power }, /* Lynx M RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c0e), board_ahci }, /* Lynx Point RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c0f), board_ahci_mobile }, /* Lynx M RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c02), board_ahci_mobile }, /* Lynx LP AHCI */
-	{ PCI_VDEVICE(INTEL, 0x9c03), board_ahci_mobile }, /* Lynx LP AHCI */
-	{ PCI_VDEVICE(INTEL, 0x9c04), board_ahci_mobile }, /* Lynx LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c05), board_ahci_mobile }, /* Lynx LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c06), board_ahci_mobile }, /* Lynx LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c07), board_ahci_mobile }, /* Lynx LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c0e), board_ahci_mobile }, /* Lynx LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c0f), board_ahci_mobile }, /* Lynx LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9dd3), board_ahci_mobile }, /* Cannon Lake PCH-LP AHCI */
+	{ PCI_VDEVICE(INTEL, 0x8c0f), board_ahci_low_power }, /* Lynx M RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c02), board_ahci_low_power }, /* Lynx LP AHCI */
+	{ PCI_VDEVICE(INTEL, 0x9c03), board_ahci_low_power }, /* Lynx LP AHCI */
+	{ PCI_VDEVICE(INTEL, 0x9c04), board_ahci_low_power }, /* Lynx LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c05), board_ahci_low_power }, /* Lynx LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c06), board_ahci_low_power }, /* Lynx LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c07), board_ahci_low_power }, /* Lynx LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c0e), board_ahci_low_power }, /* Lynx LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c0f), board_ahci_low_power }, /* Lynx LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9dd3), board_ahci_low_power }, /* Cannon Lake PCH-LP AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1f22), board_ahci }, /* Avoton AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1f23), board_ahci }, /* Avoton AHCI */
 	{ PCI_VDEVICE(INTEL, 0x1f24), board_ahci }, /* Avoton RAID */
@@ -374,26 +382,26 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0x8d66), board_ahci }, /* Wellsburg RAID */
 	{ PCI_VDEVICE(INTEL, 0x8d6e), board_ahci }, /* Wellsburg RAID */
 	{ PCI_VDEVICE(INTEL, 0x23a3), board_ahci }, /* Coleto Creek AHCI */
-	{ PCI_VDEVICE(INTEL, 0x9c83), board_ahci_mobile }, /* Wildcat LP AHCI */
-	{ PCI_VDEVICE(INTEL, 0x9c85), board_ahci_mobile }, /* Wildcat LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c87), board_ahci_mobile }, /* Wildcat LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9c8f), board_ahci_mobile }, /* Wildcat LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c83), board_ahci_low_power }, /* Wildcat LP AHCI */
+	{ PCI_VDEVICE(INTEL, 0x9c85), board_ahci_low_power }, /* Wildcat LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c87), board_ahci_low_power }, /* Wildcat LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9c8f), board_ahci_low_power }, /* Wildcat LP RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c82), board_ahci }, /* 9 Series AHCI */
-	{ PCI_VDEVICE(INTEL, 0x8c83), board_ahci_mobile }, /* 9 Series M AHCI */
+	{ PCI_VDEVICE(INTEL, 0x8c83), board_ahci_low_power }, /* 9 Series M AHCI */
 	{ PCI_VDEVICE(INTEL, 0x8c84), board_ahci }, /* 9 Series RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c85), board_ahci_mobile }, /* 9 Series M RAID */
+	{ PCI_VDEVICE(INTEL, 0x8c85), board_ahci_low_power }, /* 9 Series M RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c86), board_ahci }, /* 9 Series RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c87), board_ahci_mobile }, /* 9 Series M RAID */
+	{ PCI_VDEVICE(INTEL, 0x8c87), board_ahci_low_power }, /* 9 Series M RAID */
 	{ PCI_VDEVICE(INTEL, 0x8c8e), board_ahci }, /* 9 Series RAID */
-	{ PCI_VDEVICE(INTEL, 0x8c8f), board_ahci_mobile }, /* 9 Series M RAID */
-	{ PCI_VDEVICE(INTEL, 0x9d03), board_ahci_mobile }, /* Sunrise LP AHCI */
-	{ PCI_VDEVICE(INTEL, 0x9d05), board_ahci_mobile }, /* Sunrise LP RAID */
-	{ PCI_VDEVICE(INTEL, 0x9d07), board_ahci_mobile }, /* Sunrise LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x8c8f), board_ahci_low_power }, /* 9 Series M RAID */
+	{ PCI_VDEVICE(INTEL, 0x9d03), board_ahci_low_power }, /* Sunrise LP AHCI */
+	{ PCI_VDEVICE(INTEL, 0x9d05), board_ahci_low_power }, /* Sunrise LP RAID */
+	{ PCI_VDEVICE(INTEL, 0x9d07), board_ahci_low_power }, /* Sunrise LP RAID */
 	{ PCI_VDEVICE(INTEL, 0xa102), board_ahci }, /* Sunrise Point-H AHCI */
-	{ PCI_VDEVICE(INTEL, 0xa103), board_ahci_mobile }, /* Sunrise M AHCI */
+	{ PCI_VDEVICE(INTEL, 0xa103), board_ahci_low_power }, /* Sunrise M AHCI */
 	{ PCI_VDEVICE(INTEL, 0xa105), board_ahci }, /* Sunrise Point-H RAID */
 	{ PCI_VDEVICE(INTEL, 0xa106), board_ahci }, /* Sunrise Point-H RAID */
-	{ PCI_VDEVICE(INTEL, 0xa107), board_ahci_mobile }, /* Sunrise M RAID */
+	{ PCI_VDEVICE(INTEL, 0xa107), board_ahci_low_power }, /* Sunrise M RAID */
 	{ PCI_VDEVICE(INTEL, 0xa10f), board_ahci }, /* Sunrise Point-H RAID */
 	{ PCI_VDEVICE(INTEL, 0x2822), board_ahci }, /* Lewisburg RAID*/
 	{ PCI_VDEVICE(INTEL, 0x2823), board_ahci }, /* Lewisburg AHCI*/
@@ -410,13 +418,15 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, 0xa356), board_ahci }, /* Cannon Lake PCH-H RAID */
 	{ PCI_VDEVICE(INTEL, 0x06d7), board_ahci }, /* Comet Lake-H RAID */
 	{ PCI_VDEVICE(INTEL, 0xa386), board_ahci }, /* Comet Lake PCH-V RAID */
-	{ PCI_VDEVICE(INTEL, 0x0f22), board_ahci_mobile }, /* Bay Trail AHCI */
-	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci_mobile }, /* Bay Trail AHCI */
-	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci_mobile }, /* Cherry Tr. AHCI */
-	{ PCI_VDEVICE(INTEL, 0x5ae3), board_ahci_mobile }, /* ApolloLake AHCI */
-	{ PCI_VDEVICE(INTEL, 0x34d3), board_ahci_mobile }, /* Ice Lake LP AHCI */
-	{ PCI_VDEVICE(INTEL, 0x02d3), board_ahci_mobile }, /* Comet Lake PCH-U AHCI */
-	{ PCI_VDEVICE(INTEL, 0x02d7), board_ahci_mobile }, /* Comet Lake PCH RAID */
+	{ PCI_VDEVICE(INTEL, 0x0f22), board_ahci_low_power }, /* Bay Trail AHCI */
+	{ PCI_VDEVICE(INTEL, 0x0f23), board_ahci_low_power }, /* Bay Trail AHCI */
+	{ PCI_VDEVICE(INTEL, 0x22a3), board_ahci_low_power }, /* Cherry Tr. AHCI */
+	{ PCI_VDEVICE(INTEL, 0x5ae3), board_ahci_low_power }, /* ApolloLake AHCI */
+	{ PCI_VDEVICE(INTEL, 0x34d3), board_ahci_low_power }, /* Ice Lake LP AHCI */
+	{ PCI_VDEVICE(INTEL, 0x02d3), board_ahci_low_power }, /* Comet Lake PCH-U AHCI */
+	{ PCI_VDEVICE(INTEL, 0x02d7), board_ahci_low_power }, /* Comet Lake PCH RAID */
+	/* Elkhart Lake IDs 0x4b60 & 0x4b62 https://sata-io.org/product/8803 not tested yet */
+	{ PCI_VDEVICE(INTEL, 0x4b63), board_ahci_low_power }, /* Elkhart Lake AHCI */
 
 	/* JMicron 360/1/3/5/6, match class to avoid IDE function */
 	{ PCI_VENDOR_ID_JMICRON, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
@@ -442,8 +452,9 @@ static const struct pci_device_id ahci_pci_tbl[] = {
 		board_ahci_al },
 	/* AMD */
 	{ PCI_VDEVICE(AMD, 0x7800), board_ahci }, /* AMD Hudson-2 */
+	{ PCI_VDEVICE(AMD, 0x7801), board_ahci_no_debounce_delay }, /* AMD Hudson-2 (AHCI mode) */
 	{ PCI_VDEVICE(AMD, 0x7900), board_ahci }, /* AMD CZ */
-	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_mobile }, /* AMD Green Sardine */
+	{ PCI_VDEVICE(AMD, 0x7901), board_ahci_low_power }, /* AMD Green Sardine */
 	/* AMD is using RAID class only for ahci controllers */
 	{ PCI_VENDOR_ID_AMD, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	  PCI_CLASS_STORAGE_RAID << 8, 0xffffff, board_ahci },
@@ -707,7 +718,7 @@ static void ahci_pci_init_controller(struct ata_host *host)
 
 		/* clear port IRQ */
 		tmp = readl(port_mmio + PORT_IRQ_STAT);
-		VPRINTK("PORT_IRQ_STAT 0x%x\n", tmp);
+		dev_dbg(&pdev->dev, "PORT_IRQ_STAT 0x%x\n", tmp);
 		if (tmp)
 			writel(tmp, port_mmio + PORT_IRQ_STAT);
 	}
@@ -1499,7 +1510,6 @@ static irqreturn_t ahci_thunderx_irq_handler(int irq, void *dev_instance)
 	u32 irq_stat, irq_masked;
 	unsigned int handled = 1;
 
-	VPRINTK("ENTER\n");
 	hpriv = host->private_data;
 	mmio = hpriv->mmio;
 	irq_stat = readl(mmio + HOST_IRQ_STAT);
@@ -1516,7 +1526,6 @@ static irqreturn_t ahci_thunderx_irq_handler(int irq, void *dev_instance)
 		irq_stat = readl(mmio + HOST_IRQ_STAT);
 		spin_unlock(&host->lock);
 	} while (irq_stat);
-	VPRINTK("EXIT\n");
 
 	return IRQ_RETVAL(handled);
 }
diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 6e9c5ade4c2e..649815c196ed 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -333,7 +333,7 @@ static struct ata_port_operations ahci_brcm_platform_ops = {
 
 static const struct ata_port_info ahci_brcm_port_info = {
 	.flags		= AHCI_FLAG_COMMON | ATA_FLAG_NO_DIPM,
-	.link_flags	= ATA_LFLAG_NO_DB_DELAY,
+	.link_flags	= ATA_LFLAG_NO_DEBOUNCE_DELAY,
 	.pio_mask	= ATA_PIO4,
 	.udma_mask	= ATA_UDMA6,
 	.port_ops	= &ahci_brcm_platform_ops,
diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index 292099410cf6..c1f61d255bc3 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -588,8 +588,6 @@ static irqreturn_t xgene_ahci_irq_intr(int irq, void *dev_instance)
 	void __iomem *mmio;
 	u32 irq_stat, irq_masked;
 
-	VPRINTK("ENTER\n");
-
 	hpriv = host->private_data;
 	mmio = hpriv->mmio;
 
@@ -612,8 +610,6 @@ static irqreturn_t xgene_ahci_irq_intr(int irq, void *dev_instance)
 
 	spin_unlock(&host->lock);
 
-	VPRINTK("EXIT\n");
-
 	return IRQ_RETVAL(rc);
 }
 
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 192115a45dd7..e22d45fb8ebd 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1200,6 +1200,26 @@ static ssize_t ahci_activity_show(struct ata_device *dev, char *buf)
 	return sprintf(buf, "%d\n", emp->blink_policy);
 }
 
+static void ahci_port_clear_pending_irq(struct ata_port *ap)
+{
+	struct ahci_host_priv *hpriv = ap->host->private_data;
+	void __iomem *port_mmio = ahci_port_base(ap);
+	u32 tmp;
+
+	/* clear SError */
+	tmp = readl(port_mmio + PORT_SCR_ERR);
+	dev_dbg(ap->host->dev, "PORT_SCR_ERR 0x%x\n", tmp);
+	writel(tmp, port_mmio + PORT_SCR_ERR);
+
+	/* clear port IRQ */
+	tmp = readl(port_mmio + PORT_IRQ_STAT);
+	dev_dbg(ap->host->dev, "PORT_IRQ_STAT 0x%x\n", tmp);
+	if (tmp)
+		writel(tmp, port_mmio + PORT_IRQ_STAT);
+
+	writel(1 << ap->port_no, hpriv->mmio + HOST_IRQ_STAT);
+}
+
 static void ahci_port_init(struct device *dev, struct ata_port *ap,
 			   int port_no, void __iomem *mmio,
 			   void __iomem *port_mmio)
@@ -1214,18 +1234,7 @@ static void ahci_port_init(struct device *dev, struct ata_port *ap,
 	if (rc)
 		dev_warn(dev, "%s (%d)\n", emsg, rc);
 
-	/* clear SError */
-	tmp = readl(port_mmio + PORT_SCR_ERR);
-	VPRINTK("PORT_SCR_ERR 0x%x\n", tmp);
-	writel(tmp, port_mmio + PORT_SCR_ERR);
-
-	/* clear port IRQ */
-	tmp = readl(port_mmio + PORT_IRQ_STAT);
-	VPRINTK("PORT_IRQ_STAT 0x%x\n", tmp);
-	if (tmp)
-		writel(tmp, port_mmio + PORT_IRQ_STAT);
-
-	writel(1 << port_no, mmio + HOST_IRQ_STAT);
+	ahci_port_clear_pending_irq(ap);
 
 	/* mark esata ports */
 	tmp = readl(port_mmio + PORT_CMD);
@@ -1252,10 +1261,10 @@ void ahci_init_controller(struct ata_host *host)
 	}
 
 	tmp = readl(mmio + HOST_CTL);
-	VPRINTK("HOST_CTL 0x%x\n", tmp);
+	dev_dbg(host->dev, "HOST_CTL 0x%x\n", tmp);
 	writel(tmp | HOST_IRQ_EN, mmio + HOST_CTL);
 	tmp = readl(mmio + HOST_CTL);
-	VPRINTK("HOST_CTL 0x%x\n", tmp);
+	dev_dbg(host->dev, "HOST_CTL 0x%x\n", tmp);
 }
 EXPORT_SYMBOL_GPL(ahci_init_controller);
 
@@ -1555,6 +1564,8 @@ int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
 	tf.status = ATA_BUSY;
 	ata_tf_to_fis(&tf, 0, 0, d2h_fis);
 
+	ahci_port_clear_pending_irq(ap);
+
 	rc = sata_link_hardreset(link, timing, deadline, online,
 				 ahci_check_ready);
 
@@ -1906,8 +1917,6 @@ static irqreturn_t ahci_multi_irqs_intr_hard(int irq, void *dev_instance)
 	void __iomem *port_mmio = ahci_port_base(ap);
 	u32 status;
 
-	VPRINTK("ENTER\n");
-
 	status = readl(port_mmio + PORT_IRQ_STAT);
 	writel(status, port_mmio + PORT_IRQ_STAT);
 
@@ -1915,8 +1924,6 @@ static irqreturn_t ahci_multi_irqs_intr_hard(int irq, void *dev_instance)
 	ahci_handle_port_interrupt(ap, port_mmio, status);
 	spin_unlock(ap->lock);
 
-	VPRINTK("EXIT\n");
-
 	return IRQ_HANDLED;
 }
 
@@ -1933,9 +1940,7 @@ u32 ahci_handle_port_intr(struct ata_host *host, u32 irq_masked)
 		ap = host->ports[i];
 		if (ap) {
 			ahci_port_intr(ap);
-			VPRINTK("port %u\n", i);
 		} else {
-			VPRINTK("port %u (no irq)\n", i);
 			if (ata_ratelimit())
 				dev_warn(host->dev,
 					 "interrupt on disabled port %u\n", i);
@@ -1956,8 +1961,6 @@ static irqreturn_t ahci_single_level_irq_intr(int irq, void *dev_instance)
 	void __iomem *mmio;
 	u32 irq_stat, irq_masked;
 
-	VPRINTK("ENTER\n");
-
 	hpriv = host->private_data;
 	mmio = hpriv->mmio;
 
@@ -1985,8 +1988,6 @@ static irqreturn_t ahci_single_level_irq_intr(int irq, void *dev_instance)
 
 	spin_unlock(&host->lock);
 
-	VPRINTK("EXIT\n");
-
 	return IRQ_RETVAL(rc);
 }
 
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 025260b80a94..96786d6fcf37 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4999,17 +4999,19 @@ static void ata_port_request_pm(struct ata_port *ap, pm_message_t mesg,
 	struct ata_link *link;
 	unsigned long flags;
 
-	/* Previous resume operation might still be in
-	 * progress.  Wait for PM_PENDING to clear.
+	spin_lock_irqsave(ap->lock, flags);
+
+	/*
+	 * A previous PM operation might still be in progress. Wait for
+	 * ATA_PFLAG_PM_PENDING to clear.
 	 */
 	if (ap->pflags & ATA_PFLAG_PM_PENDING) {
+		spin_unlock_irqrestore(ap->lock, flags);
 		ata_port_wait_eh(ap);
-		WARN_ON(ap->pflags & ATA_PFLAG_PM_PENDING);
+		spin_lock_irqsave(ap->lock, flags);
 	}
 
-	/* request PM ops to EH */
-	spin_lock_irqsave(ap->lock, flags);
-
+	/* Request PM operation to EH */
 	ap->pm_mesg = mesg;
 	ap->pflags |= ATA_PFLAG_PM_PENDING;
 	ata_for_each_link(link, ap, HOST_FIRST) {
@@ -5021,10 +5023,8 @@ static void ata_port_request_pm(struct ata_port *ap, pm_message_t mesg,
 
 	spin_unlock_irqrestore(ap->lock, flags);
 
-	if (!async) {
+	if (!async)
 		ata_port_wait_eh(ap);
-		WARN_ON(ap->pflags & ATA_PFLAG_PM_PENDING);
-	}
 }
 
 /*
@@ -5192,7 +5192,7 @@ EXPORT_SYMBOL_GPL(ata_host_resume);
 #endif
 
 const struct device_type ata_port_type = {
-	.name = "ata_port",
+	.name = ATA_PORT_TYPE_NAME,
 #ifdef CONFIG_PM
 	.pm = &ata_port_pm_ops,
 #endif
@@ -5940,11 +5940,30 @@ static void ata_port_detach(struct ata_port *ap)
 	if (!ap->ops->error_handler)
 		goto skip_eh;
 
-	/* tell EH we're leaving & flush EH */
+	/* Wait for any ongoing EH */
+	ata_port_wait_eh(ap);
+
+	mutex_lock(&ap->scsi_scan_mutex);
 	spin_lock_irqsave(ap->lock, flags);
+
+	/* Remove scsi devices */
+	ata_for_each_link(link, ap, HOST_FIRST) {
+		ata_for_each_dev(dev, link, ALL) {
+			if (dev->sdev) {
+				spin_unlock_irqrestore(ap->lock, flags);
+				scsi_remove_device(dev->sdev);
+				spin_lock_irqsave(ap->lock, flags);
+				dev->sdev = NULL;
+			}
+		}
+	}
+
+	/* Tell EH to disable all devices */
 	ap->pflags |= ATA_PFLAG_UNLOADING;
 	ata_port_schedule_eh(ap);
+
 	spin_unlock_irqrestore(ap->lock, flags);
+	mutex_unlock(&ap->scsi_scan_mutex);
 
 	/* wait till EH commits suicide */
 	ata_port_wait_eh(ap);
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 8350abc17290..844483200870 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2703,18 +2703,11 @@ int ata_eh_reset(struct ata_link *link, int classify,
 			postreset(slave, classes);
 	}
 
-	/*
-	 * Some controllers can't be frozen very well and may set spurious
-	 * error conditions during reset.  Clear accumulated error
-	 * information and re-thaw the port if frozen.  As reset is the
-	 * final recovery action and we cross check link onlineness against
-	 * device classification later, no hotplug event is lost by this.
-	 */
+	/* clear cached SError */
 	spin_lock_irqsave(link->ap->lock, flags);
-	memset(&link->eh_info, 0, sizeof(link->eh_info));
+	link->eh_info.serror = 0;
 	if (slave)
-		memset(&slave->eh_info, 0, sizeof(link->eh_info));
-	ap->pflags &= ~ATA_PFLAG_EH_PENDING;
+		slave->eh_info.serror = 0;
 	spin_unlock_irqrestore(link->ap->lock, flags);
 
 	if (ap->pflags & ATA_PFLAG_FROZEN)
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index cb9395a3ad8e..04bdd53abf20 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -317,7 +317,7 @@ int sata_link_resume(struct ata_link *link, const unsigned long *params,
 		 * immediately after resuming.  Delay 200ms before
 		 * debouncing.
 		 */
-		if (!(link->flags & ATA_LFLAG_NO_DB_DELAY))
+		if (!(link->flags & ATA_LFLAG_NO_DEBOUNCE_DELAY))
 			ata_msleep(link->ap, 200);
 
 		/* is SControl restored correctly? */
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index fd9c768f31ef..9d0596dabfb9 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4214,7 +4214,7 @@ void ata_scsi_simulate(struct ata_device *dev, struct scsi_cmnd *cmd)
 		break;
 
 	case MAINTENANCE_IN:
-		if (scsicmd[1] == MI_REPORT_SUPPORTED_OPERATION_CODES)
+		if ((scsicmd[1] & 0x1f) == MI_REPORT_SUPPORTED_OPERATION_CODES)
 			ata_scsi_rbuf_fill(&args, ata_scsiop_maint_in);
 		else
 			ata_scsi_set_invalid_field(dev, cmd, 1, 0xff);
diff --git a/drivers/ata/libata-transport.c b/drivers/ata/libata-transport.c
index 60f22e1a4943..e180f63a035e 100644
--- a/drivers/ata/libata-transport.c
+++ b/drivers/ata/libata-transport.c
@@ -266,6 +266,10 @@ void ata_tport_delete(struct ata_port *ap)
 	put_device(dev);
 }
 
+static const struct device_type ata_port_sas_type = {
+	.name = ATA_PORT_TYPE_NAME,
+};
+
 /** ata_tport_add - initialize a transport ATA port structure
  *
  * @parent:	parent device
@@ -283,7 +287,10 @@ int ata_tport_add(struct device *parent,
 	struct device *dev = &ap->tdev;
 
 	device_initialize(dev);
-	dev->type = &ata_port_type;
+	if (ap->flags & ATA_FLAG_SAS_HOST)
+		dev->type = &ata_port_sas_type;
+	else
+		dev->type = &ata_port_type;
 
 	dev->parent = parent;
 	ata_host_get(ap->host);
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 68cdd81d747c..bf71bd9e66cd 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -30,6 +30,8 @@ enum {
 	ATA_DNXFER_QUIET	= (1 << 31),
 };
 
+#define ATA_PORT_TYPE_NAME	"ata_port"
+
 extern atomic_t ata_print_id;
 extern int atapi_passthru16;
 extern int libata_fua;
diff --git a/drivers/bus/ti-sysc.c b/drivers/bus/ti-sysc.c
index 74ab6cf031ce..0a159989c899 100644
--- a/drivers/bus/ti-sysc.c
+++ b/drivers/bus/ti-sysc.c
@@ -38,6 +38,7 @@ enum sysc_soc {
 	SOC_2420,
 	SOC_2430,
 	SOC_3430,
+	SOC_AM35,
 	SOC_3630,
 	SOC_4430,
 	SOC_4460,
@@ -1117,6 +1118,11 @@ static int sysc_enable_module(struct device *dev)
 	if (ddata->cfg.quirks & (SYSC_QUIRK_SWSUP_SIDLE |
 				 SYSC_QUIRK_SWSUP_SIDLE_ACT)) {
 		best_mode = SYSC_IDLE_NO;
+
+		/* Clear WAKEUP */
+		if (regbits->enwkup_shift >= 0 &&
+		    ddata->cfg.sysc_val & BIT(regbits->enwkup_shift))
+			reg &= ~BIT(regbits->enwkup_shift);
 	} else {
 		best_mode = fls(ddata->cfg.sidlemodes) - 1;
 		if (best_mode > SYSC_IDLE_MASK) {
@@ -1237,6 +1243,13 @@ static int sysc_disable_module(struct device *dev)
 		}
 	}
 
+	if (ddata->cfg.quirks & SYSC_QUIRK_SWSUP_SIDLE_ACT) {
+		/* Set WAKEUP */
+		if (regbits->enwkup_shift >= 0 &&
+		    ddata->cfg.sysc_val & BIT(regbits->enwkup_shift))
+			reg |= BIT(regbits->enwkup_shift);
+	}
+
 	reg &= ~(SYSC_IDLE_MASK << regbits->sidle_shift);
 	reg |= best_mode << regbits->sidle_shift;
 	if (regbits->autoidle_shift >= 0 &&
@@ -1496,16 +1509,16 @@ static const struct sysc_revision_quirk sysc_revision_quirks[] = {
 	SYSC_QUIRK("sham", 0, 0x100, 0x110, 0x114, 0x40000c03, 0xffffffff,
 		   SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x00000046, 0xffffffff,
-		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
+		   SYSC_QUIRK_SWSUP_SIDLE_ACT | SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x00000052, 0xffffffff,
-		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
+		   SYSC_QUIRK_SWSUP_SIDLE_ACT | SYSC_QUIRK_LEGACY_IDLE),
 	/* Uarts on omap4 and later */
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x50411e03, 0xffff00ff,
-		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
+		   SYSC_QUIRK_SWSUP_SIDLE_ACT | SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x47422e03, 0xffffffff,
-		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
+		   SYSC_QUIRK_SWSUP_SIDLE_ACT | SYSC_QUIRK_LEGACY_IDLE),
 	SYSC_QUIRK("uart", 0, 0x50, 0x54, 0x58, 0x47424e03, 0xffffffff,
-		   SYSC_QUIRK_SWSUP_SIDLE | SYSC_QUIRK_LEGACY_IDLE),
+		   SYSC_QUIRK_SWSUP_SIDLE_ACT | SYSC_QUIRK_LEGACY_IDLE),
 
 	/* Quirks that need to be set based on the module address */
 	SYSC_QUIRK("mcpdm", 0x40132000, 0, 0x10, -ENODEV, 0x50000800, 0xffffffff,
@@ -1829,7 +1842,7 @@ static void sysc_pre_reset_quirk_dss(struct sysc *ddata)
 		dev_warn(ddata->dev, "%s: timed out %08x !+ %08x\n",
 			 __func__, val, irq_mask);
 
-	if (sysc_soc->soc == SOC_3430) {
+	if (sysc_soc->soc == SOC_3430 || sysc_soc->soc == SOC_AM35) {
 		/* Clear DSS_SDI_CONTROL */
 		sysc_write(ddata, 0x44, 0);
 
@@ -2096,8 +2109,7 @@ static int sysc_reset(struct sysc *ddata)
 	}
 
 	if (ddata->cfg.srst_udelay)
-		usleep_range(ddata->cfg.srst_udelay,
-			     ddata->cfg.srst_udelay * 2);
+		fsleep(ddata->cfg.srst_udelay);
 
 	if (ddata->post_reset_quirk)
 		ddata->post_reset_quirk(ddata);
@@ -2973,6 +2985,7 @@ static void ti_sysc_idle(struct work_struct *work)
 static const struct soc_device_attribute sysc_soc_match[] = {
 	SOC_FLAG("OMAP242*", SOC_2420),
 	SOC_FLAG("OMAP243*", SOC_2430),
+	SOC_FLAG("AM35*", SOC_AM35),
 	SOC_FLAG("OMAP3[45]*", SOC_3430),
 	SOC_FLAG("OMAP3[67]*", SOC_3630),
 	SOC_FLAG("OMAP443*", SOC_4430),
@@ -3179,7 +3192,7 @@ static int sysc_check_active_timer(struct sysc *ddata)
 	 * can be dropped if we stop supporting old beagleboard revisions
 	 * A to B4 at some point.
 	 */
-	if (sysc_soc->soc == SOC_3430)
+	if (sysc_soc->soc == SOC_3430 || sysc_soc->soc == SOC_AM35)
 		error = -ENXIO;
 	else
 		error = -EBUSY;
diff --git a/drivers/char/agp/parisc-agp.c b/drivers/char/agp/parisc-agp.c
index 514f9f287a78..c6f181702b9a 100644
--- a/drivers/char/agp/parisc-agp.c
+++ b/drivers/char/agp/parisc-agp.c
@@ -394,8 +394,6 @@ find_quicksilver(struct device *dev, void *data)
 static int __init
 parisc_agp_init(void)
 {
-	extern struct sba_device *sba_list;
-
 	int err = -1;
 	struct parisc_device *sba = NULL, *lba = NULL;
 	struct lba_device *lbadev = NULL;
diff --git a/drivers/clk/tegra/clk-bpmp.c b/drivers/clk/tegra/clk-bpmp.c
index 6ecf18f71c32..f6721f1d4088 100644
--- a/drivers/clk/tegra/clk-bpmp.c
+++ b/drivers/clk/tegra/clk-bpmp.c
@@ -159,7 +159,7 @@ static unsigned long tegra_bpmp_clk_recalc_rate(struct clk_hw *hw,
 
 	err = tegra_bpmp_clk_transfer(clk->bpmp, &msg);
 	if (err < 0)
-		return err;
+		return 0;
 
 	return response.rate;
 }
diff --git a/drivers/firmware/imx/imx-dsp.c b/drivers/firmware/imx/imx-dsp.c
index a6c06d7476c3..1f410809d3ee 100644
--- a/drivers/firmware/imx/imx-dsp.c
+++ b/drivers/firmware/imx/imx-dsp.c
@@ -115,6 +115,7 @@ static int imx_dsp_setup_channels(struct imx_dsp_ipc *dsp_ipc)
 		dsp_chan->idx = i % 2;
 		dsp_chan->ch = mbox_request_channel_byname(cl, chan_name);
 		if (IS_ERR(dsp_chan->ch)) {
+			kfree(dsp_chan->name);
 			ret = PTR_ERR(dsp_chan->ch);
 			if (ret != -EPROBE_DEFER)
 				dev_err(dev, "Failed to request mbox chan %s ret %d\n",
diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic-eic-sprd.c
index 938285190566..e969ce9131dd 100644
--- a/drivers/gpio/gpio-pmic-eic-sprd.c
+++ b/drivers/gpio/gpio-pmic-eic-sprd.c
@@ -338,6 +338,7 @@ static int sprd_pmic_eic_probe(struct platform_device *pdev)
 	pmic_eic->chip.set_config = sprd_pmic_eic_set_config;
 	pmic_eic->chip.set = sprd_pmic_eic_set;
 	pmic_eic->chip.get = sprd_pmic_eic_get;
+	pmic_eic->chip.can_sleep = true;
 
 	pmic_eic->intc.name = dev_name(&pdev->dev);
 	pmic_eic->intc.irq_mask = sprd_pmic_eic_irq_mask;
diff --git a/drivers/gpio/gpio-tb10x.c b/drivers/gpio/gpio-tb10x.c
index de6afa3f9716..05357473d2a1 100644
--- a/drivers/gpio/gpio-tb10x.c
+++ b/drivers/gpio/gpio-tb10x.c
@@ -195,7 +195,7 @@ static int tb10x_gpio_probe(struct platform_device *pdev)
 				handle_edge_irq, IRQ_NOREQUEST, IRQ_NOPROBE,
 				IRQ_GC_INIT_MASK_CACHE);
 		if (ret)
-			return ret;
+			goto err_remove_domain;
 
 		gc = tb10x_gpio->domain->gc->gc[0];
 		gc->reg_base                         = tb10x_gpio->base;
@@ -209,6 +209,10 @@ static int tb10x_gpio_probe(struct platform_device *pdev)
 	}
 
 	return 0;
+
+err_remove_domain:
+	irq_domain_remove(tb10x_gpio->domain);
+	return ret;
 }
 
 static int tb10x_gpio_remove(struct platform_device *pdev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index e8485b1f02ed..70d49b998ee9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -926,12 +926,17 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			struct atom_context *atom_context;
 
 			atom_context = adev->mode_info.atom_context;
-			memcpy(vbios_info.name, atom_context->name, sizeof(atom_context->name));
-			memcpy(vbios_info.vbios_pn, atom_context->vbios_pn, sizeof(atom_context->vbios_pn));
-			vbios_info.version = atom_context->version;
-			memcpy(vbios_info.vbios_ver_str, atom_context->vbios_ver_str,
-						sizeof(atom_context->vbios_ver_str));
-			memcpy(vbios_info.date, atom_context->date, sizeof(atom_context->date));
+			if (atom_context) {
+				memcpy(vbios_info.name, atom_context->name,
+				       sizeof(atom_context->name));
+				memcpy(vbios_info.vbios_pn, atom_context->vbios_pn,
+				       sizeof(atom_context->vbios_pn));
+				vbios_info.version = atom_context->version;
+				memcpy(vbios_info.vbios_ver_str, atom_context->vbios_ver_str,
+				       sizeof(atom_context->vbios_ver_str));
+				memcpy(vbios_info.date, atom_context->date,
+				       sizeof(atom_context->date));
+			}
 
 			return copy_to_user(out, &vbios_info,
 						min((size_t)size, sizeof(vbios_info))) ? -EFAULT : 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 52142d272c86..87825818d43e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -980,7 +980,9 @@ void dce110_edp_backlight_control(
 		return;
 	}
 
-	if (link->panel_cntl) {
+	if (link->panel_cntl && !(link->dpcd_sink_ext_caps.bits.oled ||
+		link->dpcd_sink_ext_caps.bits.hdr_aux_backlight_control == 1 ||
+		link->dpcd_sink_ext_caps.bits.sdr_aux_backlight_control == 1)) {
 		bool is_backlight_on = link->panel_cntl->funcs->is_panel_backlight_on(link->panel_cntl);
 
 		if ((enable && is_backlight_on) || (!enable && !is_backlight_on)) {
diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index b3cb910b3085..f96c0a89854b 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -272,7 +272,9 @@ static int sn65dsi83_attach(struct drm_bridge *bridge,
 
 	dsi->lanes = ctx->dsi_lanes;
 	dsi->format = MIPI_DSI_FMT_RGB888;
-	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST;
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
+			  MIPI_DSI_MODE_VIDEO_NO_HFP | MIPI_DSI_MODE_VIDEO_NO_HBP |
+			  MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET;
 
 	ret = mipi_dsi_attach(dsi);
 	if (ret < 0) {
diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
index a7692584487c..b075c9bc3a50 100644
--- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
@@ -326,6 +326,8 @@ static void meson_encoder_hdmi_hpd_notify(struct drm_bridge *bridge,
 			return;
 
 		cec_notifier_set_phys_addr_from_edid(encoder_hdmi->cec_notifier, edid);
+
+		kfree(edid);
 	} else
 		cec_notifier_phys_addr_invalidate(encoder_hdmi->cec_notifier);
 }
diff --git a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
index 74d343d1a36b..656e2acf3cd9 100644
--- a/drivers/i2c/busses/i2c-i801.c
+++ b/drivers/i2c/busses/i2c-i801.c
@@ -1861,6 +1861,7 @@ static int i801_probe(struct pci_dev *dev, const struct pci_device_id *id)
 		"SMBus I801 adapter at %04lx", priv->smba);
 	err = i2c_add_adapter(&priv->adapter);
 	if (err) {
+		platform_device_unregister(priv->tco_pdev);
 		i801_acpi_remove(priv);
 		return err;
 	}
diff --git a/drivers/i2c/busses/i2c-npcm7xx.c b/drivers/i2c/busses/i2c-npcm7xx.c
index c1b679737240..73c808ef1bfe 100644
--- a/drivers/i2c/busses/i2c-npcm7xx.c
+++ b/drivers/i2c/busses/i2c-npcm7xx.c
@@ -675,6 +675,7 @@ static void npcm_i2c_callback(struct npcm_i2c *bus,
 {
 	struct i2c_msg *msgs;
 	int msgs_num;
+	bool do_complete = false;
 
 	msgs = bus->msgs;
 	msgs_num = bus->msgs_num;
@@ -701,23 +702,17 @@ static void npcm_i2c_callback(struct npcm_i2c *bus,
 				 msgs[1].flags & I2C_M_RD)
 				msgs[1].len = info;
 		}
-		if (completion_done(&bus->cmd_complete) == false)
-			complete(&bus->cmd_complete);
-	break;
-
+		do_complete = true;
+		break;
 	case I2C_NACK_IND:
 		/* MASTER transmit got a NACK before tx all bytes */
 		bus->cmd_err = -ENXIO;
-		if (bus->master_or_slave == I2C_MASTER)
-			complete(&bus->cmd_complete);
-
+		do_complete = true;
 		break;
 	case I2C_BUS_ERR_IND:
 		/* Bus error */
 		bus->cmd_err = -EAGAIN;
-		if (bus->master_or_slave == I2C_MASTER)
-			complete(&bus->cmd_complete);
-
+		do_complete = true;
 		break;
 	case I2C_WAKE_UP_IND:
 		/* I2C wake up */
@@ -731,6 +726,8 @@ static void npcm_i2c_callback(struct npcm_i2c *bus,
 	if (bus->slave)
 		bus->master_or_slave = I2C_SLAVE;
 #endif
+	if (do_complete)
+		complete(&bus->cmd_complete);
 }
 
 static u8 npcm_i2c_fifo_usage(struct npcm_i2c *bus)
diff --git a/drivers/i2c/muxes/i2c-demux-pinctrl.c b/drivers/i2c/muxes/i2c-demux-pinctrl.c
index f7a7405d4350..8e8688e8de0f 100644
--- a/drivers/i2c/muxes/i2c-demux-pinctrl.c
+++ b/drivers/i2c/muxes/i2c-demux-pinctrl.c
@@ -243,6 +243,10 @@ static int i2c_demux_pinctrl_probe(struct platform_device *pdev)
 
 		props[i].name = devm_kstrdup(&pdev->dev, "status", GFP_KERNEL);
 		props[i].value = devm_kstrdup(&pdev->dev, "ok", GFP_KERNEL);
+		if (!props[i].name || !props[i].value) {
+			err = -ENOMEM;
+			goto err_rollback;
+		}
 		props[i].length = 3;
 
 		of_changeset_init(&priv->chan[i].chgset);
diff --git a/drivers/i2c/muxes/i2c-mux-gpio.c b/drivers/i2c/muxes/i2c-mux-gpio.c
index bac415a52b78..8bad785dce36 100644
--- a/drivers/i2c/muxes/i2c-mux-gpio.c
+++ b/drivers/i2c/muxes/i2c-mux-gpio.c
@@ -49,45 +49,6 @@ static int i2c_mux_gpio_deselect(struct i2c_mux_core *muxc, u32 chan)
 	return 0;
 }
 
-#ifdef CONFIG_ACPI
-
-static int i2c_mux_gpio_get_acpi_adr(struct device *dev,
-				     struct fwnode_handle *fwdev,
-				     unsigned int *adr)
-
-{
-	unsigned long long adr64;
-	acpi_status status;
-
-	status = acpi_evaluate_integer(ACPI_HANDLE_FWNODE(fwdev),
-				       METHOD_NAME__ADR,
-				       NULL, &adr64);
-
-	if (!ACPI_SUCCESS(status)) {
-		dev_err(dev, "Cannot get address\n");
-		return -EINVAL;
-	}
-
-	*adr = adr64;
-	if (*adr != adr64) {
-		dev_err(dev, "Address out of range\n");
-		return -ERANGE;
-	}
-
-	return 0;
-}
-
-#else
-
-static int i2c_mux_gpio_get_acpi_adr(struct device *dev,
-				     struct fwnode_handle *fwdev,
-				     unsigned int *adr)
-{
-	return -EINVAL;
-}
-
-#endif
-
 static int i2c_mux_gpio_probe_fw(struct gpiomux *mux,
 				 struct platform_device *pdev)
 {
@@ -141,9 +102,11 @@ static int i2c_mux_gpio_probe_fw(struct gpiomux *mux,
 			fwnode_property_read_u32(child, "reg", values + i);
 
 		} else if (is_acpi_node(child)) {
-			rc = i2c_mux_gpio_get_acpi_adr(dev, child, values + i);
-			if (rc)
-				return rc;
+			rc = acpi_get_local_address(ACPI_HANDLE_FWNODE(child), values + i);
+			if (rc) {
+				fwnode_handle_put(child);
+				return dev_err_probe(dev, rc, "Cannot get address\n");
+			}
 		}
 
 		i++;
diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
new file mode 100644
index 000000000000..a0d8528685fe
--- /dev/null
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -0,0 +1,1657 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _I8042_ACPIPNPIO_H
+#define _I8042_ACPIPNPIO_H
+
+
+#ifdef CONFIG_X86
+#include <asm/x86_init.h>
+#endif
+
+/*
+ * Names.
+ */
+
+#define I8042_KBD_PHYS_DESC "isa0060/serio0"
+#define I8042_AUX_PHYS_DESC "isa0060/serio1"
+#define I8042_MUX_PHYS_DESC "isa0060/serio%d"
+
+/*
+ * IRQs.
+ */
+
+#if defined(__ia64__)
+# define I8042_MAP_IRQ(x)	isa_irq_to_vector((x))
+#else
+# define I8042_MAP_IRQ(x)	(x)
+#endif
+
+#define I8042_KBD_IRQ	i8042_kbd_irq
+#define I8042_AUX_IRQ	i8042_aux_irq
+
+static int i8042_kbd_irq;
+static int i8042_aux_irq;
+
+/*
+ * Register numbers.
+ */
+
+#define I8042_COMMAND_REG	i8042_command_reg
+#define I8042_STATUS_REG	i8042_command_reg
+#define I8042_DATA_REG		i8042_data_reg
+
+static int i8042_command_reg = 0x64;
+static int i8042_data_reg = 0x60;
+
+
+static inline int i8042_read_data(void)
+{
+	return inb(I8042_DATA_REG);
+}
+
+static inline int i8042_read_status(void)
+{
+	return inb(I8042_STATUS_REG);
+}
+
+static inline void i8042_write_data(int val)
+{
+	outb(val, I8042_DATA_REG);
+}
+
+static inline void i8042_write_command(int val)
+{
+	outb(val, I8042_COMMAND_REG);
+}
+
+#ifdef CONFIG_X86
+
+#include <linux/dmi.h>
+
+#define SERIO_QUIRK_NOKBD		BIT(0)
+#define SERIO_QUIRK_NOAUX		BIT(1)
+#define SERIO_QUIRK_NOMUX		BIT(2)
+#define SERIO_QUIRK_FORCEMUX		BIT(3)
+#define SERIO_QUIRK_UNLOCK		BIT(4)
+#define SERIO_QUIRK_PROBE_DEFER		BIT(5)
+#define SERIO_QUIRK_RESET_ALWAYS	BIT(6)
+#define SERIO_QUIRK_RESET_NEVER		BIT(7)
+#define SERIO_QUIRK_DIECT		BIT(8)
+#define SERIO_QUIRK_DUMBKBD		BIT(9)
+#define SERIO_QUIRK_NOLOOP		BIT(10)
+#define SERIO_QUIRK_NOTIMEOUT		BIT(11)
+#define SERIO_QUIRK_KBDRESET		BIT(12)
+#define SERIO_QUIRK_DRITEK		BIT(13)
+#define SERIO_QUIRK_NOPNP		BIT(14)
+
+/* Quirk table for different mainboards. Options similar or identical to i8042
+ * module parameters.
+ * ORDERING IS IMPORTANT! The first match will be apllied and the rest ignored.
+ * This allows entries to overwrite vendor wide quirks on a per device basis.
+ * Where this is irrelevant, entries are sorted case sensitive by DMI_SYS_VENDOR
+ * and/or DMI_BOARD_VENDOR to make it easier to avoid dublicate entries.
+ */
+static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ALIENWARE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Sentia"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X750LN"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		/* Asus X450LCP */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X450LCP"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_NEVER)
+	},
+	{
+		/* ASUS ZenBook UX425UA/QA */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ZenBook UX425"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_PROBE_DEFER | SERIO_QUIRK_RESET_NEVER)
+	},
+	{
+		/* ASUS ZenBook UM325UA/QA */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ZenBook UX325"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_PROBE_DEFER | SERIO_QUIRK_RESET_NEVER)
+	},
+	/*
+	 * On some Asus laptops, just running self tests cause problems.
+	 */
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_NEVER)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_CHASSIS_TYPE, "31"), /* Convertible Notebook */
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_NEVER)
+	},
+	{
+		/* ASUS P65UP5 - AUX LOOP command does not raise AUX IRQ */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "P/I-P65UP5"),
+			DMI_MATCH(DMI_BOARD_VERSION, "REV 2.X"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		/* ASUS G1S */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer Inc."),
+			DMI_MATCH(DMI_BOARD_NAME, "G1S"),
+			DMI_MATCH(DMI_BOARD_VERSION, "1.0"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 1360"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Acer Aspire 5710 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5710"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Acer Aspire 7738 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 7738"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Acer Aspire 5536 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5536"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "0100"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/*
+		 * Acer Aspire 5738z
+		 * Touchpad stops working in mux mode when dis- + re-enabled
+		 * with the touchpad enable/disable toggle hotkey
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5738"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Acer Aspire One 150 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "AOA150"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A114-31"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A314-31"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A315-31"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire ES1-132"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire ES1-332"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire ES1-432"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate Spin B118-RN"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	/*
+	 * Some Wistron based laptops need us to explicitly enable the 'Dritek
+	 * keyboard extension' to make their extra keys start generating scancodes.
+	 * Originally, this was just confined to older laptops, but a few Acer laptops
+	 * have turned up in 2007 that also need this again.
+	 */
+	{
+		/* Acer Aspire 5100 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5100"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
+	},
+	{
+		/* Acer Aspire 5610 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5610"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
+	},
+	{
+		/* Acer Aspire 5630 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5630"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
+	},
+	{
+		/* Acer Aspire 5650 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5650"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
+	},
+	{
+		/* Acer Aspire 5680 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5680"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
+	},
+	{
+		/* Acer Aspire 5720 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5720"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
+	},
+	{
+		/* Acer Aspire 9110 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 9110"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
+	},
+	{
+		/* Acer TravelMate 660 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 660"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
+	},
+	{
+		/* Acer TravelMate 2490 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 2490"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
+	},
+	{
+		/* Acer TravelMate 4280 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 4280"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
+	},
+	{
+		/* Amoi M636/A737 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Amoi Electronics CO.,LTD."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "M636/A737 platform"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ByteSpeed LLC"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ByteSpeed Laptop C15B"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		/* Compal HEL80I */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "COMPAL"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HEL80I"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ProLiant"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "8500"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ProLiant"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "DL760"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		/* Advent 4211 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "DIXONSXP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Advent 4211"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		/* Dell Embedded Box PC 3000 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Embedded Box PC 3000"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		/* Dell XPS M1530 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "XPS M1530"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Dell Vostro 1510 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro1510"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Dell Vostro V13 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro V13"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_NOTIMEOUT)
+	},
+	{
+		/* Dell Vostro 1320 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 1320"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		/* Dell Vostro 1520 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 1520"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		/* Dell Vostro 1720 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 1720"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		/* Entroware Proteus */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Entroware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Proteus"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "EL07R4"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS)
+	},
+	/*
+	 * Some Fujitsu notebooks are having trouble with touchpads if
+	 * active multiplexing mode is activated. Luckily they don't have
+	 * external PS/2 ports so we can safely disable it.
+	 * ... apparently some Toshibas don't like MUX mode either and
+	 * die horrible death on reboot.
+	 */
+	{
+		/* Fujitsu Lifebook P7010/P7010D */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "P7010"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Fujitsu Lifebook P5020D */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook P Series"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Fujitsu Lifebook S2000 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook S Series"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Fujitsu Lifebook S6230 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook S6230"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Fujitsu Lifebook T725 laptop */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK T725"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_NOTIMEOUT)
+	},
+	{
+		/* Fujitsu Lifebook U745 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK U745"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Fujitsu T70H */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "FMVLT70H"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Fujitsu A544 laptop */
+		/* https://bugzilla.redhat.com/show_bug.cgi?id=1111138 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK A544"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOTIMEOUT)
+	},
+	{
+		/* Fujitsu AH544 laptop */
+		/* https://bugzilla.kernel.org/show_bug.cgi?id=69731 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK AH544"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOTIMEOUT)
+	},
+	{
+		/* Fujitsu U574 laptop */
+		/* https://bugzilla.kernel.org/show_bug.cgi?id=69731 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK U574"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOTIMEOUT)
+	},
+	{
+		/* Fujitsu UH554 laptop */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK UH544"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOTIMEOUT)
+	},
+	{
+		/* Fujitsu Lifebook P7010 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "0000000000"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Fujitsu-Siemens Lifebook T3010 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK T3010"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Fujitsu-Siemens Lifebook E4010 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E4010"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Fujitsu-Siemens Amilo Pro 2010 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Pro V2010"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Fujitsu-Siemens Amilo Pro 2030 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "AMILO PRO V2030"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Fujitsu Lifebook A574/H */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "FMVA0501PZ"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Gigabyte M912 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "M912"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "01"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		/* Gigabyte Spring Peak - defines wrong chassis type */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Spring Peak"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		/* Gigabyte T1005 - defines wrong chassis type ("Other") */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "T1005"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		/* Gigabyte T1005M/P - defines wrong chassis type ("Other") */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "T1005M/P"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	/*
+	 * Some laptops need keyboard reset before probing for the trackpad to get
+	 * it detected, initialised & finally work.
+	 */
+	{
+		/* Gigabyte P35 v2 - Elantech touchpad */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "P35V2"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_KBDRESET)
+	},
+		{
+		/* Aorus branded Gigabyte X3 Plus - Elantech touchpad */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "X3"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_KBDRESET)
+	},
+	{
+		/* Gigabyte P34 - Elantech touchpad */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "P34"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_KBDRESET)
+	},
+	{
+		/* Gigabyte P57 - Elantech touchpad */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "P57"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_KBDRESET)
+	},
+	{
+		/* Gericom Bellagio */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Gericom"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "N34AS6"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Gigabyte M1022M netbook */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co.,Ltd."),
+			DMI_MATCH(DMI_BOARD_NAME, "M1022E"),
+			DMI_MATCH(DMI_BOARD_VERSION, "1.02"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dv9700"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Rev 1"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		/*
+		 * HP Pavilion DV4017EA -
+		 * errors on MUX ports are reported without raising AUXDATA
+		 * causing "spurious NAK" messages.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Pavilion dv4000 (EA032EA#ABF)"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/*
+		 * HP Pavilion ZT1000 -
+		 * like DV4017EA does not raise AUXERR for errors on MUX ports.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion Notebook PC"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "HP Pavilion Notebook ZT1000"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/*
+		 * HP Pavilion DV4270ca -
+		 * like DV4017EA does not raise AUXERR for errors on MUX ports.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Pavilion dv4000 (EH476UA#ABL)"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Newer HP Pavilion dv4 models */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dv4 Notebook PC"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_NOTIMEOUT)
+	},
+	{
+		/* IBM 2656 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "IBM"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "2656"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Avatar AVIU-145A6 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "IC4I"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Intel MBO Desktop D845PESV */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "D845PESV"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOPNP)
+	},
+	{
+		/*
+		 * Intel NUC D54250WYK - does not have i8042 controller but
+		 * declares PS/2 devices in DSDT.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "D54250WYK"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOPNP)
+	},
+	{
+		/* Lenovo 3000 n100 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "076804U"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Lenovo XiaoXin Air 12 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "80UN"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Lenovo LaVie Z */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo LaVie Z"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Lenovo Ideapad U455 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "20046"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		/* Lenovo ThinkPad L460 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L460"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		/* Lenovo ThinkPad Twist S230u */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "33474HU"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		/* LG Electronics X110 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LG Electronics Inc."),
+			DMI_MATCH(DMI_BOARD_NAME, "X110"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		/* Medion Akoya Mini E1210 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "E1210"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		/* Medion Akoya E1222 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "E122X"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	{
+		/* MSI Wind U-100 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "MICRO-STAR INTERNATIONAL CO., LTD"),
+			DMI_MATCH(DMI_BOARD_NAME, "U-100"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS | SERIO_QUIRK_NOPNP)
+	},
+	{
+		/*
+		 * No data is coming from the touchscreen unless KBC
+		 * is in legacy mode.
+		 */
+		/* Panasonic CF-29 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Matsushita"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "CF-29"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Medion Akoya E7225 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Medion"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Akoya E7225"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "1.0"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		/* Microsoft Virtual Machine */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Virtual Machine"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "VS2005R2"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		/* Medion MAM 2070 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "MAM 2070"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "5a"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		/* TUXEDO BU1406 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "N24_25BU"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* OQO Model 01 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "OQO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ZEPTO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "00"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "PEGATRON CORPORATION"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "C15B"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		/* Acer Aspire 5 A515 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "PK"),
+			DMI_MATCH(DMI_BOARD_NAME, "Grumpy_PK"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOPNP)
+	},
+	{
+		/* ULI EV4873 - AUX LOOP does not work properly */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ULI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "EV4873"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "5a"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		/*
+		 * Arima-Rioworks HDAMB -
+		 * AUX LOOP command does not raise AUX IRQ
+		 */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "RIOWORKS"),
+			DMI_MATCH(DMI_BOARD_NAME, "HDAMB"),
+			DMI_MATCH(DMI_BOARD_VERSION, "Rev E"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	{
+		/* Sharp Actius MM20 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "SHARP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "PC-MM20 Series"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/*
+		 * Sony Vaio FZ-240E -
+		 * reset and GET ID commands issued via KBD port are
+		 * sometimes being delivered to AUX3.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FZ240E"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/*
+		 * Most (all?) VAIOs do not have external PS/2 ports nor
+		 * they implement active multiplexing properly, and
+		 * MUX discovery usually messes up keyboard/touchpad.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+			DMI_MATCH(DMI_BOARD_NAME, "VAIO"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/* Sony Vaio FS-115b */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FS115B"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		/*
+		 * Sony Vaio VGN-CS series require MUX or the touch sensor
+		 * buttons will disturb touchpad operation
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-CS"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_FORCEMUX)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Satellite P10"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "EQUIUM A110"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "SATELLITE C850D"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
+	/*
+	 * A lot of modern Clevo barebones have touchpad and/or keyboard issues
+	 * after suspend fixable with nomux + reset + noloop + nopnp. Luckily,
+	 * none of them have an external PS/2 port so this can safely be set for
+	 * all of them. These two are based on a Clevo design, but have the
+	 * board_name changed.
+	 */
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
+			DMI_MATCH(DMI_BOARD_NAME, "AURA1501"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
+			DMI_MATCH(DMI_BOARD_NAME, "EDUBOOK1502"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		/* Mivvy M310 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "VIOOO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "N10"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
+	/*
+	 * Some laptops need keyboard reset before probing for the trackpad to get
+	 * it detected, initialised & finally work.
+	 */
+	{
+		/* Schenker XMG C504 - Elantech touchpad */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "XMG"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "C504"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_KBDRESET)
+	},
+	{
+		/* Blue FB5601 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "blue"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "FB5601"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "M606"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
+	},
+	/*
+	 * A lot of modern Clevo barebones have touchpad and/or keyboard issues
+	 * after suspend fixable with nomux + reset + noloop + nopnp. Luckily,
+	 * none of them have an external PS/2 port so this can safely be set for
+	 * all of them.
+	 * Clevo barebones come with board_vendor and/or system_vendor set to
+	 * either the very generic string "Notebook" and/or a different value
+	 * for each individual reseller. The only somewhat universal way to
+	 * identify them is by board_name.
+	 */
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	/*
+	 * At least one modern Clevo barebone has the touchpad connected both
+	 * via PS/2 and i2c interface. This causes a race condition between the
+	 * psmouse and i2c-hid driver. Since the full capability of the touchpad
+	 * is available via the i2c interface and the device has no external
+	 * PS/2 port, it is safe to just ignore all ps2 mouses here to avoid
+	 * this issue. The known affected device is the
+	 * TUXEDO InfinityBook S17 Gen6 / Clevo NS70MU which comes with one of
+	 * the two different dmi strings below. NS50MU is not a typo!
+	 */
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOAUX | SERIO_QUIRK_NOMUX |
+					SERIO_QUIRK_RESET_ALWAYS | SERIO_QUIRK_NOLOOP |
+					SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOAUX | SERIO_QUIRK_NOMUX |
+					SERIO_QUIRK_RESET_ALWAYS | SERIO_QUIRK_NOLOOP |
+					SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		/*
+		 * This is only a partial board_name and might be followed by
+		 * another letter or number. DMI_MATCH however does do partial
+		 * matching.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "P65xH"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		/* Clevo P650RS, 650RP6, Sager NP8152-S, and others */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "P65xRP"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		/*
+		 * This is only a partial board_name and might be followed by
+		 * another letter or number. DMI_MATCH however does do partial
+		 * matching.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "P65_P67H"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		/*
+		 * This is only a partial board_name and might be followed by
+		 * another letter or number. DMI_MATCH however does do partial
+		 * matching.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "P65_67RP"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		/*
+		 * This is only a partial board_name and might be followed by
+		 * another letter or number. DMI_MATCH however does do partial
+		 * matching.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "P65_67RS"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		/*
+		 * This is only a partial board_name and might be followed by
+		 * another letter or number. DMI_MATCH however does do partial
+		 * matching.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "P67xRP"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "PCX0DX"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	/* See comment on TUXEDO InfinityBook S17 Gen6 / Clevo NS70MU above */
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "PD5x_7xPNP_PNR_PNN_PNT"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOAUX)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
+					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
+	},
+	{ }
+};
+
+#ifdef CONFIG_PNP
+static const struct dmi_system_id i8042_dmi_laptop_table[] __initconst = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_CHASSIS_TYPE, "8"), /* Portable */
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_CHASSIS_TYPE, "9"), /* Laptop */
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
+		},
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_CHASSIS_TYPE, "14"), /* Sub-Notebook */
+		},
+	},
+	{ }
+};
+#endif
+
+#endif /* CONFIG_X86 */
+
+#ifdef CONFIG_PNP
+#include <linux/pnp.h>
+
+static bool i8042_pnp_kbd_registered;
+static unsigned int i8042_pnp_kbd_devices;
+static bool i8042_pnp_aux_registered;
+static unsigned int i8042_pnp_aux_devices;
+
+static int i8042_pnp_command_reg;
+static int i8042_pnp_data_reg;
+static int i8042_pnp_kbd_irq;
+static int i8042_pnp_aux_irq;
+
+static char i8042_pnp_kbd_name[32];
+static char i8042_pnp_aux_name[32];
+
+static void i8042_pnp_id_to_string(struct pnp_id *id, char *dst, int dst_size)
+{
+	strlcpy(dst, "PNP:", dst_size);
+
+	while (id) {
+		strlcat(dst, " ", dst_size);
+		strlcat(dst, id->id, dst_size);
+		id = id->next;
+	}
+}
+
+static int i8042_pnp_kbd_probe(struct pnp_dev *dev, const struct pnp_device_id *did)
+{
+	if (pnp_port_valid(dev, 0) && pnp_port_len(dev, 0) == 1)
+		i8042_pnp_data_reg = pnp_port_start(dev,0);
+
+	if (pnp_port_valid(dev, 1) && pnp_port_len(dev, 1) == 1)
+		i8042_pnp_command_reg = pnp_port_start(dev, 1);
+
+	if (pnp_irq_valid(dev,0))
+		i8042_pnp_kbd_irq = pnp_irq(dev, 0);
+
+	strlcpy(i8042_pnp_kbd_name, did->id, sizeof(i8042_pnp_kbd_name));
+	if (strlen(pnp_dev_name(dev))) {
+		strlcat(i8042_pnp_kbd_name, ":", sizeof(i8042_pnp_kbd_name));
+		strlcat(i8042_pnp_kbd_name, pnp_dev_name(dev), sizeof(i8042_pnp_kbd_name));
+	}
+	i8042_pnp_id_to_string(dev->id, i8042_kbd_firmware_id,
+			       sizeof(i8042_kbd_firmware_id));
+	i8042_kbd_fwnode = dev_fwnode(&dev->dev);
+
+	/* Keyboard ports are always supposed to be wakeup-enabled */
+	device_set_wakeup_enable(&dev->dev, true);
+
+	i8042_pnp_kbd_devices++;
+	return 0;
+}
+
+static int i8042_pnp_aux_probe(struct pnp_dev *dev, const struct pnp_device_id *did)
+{
+	if (pnp_port_valid(dev, 0) && pnp_port_len(dev, 0) == 1)
+		i8042_pnp_data_reg = pnp_port_start(dev,0);
+
+	if (pnp_port_valid(dev, 1) && pnp_port_len(dev, 1) == 1)
+		i8042_pnp_command_reg = pnp_port_start(dev, 1);
+
+	if (pnp_irq_valid(dev, 0))
+		i8042_pnp_aux_irq = pnp_irq(dev, 0);
+
+	strlcpy(i8042_pnp_aux_name, did->id, sizeof(i8042_pnp_aux_name));
+	if (strlen(pnp_dev_name(dev))) {
+		strlcat(i8042_pnp_aux_name, ":", sizeof(i8042_pnp_aux_name));
+		strlcat(i8042_pnp_aux_name, pnp_dev_name(dev), sizeof(i8042_pnp_aux_name));
+	}
+	i8042_pnp_id_to_string(dev->id, i8042_aux_firmware_id,
+			       sizeof(i8042_aux_firmware_id));
+
+	i8042_pnp_aux_devices++;
+	return 0;
+}
+
+static const struct pnp_device_id pnp_kbd_devids[] = {
+	{ .id = "PNP0300", .driver_data = 0 },
+	{ .id = "PNP0301", .driver_data = 0 },
+	{ .id = "PNP0302", .driver_data = 0 },
+	{ .id = "PNP0303", .driver_data = 0 },
+	{ .id = "PNP0304", .driver_data = 0 },
+	{ .id = "PNP0305", .driver_data = 0 },
+	{ .id = "PNP0306", .driver_data = 0 },
+	{ .id = "PNP0309", .driver_data = 0 },
+	{ .id = "PNP030a", .driver_data = 0 },
+	{ .id = "PNP030b", .driver_data = 0 },
+	{ .id = "PNP0320", .driver_data = 0 },
+	{ .id = "PNP0343", .driver_data = 0 },
+	{ .id = "PNP0344", .driver_data = 0 },
+	{ .id = "PNP0345", .driver_data = 0 },
+	{ .id = "CPQA0D7", .driver_data = 0 },
+	{ .id = "", },
+};
+MODULE_DEVICE_TABLE(pnp, pnp_kbd_devids);
+
+static struct pnp_driver i8042_pnp_kbd_driver = {
+	.name           = "i8042 kbd",
+	.id_table       = pnp_kbd_devids,
+	.probe          = i8042_pnp_kbd_probe,
+	.driver         = {
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
+		.suppress_bind_attrs = true,
+	},
+};
+
+static const struct pnp_device_id pnp_aux_devids[] = {
+	{ .id = "AUI0200", .driver_data = 0 },
+	{ .id = "FJC6000", .driver_data = 0 },
+	{ .id = "FJC6001", .driver_data = 0 },
+	{ .id = "PNP0f03", .driver_data = 0 },
+	{ .id = "PNP0f0b", .driver_data = 0 },
+	{ .id = "PNP0f0e", .driver_data = 0 },
+	{ .id = "PNP0f12", .driver_data = 0 },
+	{ .id = "PNP0f13", .driver_data = 0 },
+	{ .id = "PNP0f19", .driver_data = 0 },
+	{ .id = "PNP0f1c", .driver_data = 0 },
+	{ .id = "SYN0801", .driver_data = 0 },
+	{ .id = "", },
+};
+MODULE_DEVICE_TABLE(pnp, pnp_aux_devids);
+
+static struct pnp_driver i8042_pnp_aux_driver = {
+	.name           = "i8042 aux",
+	.id_table       = pnp_aux_devids,
+	.probe          = i8042_pnp_aux_probe,
+	.driver         = {
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
+		.suppress_bind_attrs = true,
+	},
+};
+
+static void i8042_pnp_exit(void)
+{
+	if (i8042_pnp_kbd_registered) {
+		i8042_pnp_kbd_registered = false;
+		pnp_unregister_driver(&i8042_pnp_kbd_driver);
+	}
+
+	if (i8042_pnp_aux_registered) {
+		i8042_pnp_aux_registered = false;
+		pnp_unregister_driver(&i8042_pnp_aux_driver);
+	}
+}
+
+static int __init i8042_pnp_init(void)
+{
+	char kbd_irq_str[4] = { 0 }, aux_irq_str[4] = { 0 };
+	bool pnp_data_busted = false;
+	int err;
+
+	if (i8042_nopnp) {
+		pr_info("PNP detection disabled\n");
+		return 0;
+	}
+
+	err = pnp_register_driver(&i8042_pnp_kbd_driver);
+	if (!err)
+		i8042_pnp_kbd_registered = true;
+
+	err = pnp_register_driver(&i8042_pnp_aux_driver);
+	if (!err)
+		i8042_pnp_aux_registered = true;
+
+	if (!i8042_pnp_kbd_devices && !i8042_pnp_aux_devices) {
+		i8042_pnp_exit();
+#if defined(__ia64__)
+		return -ENODEV;
+#else
+		pr_info("PNP: No PS/2 controller found.\n");
+		if (x86_platform.legacy.i8042 !=
+				X86_LEGACY_I8042_EXPECTED_PRESENT)
+			return -ENODEV;
+		pr_info("Probing ports directly.\n");
+		return 0;
+#endif
+	}
+
+	if (i8042_pnp_kbd_devices)
+		snprintf(kbd_irq_str, sizeof(kbd_irq_str),
+			"%d", i8042_pnp_kbd_irq);
+	if (i8042_pnp_aux_devices)
+		snprintf(aux_irq_str, sizeof(aux_irq_str),
+			"%d", i8042_pnp_aux_irq);
+
+	pr_info("PNP: PS/2 Controller [%s%s%s] at %#x,%#x irq %s%s%s\n",
+		i8042_pnp_kbd_name, (i8042_pnp_kbd_devices && i8042_pnp_aux_devices) ? "," : "",
+		i8042_pnp_aux_name,
+		i8042_pnp_data_reg, i8042_pnp_command_reg,
+		kbd_irq_str, (i8042_pnp_kbd_devices && i8042_pnp_aux_devices) ? "," : "",
+		aux_irq_str);
+
+#if defined(__ia64__)
+	if (!i8042_pnp_kbd_devices)
+		i8042_nokbd = true;
+	if (!i8042_pnp_aux_devices)
+		i8042_noaux = true;
+#endif
+
+	if (((i8042_pnp_data_reg & ~0xf) == (i8042_data_reg & ~0xf) &&
+	      i8042_pnp_data_reg != i8042_data_reg) ||
+	    !i8042_pnp_data_reg) {
+		pr_warn("PNP: PS/2 controller has invalid data port %#x; using default %#x\n",
+			i8042_pnp_data_reg, i8042_data_reg);
+		i8042_pnp_data_reg = i8042_data_reg;
+		pnp_data_busted = true;
+	}
+
+	if (((i8042_pnp_command_reg & ~0xf) == (i8042_command_reg & ~0xf) &&
+	      i8042_pnp_command_reg != i8042_command_reg) ||
+	    !i8042_pnp_command_reg) {
+		pr_warn("PNP: PS/2 controller has invalid command port %#x; using default %#x\n",
+			i8042_pnp_command_reg, i8042_command_reg);
+		i8042_pnp_command_reg = i8042_command_reg;
+		pnp_data_busted = true;
+	}
+
+	if (!i8042_nokbd && !i8042_pnp_kbd_irq) {
+		pr_warn("PNP: PS/2 controller doesn't have KBD irq; using default %d\n",
+			i8042_kbd_irq);
+		i8042_pnp_kbd_irq = i8042_kbd_irq;
+		pnp_data_busted = true;
+	}
+
+	if (!i8042_noaux && !i8042_pnp_aux_irq) {
+		if (!pnp_data_busted && i8042_pnp_kbd_irq) {
+			pr_warn("PNP: PS/2 appears to have AUX port disabled, "
+				"if this is incorrect please boot with i8042.nopnp\n");
+			i8042_noaux = true;
+		} else {
+			pr_warn("PNP: PS/2 controller doesn't have AUX irq; using default %d\n",
+				i8042_aux_irq);
+			i8042_pnp_aux_irq = i8042_aux_irq;
+		}
+	}
+
+	i8042_data_reg = i8042_pnp_data_reg;
+	i8042_command_reg = i8042_pnp_command_reg;
+	i8042_kbd_irq = i8042_pnp_kbd_irq;
+	i8042_aux_irq = i8042_pnp_aux_irq;
+
+#ifdef CONFIG_X86
+	i8042_bypass_aux_irq_test = !pnp_data_busted &&
+				    dmi_check_system(i8042_dmi_laptop_table);
+#endif
+
+	return 0;
+}
+
+#else  /* !CONFIG_PNP */
+static inline int i8042_pnp_init(void) { return 0; }
+static inline void i8042_pnp_exit(void) { }
+#endif /* CONFIG_PNP */
+
+
+#ifdef CONFIG_X86
+static void __init i8042_check_quirks(void)
+{
+	const struct dmi_system_id *device_quirk_info;
+	uintptr_t quirks;
+
+	device_quirk_info = dmi_first_match(i8042_dmi_quirk_table);
+	if (!device_quirk_info)
+		return;
+
+	quirks = (uintptr_t)device_quirk_info->driver_data;
+
+	if (quirks & SERIO_QUIRK_NOKBD)
+		i8042_nokbd = true;
+	if (quirks & SERIO_QUIRK_NOAUX)
+		i8042_noaux = true;
+	if (quirks & SERIO_QUIRK_NOMUX)
+		i8042_nomux = true;
+	if (quirks & SERIO_QUIRK_FORCEMUX)
+		i8042_nomux = false;
+	if (quirks & SERIO_QUIRK_UNLOCK)
+		i8042_unlock = true;
+	if (quirks & SERIO_QUIRK_PROBE_DEFER)
+		i8042_probe_defer = true;
+	/* Honor module parameter when value is not default */
+	if (i8042_reset == I8042_RESET_DEFAULT) {
+		if (quirks & SERIO_QUIRK_RESET_ALWAYS)
+			i8042_reset = I8042_RESET_ALWAYS;
+		if (quirks & SERIO_QUIRK_RESET_NEVER)
+			i8042_reset = I8042_RESET_NEVER;
+	}
+	if (quirks & SERIO_QUIRK_DIECT)
+		i8042_direct = true;
+	if (quirks & SERIO_QUIRK_DUMBKBD)
+		i8042_dumbkbd = true;
+	if (quirks & SERIO_QUIRK_NOLOOP)
+		i8042_noloop = true;
+	if (quirks & SERIO_QUIRK_NOTIMEOUT)
+		i8042_notimeout = true;
+	if (quirks & SERIO_QUIRK_KBDRESET)
+		i8042_kbdreset = true;
+	if (quirks & SERIO_QUIRK_DRITEK)
+		i8042_dritek = true;
+#ifdef CONFIG_PNP
+	if (quirks & SERIO_QUIRK_NOPNP)
+		i8042_nopnp = true;
+#endif
+}
+#else
+static inline void i8042_check_quirks(void) {}
+#endif
+
+static int __init i8042_platform_init(void)
+{
+	int retval;
+
+#ifdef CONFIG_X86
+	u8 a20_on = 0xdf;
+	/* Just return if platform does not have i8042 controller */
+	if (x86_platform.legacy.i8042 == X86_LEGACY_I8042_PLATFORM_ABSENT)
+		return -ENODEV;
+#endif
+
+/*
+ * On ix86 platforms touching the i8042 data register region can do really
+ * bad things. Because of this the region is always reserved on ix86 boxes.
+ *
+ *	if (!request_region(I8042_DATA_REG, 16, "i8042"))
+ *		return -EBUSY;
+ */
+
+	i8042_kbd_irq = I8042_MAP_IRQ(1);
+	i8042_aux_irq = I8042_MAP_IRQ(12);
+
+#if defined(__ia64__)
+	i8042_reset = I8042_RESET_ALWAYS;
+#endif
+
+	i8042_check_quirks();
+
+	retval = i8042_pnp_init();
+	if (retval)
+		return retval;
+
+#ifdef CONFIG_X86
+	/*
+	 * A20 was already enabled during early kernel init. But some buggy
+	 * BIOSes (in MSI Laptops) require A20 to be enabled using 8042 to
+	 * resume from S3. So we do it here and hope that nothing breaks.
+	 */
+	i8042_command(&a20_on, 0x10d1);
+	i8042_command(NULL, 0x00ff);	/* Null command for SMM firmware */
+#endif /* CONFIG_X86 */
+
+	return retval;
+}
+
+static inline void i8042_platform_exit(void)
+{
+	i8042_pnp_exit();
+}
+
+#endif /* _I8042_ACPIPNPIO_H */
diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
deleted file mode 100644
index 339e765bcf5a..000000000000
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ /dev/null
@@ -1,1650 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-#ifndef _I8042_X86IA64IO_H
-#define _I8042_X86IA64IO_H
-
-
-#ifdef CONFIG_X86
-#include <asm/x86_init.h>
-#endif
-
-/*
- * Names.
- */
-
-#define I8042_KBD_PHYS_DESC "isa0060/serio0"
-#define I8042_AUX_PHYS_DESC "isa0060/serio1"
-#define I8042_MUX_PHYS_DESC "isa0060/serio%d"
-
-/*
- * IRQs.
- */
-
-#if defined(__ia64__)
-# define I8042_MAP_IRQ(x)	isa_irq_to_vector((x))
-#else
-# define I8042_MAP_IRQ(x)	(x)
-#endif
-
-#define I8042_KBD_IRQ	i8042_kbd_irq
-#define I8042_AUX_IRQ	i8042_aux_irq
-
-static int i8042_kbd_irq;
-static int i8042_aux_irq;
-
-/*
- * Register numbers.
- */
-
-#define I8042_COMMAND_REG	i8042_command_reg
-#define I8042_STATUS_REG	i8042_command_reg
-#define I8042_DATA_REG		i8042_data_reg
-
-static int i8042_command_reg = 0x64;
-static int i8042_data_reg = 0x60;
-
-
-static inline int i8042_read_data(void)
-{
-	return inb(I8042_DATA_REG);
-}
-
-static inline int i8042_read_status(void)
-{
-	return inb(I8042_STATUS_REG);
-}
-
-static inline void i8042_write_data(int val)
-{
-	outb(val, I8042_DATA_REG);
-}
-
-static inline void i8042_write_command(int val)
-{
-	outb(val, I8042_COMMAND_REG);
-}
-
-#ifdef CONFIG_X86
-
-#include <linux/dmi.h>
-
-#define SERIO_QUIRK_NOKBD		BIT(0)
-#define SERIO_QUIRK_NOAUX		BIT(1)
-#define SERIO_QUIRK_NOMUX		BIT(2)
-#define SERIO_QUIRK_FORCEMUX		BIT(3)
-#define SERIO_QUIRK_UNLOCK		BIT(4)
-#define SERIO_QUIRK_PROBE_DEFER		BIT(5)
-#define SERIO_QUIRK_RESET_ALWAYS	BIT(6)
-#define SERIO_QUIRK_RESET_NEVER		BIT(7)
-#define SERIO_QUIRK_DIECT		BIT(8)
-#define SERIO_QUIRK_DUMBKBD		BIT(9)
-#define SERIO_QUIRK_NOLOOP		BIT(10)
-#define SERIO_QUIRK_NOTIMEOUT		BIT(11)
-#define SERIO_QUIRK_KBDRESET		BIT(12)
-#define SERIO_QUIRK_DRITEK		BIT(13)
-#define SERIO_QUIRK_NOPNP		BIT(14)
-
-/* Quirk table for different mainboards. Options similar or identical to i8042
- * module parameters.
- * ORDERING IS IMPORTANT! The first match will be apllied and the rest ignored.
- * This allows entries to overwrite vendor wide quirks on a per device basis.
- * Where this is irrelevant, entries are sorted case sensitive by DMI_SYS_VENDOR
- * and/or DMI_BOARD_VENDOR to make it easier to avoid dublicate entries.
- */
-static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ALIENWARE"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Sentia"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "X750LN"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		/* Asus X450LCP */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "X450LCP"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_NEVER)
-	},
-	{
-		/* ASUS ZenBook UX425UA/QA */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "ZenBook UX425"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_PROBE_DEFER | SERIO_QUIRK_RESET_NEVER)
-	},
-	{
-		/* ASUS ZenBook UM325UA/QA */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "ZenBook UX325"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_PROBE_DEFER | SERIO_QUIRK_RESET_NEVER)
-	},
-	/*
-	 * On some Asus laptops, just running self tests cause problems.
-	 */
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_NEVER)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-			DMI_MATCH(DMI_CHASSIS_TYPE, "31"), /* Convertible Notebook */
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_NEVER)
-	},
-	{
-		/* ASUS P65UP5 - AUX LOOP command does not raise AUX IRQ */
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer INC."),
-			DMI_MATCH(DMI_BOARD_NAME, "P/I-P65UP5"),
-			DMI_MATCH(DMI_BOARD_VERSION, "REV 2.X"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		/* ASUS G1S */
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK Computer Inc."),
-			DMI_MATCH(DMI_BOARD_NAME, "G1S"),
-			DMI_MATCH(DMI_BOARD_VERSION, "1.0"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 1360"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Acer Aspire 5710 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5710"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Acer Aspire 7738 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 7738"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Acer Aspire 5536 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5536"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "0100"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/*
-		 * Acer Aspire 5738z
-		 * Touchpad stops working in mux mode when dis- + re-enabled
-		 * with the touchpad enable/disable toggle hotkey
-		 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5738"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Acer Aspire One 150 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "AOA150"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A114-31"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A314-31"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire A315-31"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire ES1-132"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire ES1-332"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire ES1-432"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate Spin B118-RN"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	/*
-	 * Some Wistron based laptops need us to explicitly enable the 'Dritek
-	 * keyboard extension' to make their extra keys start generating scancodes.
-	 * Originally, this was just confined to older laptops, but a few Acer laptops
-	 * have turned up in 2007 that also need this again.
-	 */
-	{
-		/* Acer Aspire 5100 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5100"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
-	},
-	{
-		/* Acer Aspire 5610 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5610"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
-	},
-	{
-		/* Acer Aspire 5630 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5630"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
-	},
-	{
-		/* Acer Aspire 5650 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5650"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
-	},
-	{
-		/* Acer Aspire 5680 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5680"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
-	},
-	{
-		/* Acer Aspire 5720 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5720"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
-	},
-	{
-		/* Acer Aspire 9110 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 9110"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
-	},
-	{
-		/* Acer TravelMate 660 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 660"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
-	},
-	{
-		/* Acer TravelMate 2490 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 2490"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
-	},
-	{
-		/* Acer TravelMate 4280 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 4280"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
-	},
-	{
-		/* Amoi M636/A737 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Amoi Electronics CO.,LTD."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "M636/A737 platform"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ByteSpeed LLC"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "ByteSpeed Laptop C15B"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		/* Compal HEL80I */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "COMPAL"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "HEL80I"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "ProLiant"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "8500"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Compaq"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "ProLiant"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "DL760"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		/* Advent 4211 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "DIXONSXP"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Advent 4211"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		/* Dell Embedded Box PC 3000 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Embedded Box PC 3000"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		/* Dell XPS M1530 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "XPS M1530"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Dell Vostro 1510 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro1510"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Dell Vostro V13 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro V13"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_NOTIMEOUT)
-	},
-	{
-		/* Dell Vostro 1320 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 1320"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		/* Dell Vostro 1520 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 1520"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		/* Dell Vostro 1720 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 1720"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		/* Entroware Proteus */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Entroware"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Proteus"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "EL07R4"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS)
-	},
-	/*
-	 * Some Fujitsu notebooks are having trouble with touchpads if
-	 * active multiplexing mode is activated. Luckily they don't have
-	 * external PS/2 ports so we can safely disable it.
-	 * ... apparently some Toshibas don't like MUX mode either and
-	 * die horrible death on reboot.
-	 */
-	{
-		/* Fujitsu Lifebook P7010/P7010D */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "P7010"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Fujitsu Lifebook P5020D */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook P Series"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Fujitsu Lifebook S2000 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook S Series"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Fujitsu Lifebook S6230 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LifeBook S6230"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Fujitsu Lifebook T725 laptop */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK T725"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_NOTIMEOUT)
-	},
-	{
-		/* Fujitsu Lifebook U745 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK U745"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Fujitsu T70H */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "FMVLT70H"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Fujitsu A544 laptop */
-		/* https://bugzilla.redhat.com/show_bug.cgi?id=1111138 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK A544"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOTIMEOUT)
-	},
-	{
-		/* Fujitsu AH544 laptop */
-		/* https://bugzilla.kernel.org/show_bug.cgi?id=69731 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK AH544"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOTIMEOUT)
-	},
-	{
-		/* Fujitsu U574 laptop */
-		/* https://bugzilla.kernel.org/show_bug.cgi?id=69731 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK U574"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOTIMEOUT)
-	},
-	{
-		/* Fujitsu UH554 laptop */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK UH544"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOTIMEOUT)
-	},
-	{
-		/* Fujitsu Lifebook P7010 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "0000000000"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Fujitsu-Siemens Lifebook T3010 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK T3010"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Fujitsu-Siemens Lifebook E4010 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E4010"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Fujitsu-Siemens Amilo Pro 2010 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "AMILO Pro V2010"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Fujitsu-Siemens Amilo Pro 2030 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU SIEMENS"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "AMILO PRO V2030"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Fujitsu Lifebook A574/H */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "FMVA0501PZ"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Gigabyte M912 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "M912"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "01"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		/* Gigabyte Spring Peak - defines wrong chassis type */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Spring Peak"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		/* Gigabyte T1005 - defines wrong chassis type ("Other") */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "T1005"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		/* Gigabyte T1005M/P - defines wrong chassis type ("Other") */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "T1005M/P"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	/*
-	 * Some laptops need keyboard reset before probing for the trackpad to get
-	 * it detected, initialised & finally work.
-	 */
-	{
-		/* Gigabyte P35 v2 - Elantech touchpad */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "P35V2"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_KBDRESET)
-	},
-		{
-		/* Aorus branded Gigabyte X3 Plus - Elantech touchpad */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "X3"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_KBDRESET)
-	},
-	{
-		/* Gigabyte P34 - Elantech touchpad */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "P34"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_KBDRESET)
-	},
-	{
-		/* Gigabyte P57 - Elantech touchpad */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "P57"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_KBDRESET)
-	},
-	{
-		/* Gericom Bellagio */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Gericom"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "N34AS6"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Gigabyte M1022M netbook */
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "Gigabyte Technology Co.,Ltd."),
-			DMI_MATCH(DMI_BOARD_NAME, "M1022E"),
-			DMI_MATCH(DMI_BOARD_VERSION, "1.02"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dv9700"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "Rev 1"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		/*
-		 * HP Pavilion DV4017EA -
-		 * errors on MUX ports are reported without raising AUXDATA
-		 * causing "spurious NAK" messages.
-		 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Pavilion dv4000 (EA032EA#ABF)"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/*
-		 * HP Pavilion ZT1000 -
-		 * like DV4017EA does not raise AUXERR for errors on MUX ports.
-		 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion Notebook PC"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "HP Pavilion Notebook ZT1000"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/*
-		 * HP Pavilion DV4270ca -
-		 * like DV4017EA does not raise AUXERR for errors on MUX ports.
-		 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Pavilion dv4000 (EH476UA#ABL)"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Newer HP Pavilion dv4 models */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion dv4 Notebook PC"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_NOTIMEOUT)
-	},
-	{
-		/* IBM 2656 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "IBM"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "2656"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Avatar AVIU-145A6 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Intel"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "IC4I"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Intel MBO Desktop D845PESV */
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
-			DMI_MATCH(DMI_BOARD_NAME, "D845PESV"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOPNP)
-	},
-	{
-		/*
-		 * Intel NUC D54250WYK - does not have i8042 controller but
-		 * declares PS/2 devices in DSDT.
-		 */
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "Intel Corporation"),
-			DMI_MATCH(DMI_BOARD_NAME, "D54250WYK"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOPNP)
-	},
-	{
-		/* Lenovo 3000 n100 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "076804U"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Lenovo XiaoXin Air 12 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "80UN"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Lenovo LaVie Z */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo LaVie Z"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Lenovo Ideapad U455 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "20046"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		/* Lenovo ThinkPad L460 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad L460"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		/* Lenovo ThinkPad Twist S230u */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "33474HU"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		/* LG Electronics X110 */
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "LG Electronics Inc."),
-			DMI_MATCH(DMI_BOARD_NAME, "X110"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		/* Medion Akoya Mini E1210 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "E1210"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		/* Medion Akoya E1222 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "E122X"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	{
-		/* MSI Wind U-100 */
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "MICRO-STAR INTERNATIONAL CO., LTD"),
-			DMI_MATCH(DMI_BOARD_NAME, "U-100"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS | SERIO_QUIRK_NOPNP)
-	},
-	{
-		/*
-		 * No data is coming from the touchscreen unless KBC
-		 * is in legacy mode.
-		 */
-		/* Panasonic CF-29 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Matsushita"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "CF-29"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Medion Akoya E7225 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Medion"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Akoya E7225"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "1.0"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		/* Microsoft Virtual Machine */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Virtual Machine"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "VS2005R2"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		/* Medion MAM 2070 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "MAM 2070"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "5a"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		/* TUXEDO BU1406 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Notebook"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "N24_25BU"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* OQO Model 01 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "OQO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "ZEPTO"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "00"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "PEGATRON CORPORATION"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "C15B"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		/* Acer Aspire 5 A515 */
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "PK"),
-			DMI_MATCH(DMI_BOARD_NAME, "Grumpy_PK"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOPNP)
-	},
-	{
-		/* ULI EV4873 - AUX LOOP does not work properly */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ULI"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "EV4873"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "5a"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		/*
-		 * Arima-Rioworks HDAMB -
-		 * AUX LOOP command does not raise AUX IRQ
-		 */
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "RIOWORKS"),
-			DMI_MATCH(DMI_BOARD_NAME, "HDAMB"),
-			DMI_MATCH(DMI_BOARD_VERSION, "Rev E"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	{
-		/* Sharp Actius MM20 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "SHARP"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "PC-MM20 Series"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/*
-		 * Sony Vaio FZ-240E -
-		 * reset and GET ID commands issued via KBD port are
-		 * sometimes being delivered to AUX3.
-		 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FZ240E"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/*
-		 * Most (all?) VAIOs do not have external PS/2 ports nor
-		 * they implement active multiplexing properly, and
-		 * MUX discovery usually messes up keyboard/touchpad.
-		 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
-			DMI_MATCH(DMI_BOARD_NAME, "VAIO"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/* Sony Vaio FS-115b */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-FS115B"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		/*
-		 * Sony Vaio VGN-CS series require MUX or the touch sensor
-		 * buttons will disturb touchpad operation
-		 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "VGN-CS"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_FORCEMUX)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Satellite P10"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "EQUIUM A110"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "SATELLITE C850D"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
-	},
-	/*
-	 * A lot of modern Clevo barebones have touchpad and/or keyboard issues
-	 * after suspend fixable with nomux + reset + noloop + nopnp. Luckily,
-	 * none of them have an external PS/2 port so this can safely be set for
-	 * all of them. These two are based on a Clevo design, but have the
-	 * board_name changed.
-	 */
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
-			DMI_MATCH(DMI_BOARD_NAME, "AURA1501"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "TUXEDO"),
-			DMI_MATCH(DMI_BOARD_NAME, "EDUBOOK1502"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
-	},
-	{
-		/* Mivvy M310 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "VIOOO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "N10"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
-	},
-	/*
-	 * Some laptops need keyboard reset before probing for the trackpad to get
-	 * it detected, initialised & finally work.
-	 */
-	{
-		/* Schenker XMG C504 - Elantech touchpad */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "XMG"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "C504"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_KBDRESET)
-	},
-	{
-		/* Blue FB5601 */
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "blue"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "FB5601"),
-			DMI_MATCH(DMI_PRODUCT_VERSION, "M606"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOLOOP)
-	},
-	/*
-	 * A lot of modern Clevo barebones have touchpad and/or keyboard issues
-	 * after suspend fixable with nomux + reset + noloop + nopnp. Luckily,
-	 * none of them have an external PS/2 port so this can safely be set for
-	 * all of them.
-	 * Clevo barebones come with board_vendor and/or system_vendor set to
-	 * either the very generic string "Notebook" and/or a different value
-	 * for each individual reseller. The only somewhat universal way to
-	 * identify them is by board_name.
-	 */
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71A"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "LAPQC71B"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "N140CU"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "N141CU"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "NH5xAx"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "NL5xRU"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
-	},
-	/*
-	 * At least one modern Clevo barebone has the touchpad connected both
-	 * via PS/2 and i2c interface. This causes a race condition between the
-	 * psmouse and i2c-hid driver. Since the full capability of the touchpad
-	 * is available via the i2c interface and the device has no external
-	 * PS/2 port, it is safe to just ignore all ps2 mouses here to avoid
-	 * this issue. The known affected device is the
-	 * TUXEDO InfinityBook S17 Gen6 / Clevo NS70MU which comes with one of
-	 * the two different dmi strings below. NS50MU is not a typo!
-	 */
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "NS50MU"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOAUX | SERIO_QUIRK_NOMUX |
-					SERIO_QUIRK_RESET_ALWAYS | SERIO_QUIRK_NOLOOP |
-					SERIO_QUIRK_NOPNP)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "NS50_70MU"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOAUX | SERIO_QUIRK_NOMUX |
-					SERIO_QUIRK_RESET_ALWAYS | SERIO_QUIRK_NOLOOP |
-					SERIO_QUIRK_NOPNP)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "NJ50_70CU"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
-	},
-	{
-		/*
-		 * This is only a partial board_name and might be followed by
-		 * another letter or number. DMI_MATCH however does do partial
-		 * matching.
-		 */
-		.matches = {
-			DMI_MATCH(DMI_PRODUCT_NAME, "P65xH"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
-	},
-	{
-		/* Clevo P650RS, 650RP6, Sager NP8152-S, and others */
-		.matches = {
-			DMI_MATCH(DMI_PRODUCT_NAME, "P65xRP"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
-	},
-	{
-		/*
-		 * This is only a partial board_name and might be followed by
-		 * another letter or number. DMI_MATCH however does do partial
-		 * matching.
-		 */
-		.matches = {
-			DMI_MATCH(DMI_PRODUCT_NAME, "P65_P67H"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
-	},
-	{
-		/*
-		 * This is only a partial board_name and might be followed by
-		 * another letter or number. DMI_MATCH however does do partial
-		 * matching.
-		 */
-		.matches = {
-			DMI_MATCH(DMI_PRODUCT_NAME, "P65_67RP"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
-	},
-	{
-		/*
-		 * This is only a partial board_name and might be followed by
-		 * another letter or number. DMI_MATCH however does do partial
-		 * matching.
-		 */
-		.matches = {
-			DMI_MATCH(DMI_PRODUCT_NAME, "P65_67RS"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
-	},
-	{
-		/*
-		 * This is only a partial board_name and might be followed by
-		 * another letter or number. DMI_MATCH however does do partial
-		 * matching.
-		 */
-		.matches = {
-			DMI_MATCH(DMI_PRODUCT_NAME, "P67xRP"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "PB50_70DFx,DDx"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "PCX0DX"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "X170SM"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_BOARD_NAME, "X170KM-G"),
-		},
-		.driver_data = (void *)(SERIO_QUIRK_NOMUX | SERIO_QUIRK_RESET_ALWAYS |
-					SERIO_QUIRK_NOLOOP | SERIO_QUIRK_NOPNP)
-	},
-	{ }
-};
-
-#ifdef CONFIG_PNP
-static const struct dmi_system_id i8042_dmi_laptop_table[] __initconst = {
-	{
-		.matches = {
-			DMI_MATCH(DMI_CHASSIS_TYPE, "8"), /* Portable */
-		},
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_CHASSIS_TYPE, "9"), /* Laptop */
-		},
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_CHASSIS_TYPE, "10"), /* Notebook */
-		},
-	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_CHASSIS_TYPE, "14"), /* Sub-Notebook */
-		},
-	},
-	{ }
-};
-#endif
-
-#endif /* CONFIG_X86 */
-
-#ifdef CONFIG_PNP
-#include <linux/pnp.h>
-
-static bool i8042_pnp_kbd_registered;
-static unsigned int i8042_pnp_kbd_devices;
-static bool i8042_pnp_aux_registered;
-static unsigned int i8042_pnp_aux_devices;
-
-static int i8042_pnp_command_reg;
-static int i8042_pnp_data_reg;
-static int i8042_pnp_kbd_irq;
-static int i8042_pnp_aux_irq;
-
-static char i8042_pnp_kbd_name[32];
-static char i8042_pnp_aux_name[32];
-
-static void i8042_pnp_id_to_string(struct pnp_id *id, char *dst, int dst_size)
-{
-	strlcpy(dst, "PNP:", dst_size);
-
-	while (id) {
-		strlcat(dst, " ", dst_size);
-		strlcat(dst, id->id, dst_size);
-		id = id->next;
-	}
-}
-
-static int i8042_pnp_kbd_probe(struct pnp_dev *dev, const struct pnp_device_id *did)
-{
-	if (pnp_port_valid(dev, 0) && pnp_port_len(dev, 0) == 1)
-		i8042_pnp_data_reg = pnp_port_start(dev,0);
-
-	if (pnp_port_valid(dev, 1) && pnp_port_len(dev, 1) == 1)
-		i8042_pnp_command_reg = pnp_port_start(dev, 1);
-
-	if (pnp_irq_valid(dev,0))
-		i8042_pnp_kbd_irq = pnp_irq(dev, 0);
-
-	strlcpy(i8042_pnp_kbd_name, did->id, sizeof(i8042_pnp_kbd_name));
-	if (strlen(pnp_dev_name(dev))) {
-		strlcat(i8042_pnp_kbd_name, ":", sizeof(i8042_pnp_kbd_name));
-		strlcat(i8042_pnp_kbd_name, pnp_dev_name(dev), sizeof(i8042_pnp_kbd_name));
-	}
-	i8042_pnp_id_to_string(dev->id, i8042_kbd_firmware_id,
-			       sizeof(i8042_kbd_firmware_id));
-	i8042_kbd_fwnode = dev_fwnode(&dev->dev);
-
-	/* Keyboard ports are always supposed to be wakeup-enabled */
-	device_set_wakeup_enable(&dev->dev, true);
-
-	i8042_pnp_kbd_devices++;
-	return 0;
-}
-
-static int i8042_pnp_aux_probe(struct pnp_dev *dev, const struct pnp_device_id *did)
-{
-	if (pnp_port_valid(dev, 0) && pnp_port_len(dev, 0) == 1)
-		i8042_pnp_data_reg = pnp_port_start(dev,0);
-
-	if (pnp_port_valid(dev, 1) && pnp_port_len(dev, 1) == 1)
-		i8042_pnp_command_reg = pnp_port_start(dev, 1);
-
-	if (pnp_irq_valid(dev, 0))
-		i8042_pnp_aux_irq = pnp_irq(dev, 0);
-
-	strlcpy(i8042_pnp_aux_name, did->id, sizeof(i8042_pnp_aux_name));
-	if (strlen(pnp_dev_name(dev))) {
-		strlcat(i8042_pnp_aux_name, ":", sizeof(i8042_pnp_aux_name));
-		strlcat(i8042_pnp_aux_name, pnp_dev_name(dev), sizeof(i8042_pnp_aux_name));
-	}
-	i8042_pnp_id_to_string(dev->id, i8042_aux_firmware_id,
-			       sizeof(i8042_aux_firmware_id));
-
-	i8042_pnp_aux_devices++;
-	return 0;
-}
-
-static const struct pnp_device_id pnp_kbd_devids[] = {
-	{ .id = "PNP0300", .driver_data = 0 },
-	{ .id = "PNP0301", .driver_data = 0 },
-	{ .id = "PNP0302", .driver_data = 0 },
-	{ .id = "PNP0303", .driver_data = 0 },
-	{ .id = "PNP0304", .driver_data = 0 },
-	{ .id = "PNP0305", .driver_data = 0 },
-	{ .id = "PNP0306", .driver_data = 0 },
-	{ .id = "PNP0309", .driver_data = 0 },
-	{ .id = "PNP030a", .driver_data = 0 },
-	{ .id = "PNP030b", .driver_data = 0 },
-	{ .id = "PNP0320", .driver_data = 0 },
-	{ .id = "PNP0343", .driver_data = 0 },
-	{ .id = "PNP0344", .driver_data = 0 },
-	{ .id = "PNP0345", .driver_data = 0 },
-	{ .id = "CPQA0D7", .driver_data = 0 },
-	{ .id = "", },
-};
-MODULE_DEVICE_TABLE(pnp, pnp_kbd_devids);
-
-static struct pnp_driver i8042_pnp_kbd_driver = {
-	.name           = "i8042 kbd",
-	.id_table       = pnp_kbd_devids,
-	.probe          = i8042_pnp_kbd_probe,
-	.driver         = {
-		.probe_type = PROBE_FORCE_SYNCHRONOUS,
-		.suppress_bind_attrs = true,
-	},
-};
-
-static const struct pnp_device_id pnp_aux_devids[] = {
-	{ .id = "AUI0200", .driver_data = 0 },
-	{ .id = "FJC6000", .driver_data = 0 },
-	{ .id = "FJC6001", .driver_data = 0 },
-	{ .id = "PNP0f03", .driver_data = 0 },
-	{ .id = "PNP0f0b", .driver_data = 0 },
-	{ .id = "PNP0f0e", .driver_data = 0 },
-	{ .id = "PNP0f12", .driver_data = 0 },
-	{ .id = "PNP0f13", .driver_data = 0 },
-	{ .id = "PNP0f19", .driver_data = 0 },
-	{ .id = "PNP0f1c", .driver_data = 0 },
-	{ .id = "SYN0801", .driver_data = 0 },
-	{ .id = "", },
-};
-MODULE_DEVICE_TABLE(pnp, pnp_aux_devids);
-
-static struct pnp_driver i8042_pnp_aux_driver = {
-	.name           = "i8042 aux",
-	.id_table       = pnp_aux_devids,
-	.probe          = i8042_pnp_aux_probe,
-	.driver         = {
-		.probe_type = PROBE_FORCE_SYNCHRONOUS,
-		.suppress_bind_attrs = true,
-	},
-};
-
-static void i8042_pnp_exit(void)
-{
-	if (i8042_pnp_kbd_registered) {
-		i8042_pnp_kbd_registered = false;
-		pnp_unregister_driver(&i8042_pnp_kbd_driver);
-	}
-
-	if (i8042_pnp_aux_registered) {
-		i8042_pnp_aux_registered = false;
-		pnp_unregister_driver(&i8042_pnp_aux_driver);
-	}
-}
-
-static int __init i8042_pnp_init(void)
-{
-	char kbd_irq_str[4] = { 0 }, aux_irq_str[4] = { 0 };
-	bool pnp_data_busted = false;
-	int err;
-
-	if (i8042_nopnp) {
-		pr_info("PNP detection disabled\n");
-		return 0;
-	}
-
-	err = pnp_register_driver(&i8042_pnp_kbd_driver);
-	if (!err)
-		i8042_pnp_kbd_registered = true;
-
-	err = pnp_register_driver(&i8042_pnp_aux_driver);
-	if (!err)
-		i8042_pnp_aux_registered = true;
-
-	if (!i8042_pnp_kbd_devices && !i8042_pnp_aux_devices) {
-		i8042_pnp_exit();
-#if defined(__ia64__)
-		return -ENODEV;
-#else
-		pr_info("PNP: No PS/2 controller found.\n");
-		if (x86_platform.legacy.i8042 !=
-				X86_LEGACY_I8042_EXPECTED_PRESENT)
-			return -ENODEV;
-		pr_info("Probing ports directly.\n");
-		return 0;
-#endif
-	}
-
-	if (i8042_pnp_kbd_devices)
-		snprintf(kbd_irq_str, sizeof(kbd_irq_str),
-			"%d", i8042_pnp_kbd_irq);
-	if (i8042_pnp_aux_devices)
-		snprintf(aux_irq_str, sizeof(aux_irq_str),
-			"%d", i8042_pnp_aux_irq);
-
-	pr_info("PNP: PS/2 Controller [%s%s%s] at %#x,%#x irq %s%s%s\n",
-		i8042_pnp_kbd_name, (i8042_pnp_kbd_devices && i8042_pnp_aux_devices) ? "," : "",
-		i8042_pnp_aux_name,
-		i8042_pnp_data_reg, i8042_pnp_command_reg,
-		kbd_irq_str, (i8042_pnp_kbd_devices && i8042_pnp_aux_devices) ? "," : "",
-		aux_irq_str);
-
-#if defined(__ia64__)
-	if (!i8042_pnp_kbd_devices)
-		i8042_nokbd = true;
-	if (!i8042_pnp_aux_devices)
-		i8042_noaux = true;
-#endif
-
-	if (((i8042_pnp_data_reg & ~0xf) == (i8042_data_reg & ~0xf) &&
-	      i8042_pnp_data_reg != i8042_data_reg) ||
-	    !i8042_pnp_data_reg) {
-		pr_warn("PNP: PS/2 controller has invalid data port %#x; using default %#x\n",
-			i8042_pnp_data_reg, i8042_data_reg);
-		i8042_pnp_data_reg = i8042_data_reg;
-		pnp_data_busted = true;
-	}
-
-	if (((i8042_pnp_command_reg & ~0xf) == (i8042_command_reg & ~0xf) &&
-	      i8042_pnp_command_reg != i8042_command_reg) ||
-	    !i8042_pnp_command_reg) {
-		pr_warn("PNP: PS/2 controller has invalid command port %#x; using default %#x\n",
-			i8042_pnp_command_reg, i8042_command_reg);
-		i8042_pnp_command_reg = i8042_command_reg;
-		pnp_data_busted = true;
-	}
-
-	if (!i8042_nokbd && !i8042_pnp_kbd_irq) {
-		pr_warn("PNP: PS/2 controller doesn't have KBD irq; using default %d\n",
-			i8042_kbd_irq);
-		i8042_pnp_kbd_irq = i8042_kbd_irq;
-		pnp_data_busted = true;
-	}
-
-	if (!i8042_noaux && !i8042_pnp_aux_irq) {
-		if (!pnp_data_busted && i8042_pnp_kbd_irq) {
-			pr_warn("PNP: PS/2 appears to have AUX port disabled, "
-				"if this is incorrect please boot with i8042.nopnp\n");
-			i8042_noaux = true;
-		} else {
-			pr_warn("PNP: PS/2 controller doesn't have AUX irq; using default %d\n",
-				i8042_aux_irq);
-			i8042_pnp_aux_irq = i8042_aux_irq;
-		}
-	}
-
-	i8042_data_reg = i8042_pnp_data_reg;
-	i8042_command_reg = i8042_pnp_command_reg;
-	i8042_kbd_irq = i8042_pnp_kbd_irq;
-	i8042_aux_irq = i8042_pnp_aux_irq;
-
-#ifdef CONFIG_X86
-	i8042_bypass_aux_irq_test = !pnp_data_busted &&
-				    dmi_check_system(i8042_dmi_laptop_table);
-#endif
-
-	return 0;
-}
-
-#else  /* !CONFIG_PNP */
-static inline int i8042_pnp_init(void) { return 0; }
-static inline void i8042_pnp_exit(void) { }
-#endif /* CONFIG_PNP */
-
-
-#ifdef CONFIG_X86
-static void __init i8042_check_quirks(void)
-{
-	const struct dmi_system_id *device_quirk_info;
-	uintptr_t quirks;
-
-	device_quirk_info = dmi_first_match(i8042_dmi_quirk_table);
-	if (!device_quirk_info)
-		return;
-
-	quirks = (uintptr_t)device_quirk_info->driver_data;
-
-	if (quirks & SERIO_QUIRK_NOKBD)
-		i8042_nokbd = true;
-	if (quirks & SERIO_QUIRK_NOAUX)
-		i8042_noaux = true;
-	if (quirks & SERIO_QUIRK_NOMUX)
-		i8042_nomux = true;
-	if (quirks & SERIO_QUIRK_FORCEMUX)
-		i8042_nomux = false;
-	if (quirks & SERIO_QUIRK_UNLOCK)
-		i8042_unlock = true;
-	if (quirks & SERIO_QUIRK_PROBE_DEFER)
-		i8042_probe_defer = true;
-	/* Honor module parameter when value is not default */
-	if (i8042_reset == I8042_RESET_DEFAULT) {
-		if (quirks & SERIO_QUIRK_RESET_ALWAYS)
-			i8042_reset = I8042_RESET_ALWAYS;
-		if (quirks & SERIO_QUIRK_RESET_NEVER)
-			i8042_reset = I8042_RESET_NEVER;
-	}
-	if (quirks & SERIO_QUIRK_DIECT)
-		i8042_direct = true;
-	if (quirks & SERIO_QUIRK_DUMBKBD)
-		i8042_dumbkbd = true;
-	if (quirks & SERIO_QUIRK_NOLOOP)
-		i8042_noloop = true;
-	if (quirks & SERIO_QUIRK_NOTIMEOUT)
-		i8042_notimeout = true;
-	if (quirks & SERIO_QUIRK_KBDRESET)
-		i8042_kbdreset = true;
-	if (quirks & SERIO_QUIRK_DRITEK)
-		i8042_dritek = true;
-#ifdef CONFIG_PNP
-	if (quirks & SERIO_QUIRK_NOPNP)
-		i8042_nopnp = true;
-#endif
-}
-#else
-static inline void i8042_check_quirks(void) {}
-#endif
-
-static int __init i8042_platform_init(void)
-{
-	int retval;
-
-#ifdef CONFIG_X86
-	u8 a20_on = 0xdf;
-	/* Just return if platform does not have i8042 controller */
-	if (x86_platform.legacy.i8042 == X86_LEGACY_I8042_PLATFORM_ABSENT)
-		return -ENODEV;
-#endif
-
-/*
- * On ix86 platforms touching the i8042 data register region can do really
- * bad things. Because of this the region is always reserved on ix86 boxes.
- *
- *	if (!request_region(I8042_DATA_REG, 16, "i8042"))
- *		return -EBUSY;
- */
-
-	i8042_kbd_irq = I8042_MAP_IRQ(1);
-	i8042_aux_irq = I8042_MAP_IRQ(12);
-
-#if defined(__ia64__)
-	i8042_reset = I8042_RESET_ALWAYS;
-#endif
-
-	i8042_check_quirks();
-
-	retval = i8042_pnp_init();
-	if (retval)
-		return retval;
-
-#ifdef CONFIG_X86
-	/*
-	 * A20 was already enabled during early kernel init. But some buggy
-	 * BIOSes (in MSI Laptops) require A20 to be enabled using 8042 to
-	 * resume from S3. So we do it here and hope that nothing breaks.
-	 */
-	i8042_command(&a20_on, 0x10d1);
-	i8042_command(NULL, 0x00ff);	/* Null command for SMM firmware */
-#endif /* CONFIG_X86 */
-
-	return retval;
-}
-
-static inline void i8042_platform_exit(void)
-{
-	i8042_pnp_exit();
-}
-
-#endif /* _I8042_X86IA64IO_H */
diff --git a/drivers/input/serio/i8042.h b/drivers/input/serio/i8042.h
index 55381783dc82..bf2592fa9a78 100644
--- a/drivers/input/serio/i8042.h
+++ b/drivers/input/serio/i8042.h
@@ -20,7 +20,7 @@
 #elif defined(CONFIG_SPARC)
 #include "i8042-sparcio.h"
 #elif defined(CONFIG_X86) || defined(CONFIG_IA64)
-#include "i8042-x86ia64io.h"
+#include "i8042-acpipnpio.h"
 #else
 #include "i8042-io.h"
 #endif
diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index ab654b33f5d2..b7c41bd7409c 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -13,6 +13,7 @@
 #include <linux/interconnect.h>
 #include <linux/interconnect-provider.h>
 #include <linux/list.h>
+#include <linux/sched/mm.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index e2e80eb2840c..01748742c684 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -186,6 +186,15 @@ static void arm_smmu_free_shared_cd(struct arm_smmu_ctx_desc *cd)
 	}
 }
 
+/*
+ * Cloned from the MAX_TLBI_OPS in arch/arm64/include/asm/tlbflush.h, this
+ * is used as a threshold to replace per-page TLBI commands to issue in the
+ * command queue with an address-space TLBI command, when SMMU w/o a range
+ * invalidation feature handles too many per-page TLBI commands, which will
+ * otherwise result in a soft lockup.
+ */
+#define CMDQ_MAX_TLBI_OPS		(1 << (PAGE_SHIFT - 3))
+
 static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
 					 struct mm_struct *mm,
 					 unsigned long start, unsigned long end)
@@ -200,10 +209,22 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
 	 * range. So do a simple translation here by calculating size correctly.
 	 */
 	size = end - start;
+	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_RANGE_INV)) {
+		if (size >= CMDQ_MAX_TLBI_OPS * PAGE_SIZE)
+			size = 0;
+	}
+
+	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM)) {
+		if (!size)
+			arm_smmu_tlb_inv_asid(smmu_domain->smmu,
+					      smmu_mn->cd->asid);
+		else
+			arm_smmu_tlb_inv_range_asid(start, size,
+						    smmu_mn->cd->asid,
+						    PAGE_SIZE, false,
+						    smmu_domain);
+	}
 
-	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM))
-		arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,
-					    PAGE_SIZE, false, smmu_domain);
 	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, start, size);
 }
 
diff --git a/drivers/media/common/videobuf2/frame_vector.c b/drivers/media/common/videobuf2/frame_vector.c
index 144027035892..07ebe4424df3 100644
--- a/drivers/media/common/videobuf2/frame_vector.c
+++ b/drivers/media/common/videobuf2/frame_vector.c
@@ -30,6 +30,10 @@
  * different type underlying the specified range of virtual addresses.
  * When the function isn't able to map a single page, it returns error.
  *
+ * Note that get_vaddr_frames() cannot follow VM_IO mappings. It used
+ * to be able to do that, but that could (racily) return non-refcounted
+ * pfns.
+ *
  * This function takes care of grabbing mmap_lock as necessary.
  */
 int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
@@ -55,8 +59,6 @@ int get_vaddr_frames(unsigned long start, unsigned int nr_frames,
 	if (likely(ret > 0))
 		return ret;
 
-	/* This used to (racily) return non-refcounted pfns. Let people know */
-	WARN_ONCE(1, "get_vaddr_frames() cannot follow VM_IO mapping");
 	vec->nr_frames = 0;
 	return ret ? ret : -EFAULT;
 }
diff --git a/drivers/misc/cardreader/rts5227.c b/drivers/misc/cardreader/rts5227.c
index 0f106d700625..e4def5fa6902 100644
--- a/drivers/misc/cardreader/rts5227.c
+++ b/drivers/misc/cardreader/rts5227.c
@@ -81,63 +81,20 @@ static void rts5227_fetch_vendor_settings(struct rtsx_pcr *pcr)
 
 static void rts5227_init_from_cfg(struct rtsx_pcr *pcr)
 {
-	struct pci_dev *pdev = pcr->pci;
-	int l1ss;
-	u32 lval;
 	struct rtsx_cr_option *option = &pcr->option;
 
-	l1ss = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
-	if (!l1ss)
-		return;
-
-	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, &lval);
-
 	if (CHK_PCI_PID(pcr, 0x522A)) {
-		if (0 == (lval & 0x0F))
-			rtsx_pci_enable_oobs_polling(pcr);
-		else
+		if (rtsx_check_dev_flag(pcr, ASPM_L1_1_EN | ASPM_L1_2_EN
+				| PM_L1_1_EN | PM_L1_2_EN))
 			rtsx_pci_disable_oobs_polling(pcr);
+		else
+			rtsx_pci_enable_oobs_polling(pcr);
 	}
 
-	if (lval & PCI_L1SS_CTL1_ASPM_L1_1)
-		rtsx_set_dev_flag(pcr, ASPM_L1_1_EN);
-	else
-		rtsx_clear_dev_flag(pcr, ASPM_L1_1_EN);
-
-	if (lval & PCI_L1SS_CTL1_ASPM_L1_2)
-		rtsx_set_dev_flag(pcr, ASPM_L1_2_EN);
-	else
-		rtsx_clear_dev_flag(pcr, ASPM_L1_2_EN);
-
-	if (lval & PCI_L1SS_CTL1_PCIPM_L1_1)
-		rtsx_set_dev_flag(pcr, PM_L1_1_EN);
-	else
-		rtsx_clear_dev_flag(pcr, PM_L1_1_EN);
-
-	if (lval & PCI_L1SS_CTL1_PCIPM_L1_2)
-		rtsx_set_dev_flag(pcr, PM_L1_2_EN);
-	else
-		rtsx_clear_dev_flag(pcr, PM_L1_2_EN);
-
 	if (option->ltr_en) {
-		u16 val;
-
-		pcie_capability_read_word(pcr->pci, PCI_EXP_DEVCTL2, &val);
-		if (val & PCI_EXP_DEVCTL2_LTR_EN) {
-			option->ltr_enabled = true;
-			option->ltr_active = true;
+		if (option->ltr_enabled)
 			rtsx_set_ltr_latency(pcr, option->ltr_active_latency);
-		} else {
-			option->ltr_enabled = false;
-		}
 	}
-
-	if (rtsx_check_dev_flag(pcr, ASPM_L1_1_EN | ASPM_L1_2_EN
-				| PM_L1_1_EN | PM_L1_2_EN))
-		option->force_clkreq_0 = false;
-	else
-		option->force_clkreq_0 = true;
-
 }
 
 static int rts5227_extra_init_hw(struct rtsx_pcr *pcr)
@@ -171,7 +128,7 @@ static int rts5227_extra_init_hw(struct rtsx_pcr *pcr)
 	else
 		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG, 0x30, 0x00);
 
-	if (option->force_clkreq_0 && pcr->aspm_mode == ASPM_MODE_CFG)
+	if (option->force_clkreq_0)
 		rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, PETXCFG,
 				FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_LOW);
 	else
diff --git a/drivers/misc/cardreader/rts5228.c b/drivers/misc/cardreader/rts5228.c
index 282a03520cf5..d80216c69d4f 100644
--- a/drivers/misc/cardreader/rts5228.c
+++ b/drivers/misc/cardreader/rts5228.c
@@ -378,59 +378,25 @@ static void rts5228_process_ocp(struct rtsx_pcr *pcr)
 
 static void rts5228_init_from_cfg(struct rtsx_pcr *pcr)
 {
-	struct pci_dev *pdev = pcr->pci;
-	int l1ss;
-	u32 lval;
 	struct rtsx_cr_option *option = &pcr->option;
 
-	l1ss = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
-	if (!l1ss)
-		return;
-
-	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, &lval);
-
-	if (0 == (lval & 0x0F))
-		rtsx_pci_enable_oobs_polling(pcr);
-	else
+	if (rtsx_check_dev_flag(pcr, ASPM_L1_1_EN | ASPM_L1_2_EN
+				| PM_L1_1_EN | PM_L1_2_EN))
 		rtsx_pci_disable_oobs_polling(pcr);
-
-	if (lval & PCI_L1SS_CTL1_ASPM_L1_1)
-		rtsx_set_dev_flag(pcr, ASPM_L1_1_EN);
-	else
-		rtsx_clear_dev_flag(pcr, ASPM_L1_1_EN);
-
-	if (lval & PCI_L1SS_CTL1_ASPM_L1_2)
-		rtsx_set_dev_flag(pcr, ASPM_L1_2_EN);
-	else
-		rtsx_clear_dev_flag(pcr, ASPM_L1_2_EN);
-
-	if (lval & PCI_L1SS_CTL1_PCIPM_L1_1)
-		rtsx_set_dev_flag(pcr, PM_L1_1_EN);
 	else
-		rtsx_clear_dev_flag(pcr, PM_L1_1_EN);
-
-	if (lval & PCI_L1SS_CTL1_PCIPM_L1_2)
-		rtsx_set_dev_flag(pcr, PM_L1_2_EN);
-	else
-		rtsx_clear_dev_flag(pcr, PM_L1_2_EN);
+		rtsx_pci_enable_oobs_polling(pcr);
 
 	rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, 0xFF, 0);
-	if (option->ltr_en) {
-		u16 val;
 
-		pcie_capability_read_word(pcr->pci, PCI_EXP_DEVCTL2, &val);
-		if (val & PCI_EXP_DEVCTL2_LTR_EN) {
-			option->ltr_enabled = true;
-			option->ltr_active = true;
+	if (option->ltr_en) {
+		if (option->ltr_enabled)
 			rtsx_set_ltr_latency(pcr, option->ltr_active_latency);
-		} else {
-			option->ltr_enabled = false;
-		}
 	}
 }
 
 static int rts5228_extra_init_hw(struct rtsx_pcr *pcr)
 {
+	struct rtsx_cr_option *option = &pcr->option;
 
 	rtsx_pci_write_register(pcr, RTS5228_AUTOLOAD_CFG1,
 			CD_RESUME_EN_MASK, CD_RESUME_EN_MASK);
@@ -461,6 +427,17 @@ static int rts5228_extra_init_hw(struct rtsx_pcr *pcr)
 	else
 		rtsx_pci_write_register(pcr, PETXCFG, 0x30, 0x00);
 
+	/*
+	 * If u_force_clkreq_0 is enabled, CLKREQ# PIN will be forced
+	 * to drive low, and we forcibly request clock.
+	 */
+	if (option->force_clkreq_0)
+		rtsx_pci_write_register(pcr, PETXCFG,
+				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_LOW);
+	else
+		rtsx_pci_write_register(pcr, PETXCFG,
+				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_HIGH);
+
 	rtsx_pci_write_register(pcr, PWD_SUSPEND_EN, 0xFF, 0xFB);
 	rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, 0x10, 0x00);
 	rtsx_pci_write_register(pcr, RTS5228_REG_PME_FORCE_CTL,
diff --git a/drivers/misc/cardreader/rts5249.c b/drivers/misc/cardreader/rts5249.c
index 6b5e4bdf209d..e34613f40499 100644
--- a/drivers/misc/cardreader/rts5249.c
+++ b/drivers/misc/cardreader/rts5249.c
@@ -85,64 +85,22 @@ static void rtsx_base_fetch_vendor_settings(struct rtsx_pcr *pcr)
 
 static void rts5249_init_from_cfg(struct rtsx_pcr *pcr)
 {
-	struct pci_dev *pdev = pcr->pci;
-	int l1ss;
 	struct rtsx_cr_option *option = &(pcr->option);
-	u32 lval;
-
-	l1ss = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
-	if (!l1ss)
-		return;
-
-	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, &lval);
 
 	if (CHK_PCI_PID(pcr, PID_524A) || CHK_PCI_PID(pcr, PID_525A)) {
-		if (0 == (lval & 0x0F))
-			rtsx_pci_enable_oobs_polling(pcr);
-		else
+		if (rtsx_check_dev_flag(pcr, ASPM_L1_1_EN | ASPM_L1_2_EN
+				| PM_L1_1_EN | PM_L1_2_EN))
 			rtsx_pci_disable_oobs_polling(pcr);
+		else
+			rtsx_pci_enable_oobs_polling(pcr);
 	}
 
-
-	if (lval & PCI_L1SS_CTL1_ASPM_L1_1)
-		rtsx_set_dev_flag(pcr, ASPM_L1_1_EN);
-
-	if (lval & PCI_L1SS_CTL1_ASPM_L1_2)
-		rtsx_set_dev_flag(pcr, ASPM_L1_2_EN);
-
-	if (lval & PCI_L1SS_CTL1_PCIPM_L1_1)
-		rtsx_set_dev_flag(pcr, PM_L1_1_EN);
-
-	if (lval & PCI_L1SS_CTL1_PCIPM_L1_2)
-		rtsx_set_dev_flag(pcr, PM_L1_2_EN);
-
 	if (option->ltr_en) {
-		u16 val;
-
-		pcie_capability_read_word(pdev, PCI_EXP_DEVCTL2, &val);
-		if (val & PCI_EXP_DEVCTL2_LTR_EN) {
-			option->ltr_enabled = true;
-			option->ltr_active = true;
+		if (option->ltr_enabled)
 			rtsx_set_ltr_latency(pcr, option->ltr_active_latency);
-		} else {
-			option->ltr_enabled = false;
-		}
 	}
 }
 
-static int rts5249_init_from_hw(struct rtsx_pcr *pcr)
-{
-	struct rtsx_cr_option *option = &(pcr->option);
-
-	if (rtsx_check_dev_flag(pcr, ASPM_L1_1_EN | ASPM_L1_2_EN
-				| PM_L1_1_EN | PM_L1_2_EN))
-		option->force_clkreq_0 = false;
-	else
-		option->force_clkreq_0 = true;
-
-	return 0;
-}
-
 static void rts52xa_save_content_from_efuse(struct rtsx_pcr *pcr)
 {
 	u8 cnt, sv;
@@ -254,7 +212,6 @@ static int rts5249_extra_init_hw(struct rtsx_pcr *pcr)
 	struct rtsx_cr_option *option = &(pcr->option);
 
 	rts5249_init_from_cfg(pcr);
-	rts5249_init_from_hw(pcr);
 
 	rtsx_pci_init_cmd(pcr);
 
@@ -302,11 +259,12 @@ static int rts5249_extra_init_hw(struct rtsx_pcr *pcr)
 		}
 	}
 
+
 	/*
 	 * If u_force_clkreq_0 is enabled, CLKREQ# PIN will be forced
 	 * to drive low, and we forcibly request clock.
 	 */
-	if (option->force_clkreq_0 && pcr->aspm_mode == ASPM_MODE_CFG)
+	if (option->force_clkreq_0)
 		rtsx_pci_write_register(pcr, PETXCFG,
 			FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_LOW);
 	else
diff --git a/drivers/misc/cardreader/rts5260.c b/drivers/misc/cardreader/rts5260.c
index 79b18f6f73a8..d2d3a6ccb8f7 100644
--- a/drivers/misc/cardreader/rts5260.c
+++ b/drivers/misc/cardreader/rts5260.c
@@ -480,47 +480,19 @@ static void rts5260_pwr_saving_setting(struct rtsx_pcr *pcr)
 
 static void rts5260_init_from_cfg(struct rtsx_pcr *pcr)
 {
-	struct pci_dev *pdev = pcr->pci;
-	int l1ss;
 	struct rtsx_cr_option *option = &pcr->option;
-	u32 lval;
-
-	l1ss = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
-	if (!l1ss)
-		return;
-
-	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, &lval);
-
-	if (lval & PCI_L1SS_CTL1_ASPM_L1_1)
-		rtsx_set_dev_flag(pcr, ASPM_L1_1_EN);
-
-	if (lval & PCI_L1SS_CTL1_ASPM_L1_2)
-		rtsx_set_dev_flag(pcr, ASPM_L1_2_EN);
-
-	if (lval & PCI_L1SS_CTL1_PCIPM_L1_1)
-		rtsx_set_dev_flag(pcr, PM_L1_1_EN);
-
-	if (lval & PCI_L1SS_CTL1_PCIPM_L1_2)
-		rtsx_set_dev_flag(pcr, PM_L1_2_EN);
 
 	rts5260_pwr_saving_setting(pcr);
 
 	if (option->ltr_en) {
-		u16 val;
-
-		pcie_capability_read_word(pdev, PCI_EXP_DEVCTL2, &val);
-		if (val & PCI_EXP_DEVCTL2_LTR_EN) {
-			option->ltr_enabled = true;
-			option->ltr_active = true;
+		if (option->ltr_enabled)
 			rtsx_set_ltr_latency(pcr, option->ltr_active_latency);
-		} else {
-			option->ltr_enabled = false;
-		}
 	}
 }
 
 static int rts5260_extra_init_hw(struct rtsx_pcr *pcr)
 {
+	struct rtsx_cr_option *option = &pcr->option;
 
 	/* Set mcu_cnt to 7 to ensure data can be sampled properly */
 	rtsx_pci_write_register(pcr, 0xFC03, 0x7F, 0x07);
@@ -539,6 +511,17 @@ static int rts5260_extra_init_hw(struct rtsx_pcr *pcr)
 
 	rts5260_init_hw(pcr);
 
+	/*
+	 * If u_force_clkreq_0 is enabled, CLKREQ# PIN will be forced
+	 * to drive low, and we forcibly request clock.
+	 */
+	if (option->force_clkreq_0)
+		rtsx_pci_write_register(pcr, PETXCFG,
+				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_LOW);
+	else
+		rtsx_pci_write_register(pcr, PETXCFG,
+				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_HIGH);
+
 	rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, 0x10, 0x00);
 
 	return 0;
diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index 2a97eeb0e509..179b80099558 100644
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -424,54 +424,17 @@ static int rts5261_init_from_hw(struct rtsx_pcr *pcr)
 
 static void rts5261_init_from_cfg(struct rtsx_pcr *pcr)
 {
-	struct pci_dev *pdev = pcr->pci;
-	int l1ss;
-	u32 lval;
 	struct rtsx_cr_option *option = &pcr->option;
 
-	l1ss = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
-	if (!l1ss)
-		return;
-
-	pci_read_config_dword(pdev, l1ss + PCI_L1SS_CTL1, &lval);
-
-	if (lval & PCI_L1SS_CTL1_ASPM_L1_1)
-		rtsx_set_dev_flag(pcr, ASPM_L1_1_EN);
-	else
-		rtsx_clear_dev_flag(pcr, ASPM_L1_1_EN);
-
-	if (lval & PCI_L1SS_CTL1_ASPM_L1_2)
-		rtsx_set_dev_flag(pcr, ASPM_L1_2_EN);
-	else
-		rtsx_clear_dev_flag(pcr, ASPM_L1_2_EN);
-
-	if (lval & PCI_L1SS_CTL1_PCIPM_L1_1)
-		rtsx_set_dev_flag(pcr, PM_L1_1_EN);
-	else
-		rtsx_clear_dev_flag(pcr, PM_L1_1_EN);
-
-	if (lval & PCI_L1SS_CTL1_PCIPM_L1_2)
-		rtsx_set_dev_flag(pcr, PM_L1_2_EN);
-	else
-		rtsx_clear_dev_flag(pcr, PM_L1_2_EN);
-
-	rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, 0xFF, 0);
 	if (option->ltr_en) {
-		u16 val;
-
-		pcie_capability_read_word(pdev, PCI_EXP_DEVCTL2, &val);
-		if (val & PCI_EXP_DEVCTL2_LTR_EN) {
-			option->ltr_enabled = true;
-			option->ltr_active = true;
+		if (option->ltr_enabled)
 			rtsx_set_ltr_latency(pcr, option->ltr_active_latency);
-		} else {
-			option->ltr_enabled = false;
-		}
 	}
 }
 
 static int rts5261_extra_init_hw(struct rtsx_pcr *pcr)
 {
+	struct rtsx_cr_option *option = &pcr->option;
 	u32 val;
 
 	rtsx_pci_write_register(pcr, RTS5261_AUTOLOAD_CFG1,
@@ -517,6 +480,17 @@ static int rts5261_extra_init_hw(struct rtsx_pcr *pcr)
 	else
 		rtsx_pci_write_register(pcr, PETXCFG, 0x30, 0x00);
 
+	/*
+	 * If u_force_clkreq_0 is enabled, CLKREQ# PIN will be forced
+	 * to drive low, and we forcibly request clock.
+	 */
+	if (option->force_clkreq_0)
+		rtsx_pci_write_register(pcr, PETXCFG,
+				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_LOW);
+	else
+		rtsx_pci_write_register(pcr, PETXCFG,
+				 FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_HIGH);
+
 	rtsx_pci_write_register(pcr, PWD_SUSPEND_EN, 0xFF, 0xFB);
 	rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, 0x10, 0x00);
 	rtsx_pci_write_register(pcr, RTS5261_REG_PME_FORCE_CTL,
diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index c0bf747305e2..b2099bb54ac1 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -1400,11 +1400,8 @@ static int rtsx_pci_init_hw(struct rtsx_pcr *pcr)
 			return err;
 	}
 
-	if (pcr->aspm_mode == ASPM_MODE_REG) {
+	if (pcr->aspm_mode == ASPM_MODE_REG)
 		rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, 0x30, 0x30);
-		rtsx_pci_write_register(pcr, PETXCFG,
-				FORCE_CLKREQ_DELINK_MASK, FORCE_CLKREQ_HIGH);
-	}
 
 	/* No CD interrupt if probing driver with card inserted.
 	 * So we need to initialize pcr->card_exist here.
@@ -1419,7 +1416,9 @@ static int rtsx_pci_init_hw(struct rtsx_pcr *pcr)
 
 static int rtsx_pci_init_chip(struct rtsx_pcr *pcr)
 {
-	int err;
+	struct rtsx_cr_option *option = &(pcr->option);
+	int err, l1ss;
+	u32 lval;
 	u16 cfg_val;
 	u8 val;
 
@@ -1504,6 +1503,48 @@ static int rtsx_pci_init_chip(struct rtsx_pcr *pcr)
 			pcr->aspm_enabled = true;
 	}
 
+	l1ss = pci_find_ext_capability(pcr->pci, PCI_EXT_CAP_ID_L1SS);
+	if (l1ss) {
+		pci_read_config_dword(pcr->pci, l1ss + PCI_L1SS_CTL1, &lval);
+
+		if (lval & PCI_L1SS_CTL1_ASPM_L1_1)
+			rtsx_set_dev_flag(pcr, ASPM_L1_1_EN);
+		else
+			rtsx_clear_dev_flag(pcr, ASPM_L1_1_EN);
+
+		if (lval & PCI_L1SS_CTL1_ASPM_L1_2)
+			rtsx_set_dev_flag(pcr, ASPM_L1_2_EN);
+		else
+			rtsx_clear_dev_flag(pcr, ASPM_L1_2_EN);
+
+		if (lval & PCI_L1SS_CTL1_PCIPM_L1_1)
+			rtsx_set_dev_flag(pcr, PM_L1_1_EN);
+		else
+			rtsx_clear_dev_flag(pcr, PM_L1_1_EN);
+
+		if (lval & PCI_L1SS_CTL1_PCIPM_L1_2)
+			rtsx_set_dev_flag(pcr, PM_L1_2_EN);
+		else
+			rtsx_clear_dev_flag(pcr, PM_L1_2_EN);
+
+		pcie_capability_read_word(pcr->pci, PCI_EXP_DEVCTL2, &cfg_val);
+		if (cfg_val & PCI_EXP_DEVCTL2_LTR_EN) {
+			option->ltr_enabled = true;
+			option->ltr_active = true;
+		} else {
+			option->ltr_enabled = false;
+		}
+
+		if (rtsx_check_dev_flag(pcr, ASPM_L1_1_EN | ASPM_L1_2_EN
+				| PM_L1_1_EN | PM_L1_2_EN))
+			option->force_clkreq_0 = false;
+		else
+			option->force_clkreq_0 = true;
+	} else {
+		option->ltr_enabled = false;
+		option->force_clkreq_0 = true;
+	}
+
 	if (pcr->ops->fetch_vendor_settings)
 		pcr->ops->fetch_vendor_settings(pcr);
 
diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index f3673be4fc08..3eba01de9525 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1788,6 +1788,9 @@ static int ena_clean_rx_irq(struct ena_ring *rx_ring, struct napi_struct *napi,
 	return work_done;
 
 error:
+	if (xdp_flags & ENA_XDP_REDIRECT)
+		xdp_do_flush();
+
 	adapter = netdev_priv(rx_ring->netdev);
 
 	if (rc == -ENOSPC) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 931bb40ac05b..4cb22e406052 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2520,6 +2520,7 @@ static int bnxt_poll_nitroa0(struct napi_struct *napi, int budget)
 	struct rx_cmp_ext *rxcmp1;
 	u32 cp_cons, tmp_raw_cons;
 	u32 raw_cons = cpr->cp_raw_cons;
+	bool flush_xdp = false;
 	u32 rx_pkts = 0;
 	u8 event = 0;
 
@@ -2554,6 +2555,8 @@ static int bnxt_poll_nitroa0(struct napi_struct *napi, int budget)
 				rx_pkts++;
 			else if (rc == -EBUSY)	/* partial completion */
 				break;
+			if (event & BNXT_REDIRECT_EVENT)
+				flush_xdp = true;
 		} else if (unlikely(TX_CMP_TYPE(txcmp) ==
 				    CMPL_BASE_TYPE_HWRM_DONE)) {
 			bnxt_hwrm_handler(bp, txcmp);
@@ -2573,6 +2576,8 @@ static int bnxt_poll_nitroa0(struct napi_struct *napi, int budget)
 
 	if (event & BNXT_AGG_EVENT)
 		bnxt_db_write(bp, &rxr->rx_agg_db, rxr->rx_agg_prod);
+	if (flush_xdp)
+		xdp_do_flush();
 
 	if (!bnxt_has_work(bp, cpr) && rx_pkts < budget) {
 		napi_complete_done(napi, rx_pkts);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 3693ff55197d..fde1ff358045 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3156,6 +3156,15 @@ static void hns3_set_default_feature(struct net_device *netdev)
 		  NETIF_F_HW_TC);
 
 	netdev->hw_enc_features |= netdev->vlan_features | NETIF_F_TSO_MANGLEID;
+
+	/* The device_version V3 hardware can't offload the checksum for IP in
+	 * GRE packets, but can do it for NvGRE. So default to disable the
+	 * checksum and GSO offload for GRE.
+	 */
+	if (ae_dev->dev_version > HNAE3_DEVICE_VERSION_V2) {
+		netdev->features &= ~NETIF_F_GSO_GRE;
+		netdev->features &= ~NETIF_F_GSO_GRE_CSUM;
+	}
 }
 
 static int hns3_alloc_buffer(struct hns3_enet_ring *ring,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index a415760505ab..ca59e1cd992e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3391,9 +3391,14 @@ static u32 hclge_check_event_cause(struct hclge_dev *hdev, u32 *clearval)
 static void hclge_clear_event_cause(struct hclge_dev *hdev, u32 event_type,
 				    u32 regclr)
 {
+#define HCLGE_IMP_RESET_DELAY		5
+
 	switch (event_type) {
 	case HCLGE_VECTOR0_EVENT_PTP:
 	case HCLGE_VECTOR0_EVENT_RST:
+		if (regclr == BIT(HCLGE_VECTOR0_IMPRESET_INT_B))
+			mdelay(HCLGE_IMP_RESET_DELAY);
+
 		hclge_write_dev(&hdev->hw, HCLGE_MISC_RESET_STS_REG, regclr);
 		break;
 	case HCLGE_VECTOR0_EVENT_MBX:
@@ -7546,6 +7551,12 @@ static int hclge_del_cls_flower(struct hnae3_handle *handle,
 	ret = hclge_fd_tcam_config(hdev, HCLGE_FD_STAGE_1, true, rule->location,
 				   NULL, false);
 	if (ret) {
+		/* if tcam config fail, set rule state to TO_DEL,
+		 * so the rule will be deleted when periodic
+		 * task being scheduled.
+		 */
+		hclge_update_fd_list(hdev, HCLGE_FD_TO_DEL, rule->location, NULL);
+		set_bit(HCLGE_STATE_FD_TBL_CHANGED, &hdev->state);
 		spin_unlock_bh(&hdev->fd_rule_lock);
 		return ret;
 	}
@@ -8967,7 +8978,7 @@ static void hclge_update_overflow_flags(struct hclge_vport *vport,
 	if (mac_type == HCLGE_MAC_ADDR_UC) {
 		if (is_all_added)
 			vport->overflow_promisc_flags &= ~HNAE3_OVERFLOW_UPE;
-		else
+		else if (hclge_is_umv_space_full(vport, true))
 			vport->overflow_promisc_flags |= HNAE3_OVERFLOW_UPE;
 	} else {
 		if (is_all_added)
diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index a42ca847c8f8..b76e6f94edb0 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -566,6 +566,7 @@ struct i40e_pf {
 #define I40E_FLAG_DISABLE_FW_LLDP		BIT(24)
 #define I40E_FLAG_RS_FEC			BIT(25)
 #define I40E_FLAG_BASE_R_FEC			BIT(26)
+#define I40E_FLAG_VF_VLAN_PRUNING		BIT(27)
 /* TOTAL_PORT_SHUTDOWN
  * Allows to physically disable the link on the NIC's port.
  * If enabled, (after link down request from the OS)
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index d124cb947ffa..d0b9ee756b30 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -451,6 +451,8 @@ static const struct i40e_priv_flags i40e_gstrings_priv_flags[] = {
 	I40E_PRIV_FLAG("disable-fw-lldp", I40E_FLAG_DISABLE_FW_LLDP, 0),
 	I40E_PRIV_FLAG("rs-fec", I40E_FLAG_RS_FEC, 0),
 	I40E_PRIV_FLAG("base-r-fec", I40E_FLAG_BASE_R_FEC, 0),
+	I40E_PRIV_FLAG("vf-vlan-pruning",
+		       I40E_FLAG_VF_VLAN_PRUNING, 0),
 };
 
 #define I40E_PRIV_FLAGS_STR_LEN ARRAY_SIZE(i40e_gstrings_priv_flags)
@@ -5293,6 +5295,13 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 		return -EOPNOTSUPP;
 	}
 
+	if ((changed_flags & I40E_FLAG_VF_VLAN_PRUNING) &&
+	    pf->num_alloc_vfs) {
+		dev_warn(&pf->pdev->dev,
+			 "Changing vf-vlan-pruning flag while VF(s) are active is not supported\n");
+		return -EOPNOTSUPP;
+	}
+
 	if ((changed_flags & new_flags &
 	     I40E_FLAG_LINK_DOWN_ON_CLOSE_ENABLED) &&
 	    (new_flags & I40E_FLAG_MFP_ENABLED))
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index d3f3874220a3..539bb69548f2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -1426,6 +1426,114 @@ static int i40e_correct_mac_vlan_filters(struct i40e_vsi *vsi,
 	return 0;
 }
 
+/**
+ * i40e_get_vf_new_vlan - Get new vlan id on a vf
+ * @vsi: the vsi to configure
+ * @new_mac: new mac filter to be added
+ * @f: existing mac filter, replaced with new_mac->f if new_mac is not NULL
+ * @vlan_filters: the number of active VLAN filters
+ * @trusted: flag if the VF is trusted
+ *
+ * Get new VLAN id based on current VLAN filters, trust, PVID
+ * and vf-vlan-prune-disable flag.
+ *
+ * Returns the value of the new vlan filter or
+ * the old value if no new filter is needed.
+ */
+static s16 i40e_get_vf_new_vlan(struct i40e_vsi *vsi,
+				struct i40e_new_mac_filter *new_mac,
+				struct i40e_mac_filter *f,
+				int vlan_filters,
+				bool trusted)
+{
+	s16 pvid = le16_to_cpu(vsi->info.pvid);
+	struct i40e_pf *pf = vsi->back;
+	bool is_any;
+
+	if (new_mac)
+		f = new_mac->f;
+
+	if (pvid && f->vlan != pvid)
+		return pvid;
+
+	is_any = (trusted ||
+		  !(pf->flags & I40E_FLAG_VF_VLAN_PRUNING));
+
+	if ((vlan_filters && f->vlan == I40E_VLAN_ANY) ||
+	    (!is_any && !vlan_filters && f->vlan == I40E_VLAN_ANY) ||
+	    (is_any && !vlan_filters && f->vlan == 0)) {
+		if (is_any)
+			return I40E_VLAN_ANY;
+		else
+			return 0;
+	}
+
+	return f->vlan;
+}
+
+/**
+ * i40e_correct_vf_mac_vlan_filters - Correct non-VLAN VF filters if necessary
+ * @vsi: the vsi to configure
+ * @tmp_add_list: list of filters ready to be added
+ * @tmp_del_list: list of filters ready to be deleted
+ * @vlan_filters: the number of active VLAN filters
+ * @trusted: flag if the VF is trusted
+ *
+ * Correct VF VLAN filters based on current VLAN filters, trust, PVID
+ * and vf-vlan-prune-disable flag.
+ *
+ * In case of memory allocation failure return -ENOMEM. Otherwise, return 0.
+ *
+ * This function is only expected to be called from within
+ * i40e_sync_vsi_filters.
+ *
+ * NOTE: This function expects to be called while under the
+ * mac_filter_hash_lock
+ */
+static int i40e_correct_vf_mac_vlan_filters(struct i40e_vsi *vsi,
+					    struct hlist_head *tmp_add_list,
+					    struct hlist_head *tmp_del_list,
+					    int vlan_filters,
+					    bool trusted)
+{
+	struct i40e_mac_filter *f, *add_head;
+	struct i40e_new_mac_filter *new_mac;
+	struct hlist_node *h;
+	int bkt, new_vlan;
+
+	hlist_for_each_entry(new_mac, tmp_add_list, hlist) {
+		new_mac->f->vlan = i40e_get_vf_new_vlan(vsi, new_mac, NULL,
+							vlan_filters, trusted);
+	}
+
+	hash_for_each_safe(vsi->mac_filter_hash, bkt, h, f, hlist) {
+		new_vlan = i40e_get_vf_new_vlan(vsi, NULL, f, vlan_filters,
+						trusted);
+		if (new_vlan != f->vlan) {
+			add_head = i40e_add_filter(vsi, f->macaddr, new_vlan);
+			if (!add_head)
+				return -ENOMEM;
+			/* Create a temporary i40e_new_mac_filter */
+			new_mac = kzalloc(sizeof(*new_mac), GFP_ATOMIC);
+			if (!new_mac)
+				return -ENOMEM;
+			new_mac->f = add_head;
+			new_mac->state = add_head->state;
+
+			/* Add the new filter to the tmp list */
+			hlist_add_head(&new_mac->hlist, tmp_add_list);
+
+			/* Put the original filter into the delete list */
+			f->state = I40E_FILTER_REMOVE;
+			hash_del(&f->hlist);
+			hlist_add_head(&f->hlist, tmp_del_list);
+		}
+	}
+
+	vsi->has_vlan_filter = !!vlan_filters;
+	return 0;
+}
+
 /**
  * i40e_rm_default_mac_filter - Remove the default MAC filter set by NVM
  * @vsi: the PF Main VSI - inappropriate for any other VSI
@@ -2483,10 +2591,14 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 				vlan_filters++;
 		}
 
-		retval = i40e_correct_mac_vlan_filters(vsi,
-						       &tmp_add_list,
-						       &tmp_del_list,
-						       vlan_filters);
+		if (vsi->type != I40E_VSI_SRIOV)
+			retval = i40e_correct_mac_vlan_filters
+				(vsi, &tmp_add_list, &tmp_del_list,
+				 vlan_filters);
+		else if (pf->vf)
+			retval = i40e_correct_vf_mac_vlan_filters
+				(vsi, &tmp_add_list, &tmp_del_list,
+				 vlan_filters, pf->vf[vsi->vf_id].trusted);
 
 		hlist_for_each_entry(new, &tmp_add_list, hlist)
 			netdev_hw_addr_refcnt(new->f, vsi->netdev, 1);
@@ -2656,7 +2768,8 @@ int i40e_sync_vsi_filters(struct i40e_vsi *vsi)
 	}
 
 	/* if the VF is not trusted do not do promisc */
-	if ((vsi->type == I40E_VSI_SRIOV) && !pf->vf[vsi->vf_id].trusted) {
+	if (vsi->type == I40E_VSI_SRIOV && pf->vf &&
+	    !pf->vf[vsi->vf_id].trusted) {
 		clear_bit(__I40E_VSI_OVERFLOW_PROMISC, vsi->state);
 		goto out;
 	}
@@ -2915,8 +3028,21 @@ int i40e_add_vlan_all_mac(struct i40e_vsi *vsi, s16 vid)
 	int bkt;
 
 	hash_for_each_safe(vsi->mac_filter_hash, bkt, h, f, hlist) {
-		if (f->state == I40E_FILTER_REMOVE)
+		/* If we're asked to add a filter that has been marked for
+		 * removal, it is safe to simply restore it to active state.
+		 * __i40e_del_filter will have simply deleted any filters which
+		 * were previously marked NEW or FAILED, so if it is currently
+		 * marked REMOVE it must have previously been ACTIVE. Since we
+		 * haven't yet run the sync filters task, just restore this
+		 * filter to the ACTIVE state so that the sync task leaves it
+		 * in place.
+		 */
+		if (f->state == I40E_FILTER_REMOVE && f->vlan == vid) {
+			f->state = I40E_FILTER_ACTIVE;
+			continue;
+		} else if (f->state == I40E_FILTER_REMOVE) {
 			continue;
+		}
 		add_f = i40e_add_filter(vsi, f->macaddr, vid);
 		if (!add_f) {
 			dev_info(&vsi->back->pdev->dev,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 46758bbcb04f..7950b18cb7a4 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -4372,9 +4372,8 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev, int vf_id,
 		/* duplicate request, so just return success */
 		goto error_pvid;
 
-	i40e_vc_reset_vf(vf, true);
-	/* During reset the VF got a new VSI, so refresh a pointer. */
-	vsi = pf->vsi[vf->lan_vsi_idx];
+	i40e_vlan_stripping_enable(vsi);
+
 	/* Locked once because multiple functions below iterate list */
 	spin_lock_bh(&vsi->mac_filter_hash_lock);
 
@@ -4387,7 +4386,7 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev, int vf_id,
 	 * MAC addresses deleted.
 	 */
 	if ((!(vlan_id || qos) ||
-	    vlanprio != le16_to_cpu(vsi->info.pvid)) &&
+	     vlanprio != le16_to_cpu(vsi->info.pvid)) &&
 	    vsi->info.pvid) {
 		ret = i40e_add_vlan_all_mac(vsi, I40E_VLAN_ANY);
 		if (ret) {
@@ -4460,6 +4459,10 @@ int i40e_ndo_set_vf_port_vlan(struct net_device *netdev, int vf_id,
 	 */
 	vf->port_vlan_id = le16_to_cpu(vsi->info.pvid);
 
+	i40e_vc_reset_vf(vf, true);
+	/* During reset the VF got a new VSI, so refresh a pointer. */
+	vsi = pf->vsi[vf->lan_vsi_idx];
+
 	ret = i40e_config_vf_promiscuous_mode(vf, vsi->id, allmulti, alluni);
 	if (ret) {
 		dev_err(&pf->pdev->dev, "Unable to config vf promiscuous mode\n");
@@ -4750,6 +4753,11 @@ int i40e_ndo_set_vf_trust(struct net_device *netdev, int vf_id, bool setting)
 		goto out;
 
 	vf->trusted = setting;
+
+	/* request PF to sync mac/vlan filters for the VF */
+	set_bit(__I40E_MACVLAN_SYNC_PENDING, pf->state);
+	pf->vsi[vf->lan_vsi_idx]->flags |= I40E_VSI_FLAG_FILTER_CHANGED;
+
 	i40e_vc_reset_vf(vf, true);
 	dev_info(&pf->pdev->dev, "VF %u is now %strusted\n",
 		 vf_id, setting ? "" : "un");
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index a87f4f1ae684..41b8ff0d4df5 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -1142,7 +1142,8 @@ void iavf_down(struct iavf_adapter *adapter)
 	iavf_clear_fdir_filters(adapter);
 	iavf_clear_adv_rss_conf(adapter);
 
-	if (!(adapter->flags & IAVF_FLAG_PF_COMMS_FAILED)) {
+	if (!(adapter->flags & IAVF_FLAG_PF_COMMS_FAILED) &&
+	    !(test_bit(__IAVF_IN_REMOVE_TASK, &adapter->crit_section))) {
 		/* cancel any current operation */
 		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
 		/* Schedule operations to close down the HW. Don't wait
diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 859ddc07fbbf..17cb4c13d002 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -861,6 +861,18 @@ static void igc_ethtool_get_stats(struct net_device *netdev,
 	spin_unlock(&adapter->stats64_lock);
 }
 
+static int igc_ethtool_get_previous_rx_coalesce(struct igc_adapter *adapter)
+{
+	return (adapter->rx_itr_setting <= 3) ?
+		adapter->rx_itr_setting : adapter->rx_itr_setting >> 2;
+}
+
+static int igc_ethtool_get_previous_tx_coalesce(struct igc_adapter *adapter)
+{
+	return (adapter->tx_itr_setting <= 3) ?
+		adapter->tx_itr_setting : adapter->tx_itr_setting >> 2;
+}
+
 static int igc_ethtool_get_coalesce(struct net_device *netdev,
 				    struct ethtool_coalesce *ec,
 				    struct kernel_ethtool_coalesce *kernel_coal,
@@ -868,17 +880,8 @@ static int igc_ethtool_get_coalesce(struct net_device *netdev,
 {
 	struct igc_adapter *adapter = netdev_priv(netdev);
 
-	if (adapter->rx_itr_setting <= 3)
-		ec->rx_coalesce_usecs = adapter->rx_itr_setting;
-	else
-		ec->rx_coalesce_usecs = adapter->rx_itr_setting >> 2;
-
-	if (!(adapter->flags & IGC_FLAG_QUEUE_PAIRS)) {
-		if (adapter->tx_itr_setting <= 3)
-			ec->tx_coalesce_usecs = adapter->tx_itr_setting;
-		else
-			ec->tx_coalesce_usecs = adapter->tx_itr_setting >> 2;
-	}
+	ec->rx_coalesce_usecs = igc_ethtool_get_previous_rx_coalesce(adapter);
+	ec->tx_coalesce_usecs = igc_ethtool_get_previous_tx_coalesce(adapter);
 
 	return 0;
 }
@@ -903,8 +906,12 @@ static int igc_ethtool_set_coalesce(struct net_device *netdev,
 	    ec->tx_coalesce_usecs == 2)
 		return -EINVAL;
 
-	if ((adapter->flags & IGC_FLAG_QUEUE_PAIRS) && ec->tx_coalesce_usecs)
+	if ((adapter->flags & IGC_FLAG_QUEUE_PAIRS) &&
+	    ec->tx_coalesce_usecs != igc_ethtool_get_previous_tx_coalesce(adapter)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Queue Pair mode enabled, both Rx and Tx coalescing controlled by rx-usecs");
 		return -EINVAL;
+	}
 
 	/* If ITR is disabled, disable DMAC */
 	if (ec->rx_coalesce_usecs == 0) {
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index a8c24a1c12b4..6185566fbb98 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6271,7 +6271,7 @@ static int igc_xdp_xmit(struct net_device *dev, int num_frames,
 	struct igc_ring *ring;
 	int i, drops;
 
-	if (unlikely(test_bit(__IGC_DOWN, &adapter->state)))
+	if (unlikely(!netif_carrier_ok(dev)))
 		return -ENETDOWN;
 
 	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index 922bb6c9e01d..676c58dc1981 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -174,6 +174,7 @@ typedef void (*ionic_desc_cb)(struct ionic_queue *q,
 			      struct ionic_desc_info *desc_info,
 			      struct ionic_cq_info *cq_info, void *cb_arg);
 
+#define IONIC_MAX_BUF_LEN			((u16)-1)
 #define IONIC_PAGE_SIZE				PAGE_SIZE
 #define IONIC_PAGE_SPLIT_SZ			(PAGE_SIZE / 2)
 #define IONIC_PAGE_GFP_MASK			(GFP_ATOMIC | __GFP_NOWARN |\
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 376f97b4008b..6604f5862f89 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -151,7 +151,8 @@ static struct sk_buff *ionic_rx_frags(struct ionic_queue *q,
 			return NULL;
 		}
 
-		frag_len = min_t(u16, len, IONIC_PAGE_SIZE - buf_info->page_offset);
+		frag_len = min_t(u16, len, min_t(u32, IONIC_MAX_BUF_LEN,
+						 IONIC_PAGE_SIZE - buf_info->page_offset));
 		len -= frag_len;
 
 		dma_sync_single_for_cpu(dev,
@@ -388,7 +389,8 @@ void ionic_rx_fill(struct ionic_queue *q)
 
 		/* fill main descriptor - buf[0] */
 		desc->addr = cpu_to_le64(buf_info->dma_addr + buf_info->page_offset);
-		frag_len = min_t(u16, len, IONIC_PAGE_SIZE - buf_info->page_offset);
+		frag_len = min_t(u16, len, min_t(u32, IONIC_MAX_BUF_LEN,
+						 IONIC_PAGE_SIZE - buf_info->page_offset));
 		desc->len = cpu_to_le16(frag_len);
 		remain_len -= frag_len;
 		buf_info++;
@@ -407,7 +409,9 @@ void ionic_rx_fill(struct ionic_queue *q)
 			}
 
 			sg_elem->addr = cpu_to_le64(buf_info->dma_addr + buf_info->page_offset);
-			frag_len = min_t(u16, remain_len, IONIC_PAGE_SIZE - buf_info->page_offset);
+			frag_len = min_t(u16, remain_len, min_t(u32, IONIC_MAX_BUF_LEN,
+								IONIC_PAGE_SIZE -
+								buf_info->page_offset));
 			sg_elem->len = cpu_to_le16(frag_len);
 			remain_len -= frag_len;
 			buf_info++;
diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index f99df92d211e..44275094906c 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2122,7 +2122,12 @@ static const struct ethtool_ops team_ethtool_ops = {
 static void team_setup_by_port(struct net_device *dev,
 			       struct net_device *port_dev)
 {
-	dev->header_ops	= port_dev->header_ops;
+	struct team *team = netdev_priv(dev);
+
+	if (port_dev->type == ARPHRD_ETHER)
+		dev->header_ops	= team->header_ops_cache;
+	else
+		dev->header_ops	= port_dev->header_ops;
 	dev->type = port_dev->type;
 	dev->hard_header_len = port_dev->hard_header_len;
 	dev->needed_headroom = port_dev->needed_headroom;
@@ -2169,8 +2174,11 @@ static int team_dev_type_check_change(struct net_device *dev,
 
 static void team_setup(struct net_device *dev)
 {
+	struct team *team = netdev_priv(dev);
+
 	ether_setup(dev);
 	dev->max_mtu = ETH_MAX_MTU;
+	team->header_ops_cache = dev->header_ops;
 
 	dev->netdev_ops = &team_netdev_ops;
 	dev->ethtool_ops = &team_ethtool_ops;
diff --git a/drivers/net/thunderbolt.c b/drivers/net/thunderbolt.c
index 3395dcb0b262..470852f7a64d 100644
--- a/drivers/net/thunderbolt.c
+++ b/drivers/net/thunderbolt.c
@@ -993,12 +993,11 @@ static bool tbnet_xmit_csum_and_map(struct tbnet *net, struct sk_buff *skb,
 		*tucso = ~csum_tcpudp_magic(ip_hdr(skb)->saddr,
 					    ip_hdr(skb)->daddr, 0,
 					    ip_hdr(skb)->protocol, 0);
-	} else if (skb_is_gso_v6(skb)) {
+	} else if (skb_is_gso(skb) && skb_is_gso_v6(skb)) {
 		tucso = dest + ((void *)&(tcp_hdr(skb)->check) - data);
 		*tucso = ~csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
 					  &ipv6_hdr(skb)->daddr, 0,
 					  IPPROTO_TCP, 0);
-		return false;
 	} else if (protocol == htons(ETH_P_IPV6)) {
 		tucso = dest + skb_checksum_start_offset(skb) + skb->csum_offset;
 		*tucso = ~csum_ipv6_magic(&ipv6_hdr(skb)->saddr,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index bb3813e8474f..65172a654a19 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -384,14 +384,6 @@ static int nvme_pci_npages_sgl(void)
 			NVME_CTRL_PAGE_SIZE);
 }
 
-static size_t nvme_pci_iod_alloc_size(void)
-{
-	size_t npages = max(nvme_pci_npages_prp(), nvme_pci_npages_sgl());
-
-	return sizeof(__le64 *) * npages +
-		sizeof(struct scatterlist) * NVME_MAX_SEGS;
-}
-
 static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 				unsigned int hctx_idx)
 {
@@ -2662,6 +2654,22 @@ static void nvme_release_prp_pools(struct nvme_dev *dev)
 	dma_pool_destroy(dev->prp_small_pool);
 }
 
+static int nvme_pci_alloc_iod_mempool(struct nvme_dev *dev)
+{
+	size_t npages = max(nvme_pci_npages_prp(), nvme_pci_npages_sgl());
+	size_t alloc_size = sizeof(__le64 *) * npages +
+			    sizeof(struct scatterlist) * NVME_MAX_SEGS;
+
+	WARN_ON_ONCE(alloc_size > PAGE_SIZE);
+	dev->iod_mempool = mempool_create_node(1,
+			mempool_kmalloc, mempool_kfree,
+			(void *)alloc_size, GFP_KERNEL,
+			dev_to_node(dev->dev));
+	if (!dev->iod_mempool)
+		return -ENOMEM;
+	return 0;
+}
+
 static void nvme_free_tagset(struct nvme_dev *dev)
 {
 	if (dev->tagset.tags)
@@ -2669,6 +2677,7 @@ static void nvme_free_tagset(struct nvme_dev *dev)
 	dev->ctrl.tagset = NULL;
 }
 
+/* pairs with nvme_pci_alloc_dev */
 static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 {
 	struct nvme_dev *dev = to_nvme_dev(ctrl);
@@ -2958,20 +2967,20 @@ static void nvme_async_probe(void *data, async_cookie_t cookie)
 	nvme_put_ctrl(&dev->ctrl);
 }
 
-static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
+		const struct pci_device_id *id)
 {
-	int node, result = -ENOMEM;
-	struct nvme_dev *dev;
 	unsigned long quirks = id->driver_data;
-	size_t alloc_size;
-
-	node = dev_to_node(&pdev->dev);
-	if (node == NUMA_NO_NODE)
-		set_dev_node(&pdev->dev, first_memory_node);
+	int node = dev_to_node(&pdev->dev);
+	struct nvme_dev *dev;
+	int ret = -ENOMEM;
 
 	dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, node);
 	if (!dev)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
+	INIT_WORK(&dev->ctrl.reset_work, nvme_reset_work);
+	INIT_WORK(&dev->remove_work, nvme_remove_dead_ctrl_work);
+	mutex_init(&dev->shutdown_lock);
 
 	dev->nr_write_queues = write_queues;
 	dev->nr_poll_queues = poll_queues;
@@ -2979,25 +2988,11 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	dev->queues = kcalloc_node(dev->nr_allocated_queues,
 			sizeof(struct nvme_queue), GFP_KERNEL, node);
 	if (!dev->queues)
-		goto free;
+		goto out_free_dev;
 
 	dev->dev = get_device(&pdev->dev);
-	pci_set_drvdata(pdev, dev);
-
-	result = nvme_dev_map(dev);
-	if (result)
-		goto put_pci;
-
-	INIT_WORK(&dev->ctrl.reset_work, nvme_reset_work);
-	INIT_WORK(&dev->remove_work, nvme_remove_dead_ctrl_work);
-	mutex_init(&dev->shutdown_lock);
-
-	result = nvme_setup_prp_pools(dev);
-	if (result)
-		goto unmap;
 
 	quirks |= check_vendor_combination_bug(pdev);
-
 	if (!noacpi && acpi_storage_d3(&pdev->dev)) {
 		/*
 		 * Some systems use a bios work around to ask for D3 on
@@ -3007,46 +3002,54 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			 "platform quirk: setting simple suspend\n");
 		quirks |= NVME_QUIRK_SIMPLE_SUSPEND;
 	}
+	ret = nvme_init_ctrl(&dev->ctrl, &pdev->dev, &nvme_pci_ctrl_ops,
+			     quirks);
+	if (ret)
+		goto out_put_device;
+	return dev;
 
-	/*
-	 * Double check that our mempool alloc size will cover the biggest
-	 * command we support.
-	 */
-	alloc_size = nvme_pci_iod_alloc_size();
-	WARN_ON_ONCE(alloc_size > PAGE_SIZE);
+out_put_device:
+	put_device(dev->dev);
+	kfree(dev->queues);
+out_free_dev:
+	kfree(dev);
+	return ERR_PTR(ret);
+}
 
-	dev->iod_mempool = mempool_create_node(1, mempool_kmalloc,
-						mempool_kfree,
-						(void *) alloc_size,
-						GFP_KERNEL, node);
-	if (!dev->iod_mempool) {
-		result = -ENOMEM;
-		goto release_pools;
-	}
+static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct nvme_dev *dev;
+	int result = -ENOMEM;
+
+	dev = nvme_pci_alloc_dev(pdev, id);
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
+	result = nvme_dev_map(dev);
+	if (result)
+		goto out_uninit_ctrl;
+
+	result = nvme_setup_prp_pools(dev);
+	if (result)
+		goto out_dev_unmap;
 
-	result = nvme_init_ctrl(&dev->ctrl, &pdev->dev, &nvme_pci_ctrl_ops,
-			quirks);
+	result = nvme_pci_alloc_iod_mempool(dev);
 	if (result)
-		goto release_mempool;
+		goto out_release_prp_pools;
 
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
+	pci_set_drvdata(pdev, dev);
 
 	nvme_reset_ctrl(&dev->ctrl);
 	async_schedule(nvme_async_probe, dev);
-
 	return 0;
 
- release_mempool:
-	mempool_destroy(dev->iod_mempool);
- release_pools:
+out_release_prp_pools:
 	nvme_release_prp_pools(dev);
- unmap:
+out_dev_unmap:
 	nvme_dev_unmap(dev);
- put_pci:
-	put_device(dev->dev);
- free:
-	kfree(dev->queues);
-	kfree(dev);
+out_uninit_ctrl:
+	nvme_uninit_ctrl(&dev->ctrl);
 	return result;
 }
 
diff --git a/drivers/parisc/iosapic.c b/drivers/parisc/iosapic.c
index 93ea922618c3..56562ae99f68 100644
--- a/drivers/parisc/iosapic.c
+++ b/drivers/parisc/iosapic.c
@@ -202,9 +202,9 @@ static inline void iosapic_write(void __iomem *iosapic, unsigned int reg, u32 va
 
 static DEFINE_SPINLOCK(iosapic_lock);
 
-static inline void iosapic_eoi(void __iomem *addr, unsigned int data)
+static inline void iosapic_eoi(__le32 __iomem *addr, __le32 data)
 {
-	__raw_writel(data, addr);
+	__raw_writel((__force u32)data, addr);
 }
 
 /*
diff --git a/drivers/parisc/iosapic_private.h b/drivers/parisc/iosapic_private.h
index 73ecc657ad95..bd8ff40162b4 100644
--- a/drivers/parisc/iosapic_private.h
+++ b/drivers/parisc/iosapic_private.h
@@ -118,8 +118,8 @@ struct iosapic_irt {
 struct vector_info {
 	struct iosapic_info *iosapic;	/* I/O SAPIC this vector is on */
 	struct irt_entry *irte;		/* IRT entry */
-	u32 __iomem *eoi_addr;		/* precalculate EOI reg address */
-	u32	eoi_data;		/* IA64: ?       PA: swapped txn_data */
+	__le32 __iomem *eoi_addr;	/* precalculate EOI reg address */
+	__le32	eoi_data;		/* IA64: ?       PA: swapped txn_data */
 	int	txn_irq;		/* virtual IRQ number for processor */
 	ulong	txn_addr;		/* IA64: id_eid  PA: partial HPA */
 	u32	txn_data;		/* CPU interrupt bit */
diff --git a/drivers/platform/mellanox/Kconfig b/drivers/platform/mellanox/Kconfig
index edd17e1a1f88..a57ae5cbc00a 100644
--- a/drivers/platform/mellanox/Kconfig
+++ b/drivers/platform/mellanox/Kconfig
@@ -48,6 +48,7 @@ config MLXBF_BOOTCTL
 	tristate "Mellanox BlueField Firmware Boot Control driver"
 	depends on ARM64
 	depends on ACPI
+	depends on NET
 	help
 	  The Mellanox BlueField firmware implements functionality to
 	  request swapping the primary and alternate eMMC boot partition,
diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index e7a3e3402817..189c5460edd8 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 
@@ -232,19 +233,15 @@ static inline u32 ipc_data_readl(struct intel_scu_ipc_dev *scu, u32 offset)
 /* Wait till scu status is busy */
 static inline int busy_loop(struct intel_scu_ipc_dev *scu)
 {
-	unsigned long end = jiffies + IPC_TIMEOUT;
-
-	do {
-		u32 status;
-
-		status = ipc_read_status(scu);
-		if (!(status & IPC_STATUS_BUSY))
-			return (status & IPC_STATUS_ERR) ? -EIO : 0;
+	u8 status;
+	int err;
 
-		usleep_range(50, 100);
-	} while (time_before(jiffies, end));
+	err = readx_poll_timeout(ipc_read_status, scu, status, !(status & IPC_STATUS_BUSY),
+				 100, jiffies_to_usecs(IPC_TIMEOUT));
+	if (err)
+		return err;
 
-	return -ETIMEDOUT;
+	return (status & IPC_STATUS_ERR) ? -EIO : 0;
 }
 
 /* Wait till ipc ioc interrupt is received or timeout in 10 HZ */
@@ -252,10 +249,12 @@ static inline int ipc_wait_for_interrupt(struct intel_scu_ipc_dev *scu)
 {
 	int status;
 
-	if (!wait_for_completion_timeout(&scu->cmd_complete, IPC_TIMEOUT))
-		return -ETIMEDOUT;
+	wait_for_completion_timeout(&scu->cmd_complete, IPC_TIMEOUT);
 
 	status = ipc_read_status(scu);
+	if (status & IPC_STATUS_BUSY)
+		return -ETIMEDOUT;
+
 	if (status & IPC_STATUS_ERR)
 		return -EIO;
 
@@ -267,6 +266,24 @@ static int intel_scu_ipc_check_status(struct intel_scu_ipc_dev *scu)
 	return scu->irq > 0 ? ipc_wait_for_interrupt(scu) : busy_loop(scu);
 }
 
+static struct intel_scu_ipc_dev *intel_scu_ipc_get(struct intel_scu_ipc_dev *scu)
+{
+	u8 status;
+
+	if (!scu)
+		scu = ipcdev;
+	if (!scu)
+		return ERR_PTR(-ENODEV);
+
+	status = ipc_read_status(scu);
+	if (status & IPC_STATUS_BUSY) {
+		dev_dbg(&scu->dev, "device is busy\n");
+		return ERR_PTR(-EBUSY);
+	}
+
+	return scu;
+}
+
 /* Read/Write power control(PMIC in Langwell, MSIC in PenWell) registers */
 static int pwr_reg_rdwr(struct intel_scu_ipc_dev *scu, u16 *addr, u8 *data,
 			u32 count, u32 op, u32 id)
@@ -280,11 +297,10 @@ static int pwr_reg_rdwr(struct intel_scu_ipc_dev *scu, u16 *addr, u8 *data,
 	memset(cbuf, 0, sizeof(cbuf));
 
 	mutex_lock(&ipclock);
-	if (!scu)
-		scu = ipcdev;
-	if (!scu) {
+	scu = intel_scu_ipc_get(scu);
+	if (IS_ERR(scu)) {
 		mutex_unlock(&ipclock);
-		return -ENODEV;
+		return PTR_ERR(scu);
 	}
 
 	for (nc = 0; nc < count; nc++, offset += 2) {
@@ -439,13 +455,12 @@ int intel_scu_ipc_dev_simple_command(struct intel_scu_ipc_dev *scu, int cmd,
 	int err;
 
 	mutex_lock(&ipclock);
-	if (!scu)
-		scu = ipcdev;
-	if (!scu) {
+	scu = intel_scu_ipc_get(scu);
+	if (IS_ERR(scu)) {
 		mutex_unlock(&ipclock);
-		return -ENODEV;
+		return PTR_ERR(scu);
 	}
-	scu = ipcdev;
+
 	cmdval = sub << 12 | cmd;
 	ipc_command(scu, cmdval);
 	err = intel_scu_ipc_check_status(scu);
@@ -485,11 +500,10 @@ int intel_scu_ipc_dev_command_with_size(struct intel_scu_ipc_dev *scu, int cmd,
 		return -EINVAL;
 
 	mutex_lock(&ipclock);
-	if (!scu)
-		scu = ipcdev;
-	if (!scu) {
+	scu = intel_scu_ipc_get(scu);
+	if (IS_ERR(scu)) {
 		mutex_unlock(&ipclock);
-		return -ENODEV;
+		return PTR_ERR(scu);
 	}
 
 	memcpy(inbuf, in, inlen);
diff --git a/drivers/power/supply/ucs1002_power.c b/drivers/power/supply/ucs1002_power.c
index ef673ec3db56..332cb50d9fb4 100644
--- a/drivers/power/supply/ucs1002_power.c
+++ b/drivers/power/supply/ucs1002_power.c
@@ -384,7 +384,8 @@ static int ucs1002_get_property(struct power_supply *psy,
 	case POWER_SUPPLY_PROP_USB_TYPE:
 		return ucs1002_get_usb_type(info, val);
 	case POWER_SUPPLY_PROP_HEALTH:
-		return val->intval = info->health;
+		val->intval = info->health;
+		return 0;
 	case POWER_SUPPLY_PROP_PRESENT:
 		val->intval = info->present;
 		return 0;
diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index 32fc450bf84b..352705e023c8 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -4402,7 +4402,7 @@ pm8001_chip_phy_start_req(struct pm8001_hba_info *pm8001_ha, u8 phy_id)
 	payload.sas_identify.dev_type = SAS_END_DEVICE;
 	payload.sas_identify.initiator_bits = SAS_PROTOCOL_ALL;
 	memcpy(payload.sas_identify.sas_addr,
-		pm8001_ha->sas_addr, SAS_ADDR_SIZE);
+		&pm8001_ha->phy[phy_id].dev_sas_addr, SAS_ADDR_SIZE);
 	payload.sas_identify.phy_id = phy_id;
 	ret = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opcode, &payload,
 			sizeof(payload), 0);
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 04746df26c6c..d37b1bdb29b4 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -3793,10 +3793,12 @@ static int mpi_set_controller_config_resp(struct pm8001_hba_info *pm8001_ha,
 			(struct set_ctrl_cfg_resp *)(piomb + 4);
 	u32 status = le32_to_cpu(pPayload->status);
 	u32 err_qlfr_pgcd = le32_to_cpu(pPayload->err_qlfr_pgcd);
+	u32 tag = le32_to_cpu(pPayload->tag);
 
 	pm8001_dbg(pm8001_ha, MSG,
 		   "SET CONTROLLER RESP: status 0x%x qlfr_pgcd 0x%x\n",
 		   status, err_qlfr_pgcd);
+	pm8001_tag_free(pm8001_ha, tag);
 
 	return 0;
 }
@@ -4814,7 +4816,7 @@ pm80xx_chip_phy_start_req(struct pm8001_hba_info *pm8001_ha, u8 phy_id)
 	payload.sas_identify.dev_type = SAS_END_DEVICE;
 	payload.sas_identify.initiator_bits = SAS_PROTOCOL_ALL;
 	memcpy(payload.sas_identify.sas_addr,
-	  &pm8001_ha->sas_addr, SAS_ADDR_SIZE);
+		&pm8001_ha->phy[phy_id].dev_sas_addr, SAS_ADDR_SIZE);
 	payload.sas_identify.phy_id = phy_id;
 	ret = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opcode, &payload,
 			sizeof(payload), 0);
diff --git a/drivers/scsi/qedf/qedf_io.c b/drivers/scsi/qedf/qedf_io.c
index bb5761ed3f51..a1a1f4e46660 100644
--- a/drivers/scsi/qedf/qedf_io.c
+++ b/drivers/scsi/qedf/qedf_io.c
@@ -1913,6 +1913,7 @@ int qedf_initiate_abts(struct qedf_ioreq *io_req, bool return_scsi_cmd_on_abts)
 		goto drop_rdata_kref;
 	}
 
+	spin_lock_irqsave(&fcport->rport_lock, flags);
 	if (!test_bit(QEDF_CMD_OUTSTANDING, &io_req->flags) ||
 	    test_bit(QEDF_CMD_IN_CLEANUP, &io_req->flags) ||
 	    test_bit(QEDF_CMD_IN_ABORT, &io_req->flags)) {
@@ -1920,17 +1921,20 @@ int qedf_initiate_abts(struct qedf_ioreq *io_req, bool return_scsi_cmd_on_abts)
 			 "io_req xid=0x%x sc_cmd=%p already in cleanup or abort processing or already completed.\n",
 			 io_req->xid, io_req->sc_cmd);
 		rc = 1;
+		spin_unlock_irqrestore(&fcport->rport_lock, flags);
 		goto drop_rdata_kref;
 	}
 
+	/* Set the command type to abort */
+	io_req->cmd_type = QEDF_ABTS;
+	spin_unlock_irqrestore(&fcport->rport_lock, flags);
+
 	kref_get(&io_req->refcount);
 
 	xid = io_req->xid;
 	qedf->control_requests++;
 	qedf->packet_aborts++;
 
-	/* Set the command type to abort */
-	io_req->cmd_type = QEDF_ABTS;
 	io_req->return_scsi_cmd_on_abts = return_scsi_cmd_on_abts;
 
 	set_bit(QEDF_CMD_IN_ABORT, &io_req->flags);
@@ -2219,7 +2223,9 @@ int qedf_initiate_cleanup(struct qedf_ioreq *io_req,
 		  refcount, fcport, fcport->rdata->ids.port_id);
 
 	/* Cleanup cmds re-use the same TID as the original I/O */
+	spin_lock_irqsave(&fcport->rport_lock, flags);
 	io_req->cmd_type = QEDF_CLEANUP;
+	spin_unlock_irqrestore(&fcport->rport_lock, flags);
 	io_req->return_scsi_cmd_on_abts = return_scsi_cmd_on_abts;
 
 	init_completion(&io_req->cleanup_done);
diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index 61959dd2237f..18380a932ab6 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -2807,6 +2807,8 @@ void qedf_process_cqe(struct qedf_ctx *qedf, struct fcoe_cqe *cqe)
 	struct qedf_ioreq *io_req;
 	struct qedf_rport *fcport;
 	u32 comp_type;
+	u8 io_comp_type;
+	unsigned long flags;
 
 	comp_type = (cqe->cqe_data >> FCOE_CQE_CQE_TYPE_SHIFT) &
 	    FCOE_CQE_CQE_TYPE_MASK;
@@ -2840,11 +2842,14 @@ void qedf_process_cqe(struct qedf_ctx *qedf, struct fcoe_cqe *cqe)
 		return;
 	}
 
+	spin_lock_irqsave(&fcport->rport_lock, flags);
+	io_comp_type = io_req->cmd_type;
+	spin_unlock_irqrestore(&fcport->rport_lock, flags);
 
 	switch (comp_type) {
 	case FCOE_GOOD_COMPLETION_CQE_TYPE:
 		atomic_inc(&fcport->free_sqes);
-		switch (io_req->cmd_type) {
+		switch (io_comp_type) {
 		case QEDF_SCSI_CMD:
 			qedf_scsi_completion(qedf, cqe, io_req);
 			break;
diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index d70c2f4ba718..3c876967e8b1 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -3461,6 +3461,7 @@ struct qla_msix_entry {
 	int have_irq;
 	int in_use;
 	uint32_t vector;
+	uint32_t vector_base0;
 	uint16_t entry;
 	char name[30];
 	void *handle;
@@ -3790,6 +3791,7 @@ struct qla_qpair {
 	uint64_t retry_term_jiff;
 	struct qla_tgt_counters tgt_counters;
 	uint16_t cpuid;
+	bool cpu_mapped;
 	struct qla_fw_resources fwres ____cacheline_aligned;
 	u32	cmd_cnt;
 	u32	cmd_completion_cnt;
@@ -4119,6 +4121,7 @@ struct qla_hw_data {
 	struct req_que **req_q_map;
 	struct rsp_que **rsp_q_map;
 	struct qla_qpair **queue_pair_map;
+	struct qla_qpair **qp_cpu_map;
 	unsigned long req_qid_map[(QLA_MAX_QUEUES / 8) / sizeof(unsigned long)];
 	unsigned long rsp_qid_map[(QLA_MAX_QUEUES / 8) / sizeof(unsigned long)];
 	unsigned long qpair_qid_map[(QLA_MAX_QUEUES / 8)
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 1a2ceef92bf0..b59d5b560a27 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -9779,8 +9779,9 @@ struct qla_qpair *qla2xxx_create_qpair(struct scsi_qla_host *vha, int qos,
 		qpair->req = ha->req_q_map[req_id];
 		qpair->rsp->req = qpair->req;
 		qpair->rsp->qpair = qpair;
-		/* init qpair to this cpu. Will adjust at run time. */
-		qla_cpu_update(qpair, raw_smp_processor_id());
+
+		if (!qpair->cpu_mapped)
+			qla_cpu_update(qpair, raw_smp_processor_id());
 
 		if (IS_T10_PI_CAPABLE(ha) && ql2xenabledif) {
 			if (ha->fw_attributes & BIT_4)
diff --git a/drivers/scsi/qla2xxx/qla_inline.h b/drivers/scsi/qla2xxx/qla_inline.h
index a7b5d1114682..a4a56ab0ba74 100644
--- a/drivers/scsi/qla2xxx/qla_inline.h
+++ b/drivers/scsi/qla2xxx/qla_inline.h
@@ -573,3 +573,61 @@ fcport_is_bigger(fc_port_t *fcport)
 {
 	return !fcport_is_smaller(fcport);
 }
+
+static inline struct qla_qpair *
+qla_mapq_nvme_select_qpair(struct qla_hw_data *ha, struct qla_qpair *qpair)
+{
+	int cpuid = raw_smp_processor_id();
+
+	if (qpair->cpuid != cpuid &&
+	    ha->qp_cpu_map[cpuid]) {
+		qpair = ha->qp_cpu_map[cpuid];
+	}
+	return qpair;
+}
+
+static inline void
+qla_mapq_init_qp_cpu_map(struct qla_hw_data *ha,
+			 struct qla_msix_entry *msix,
+			 struct qla_qpair *qpair)
+{
+	const struct cpumask *mask;
+	unsigned int cpu;
+
+	if (!ha->qp_cpu_map)
+		return;
+	mask = pci_irq_get_affinity(ha->pdev, msix->vector_base0);
+	if (!mask)
+		return;
+	qpair->cpuid = cpumask_first(mask);
+	for_each_cpu(cpu, mask) {
+		ha->qp_cpu_map[cpu] = qpair;
+	}
+	msix->cpuid = qpair->cpuid;
+	qpair->cpu_mapped = true;
+}
+
+static inline void
+qla_mapq_free_qp_cpu_map(struct qla_hw_data *ha)
+{
+	if (ha->qp_cpu_map) {
+		kfree(ha->qp_cpu_map);
+		ha->qp_cpu_map = NULL;
+	}
+}
+
+static inline int qla_mapq_alloc_qp_cpu_map(struct qla_hw_data *ha)
+{
+	scsi_qla_host_t *vha = pci_get_drvdata(ha->pdev);
+
+	if (!ha->qp_cpu_map) {
+		ha->qp_cpu_map = kcalloc(NR_CPUS, sizeof(struct qla_qpair *),
+					 GFP_KERNEL);
+		if (!ha->qp_cpu_map) {
+			ql_log(ql_log_fatal, vha, 0x0180,
+			       "Unable to allocate memory for qp_cpu_map ptrs.\n");
+			return -1;
+		}
+	}
+	return 0;
+}
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 80c2dcf567b0..51e906fa8694 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -3780,9 +3780,11 @@ void qla24xx_process_response_queue(struct scsi_qla_host *vha,
 	if (!ha->flags.fw_started)
 		return;
 
-	if (rsp->qpair->cpuid != smp_processor_id() || !rsp->qpair->rcv_intr) {
+	if (rsp->qpair->cpuid != raw_smp_processor_id() || !rsp->qpair->rcv_intr) {
 		rsp->qpair->rcv_intr = 1;
-		qla_cpu_update(rsp->qpair, smp_processor_id());
+
+		if (!rsp->qpair->cpu_mapped)
+			qla_cpu_update(rsp->qpair, raw_smp_processor_id());
 	}
 
 #define __update_rsp_in(_update, _is_shadow_hba, _rsp, _rsp_in)		\
@@ -4277,7 +4279,7 @@ qla2xxx_msix_rsp_q(int irq, void *dev_id)
 	}
 	ha = qpair->hw;
 
-	queue_work_on(smp_processor_id(), ha->wq, &qpair->q_work);
+	queue_work(ha->wq, &qpair->q_work);
 
 	return IRQ_HANDLED;
 }
@@ -4303,7 +4305,7 @@ qla2xxx_msix_rsp_q_hs(int irq, void *dev_id)
 	wrt_reg_dword(&reg->hccr, HCCRX_CLR_RISC_INT);
 	spin_unlock_irqrestore(&ha->hardware_lock, flags);
 
-	queue_work_on(smp_processor_id(), ha->wq, &qpair->q_work);
+	queue_work(ha->wq, &qpair->q_work);
 
 	return IRQ_HANDLED;
 }
@@ -4396,6 +4398,7 @@ qla24xx_enable_msix(struct qla_hw_data *ha, struct rsp_que *rsp)
 	for (i = 0; i < ha->msix_count; i++) {
 		qentry = &ha->msix_entries[i];
 		qentry->vector = pci_irq_vector(ha->pdev, i);
+		qentry->vector_base0 = i;
 		qentry->entry = i;
 		qentry->have_irq = 0;
 		qentry->in_use = 0;
@@ -4623,5 +4626,6 @@ int qla25xx_request_irq(struct qla_hw_data *ha, struct qla_qpair *qpair,
 	}
 	msix->have_irq = 1;
 	msix->handle = qpair;
+	qla_mapq_init_qp_cpu_map(ha, msix, qpair);
 	return ret;
 }
diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index f535f478e37c..088e84042efc 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -598,6 +598,7 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
 	fc_port_t *fcport;
 	struct srb_iocb *nvme;
 	struct scsi_qla_host *vha;
+	struct qla_hw_data *ha;
 	int rval;
 	srb_t *sp;
 	struct qla_qpair *qpair = hw_queue_handle;
@@ -618,6 +619,7 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
 		return -ENODEV;
 
 	vha = fcport->vha;
+	ha = vha->hw;
 
 	if (test_bit(ABORT_ISP_ACTIVE, &vha->dpc_flags))
 		return -EBUSY;
@@ -632,6 +634,8 @@ static int qla_nvme_post_cmd(struct nvme_fc_local_port *lport,
 	if (fcport->nvme_flag & NVME_FLAG_RESETTING)
 		return -EBUSY;
 
+	qpair = qla_mapq_nvme_select_qpair(ha, qpair);
+
 	/* Alloc SRB structure */
 	sp = qla2xxx_get_qpair_sp(vha, qpair, fcport, GFP_ATOMIC);
 	if (!sp)
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index a40af9b832ab..1b175e5c0cfc 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -467,6 +467,11 @@ static int qla2x00_alloc_queues(struct qla_hw_data *ha, struct req_que *req,
 			    "Unable to allocate memory for queue pair ptrs.\n");
 			goto fail_qpair_map;
 		}
+		if (qla_mapq_alloc_qp_cpu_map(ha) != 0) {
+			kfree(ha->queue_pair_map);
+			ha->queue_pair_map = NULL;
+			goto fail_qpair_map;
+		}
 	}
 
 	/*
@@ -541,6 +546,7 @@ static void qla2x00_free_queues(struct qla_hw_data *ha)
 		ha->base_qpair = NULL;
 	}
 
+	qla_mapq_free_qp_cpu_map(ha);
 	spin_lock_irqsave(&ha->hardware_lock, flags);
 	for (cnt = 0; cnt < ha->max_req_queues; cnt++) {
 		if (!test_bit(cnt, ha->req_qid_map))
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 2ce041fdec75..ef46dce73978 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -4459,8 +4459,7 @@ static int qlt_handle_cmd_for_atio(struct scsi_qla_host *vha,
 		queue_work_on(cmd->se_cmd.cpuid, qla_tgt_wq, &cmd->work);
 	} else if (ha->msix_count) {
 		if (cmd->atio.u.isp24.fcp_cmnd.rddata)
-			queue_work_on(smp_processor_id(), qla_tgt_wq,
-			    &cmd->work);
+			queue_work(qla_tgt_wq, &cmd->work);
 		else
 			queue_work_on(cmd->se_cmd.cpuid, qla_tgt_wq,
 			    &cmd->work);
diff --git a/drivers/scsi/qla2xxx/tcm_qla2xxx.c b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
index 03de1bcf1461..b3852be971e4 100644
--- a/drivers/scsi/qla2xxx/tcm_qla2xxx.c
+++ b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
@@ -310,7 +310,7 @@ static void tcm_qla2xxx_free_cmd(struct qla_tgt_cmd *cmd)
 	cmd->trc_flags |= TRC_CMD_DONE;
 
 	INIT_WORK(&cmd->work, tcm_qla2xxx_complete_free);
-	queue_work_on(smp_processor_id(), tcm_qla2xxx_free_wq, &cmd->work);
+	queue_work(tcm_qla2xxx_free_wq, &cmd->work);
 }
 
 /*
@@ -557,7 +557,7 @@ static void tcm_qla2xxx_handle_data(struct qla_tgt_cmd *cmd)
 	cmd->trc_flags |= TRC_DATA_IN;
 	cmd->cmd_in_wq = 1;
 	INIT_WORK(&cmd->work, tcm_qla2xxx_handle_data_work);
-	queue_work_on(smp_processor_id(), tcm_qla2xxx_free_wq, &cmd->work);
+	queue_work(tcm_qla2xxx_free_wq, &cmd->work);
 }
 
 static int tcm_qla2xxx_chk_dif_tags(uint32_t tag)
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index d00d263705e1..f48036f09eab 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -2309,7 +2309,6 @@ __ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd,
 		      bool completion)
 {
 	lockdep_assert_held(&hba->uic_cmd_mutex);
-	lockdep_assert_held(hba->host->host_lock);
 
 	if (!ufshcd_ready_for_uic_cmd(hba)) {
 		dev_err(hba->dev,
@@ -2336,15 +2335,12 @@ __ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd,
 int ufshcd_send_uic_cmd(struct ufs_hba *hba, struct uic_command *uic_cmd)
 {
 	int ret;
-	unsigned long flags;
 
 	ufshcd_hold(hba, false);
 	mutex_lock(&hba->uic_cmd_mutex);
 	ufshcd_add_delay_before_dme_cmd(hba);
 
-	spin_lock_irqsave(hba->host->host_lock, flags);
 	ret = __ufshcd_send_uic_cmd(hba, uic_cmd, true);
-	spin_unlock_irqrestore(hba->host->host_lock, flags);
 	if (!ret)
 		ret = ufshcd_wait_for_uic_cmd(hba, uic_cmd);
 
@@ -3967,8 +3963,8 @@ static int ufshcd_uic_pwr_ctrl(struct ufs_hba *hba, struct uic_command *cmd)
 		wmb();
 		reenable_intr = true;
 	}
-	ret = __ufshcd_send_uic_cmd(hba, cmd, false);
 	spin_unlock_irqrestore(hba->host->host_lock, flags);
+	ret = __ufshcd_send_uic_cmd(hba, cmd, false);
 	if (ret) {
 		dev_err(hba->dev,
 			"pwr ctrl cmd 0x%x with mode 0x%x uic error %d\n",
diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
index 32ed9dc88e45..08197b03955d 100644
--- a/drivers/soc/imx/soc-imx8m.c
+++ b/drivers/soc/imx/soc-imx8m.c
@@ -100,6 +100,7 @@ static void __init imx8mm_soc_uid(void)
 {
 	void __iomem *ocotp_base;
 	struct device_node *np;
+	struct clk *clk;
 	u32 offset = of_machine_is_compatible("fsl,imx8mp") ?
 		     IMX8MP_OCOTP_UID_OFFSET : 0;
 
@@ -109,11 +110,20 @@ static void __init imx8mm_soc_uid(void)
 
 	ocotp_base = of_iomap(np, 0);
 	WARN_ON(!ocotp_base);
+	clk = of_clk_get_by_name(np, NULL);
+	if (IS_ERR(clk)) {
+		WARN_ON(IS_ERR(clk));
+		return;
+	}
+
+	clk_prepare_enable(clk);
 
 	soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH + offset);
 	soc_uid <<= 32;
 	soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW + offset);
 
+	clk_disable_unprepare(clk);
+	clk_put(clk);
 	iounmap(ocotp_base);
 	of_node_put(np);
 }
diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 2b0301fc971c..23e4c30e6a60 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1029,6 +1029,13 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
 	fspi_writel(f, FSPI_AHBCR_PREF_EN | FSPI_AHBCR_RDADDROPT,
 		 base + FSPI_AHBCR);
 
+	/* Reset the FLSHxCR1 registers. */
+	reg = FSPI_FLSHXCR1_TCSH(0x3) | FSPI_FLSHXCR1_TCSS(0x3);
+	fspi_writel(f, reg, base + FSPI_FLSHA1CR1);
+	fspi_writel(f, reg, base + FSPI_FLSHA2CR1);
+	fspi_writel(f, reg, base + FSPI_FLSHB1CR1);
+	fspi_writel(f, reg, base + FSPI_FLSHB2CR1);
+
 	/* AHB Read - Set lut sequence ID for all CS. */
 	fspi_writel(f, SEQID_LUT, base + FSPI_FLSHA1CR2);
 	fspi_writel(f, SEQID_LUT, base + FSPI_FLSHA2CR2);
diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 3c6f201b5dd8..191baa6e45c0 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -268,6 +268,7 @@ struct stm32_spi_cfg {
  * @fifo_size: size of the embedded fifo in bytes
  * @cur_midi: master inter-data idleness in ns
  * @cur_speed: speed configured in Hz
+ * @cur_half_period: time of a half bit in us
  * @cur_bpw: number of bits in a single SPI data frame
  * @cur_fthlv: fifo threshold level (data frames in a single data packet)
  * @cur_comm: SPI communication mode
@@ -294,6 +295,7 @@ struct stm32_spi {
 
 	unsigned int cur_midi;
 	unsigned int cur_speed;
+	unsigned int cur_half_period;
 	unsigned int cur_bpw;
 	unsigned int cur_fthlv;
 	unsigned int cur_comm;
@@ -454,6 +456,8 @@ static int stm32_spi_prepare_mbr(struct stm32_spi *spi, u32 speed_hz,
 
 	spi->cur_speed = spi->clk_rate / (1 << mbrdiv);
 
+	spi->cur_half_period = DIV_ROUND_CLOSEST(USEC_PER_SEC, 2 * spi->cur_speed);
+
 	return mbrdiv - 1;
 }
 
@@ -695,6 +699,10 @@ static void stm32h7_spi_disable(struct stm32_spi *spi)
 		return;
 	}
 
+	/* Add a delay to make sure that transmission is ended. */
+	if (spi->cur_half_period)
+		udelay(spi->cur_half_period);
+
 	if (spi->cur_usedma && spi->dma_tx)
 		dmaengine_terminate_all(spi->dma_tx);
 	if (spi->cur_usedma && spi->dma_rx)
diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 23ad052528db..d79853ba7792 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -95,6 +95,7 @@ struct sun6i_spi {
 	struct reset_control	*rstc;
 
 	struct completion	done;
+	struct completion	dma_rx_done;
 
 	const u8		*tx_buf;
 	u8			*rx_buf;
@@ -189,6 +190,13 @@ static size_t sun6i_spi_max_transfer_size(struct spi_device *spi)
 	return SUN6I_MAX_XFER_SIZE - 1;
 }
 
+static void sun6i_spi_dma_rx_cb(void *param)
+{
+	struct sun6i_spi *sspi = param;
+
+	complete(&sspi->dma_rx_done);
+}
+
 static int sun6i_spi_prepare_dma(struct sun6i_spi *sspi,
 				 struct spi_transfer *tfr)
 {
@@ -200,7 +208,7 @@ static int sun6i_spi_prepare_dma(struct sun6i_spi *sspi,
 		struct dma_slave_config rxconf = {
 			.direction = DMA_DEV_TO_MEM,
 			.src_addr = sspi->dma_addr_rx,
-			.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
+			.src_addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE,
 			.src_maxburst = 8,
 		};
 
@@ -213,6 +221,8 @@ static int sun6i_spi_prepare_dma(struct sun6i_spi *sspi,
 						 DMA_PREP_INTERRUPT);
 		if (!rxdesc)
 			return -EINVAL;
+		rxdesc->callback_param = sspi;
+		rxdesc->callback = sun6i_spi_dma_rx_cb;
 	}
 
 	txdesc = NULL;
@@ -268,6 +278,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 		return -EINVAL;
 
 	reinit_completion(&sspi->done);
+	reinit_completion(&sspi->dma_rx_done);
 	sspi->tx_buf = tfr->tx_buf;
 	sspi->rx_buf = tfr->rx_buf;
 	sspi->len = tfr->len;
@@ -426,6 +437,22 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	start = jiffies;
 	timeout = wait_for_completion_timeout(&sspi->done,
 					      msecs_to_jiffies(tx_time));
+
+	if (!use_dma) {
+		sun6i_spi_drain_fifo(sspi);
+	} else {
+		if (timeout && rx_len) {
+			/*
+			 * Even though RX on the peripheral side has finished
+			 * RX DMA might still be in flight
+			 */
+			timeout = wait_for_completion_timeout(&sspi->dma_rx_done,
+							      timeout);
+			if (!timeout)
+				dev_warn(&master->dev, "RX DMA timeout\n");
+		}
+	}
+
 	end = jiffies;
 	if (!timeout) {
 		dev_warn(&master->dev,
@@ -453,7 +480,6 @@ static irqreturn_t sun6i_spi_handler(int irq, void *dev_id)
 	/* Transfer complete */
 	if (status & SUN6I_INT_CTL_TC) {
 		sun6i_spi_write(sspi, SUN6I_INT_STA_REG, SUN6I_INT_CTL_TC);
-		sun6i_spi_drain_fifo(sspi);
 		complete(&sspi->done);
 		return IRQ_HANDLED;
 	}
@@ -611,6 +637,7 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 	}
 
 	init_completion(&sspi->done);
+	init_completion(&sspi->dma_rx_done);
 
 	sspi->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(sspi->rstc)) {
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 67889c014414..c16ed6e9e49d 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2412,10 +2412,8 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
 		gsm->has_devices = false;
 	}
 	for (i = NUM_DLCI - 1; i >= 0; i--)
-		if (gsm->dlci[i]) {
+		if (gsm->dlci[i])
 			gsm_dlci_release(gsm->dlci[i]);
-			gsm->dlci[i] = NULL;
-		}
 	mutex_unlock(&gsm->mutex);
 	/* Now wipe the queues */
 	tty_ldisc_flush(gsm->tty);
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 74e477016f25..45a8f76f562e 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1930,7 +1930,10 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 		skip_rx = true;
 
 	if (status & (UART_LSR_DR | UART_LSR_BI) && !skip_rx) {
-		if (irqd_is_wakeup_set(irq_get_irq_data(port->irq)))
+		struct irq_data *d;
+
+		d = irq_get_irq_data(port->irq);
+		if (d && irqd_is_wakeup_set(d))
 			pm_wakeup_event(tport->tty->dev, 0);
 		if (!up->dma || handle_rx_dma(up, iir))
 			status = serial8250_rx_chars(up, status);
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 26531aa19428..662524574cc3 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2017,7 +2017,7 @@ config FB_COBALT
 
 config FB_SH7760
 	bool "SH7760/SH7763/SH7720/SH7721 LCDC support"
-	depends on FB && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763 \
+	depends on FB=y && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763 \
 		|| CPU_SUBTYPE_SH7720 || CPU_SUBTYPE_SH7721)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index ced2fc0deb8c..a8052a3faaab 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -424,6 +424,20 @@ static unsigned int iTCO_wdt_get_timeleft(struct watchdog_device *wd_dev)
 	return time_left;
 }
 
+/* Returns true if the watchdog was running */
+static bool iTCO_wdt_set_running(struct iTCO_wdt_private *p)
+{
+	u16 val;
+
+	/* Bit 11: TCO Timer Halt -> 0 = The TCO timer is enabled */
+	val = inw(TCO1_CNT(p));
+	if (!(val & BIT(11))) {
+		set_bit(WDOG_HW_RUNNING, &p->wddev.status);
+		return true;
+	}
+	return false;
+}
+
 /*
  *	Kernel Interfaces
  */
@@ -512,9 +526,6 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
 		return -ENODEV;	/* Cannot reset NO_REBOOT bit */
 	}
 
-	/* Set the NO_REBOOT bit to prevent later reboots, just for sure */
-	p->update_no_reboot_bit(p->no_reboot_priv, true);
-
 	if (turn_SMI_watchdog_clear_off >= p->iTCO_version) {
 		/*
 		 * Bit 13: TCO_EN -> 0
@@ -566,8 +577,13 @@ static int iTCO_wdt_probe(struct platform_device *pdev)
 	watchdog_set_drvdata(&p->wddev, p);
 	platform_set_drvdata(pdev, p);
 
-	/* Make sure the watchdog is not running */
-	iTCO_wdt_stop(&p->wddev);
+	if (!iTCO_wdt_set_running(p)) {
+		/*
+		 * If the watchdog was not running set NO_REBOOT now to
+		 * prevent later reboots.
+		 */
+		p->update_no_reboot_bit(p->no_reboot_priv, true);
+	}
 
 	/* Check that the heartbeat value is within it's range;
 	   if not reset to the default */
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index c316931fc99c..f51f6e4d1a32 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -345,10 +345,9 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 	/* there's now no turning back... the old userspace image is dead,
 	 * defunct, deceased, etc.
 	 */
+	SET_PERSONALITY(exec_params.hdr);
 	if (elf_check_fdpic(&exec_params.hdr))
-		set_personality(PER_LINUX_FDPIC);
-	else
-		set_personality(PER_LINUX);
+		current->personality |= PER_LINUX_FDPIC;
 	if (elf_read_implies_exec(&exec_params.hdr, executable_stack))
 		current->personality |= READ_IMPLIES_EXEC;
 
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index e6872d65c0e2..fd951aeaeac5 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1401,9 +1401,10 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 	ret = __btrfs_add_delayed_insertion_item(delayed_node, delayed_item);
 	if (unlikely(ret)) {
 		btrfs_err(trans->fs_info,
-			  "err add delayed dir index item(name: %.*s) into the insertion tree of the delayed node(root id: %llu, inode id: %llu, errno: %d)",
-			  name_len, name, delayed_node->root->root_key.objectid,
-			  delayed_node->inode_id, ret);
+"error adding delayed dir index item, name: %.*s, index: %llu, root: %llu, dir: %llu, dir->index_cnt: %llu, delayed_node->index_cnt: %llu, error: %d",
+			  name_len, name, index, btrfs_root_id(delayed_node->root),
+			  delayed_node->inode_id, dir->index_cnt,
+			  delayed_node->index_cnt, ret);
 		BUG();
 	}
 	mutex_unlock(&delayed_node->mutex);
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index f9f6dfbc86bc..346fc46d019b 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -6722,8 +6722,14 @@ void read_extent_buffer(const struct extent_buffer *eb, void *dstv,
 	char *dst = (char *)dstv;
 	unsigned long i = get_eb_page_index(start);
 
-	if (check_eb_range(eb, start, len))
+	if (check_eb_range(eb, start, len)) {
+		/*
+		 * Invalid range hit, reset the memory, so callers won't get
+		 * some random garbage for their uninitialzed memory.
+		 */
+		memset(dstv, 0, len);
 		return;
+	}
 
 	offset = get_eb_offset_in_page(eb, start);
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index ea23b83fc96b..2fd0ee0e6e93 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2364,7 +2364,7 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	 * calculated f_bavail.
 	 */
 	if (!mixed && block_rsv->space_info->full &&
-	    total_free_meta - thresh < block_rsv->size)
+	    (total_free_meta < thresh || total_free_meta - thresh < block_rsv->size))
 		buf->f_bavail = 0;
 
 	buf->f_type = BTRFS_SUPER_MAGIC;
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 82848412ad85..30a9a89c141b 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -2531,7 +2531,7 @@ int cifs_fiemap(struct inode *inode, struct fiemap_extent_info *fei, u64 start,
 	}
 
 	cifsFileInfo_put(cfile);
-	return -ENOTSUPP;
+	return -EOPNOTSUPP;
 }
 
 int cifs_truncate_page(struct address_space *mapping, loff_t from)
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 560c4ababfe1..d8ce079ba909 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -266,7 +266,7 @@ smb2_adjust_credits(struct TCP_Server_Info *server,
 		cifs_server_dbg(VFS, "request has less credits (%d) than required (%d)",
 				credits->value, new_val);
 
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
 	spin_lock(&server->req_lock);
@@ -1308,7 +1308,7 @@ smb2_set_ea(const unsigned int xid, struct cifs_tcon *tcon,
 			/* Use a fudge factor of 256 bytes in case we collide
 			 * with a different set_EAs command.
 			 */
-			if(CIFSMaxBufSize - MAX_SMB2_CREATE_RESPONSE_SIZE -
+			if (CIFSMaxBufSize - MAX_SMB2_CREATE_RESPONSE_SIZE -
 			   MAX_SMB2_CLOSE_RESPONSE_SIZE - 256 <
 			   used_len + ea_name_len + ea_value_len + 1) {
 				rc = -ENOSPC;
@@ -4822,7 +4822,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 
 	if (shdr->Command != SMB2_READ) {
 		cifs_server_dbg(VFS, "only big read responses are supported\n");
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
 	if (server->ops->is_session_expired &&
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 976cb4b3ff66..e1a5ec7362ad 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1656,7 +1656,7 @@ struct ext4_sb_info {
 	struct task_struct *s_mmp_tsk;
 
 	/* record the last minlen when FITRIM is called. */
-	atomic_t s_last_trim_minblks;
+	unsigned long s_last_trim_minblks;
 
 	/* Reference to checksum algorithm driver via cryptoapi */
 	struct crypto_shash *s_chksum_driver;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 7e7153c673c0..e5b81d8be232 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/nospec.h>
 #include <linux/backing-dev.h>
+#include <linux/freezer.h>
 #include <trace/events/ext4.h>
 
 /*
@@ -6433,6 +6434,21 @@ __acquires(bitlock)
 	return ret;
 }
 
+static ext4_grpblk_t ext4_last_grp_cluster(struct super_block *sb,
+					   ext4_group_t grp)
+{
+	if (grp < ext4_get_groups_count(sb))
+		return EXT4_CLUSTERS_PER_GROUP(sb) - 1;
+	return (ext4_blocks_count(EXT4_SB(sb)->s_es) -
+		ext4_group_first_block_no(sb, grp) - 1) >>
+					EXT4_CLUSTER_BITS(sb);
+}
+
+static bool ext4_trim_interrupted(void)
+{
+	return fatal_signal_pending(current) || freezing(current);
+}
+
 static int ext4_try_to_trim_range(struct super_block *sb,
 		struct ext4_buddy *e4b, ext4_grpblk_t start,
 		ext4_grpblk_t max, ext4_grpblk_t minblocks)
@@ -6440,12 +6456,13 @@ __acquires(ext4_group_lock_ptr(sb, e4b->bd_group))
 __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 {
 	ext4_grpblk_t next, count, free_count;
+	bool set_trimmed = false;
 	void *bitmap;
-	int ret = 0;
 
 	bitmap = e4b->bd_bitmap;
-	start = (e4b->bd_info->bb_first_free > start) ?
-		e4b->bd_info->bb_first_free : start;
+	if (start == 0 && max >= ext4_last_grp_cluster(sb, e4b->bd_group))
+		set_trimmed = true;
+	start = max(e4b->bd_info->bb_first_free, start);
 	count = 0;
 	free_count = 0;
 
@@ -6456,19 +6473,17 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 		next = mb_find_next_bit(bitmap, max + 1, start);
 
 		if ((next - start) >= minblocks) {
-			ret = ext4_trim_extent(sb, start, next - start, e4b);
+			int ret = ext4_trim_extent(sb, start, next - start, e4b);
+
 			if (ret && ret != -EOPNOTSUPP)
-				break;
-			ret = 0;
+				return count;
 			count += next - start;
 		}
 		free_count += next - start;
 		start = next + 1;
 
-		if (fatal_signal_pending(current)) {
-			count = -ERESTARTSYS;
-			break;
-		}
+		if (ext4_trim_interrupted())
+			return count;
 
 		if (need_resched()) {
 			ext4_unlock_group(sb, e4b->bd_group);
@@ -6480,6 +6495,9 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 			break;
 	}
 
+	if (set_trimmed)
+		EXT4_MB_GRP_SET_TRIMMED(e4b->bd_info);
+
 	return count;
 }
 
@@ -6490,7 +6508,6 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
  * @start:		first group block to examine
  * @max:		last group block to examine
  * @minblocks:		minimum extent block count
- * @set_trimmed:	set the trimmed flag if at least one block is trimmed
  *
  * ext4_trim_all_free walks through group's block bitmap searching for free
  * extents. When the free extent is found, mark it as used in group buddy
@@ -6500,7 +6517,7 @@ __releases(ext4_group_lock_ptr(sb, e4b->bd_group))
 static ext4_grpblk_t
 ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 		   ext4_grpblk_t start, ext4_grpblk_t max,
-		   ext4_grpblk_t minblocks, bool set_trimmed)
+		   ext4_grpblk_t minblocks)
 {
 	struct ext4_buddy e4b;
 	int ret;
@@ -6517,13 +6534,10 @@ ext4_trim_all_free(struct super_block *sb, ext4_group_t group,
 	ext4_lock_group(sb, group);
 
 	if (!EXT4_MB_GRP_WAS_TRIMMED(e4b.bd_info) ||
-	    minblocks < atomic_read(&EXT4_SB(sb)->s_last_trim_minblks)) {
+	    minblocks < EXT4_SB(sb)->s_last_trim_minblks)
 		ret = ext4_try_to_trim_range(sb, &e4b, start, max, minblocks);
-		if (ret >= 0 && set_trimmed)
-			EXT4_MB_GRP_SET_TRIMMED(e4b.bd_info);
-	} else {
+	else
 		ret = 0;
-	}
 
 	ext4_unlock_group(sb, group);
 	ext4_mb_unload_buddy(&e4b);
@@ -6556,7 +6570,6 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 	ext4_fsblk_t first_data_blk =
 			le32_to_cpu(EXT4_SB(sb)->s_es->s_first_data_block);
 	ext4_fsblk_t max_blks = ext4_blocks_count(EXT4_SB(sb)->s_es);
-	bool whole_group, eof = false;
 	int ret = 0;
 
 	start = range->start >> sb->s_blocksize_bits;
@@ -6575,10 +6588,8 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 		if (minlen > EXT4_CLUSTERS_PER_GROUP(sb))
 			goto out;
 	}
-	if (end >= max_blks - 1) {
+	if (end >= max_blks - 1)
 		end = max_blks - 1;
-		eof = true;
-	}
 	if (end <= first_data_blk)
 		goto out;
 	if (start < first_data_blk)
@@ -6592,9 +6603,10 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 
 	/* end now represents the last cluster to discard in this group */
 	end = EXT4_CLUSTERS_PER_GROUP(sb) - 1;
-	whole_group = true;
 
 	for (group = first_group; group <= last_group; group++) {
+		if (ext4_trim_interrupted())
+			break;
 		grp = ext4_get_group_info(sb, group);
 		if (!grp)
 			continue;
@@ -6611,13 +6623,11 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 		 * change it for the last group, note that last_cluster is
 		 * already computed earlier by ext4_get_group_no_and_offset()
 		 */
-		if (group == last_group) {
+		if (group == last_group)
 			end = last_cluster;
-			whole_group = eof ? true : end == EXT4_CLUSTERS_PER_GROUP(sb) - 1;
-		}
 		if (grp->bb_free >= minlen) {
 			cnt = ext4_trim_all_free(sb, group, first_cluster,
-						 end, minlen, whole_group);
+						 end, minlen);
 			if (cnt < 0) {
 				ret = cnt;
 				break;
@@ -6633,7 +6643,7 @@ int ext4_trim_fs(struct super_block *sb, struct fstrim_range *range)
 	}
 
 	if (!ret)
-		atomic_set(&EXT4_SB(sb)->s_last_trim_minblks, minlen);
+		EXT4_SB(sb)->s_last_trim_minblks = minlen;
 
 out:
 	range->len = EXT4_C2B(EXT4_SB(sb), trimmed) << sb->s_blocksize_bits;
@@ -6662,8 +6672,7 @@ ext4_mballoc_query_range(
 
 	ext4_lock_group(sb, group);
 
-	start = (e4b.bd_info->bb_first_free > start) ?
-		e4b.bd_info->bb_first_free : start;
+	start = max(e4b.bd_info->bb_first_free, start);
 	if (end >= EXT4_CLUSTERS_PER_GROUP(sb))
 		end = EXT4_CLUSTERS_PER_GROUP(sb) - 1;
 
diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 018af6ec97b4..bbe2a5cc49f6 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -525,7 +525,9 @@ static void nfs_direct_add_page_head(struct list_head *list,
 	kref_get(&head->wb_kref);
 }
 
-static void nfs_direct_join_group(struct list_head *list, struct inode *inode)
+static void nfs_direct_join_group(struct list_head *list,
+				  struct nfs_commit_info *cinfo,
+				  struct inode *inode)
 {
 	struct nfs_page *req, *subreq;
 
@@ -547,7 +549,7 @@ static void nfs_direct_join_group(struct list_head *list, struct inode *inode)
 				nfs_release_request(subreq);
 			}
 		} while ((subreq = subreq->wb_this_page) != req);
-		nfs_join_page_group(req, inode);
+		nfs_join_page_group(req, cinfo, inode);
 	}
 }
 
@@ -573,7 +575,7 @@ static void nfs_direct_write_reschedule(struct nfs_direct_req *dreq)
 	nfs_init_cinfo_from_dreq(&cinfo, dreq);
 	nfs_direct_write_scan_commit_list(dreq->inode, &reqs, &cinfo);
 
-	nfs_direct_join_group(&reqs, dreq->inode);
+	nfs_direct_join_group(&reqs, &cinfo, dreq->inode);
 
 	dreq->count = 0;
 	dreq->max_count = 0;
@@ -784,16 +786,21 @@ static void nfs_write_sync_pgio_error(struct list_head *head, int error)
 static void nfs_direct_write_reschedule_io(struct nfs_pgio_header *hdr)
 {
 	struct nfs_direct_req *dreq = hdr->dreq;
+	struct nfs_page *req;
+	struct nfs_commit_info cinfo;
 
+	nfs_init_cinfo_from_dreq(&cinfo, dreq);
 	spin_lock(&dreq->lock);
-	if (dreq->error == 0) {
+	if (dreq->error == 0)
 		dreq->flags = NFS_ODIRECT_RESCHED_WRITES;
-		/* fake unstable write to let common nfs resend pages */
-		hdr->verf.committed = NFS_UNSTABLE;
-		hdr->good_bytes = hdr->args.offset + hdr->args.count -
-			hdr->io_start;
-	}
+	set_bit(NFS_IOHDR_REDO, &hdr->flags);
 	spin_unlock(&dreq->lock);
+	while (!list_empty(&hdr->pages)) {
+		req = nfs_list_entry(hdr->pages.next);
+		nfs_list_remove_request(req);
+		nfs_unlock_request(req);
+		nfs_mark_request_commit(req, NULL, &cinfo, 0);
+	}
 }
 
 static const struct nfs_pgio_completion_ops nfs_direct_write_completion_ops = {
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index ceef75b4d249..4269df0f0ffa 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1238,6 +1238,7 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 		case -EPFNOSUPPORT:
 		case -EPROTONOSUPPORT:
 		case -EOPNOTSUPP:
+		case -EINVAL:
 		case -ECONNREFUSED:
 		case -ECONNRESET:
 		case -EHOSTDOWN:
diff --git a/fs/nfs/nfs4client.c b/fs/nfs/nfs4client.c
index 1bf7a72ebda6..cba8b4c1fb4a 100644
--- a/fs/nfs/nfs4client.c
+++ b/fs/nfs/nfs4client.c
@@ -231,6 +231,8 @@ struct nfs_client *nfs4_alloc_client(const struct nfs_client_initdata *cl_init)
 	__set_bit(NFS_CS_DISCRTRY, &clp->cl_flags);
 	__set_bit(NFS_CS_NO_RETRANS_TIMEOUT, &clp->cl_flags);
 
+	if (test_bit(NFS_CS_DS, &cl_init->init_flags))
+		__set_bit(NFS_CS_DS, &clp->cl_flags);
 	/*
 	 * Set up the connection to the server before we add add to the
 	 * global list.
@@ -414,6 +416,8 @@ static void nfs4_add_trunk(struct nfs_client *clp, struct nfs_client *old)
 		.net = old->cl_net,
 		.servername = old->cl_hostname,
 	};
+	int max_connect = test_bit(NFS_CS_PNFS, &clp->cl_flags) ?
+		clp->cl_max_connect : old->cl_max_connect;
 
 	if (clp->cl_proto != old->cl_proto)
 		return;
@@ -427,7 +431,7 @@ static void nfs4_add_trunk(struct nfs_client *clp, struct nfs_client *old)
 	xprt_args.addrlen = clp_salen;
 
 	rpc_clnt_add_xprt(old->cl_rpcclient, &xprt_args,
-			  rpc_clnt_test_and_add_xprt, NULL);
+			  rpc_clnt_test_and_add_xprt, &max_connect);
 }
 
 /**
@@ -993,6 +997,9 @@ struct nfs_client *nfs4_set_ds_client(struct nfs_server *mds_srv,
 	if (mds_srv->flags & NFS_MOUNT_NORESVPORT)
 		__set_bit(NFS_CS_NORESVPORT, &cl_init.init_flags);
 
+	__set_bit(NFS_CS_DS, &cl_init.init_flags);
+	__set_bit(NFS_CS_PNFS, &cl_init.init_flags);
+	cl_init.max_connect = NFS_MAX_TRANSPORTS;
 	/*
 	 * Set an authflavor equual to the MDS value. Use the MDS nfs_client
 	 * cl_ipaddr so as to use the same EXCHANGE_ID co_ownerid as the MDS
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index a21e25cbd451..32204c0b3d09 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -8715,6 +8715,8 @@ nfs4_run_exchange_id(struct nfs_client *clp, const struct cred *cred,
 #ifdef CONFIG_NFS_V4_1_MIGRATION
 	calldata->args.flags |= EXCHGID4_FLAG_SUPP_MOVED_MIGR;
 #endif
+	if (test_bit(NFS_CS_DS, &clp->cl_flags))
+		calldata->args.flags |= EXCHGID4_FLAG_USE_PNFS_DS;
 	msg.rpc_argp = &calldata->args;
 	msg.rpc_resp = &calldata->res;
 	task_setup_data.callback_data = calldata;
@@ -8792,6 +8794,8 @@ static int _nfs4_proc_exchange_id(struct nfs_client *clp, const struct cred *cre
 	/* Save the EXCHANGE_ID verifier session trunk tests */
 	memcpy(clp->cl_confirm.data, argp->verifier.data,
 	       sizeof(clp->cl_confirm.data));
+	if (resp->flags & EXCHGID4_FLAG_USE_PNFS_DS)
+		set_bit(NFS_CS_DS, &clp->cl_flags);
 out:
 	trace_nfs4_exchange_id(clp, status);
 	rpc_put_task(task);
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index be70874bc329..4231d51fc1ad 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -58,7 +58,8 @@ static const struct nfs_pgio_completion_ops nfs_async_write_completion_ops;
 static const struct nfs_commit_completion_ops nfs_commit_completion_ops;
 static const struct nfs_rw_ops nfs_rw_write_ops;
 static void nfs_inode_remove_request(struct nfs_page *req);
-static void nfs_clear_request_commit(struct nfs_page *req);
+static void nfs_clear_request_commit(struct nfs_commit_info *cinfo,
+				     struct nfs_page *req);
 static void nfs_init_cinfo_from_inode(struct nfs_commit_info *cinfo,
 				      struct inode *inode);
 static struct nfs_page *
@@ -500,8 +501,8 @@ nfs_destroy_unlinked_subrequests(struct nfs_page *destroy_list,
  * the (former) group.  All subrequests are removed from any write or commit
  * lists, unlinked from the group and destroyed.
  */
-void
-nfs_join_page_group(struct nfs_page *head, struct inode *inode)
+void nfs_join_page_group(struct nfs_page *head, struct nfs_commit_info *cinfo,
+			 struct inode *inode)
 {
 	struct nfs_page *subreq;
 	struct nfs_page *destroy_list = NULL;
@@ -531,7 +532,7 @@ nfs_join_page_group(struct nfs_page *head, struct inode *inode)
 	 * Commit list removal accounting is done after locks are dropped */
 	subreq = head;
 	do {
-		nfs_clear_request_commit(subreq);
+		nfs_clear_request_commit(cinfo, subreq);
 		subreq = subreq->wb_this_page;
 	} while (subreq != head);
 
@@ -565,8 +566,10 @@ nfs_lock_and_join_requests(struct page *page)
 {
 	struct inode *inode = page_file_mapping(page)->host;
 	struct nfs_page *head;
+	struct nfs_commit_info cinfo;
 	int ret;
 
+	nfs_init_cinfo_from_inode(&cinfo, inode);
 	/*
 	 * A reference is taken only on the head request which acts as a
 	 * reference to the whole page group - the group will not be destroyed
@@ -583,7 +586,7 @@ nfs_lock_and_join_requests(struct page *page)
 		return ERR_PTR(ret);
 	}
 
-	nfs_join_page_group(head, inode);
+	nfs_join_page_group(head, &cinfo, inode);
 
 	return head;
 }
@@ -945,18 +948,16 @@ nfs_clear_page_commit(struct page *page)
 }
 
 /* Called holding the request lock on @req */
-static void
-nfs_clear_request_commit(struct nfs_page *req)
+static void nfs_clear_request_commit(struct nfs_commit_info *cinfo,
+				     struct nfs_page *req)
 {
 	if (test_bit(PG_CLEAN, &req->wb_flags)) {
 		struct nfs_open_context *ctx = nfs_req_openctx(req);
 		struct inode *inode = d_inode(ctx->dentry);
-		struct nfs_commit_info cinfo;
 
-		nfs_init_cinfo_from_inode(&cinfo, inode);
 		mutex_lock(&NFS_I(inode)->commit_mutex);
-		if (!pnfs_clear_request_commit(req, &cinfo)) {
-			nfs_request_remove_commit_list(req, &cinfo);
+		if (!pnfs_clear_request_commit(req, cinfo)) {
+			nfs_request_remove_commit_list(req, cinfo);
 		}
 		mutex_unlock(&NFS_I(inode)->commit_mutex);
 		nfs_clear_page_commit(req->wb_page);
diff --git a/fs/nilfs2/gcinode.c b/fs/nilfs2/gcinode.c
index aadea660c66c..b0077f5f7112 100644
--- a/fs/nilfs2/gcinode.c
+++ b/fs/nilfs2/gcinode.c
@@ -73,10 +73,8 @@ int nilfs_gccache_submit_read_data(struct inode *inode, sector_t blkoff,
 		struct the_nilfs *nilfs = inode->i_sb->s_fs_info;
 
 		err = nilfs_dat_translate(nilfs->ns_dat, vbn, &pbn);
-		if (unlikely(err)) { /* -EIO, -ENOMEM, -ENOENT */
-			brelse(bh);
+		if (unlikely(err)) /* -EIO, -ENOMEM, -ENOENT */
 			goto failed;
-		}
 	}
 
 	lock_buffer(bh);
@@ -102,6 +100,8 @@ int nilfs_gccache_submit_read_data(struct inode *inode, sector_t blkoff,
  failed:
 	unlock_page(bh->b_page);
 	put_page(bh->b_page);
+	if (unlikely(err))
+		brelse(bh);
 	return err;
 }
 
diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index a6d21fc0033c..97f387d30e74 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -208,11 +208,16 @@ static void *m_start(struct seq_file *m, loff_t *pos)
 		return ERR_PTR(-ESRCH);
 
 	mm = priv->mm;
-	if (!mm || !mmget_not_zero(mm))
+	if (!mm || !mmget_not_zero(mm)) {
+		put_task_struct(priv->task);
+		priv->task = NULL;
 		return NULL;
+	}
 
 	if (mmap_read_lock_killable(mm)) {
 		mmput(mm);
+		put_task_struct(priv->task);
+		priv->task = NULL;
 		return ERR_PTR(-EINTR);
 	}
 
@@ -221,23 +226,21 @@ static void *m_start(struct seq_file *m, loff_t *pos)
 		if (n-- == 0)
 			return p;
 
-	mmap_read_unlock(mm);
-	mmput(mm);
 	return NULL;
 }
 
-static void m_stop(struct seq_file *m, void *_vml)
+static void m_stop(struct seq_file *m, void *v)
 {
 	struct proc_maps_private *priv = m->private;
+	struct mm_struct *mm = priv->mm;
 
-	if (!IS_ERR_OR_NULL(_vml)) {
-		mmap_read_unlock(priv->mm);
-		mmput(priv->mm);
-	}
-	if (priv->task) {
-		put_task_struct(priv->task);
-		priv->task = NULL;
-	}
+	if (!priv->task)
+		return;
+
+	mmap_read_unlock(mm);
+	mmput(mm);
+	put_task_struct(priv->task);
+	priv->task = NULL;
 }
 
 static void *m_next(struct seq_file *m, void *_p, loff_t *pos)
diff --git a/fs/xfs/scrub/common.c b/fs/xfs/scrub/common.c
index bf1f3607d0b6..08df23edea72 100644
--- a/fs/xfs/scrub/common.c
+++ b/fs/xfs/scrub/common.c
@@ -864,28 +864,3 @@ xchk_ilock_inverted(
 	return -EDEADLOCK;
 }
 
-/* Pause background reaping of resources. */
-void
-xchk_stop_reaping(
-	struct xfs_scrub	*sc)
-{
-	sc->flags |= XCHK_REAPING_DISABLED;
-	xfs_blockgc_stop(sc->mp);
-	xfs_inodegc_stop(sc->mp);
-}
-
-/* Restart background reaping of resources. */
-void
-xchk_start_reaping(
-	struct xfs_scrub	*sc)
-{
-	/*
-	 * Readonly filesystems do not perform inactivation or speculative
-	 * preallocation, so there's no need to restart the workers.
-	 */
-	if (!xfs_is_readonly(sc->mp)) {
-		xfs_inodegc_start(sc->mp);
-		xfs_blockgc_start(sc->mp);
-	}
-	sc->flags &= ~XCHK_REAPING_DISABLED;
-}
diff --git a/fs/xfs/scrub/common.h b/fs/xfs/scrub/common.h
index 454145db10e7..2ca80102e704 100644
--- a/fs/xfs/scrub/common.h
+++ b/fs/xfs/scrub/common.h
@@ -148,7 +148,5 @@ static inline bool xchk_skip_xref(struct xfs_scrub_metadata *sm)
 
 int xchk_metadata_inode_forks(struct xfs_scrub *sc);
 int xchk_ilock_inverted(struct xfs_inode *ip, uint lock_mode);
-void xchk_stop_reaping(struct xfs_scrub *sc);
-void xchk_start_reaping(struct xfs_scrub *sc);
 
 #endif	/* __XFS_SCRUB_COMMON_H__ */
diff --git a/fs/xfs/scrub/fscounters.c b/fs/xfs/scrub/fscounters.c
index 48a6cbdf95d0..037541339d80 100644
--- a/fs/xfs/scrub/fscounters.c
+++ b/fs/xfs/scrub/fscounters.c
@@ -128,13 +128,6 @@ xchk_setup_fscounters(
 	if (error)
 		return error;
 
-	/*
-	 * Pause background reclaim while we're scrubbing to reduce the
-	 * likelihood of background perturbations to the counters throwing off
-	 * our calculations.
-	 */
-	xchk_stop_reaping(sc);
-
 	return xchk_trans_alloc(sc, 0);
 }
 
@@ -353,6 +346,12 @@ xchk_fscounters(
 	if (fdblocks > mp->m_sb.sb_dblocks)
 		xchk_set_corrupt(sc);
 
+	/*
+	 * XXX: We can't quiesce percpu counter updates, so exit early.
+	 * This can be re-enabled when we gain exclusive freeze functionality.
+	 */
+	return 0;
+
 	/*
 	 * If ifree exceeds icount by more than the minimum variance then
 	 * something's probably wrong with the counters.
diff --git a/fs/xfs/scrub/scrub.c b/fs/xfs/scrub/scrub.c
index 51e4c61916d2..e4d2a41983f7 100644
--- a/fs/xfs/scrub/scrub.c
+++ b/fs/xfs/scrub/scrub.c
@@ -171,8 +171,6 @@ xchk_teardown(
 	}
 	if (sc->sm->sm_flags & XFS_SCRUB_IFLAG_REPAIR)
 		mnt_drop_write_file(sc->file);
-	if (sc->flags & XCHK_REAPING_DISABLED)
-		xchk_start_reaping(sc);
 	if (sc->flags & XCHK_HAS_QUOTAOFFLOCK) {
 		mutex_unlock(&sc->mp->m_quotainfo->qi_quotaofflock);
 		sc->flags &= ~XCHK_HAS_QUOTAOFFLOCK;
diff --git a/fs/xfs/scrub/scrub.h b/fs/xfs/scrub/scrub.h
index 80e5026bba44..e8d9fe9de26e 100644
--- a/fs/xfs/scrub/scrub.h
+++ b/fs/xfs/scrub/scrub.h
@@ -89,7 +89,6 @@ struct xfs_scrub {
 /* XCHK state flags grow up from zero, XREP state flags grown down from 2^31 */
 #define XCHK_TRY_HARDER		(1 << 0)  /* can't get resources, try again */
 #define XCHK_HAS_QUOTAOFFLOCK	(1 << 1)  /* we hold the quotaoff lock */
-#define XCHK_REAPING_DISABLED	(1 << 2)  /* background block reaping paused */
 #define XREP_ALREADY_FIXED	(1 << 31) /* checking our repair work */
 
 /* Metadata scrubbers */
diff --git a/fs/xfs/xfs_icache.c b/fs/xfs/xfs_icache.c
index 5e44d7bbd8fc..eab98d76dbe1 100644
--- a/fs/xfs/xfs_icache.c
+++ b/fs/xfs/xfs_icache.c
@@ -448,18 +448,23 @@ xfs_iget_check_free_state(
 }
 
 /* Make all pending inactivation work start immediately. */
-static void
+static bool
 xfs_inodegc_queue_all(
 	struct xfs_mount	*mp)
 {
 	struct xfs_inodegc	*gc;
 	int			cpu;
+	bool			ret = false;
 
 	for_each_online_cpu(cpu) {
 		gc = per_cpu_ptr(mp->m_inodegc, cpu);
-		if (!llist_empty(&gc->list))
-			queue_work_on(cpu, mp->m_inodegc_wq, &gc->work);
+		if (!llist_empty(&gc->list)) {
+			mod_delayed_work_on(cpu, mp->m_inodegc_wq, &gc->work, 0);
+			ret = true;
+		}
 	}
+
+	return ret;
 }
 
 /*
@@ -1851,11 +1856,13 @@ void
 xfs_inodegc_worker(
 	struct work_struct	*work)
 {
-	struct xfs_inodegc	*gc = container_of(work, struct xfs_inodegc,
-							work);
+	struct xfs_inodegc	*gc = container_of(to_delayed_work(work),
+						struct xfs_inodegc, work);
 	struct llist_node	*node = llist_del_all(&gc->list);
 	struct xfs_inode	*ip, *n;
 
+	ASSERT(gc->cpu == smp_processor_id());
+
 	WRITE_ONCE(gc->items, 0);
 
 	if (!node)
@@ -1872,42 +1879,69 @@ xfs_inodegc_worker(
 }
 
 /*
- * Force all currently queued inode inactivation work to run immediately and
- * wait for the work to finish.
+ * Expedite all pending inodegc work to run immediately. This does not wait for
+ * completion of the work.
  */
 void
-xfs_inodegc_flush(
+xfs_inodegc_push(
 	struct xfs_mount	*mp)
 {
 	if (!xfs_is_inodegc_enabled(mp))
 		return;
+	trace_xfs_inodegc_push(mp, __return_address);
+	xfs_inodegc_queue_all(mp);
+}
 
+/*
+ * Force all currently queued inode inactivation work to run immediately and
+ * wait for the work to finish.
+ */
+void
+xfs_inodegc_flush(
+	struct xfs_mount	*mp)
+{
+	xfs_inodegc_push(mp);
 	trace_xfs_inodegc_flush(mp, __return_address);
-
-	xfs_inodegc_queue_all(mp);
 	flush_workqueue(mp->m_inodegc_wq);
 }
 
 /*
  * Flush all the pending work and then disable the inode inactivation background
- * workers and wait for them to stop.
+ * workers and wait for them to stop.  Caller must hold sb->s_umount to
+ * coordinate changes in the inodegc_enabled state.
  */
 void
 xfs_inodegc_stop(
 	struct xfs_mount	*mp)
 {
+	bool			rerun;
+
 	if (!xfs_clear_inodegc_enabled(mp))
 		return;
 
+	/*
+	 * Drain all pending inodegc work, including inodes that could be
+	 * queued by racing xfs_inodegc_queue or xfs_inodegc_shrinker_scan
+	 * threads that sample the inodegc state just prior to us clearing it.
+	 * The inodegc flag state prevents new threads from queuing more
+	 * inodes, so we queue pending work items and flush the workqueue until
+	 * all inodegc lists are empty.  IOWs, we cannot use drain_workqueue
+	 * here because it does not allow other unserialized mechanisms to
+	 * reschedule inodegc work while this draining is in progress.
+	 */
 	xfs_inodegc_queue_all(mp);
-	drain_workqueue(mp->m_inodegc_wq);
+	do {
+		flush_workqueue(mp->m_inodegc_wq);
+		rerun = xfs_inodegc_queue_all(mp);
+	} while (rerun);
 
 	trace_xfs_inodegc_stop(mp, __return_address);
 }
 
 /*
  * Enable the inode inactivation background workers and schedule deferred inode
- * inactivation work if there is any.
+ * inactivation work if there is any.  Caller must hold sb->s_umount to
+ * coordinate changes in the inodegc_enabled state.
  */
 void
 xfs_inodegc_start(
@@ -2021,6 +2055,7 @@ xfs_inodegc_queue(
 	struct xfs_inodegc	*gc;
 	int			items;
 	unsigned int		shrinker_hits;
+	unsigned long		queue_delay = 1;
 
 	trace_xfs_inode_set_need_inactive(ip);
 	spin_lock(&ip->i_flags_lock);
@@ -2032,19 +2067,27 @@ xfs_inodegc_queue(
 	items = READ_ONCE(gc->items);
 	WRITE_ONCE(gc->items, items + 1);
 	shrinker_hits = READ_ONCE(gc->shrinker_hits);
-	put_cpu_ptr(gc);
 
-	if (!xfs_is_inodegc_enabled(mp))
+	/*
+	 * We queue the work while holding the current CPU so that the work
+	 * is scheduled to run on this CPU.
+	 */
+	if (!xfs_is_inodegc_enabled(mp)) {
+		put_cpu_ptr(gc);
 		return;
-
-	if (xfs_inodegc_want_queue_work(ip, items)) {
-		trace_xfs_inodegc_queue(mp, __return_address);
-		queue_work(mp->m_inodegc_wq, &gc->work);
 	}
 
+	if (xfs_inodegc_want_queue_work(ip, items))
+		queue_delay = 0;
+
+	trace_xfs_inodegc_queue(mp, __return_address);
+	mod_delayed_work_on(current_cpu(), mp->m_inodegc_wq, &gc->work,
+			queue_delay);
+	put_cpu_ptr(gc);
+
 	if (xfs_inodegc_want_flush_work(ip, items, shrinker_hits)) {
 		trace_xfs_inodegc_throttle(mp, __return_address);
-		flush_work(&gc->work);
+		flush_delayed_work(&gc->work);
 	}
 }
 
@@ -2061,7 +2104,7 @@ xfs_inodegc_cpu_dead(
 	unsigned int		count = 0;
 
 	dead_gc = per_cpu_ptr(mp->m_inodegc, dead_cpu);
-	cancel_work_sync(&dead_gc->work);
+	cancel_delayed_work_sync(&dead_gc->work);
 
 	if (llist_empty(&dead_gc->list))
 		return;
@@ -2080,12 +2123,13 @@ xfs_inodegc_cpu_dead(
 	llist_add_batch(first, last, &gc->list);
 	count += READ_ONCE(gc->items);
 	WRITE_ONCE(gc->items, count);
-	put_cpu_ptr(gc);
 
 	if (xfs_is_inodegc_enabled(mp)) {
 		trace_xfs_inodegc_queue(mp, __return_address);
-		queue_work(mp->m_inodegc_wq, &gc->work);
+		mod_delayed_work_on(current_cpu(), mp->m_inodegc_wq, &gc->work,
+				0);
 	}
+	put_cpu_ptr(gc);
 }
 
 /*
@@ -2180,7 +2224,7 @@ xfs_inodegc_shrinker_scan(
 			unsigned int	h = READ_ONCE(gc->shrinker_hits);
 
 			WRITE_ONCE(gc->shrinker_hits, h + 1);
-			queue_work_on(cpu, mp->m_inodegc_wq, &gc->work);
+			mod_delayed_work_on(cpu, mp->m_inodegc_wq, &gc->work, 0);
 			no_items = false;
 		}
 	}
diff --git a/fs/xfs/xfs_icache.h b/fs/xfs/xfs_icache.h
index 2e4cfddf8b8e..6cd180721659 100644
--- a/fs/xfs/xfs_icache.h
+++ b/fs/xfs/xfs_icache.h
@@ -76,6 +76,7 @@ void xfs_blockgc_stop(struct xfs_mount *mp);
 void xfs_blockgc_start(struct xfs_mount *mp);
 
 void xfs_inodegc_worker(struct work_struct *work);
+void xfs_inodegc_push(struct xfs_mount *mp);
 void xfs_inodegc_flush(struct xfs_mount *mp);
 void xfs_inodegc_stop(struct xfs_mount *mp);
 void xfs_inodegc_start(struct xfs_mount *mp);
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index 86564295fce6..29f35169bf9c 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -61,11 +61,14 @@ struct xfs_error_cfg {
  */
 struct xfs_inodegc {
 	struct llist_head	list;
-	struct work_struct	work;
+	struct delayed_work	work;
 
 	/* approximate count of inodes in the list */
 	unsigned int		items;
 	unsigned int		shrinker_hits;
+#if defined(DEBUG) || defined(XFS_WARN)
+	unsigned int		cpu;
+#endif
 };
 
 /*
diff --git a/fs/xfs/xfs_qm_syscalls.c b/fs/xfs/xfs_qm_syscalls.c
index 47fe60e1a887..322a111dfbc0 100644
--- a/fs/xfs/xfs_qm_syscalls.c
+++ b/fs/xfs/xfs_qm_syscalls.c
@@ -481,9 +481,12 @@ xfs_qm_scall_getquota(
 	struct xfs_dquot	*dqp;
 	int			error;
 
-	/* Flush inodegc work at the start of a quota reporting scan. */
+	/*
+	 * Expedite pending inodegc work at the start of a quota reporting
+	 * scan but don't block waiting for it to complete.
+	 */
 	if (id == 0)
-		xfs_inodegc_flush(mp);
+		xfs_inodegc_push(mp);
 
 	/*
 	 * Try to get the dquot. We don't want it allocated on disk, so don't
@@ -525,7 +528,7 @@ xfs_qm_scall_getquota_next(
 
 	/* Flush inodegc work at the start of a quota reporting scan. */
 	if (*id == 0)
-		xfs_inodegc_flush(mp);
+		xfs_inodegc_push(mp);
 
 	error = xfs_qm_dqget_next(mp, *id, type, &dqp);
 	if (error)
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index df1d6be61bfa..569960e4ea3a 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -795,8 +795,11 @@ xfs_fs_statfs(
 	xfs_extlen_t		lsize;
 	int64_t			ffree;
 
-	/* Wait for whatever inactivations are in progress. */
-	xfs_inodegc_flush(mp);
+	/*
+	 * Expedite background inodegc but don't wait. We do not want to block
+	 * here waiting hours for a billion extent file to be truncated.
+	 */
+	xfs_inodegc_push(mp);
 
 	statp->f_type = XFS_SUPER_MAGIC;
 	statp->f_namelen = MAXNAMELEN - 1;
@@ -1059,9 +1062,12 @@ xfs_inodegc_init_percpu(
 
 	for_each_possible_cpu(cpu) {
 		gc = per_cpu_ptr(mp->m_inodegc, cpu);
+#if defined(DEBUG) || defined(XFS_WARN)
+		gc->cpu = cpu;
+#endif
 		init_llist_head(&gc->list);
 		gc->items = 0;
-		INIT_WORK(&gc->work, xfs_inodegc_worker);
+		INIT_DELAYED_WORK(&gc->work, xfs_inodegc_worker);
 	}
 	return 0;
 }
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 1033a95fbf8e..ebd17ddba024 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -240,6 +240,7 @@ DEFINE_EVENT(xfs_fs_class, name,					\
 	TP_PROTO(struct xfs_mount *mp, void *caller_ip), \
 	TP_ARGS(mp, caller_ip))
 DEFINE_FS_EVENT(xfs_inodegc_flush);
+DEFINE_FS_EVENT(xfs_inodegc_push);
 DEFINE_FS_EVENT(xfs_inodegc_start);
 DEFINE_FS_EVENT(xfs_inodegc_stop);
 DEFINE_FS_EVENT(xfs_inodegc_queue);
diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 47d9abfbdb55..1deb9a0fe74e 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -38,7 +38,7 @@ asm(							\
 	____BTF_ID(symbol)
 
 #define __ID(prefix) \
-	__PASTE(prefix, __COUNTER__)
+	__PASTE(__PASTE(prefix, __COUNTER__), __LINE__)
 
 /*
  * The BTF_ID defines unique symbol for each ID pointing
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 45cdb12243e3..0d97d1cf660f 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -451,6 +451,7 @@ extern struct mutex cgroup_mutex;
 extern spinlock_t css_set_lock;
 #define task_css_set_check(task, __c)					\
 	rcu_dereference_check((task)->cgroups,				\
+		rcu_read_lock_sched_held() ||				\
 		lockdep_is_held(&cgroup_mutex) ||			\
 		lockdep_is_held(&css_set_lock) ||			\
 		((task)->flags & PF_EXITING) || (__c))
@@ -792,11 +793,9 @@ static inline void cgroup_account_cputime(struct task_struct *task,
 
 	cpuacct_charge(task, delta_exec);
 
-	rcu_read_lock();
 	cgrp = task_dfl_cgroup(task);
 	if (cgroup_parent(cgrp))
 		__cgroup_account_cputime(cgrp, delta_exec);
-	rcu_read_unlock();
 }
 
 static inline void cgroup_account_cputime_field(struct task_struct *task,
diff --git a/include/linux/if_team.h b/include/linux/if_team.h
index 5dd1657947b7..762c77d13e7d 100644
--- a/include/linux/if_team.h
+++ b/include/linux/if_team.h
@@ -189,6 +189,8 @@ struct team {
 	struct net_device *dev; /* associated netdevice */
 	struct team_pcpu_stats __percpu *pcpu_stats;
 
+	const struct header_ops *header_ops_cache;
+
 	struct mutex lock; /* used for overall locking, e.g. port lists write */
 
 	/*
diff --git a/include/linux/libata.h b/include/linux/libata.h
index fa568d35bcbf..3069064dc269 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -191,7 +191,7 @@ enum {
 	ATA_LFLAG_NO_LPM	= (1 << 8), /* disable LPM on this link */
 	ATA_LFLAG_RST_ONCE	= (1 << 9), /* limit recovery to one reset */
 	ATA_LFLAG_CHANGED	= (1 << 10), /* LPM state changed on this link */
-	ATA_LFLAG_NO_DB_DELAY	= (1 << 11), /* no debounce delay on link resume */
+	ATA_LFLAG_NO_DEBOUNCE_DELAY = (1 << 11), /* no debounce delay on link resume */
 
 	/* struct ata_port flags */
 	ATA_FLAG_SLAVE_POSS	= (1 << 0), /* host supports slave dev */
@@ -301,7 +301,7 @@ enum {
 	 * advised to wait only for the following duration before
 	 * doing SRST.
 	 */
-	ATA_TMOUT_PMP_SRST_WAIT	= 5000,
+	ATA_TMOUT_PMP_SRST_WAIT	= 10000,
 
 	/* When the LPM policy is set to ATA_LPM_MAX_POWER, there might
 	 * be a spurious PHY event, so ignore the first PHY event that
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index da9ef0ab9b4b..5e065f16d061 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -48,6 +48,7 @@ struct nfs_client {
 #define NFS_CS_NOPING		6		/* - don't ping on connect */
 #define NFS_CS_DS		7		/* - Server is a DS */
 #define NFS_CS_REUSEPORT	8		/* - reuse src port on reconnect */
+#define NFS_CS_PNFS		9		/* - Server used for pnfs */
 	struct sockaddr_storage	cl_addr;	/* server identifier */
 	size_t			cl_addrlen;
 	char *			cl_hostname;	/* hostname of server */
diff --git a/include/linux/nfs_page.h b/include/linux/nfs_page.h
index f0373a6cb5fb..40aa09a21f75 100644
--- a/include/linux/nfs_page.h
+++ b/include/linux/nfs_page.h
@@ -145,7 +145,9 @@ extern	void nfs_unlock_request(struct nfs_page *req);
 extern	void nfs_unlock_and_release_request(struct nfs_page *);
 extern	struct nfs_page *nfs_page_group_lock_head(struct nfs_page *req);
 extern	int nfs_page_group_lock_subrequests(struct nfs_page *head);
-extern	void nfs_join_page_group(struct nfs_page *head, struct inode *inode);
+extern void nfs_join_page_group(struct nfs_page *head,
+				struct nfs_commit_info *cinfo,
+				struct inode *inode);
 extern int nfs_page_group_lock(struct nfs_page *);
 extern void nfs_page_group_unlock(struct nfs_page *);
 extern bool nfs_page_group_sync_on_bit(struct nfs_page *, unsigned int);
diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 37ded6b8fee6..2c5d0102315d 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -516,8 +516,8 @@ do {									\
 
 static inline void do_write_seqcount_begin_nested(seqcount_t *s, int subclass)
 {
-	do_raw_write_seqcount_begin(s);
 	seqcount_acquire(&s->dep_map, subclass, 0, _RET_IP_);
+	do_raw_write_seqcount_begin(s);
 }
 
 /**
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 1458b3eae8ad..a0b47f2b896e 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -477,6 +477,7 @@ struct nft_set_elem_expr {
  *
  *	@list: table set list node
  *	@bindings: list of set bindings
+ *	@refs: internal refcounting for async set destruction
  *	@table: table this set belongs to
  *	@net: netnamespace this set belongs to
  * 	@name: name of the set
@@ -498,6 +499,7 @@ struct nft_set_elem_expr {
  *	@expr: stateful expression
  * 	@ops: set ops
  * 	@flags: set flags
+ *	@dead: set will be freed, never cleared
  *	@genmask: generation mask
  * 	@klen: key length
  * 	@dlen: data length
@@ -506,6 +508,7 @@ struct nft_set_elem_expr {
 struct nft_set {
 	struct list_head		list;
 	struct list_head		bindings;
+	refcount_t			refs;
 	struct nft_table		*table;
 	possible_net_t			net;
 	char				*name;
@@ -527,7 +530,8 @@ struct nft_set {
 	struct list_head		pending_update;
 	/* runtime data below here */
 	const struct nft_set_ops	*ops ____cacheline_aligned;
-	u16				flags:14,
+	u16				flags:13,
+					dead:1,
 					genmask:2;
 	u8				klen;
 	u8				dlen;
@@ -548,6 +552,11 @@ static inline void *nft_set_priv(const struct nft_set *set)
 	return (void *)set->data;
 }
 
+static inline bool nft_set_gc_is_pending(const struct nft_set *s)
+{
+	return refcount_read(&s->refs) != 1;
+}
+
 static inline struct nft_set *nft_set_container_of(const void *priv)
 {
 	return (void *)priv - offsetof(struct nft_set, data);
@@ -561,7 +570,6 @@ struct nft_set *nft_set_lookup_global(const struct net *net,
 
 struct nft_set_ext *nft_set_catchall_lookup(const struct net *net,
 					    const struct nft_set *set);
-void *nft_set_catchall_gc(const struct nft_set *set);
 
 static inline unsigned long nft_set_gc_interval(const struct nft_set *set)
 {
@@ -776,62 +784,6 @@ void nft_set_elem_destroy(const struct nft_set *set, void *elem,
 void nf_tables_set_elem_destroy(const struct nft_ctx *ctx,
 				const struct nft_set *set, void *elem);
 
-/**
- *	struct nft_set_gc_batch_head - nf_tables set garbage collection batch
- *
- *	@rcu: rcu head
- *	@set: set the elements belong to
- *	@cnt: count of elements
- */
-struct nft_set_gc_batch_head {
-	struct rcu_head			rcu;
-	const struct nft_set		*set;
-	unsigned int			cnt;
-};
-
-#define NFT_SET_GC_BATCH_SIZE	((PAGE_SIZE -				  \
-				  sizeof(struct nft_set_gc_batch_head)) / \
-				 sizeof(void *))
-
-/**
- *	struct nft_set_gc_batch - nf_tables set garbage collection batch
- *
- * 	@head: GC batch head
- * 	@elems: garbage collection elements
- */
-struct nft_set_gc_batch {
-	struct nft_set_gc_batch_head	head;
-	void				*elems[NFT_SET_GC_BATCH_SIZE];
-};
-
-struct nft_set_gc_batch *nft_set_gc_batch_alloc(const struct nft_set *set,
-						gfp_t gfp);
-void nft_set_gc_batch_release(struct rcu_head *rcu);
-
-static inline void nft_set_gc_batch_complete(struct nft_set_gc_batch *gcb)
-{
-	if (gcb != NULL)
-		call_rcu(&gcb->head.rcu, nft_set_gc_batch_release);
-}
-
-static inline struct nft_set_gc_batch *
-nft_set_gc_batch_check(const struct nft_set *set, struct nft_set_gc_batch *gcb,
-		       gfp_t gfp)
-{
-	if (gcb != NULL) {
-		if (gcb->head.cnt + 1 < ARRAY_SIZE(gcb->elems))
-			return gcb;
-		nft_set_gc_batch_complete(gcb);
-	}
-	return nft_set_gc_batch_alloc(set, gfp);
-}
-
-static inline void nft_set_gc_batch_add(struct nft_set_gc_batch *gcb,
-					void *elem)
-{
-	gcb->elems[gcb->head.cnt++] = elem;
-}
-
 struct nft_expr_ops;
 /**
  *	struct nft_expr_type - nf_tables expression type
@@ -1490,39 +1442,30 @@ static inline void nft_set_elem_change_active(const struct net *net,
 
 #endif /* IS_ENABLED(CONFIG_NF_TABLES) */
 
-/*
- * We use a free bit in the genmask field to indicate the element
- * is busy, meaning it is currently being processed either by
- * the netlink API or GC.
- *
- * Even though the genmask is only a single byte wide, this works
- * because the extension structure if fully constant once initialized,
- * so there are no non-atomic write accesses unless it is already
- * marked busy.
- */
-#define NFT_SET_ELEM_BUSY_MASK	(1 << 2)
+#define NFT_SET_ELEM_DEAD_MASK	(1 << 2)
 
 #if defined(__LITTLE_ENDIAN_BITFIELD)
-#define NFT_SET_ELEM_BUSY_BIT	2
+#define NFT_SET_ELEM_DEAD_BIT	2
 #elif defined(__BIG_ENDIAN_BITFIELD)
-#define NFT_SET_ELEM_BUSY_BIT	(BITS_PER_LONG - BITS_PER_BYTE + 2)
+#define NFT_SET_ELEM_DEAD_BIT	(BITS_PER_LONG - BITS_PER_BYTE + 2)
 #else
 #error
 #endif
 
-static inline int nft_set_elem_mark_busy(struct nft_set_ext *ext)
+static inline void nft_set_elem_dead(struct nft_set_ext *ext)
 {
 	unsigned long *word = (unsigned long *)ext;
 
 	BUILD_BUG_ON(offsetof(struct nft_set_ext, genmask) != 0);
-	return test_and_set_bit(NFT_SET_ELEM_BUSY_BIT, word);
+	set_bit(NFT_SET_ELEM_DEAD_BIT, word);
 }
 
-static inline void nft_set_elem_clear_busy(struct nft_set_ext *ext)
+static inline int nft_set_elem_is_dead(const struct nft_set_ext *ext)
 {
 	unsigned long *word = (unsigned long *)ext;
 
-	clear_bit(NFT_SET_ELEM_BUSY_BIT, word);
+	BUILD_BUG_ON(offsetof(struct nft_set_ext, genmask) != 0);
+	return test_bit(NFT_SET_ELEM_DEAD_BIT, word);
 }
 
 /**
@@ -1656,6 +1599,39 @@ struct nft_trans_flowtable {
 #define nft_trans_flowtable_flags(trans)	\
 	(((struct nft_trans_flowtable *)trans->data)->flags)
 
+#define NFT_TRANS_GC_BATCHCOUNT	256
+
+struct nft_trans_gc {
+	struct list_head	list;
+	struct net		*net;
+	struct nft_set		*set;
+	u32			seq;
+	u16			count;
+	void			*priv[NFT_TRANS_GC_BATCHCOUNT];
+	struct rcu_head		rcu;
+};
+
+struct nft_trans_gc *nft_trans_gc_alloc(struct nft_set *set,
+					unsigned int gc_seq, gfp_t gfp);
+void nft_trans_gc_destroy(struct nft_trans_gc *trans);
+
+struct nft_trans_gc *nft_trans_gc_queue_async(struct nft_trans_gc *gc,
+					      unsigned int gc_seq, gfp_t gfp);
+void nft_trans_gc_queue_async_done(struct nft_trans_gc *gc);
+
+struct nft_trans_gc *nft_trans_gc_queue_sync(struct nft_trans_gc *gc, gfp_t gfp);
+void nft_trans_gc_queue_sync_done(struct nft_trans_gc *trans);
+
+void nft_trans_gc_elem_add(struct nft_trans_gc *gc, void *priv);
+
+struct nft_trans_gc *nft_trans_gc_catchall_async(struct nft_trans_gc *gc,
+						 unsigned int gc_seq);
+struct nft_trans_gc *nft_trans_gc_catchall_sync(struct nft_trans_gc *gc);
+
+void nft_setelem_data_deactivate(const struct net *net,
+				 const struct nft_set *set,
+				 struct nft_set_elem *elem);
+
 int __init nft_chain_filter_init(void);
 void nft_chain_filter_fini(void);
 
@@ -1683,6 +1659,7 @@ struct nftables_pernet {
 	u64			table_handle;
 	unsigned int		base_seq;
 	u8			validate_state;
+	unsigned int		gc_seq;
 };
 
 extern unsigned int nf_tables_net_id;
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a887e582f0e7..9fb06a511250 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1762,7 +1762,9 @@ union bpf_attr {
  * 		performed again, if the helper is used in combination with
  * 		direct packet access.
  * 	Return
- * 		0 on success, or a negative error in case of failure.
+ * 		0 on success, or a negative error in case of failure. Positive
+ * 		error indicates a potential drop or congestion in the target
+ * 		device. The particular positive error codes are not defined.
  *
  * u64 bpf_get_current_pid_tgid(void)
  * 	Return
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 1519125b9814..d00bedfdadbb 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -4038,7 +4038,7 @@ static int io_linkat_prep(struct io_kiocb *req,
 
 	if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
 		return -EINVAL;
-	if (sqe->ioprio || sqe->rw_flags || sqe->buf_index || sqe->splice_fd_in)
+	if (sqe->ioprio || sqe->buf_index || sqe->splice_fd_in)
 		return -EINVAL;
 	if (unlikely(req->flags & REQ_F_FIXED_FILE))
 		return -EBADF;
diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
index f9c734aaa990..ef95b796a0fa 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -103,7 +103,12 @@ static int __queue_map_get(struct bpf_map *map, void *value, bool delete)
 	int err = 0;
 	void *ptr;
 
-	raw_spin_lock_irqsave(&qs->lock, flags);
+	if (in_nmi()) {
+		if (!raw_spin_trylock_irqsave(&qs->lock, flags))
+			return -EBUSY;
+	} else {
+		raw_spin_lock_irqsave(&qs->lock, flags);
+	}
 
 	if (queue_stack_map_is_empty(qs)) {
 		memset(value, 0, qs->map.value_size);
@@ -133,7 +138,12 @@ static int __stack_map_get(struct bpf_map *map, void *value, bool delete)
 	void *ptr;
 	u32 index;
 
-	raw_spin_lock_irqsave(&qs->lock, flags);
+	if (in_nmi()) {
+		if (!raw_spin_trylock_irqsave(&qs->lock, flags))
+			return -EBUSY;
+	} else {
+		raw_spin_lock_irqsave(&qs->lock, flags);
+	}
 
 	if (queue_stack_map_is_empty(qs)) {
 		memset(value, 0, qs->map.value_size);
@@ -198,7 +208,12 @@ static int queue_stack_map_push_elem(struct bpf_map *map, void *value,
 	if (flags & BPF_NOEXIST || flags > BPF_EXIST)
 		return -EINVAL;
 
-	raw_spin_lock_irqsave(&qs->lock, irq_flags);
+	if (in_nmi()) {
+		if (!raw_spin_trylock_irqsave(&qs->lock, irq_flags))
+			return -EBUSY;
+	} else {
+		raw_spin_lock_irqsave(&qs->lock, irq_flags);
+	}
 
 	if (queue_stack_map_is_full(qs)) {
 		if (!replace) {
diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 2caafd13f8aa..1f9a8cee4224 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -605,15 +605,19 @@ static struct dma_debug_entry *__dma_entry_alloc(void)
 	return entry;
 }
 
-static void __dma_entry_alloc_check_leak(void)
+/*
+ * This should be called outside of free_entries_lock scope to avoid potential
+ * deadlocks with serial consoles that use DMA.
+ */
+static void __dma_entry_alloc_check_leak(u32 nr_entries)
 {
-	u32 tmp = nr_total_entries % nr_prealloc_entries;
+	u32 tmp = nr_entries % nr_prealloc_entries;
 
 	/* Shout each time we tick over some multiple of the initial pool */
 	if (tmp < DMA_DEBUG_DYNAMIC_ENTRIES) {
 		pr_info("dma_debug_entry pool grown to %u (%u00%%)\n",
-			nr_total_entries,
-			(nr_total_entries / nr_prealloc_entries));
+			nr_entries,
+			(nr_entries / nr_prealloc_entries));
 	}
 }
 
@@ -624,8 +628,10 @@ static void __dma_entry_alloc_check_leak(void)
  */
 static struct dma_debug_entry *dma_entry_alloc(void)
 {
+	bool alloc_check_leak = false;
 	struct dma_debug_entry *entry;
 	unsigned long flags;
+	u32 nr_entries;
 
 	spin_lock_irqsave(&free_entries_lock, flags);
 	if (num_free_entries == 0) {
@@ -635,13 +641,17 @@ static struct dma_debug_entry *dma_entry_alloc(void)
 			pr_err("debugging out of memory - disabling\n");
 			return NULL;
 		}
-		__dma_entry_alloc_check_leak();
+		alloc_check_leak = true;
+		nr_entries = nr_total_entries;
 	}
 
 	entry = __dma_entry_alloc();
 
 	spin_unlock_irqrestore(&free_entries_lock, flags);
 
+	if (alloc_check_leak)
+		__dma_entry_alloc_check_leak(nr_entries);
+
 #ifdef CONFIG_STACKTRACE
 	entry->stack_len = stack_trace_save(entry->stack_entries,
 					    ARRAY_SIZE(entry->stack_entries),
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2324b7055260..02c91528127a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8725,7 +8725,7 @@ void __init init_idle(struct task_struct *idle, int cpu)
 	 * PF_KTHREAD should already be set at this point; regardless, make it
 	 * look like a proper per-CPU kthread.
 	 */
-	idle->flags |= PF_IDLE | PF_KTHREAD | PF_NO_SETAFFINITY;
+	idle->flags |= PF_KTHREAD | PF_NO_SETAFFINITY;
 	kthread_set_per_cpu(idle, cpu);
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index cacc2076ad21..f0af0fecde9d 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -331,12 +331,10 @@ void cpuacct_charge(struct task_struct *tsk, u64 cputime)
 	unsigned int cpu = task_cpu(tsk);
 	struct cpuacct *ca;
 
-	rcu_read_lock();
+	lockdep_assert_rq_held(cpu_rq(cpu));
 
 	for (ca = task_ca(tsk); ca; ca = parent_ca(ca))
 		*per_cpu_ptr(ca->cpuusage, cpu) += cputime;
-
-	rcu_read_unlock();
 }
 
 /*
diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index d583f2aa744e..b41655e00f61 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -102,6 +102,7 @@ static inline int __cpupri_find(struct cpupri *cp, struct task_struct *p,
 
 	if (lowest_mask) {
 		cpumask_and(lowest_mask, &p->cpus_mask, vec->mask);
+		cpumask_and(lowest_mask, lowest_mask, cpu_active_mask);
 
 		/*
 		 * We have to ensure that we have at least one bit
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 499a3e286cd0..6b8d2169d9ea 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -397,6 +397,7 @@ EXPORT_SYMBOL_GPL(play_idle_precise);
 
 void cpu_startup_entry(enum cpuhp_state state)
 {
+	current->flags |= PF_IDLE;
 	arch_cpu_idle_prepare();
 	cpuhp_online_idle(state);
 	while (1)
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index db7cefd196ce..2e5f3de7bfb0 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1106,6 +1106,9 @@ __poll_t ring_buffer_poll_wait(struct trace_buffer *buffer, int cpu,
 	if (full) {
 		poll_wait(filp, &work->full_waiters, poll_table);
 		work->full_waiters_pending = true;
+		if (!cpu_buffer->shortest_full ||
+		    cpu_buffer->shortest_full > full)
+			cpu_buffer->shortest_full = full;
 	} else {
 		poll_wait(filp, &work->waiters, poll_table);
 		work->waiters_pending = true;
@@ -2176,6 +2179,8 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 				err = -ENOMEM;
 				goto out_err;
 			}
+
+			cond_resched();
 		}
 
 		cpus_read_lock();
@@ -2350,6 +2355,11 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
 	 */
 	commit = rb_page_commit(iter_head_page);
 	smp_rmb();
+
+	/* An event needs to be at least 8 bytes in size */
+	if (iter->head > commit - 8)
+		goto reset;
+
 	event = __rb_page_index(iter_head_page, iter->head);
 	length = rb_event_length(event);
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6adacfc880d6..7453840c77be 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4887,6 +4887,39 @@ int tracing_open_generic_tr(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+/*
+ * The private pointer of the inode is the trace_event_file.
+ * Update the tr ref count associated to it.
+ */
+int tracing_open_file_tr(struct inode *inode, struct file *filp)
+{
+	struct trace_event_file *file = inode->i_private;
+	int ret;
+
+	ret = tracing_check_open_get_tr(file->tr);
+	if (ret)
+		return ret;
+
+	filp->private_data = inode->i_private;
+
+	return 0;
+}
+
+int tracing_release_file_tr(struct inode *inode, struct file *filp)
+{
+	struct trace_event_file *file = inode->i_private;
+
+	trace_array_put(file->tr);
+
+	return 0;
+}
+
+static int tracing_mark_open(struct inode *inode, struct file *filp)
+{
+	stream_open(inode, filp);
+	return tracing_open_generic_tr(inode, filp);
+}
+
 static int tracing_release(struct inode *inode, struct file *file)
 {
 	struct trace_array *tr = inode->i_private;
@@ -7225,9 +7258,6 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	if (tt)
 		event_triggers_post_call(tr->trace_marker_file, tt);
 
-	if (written > 0)
-		*fpos += written;
-
 	return written;
 }
 
@@ -7286,9 +7316,6 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 
 	__buffer_unlock_commit(buffer, event);
 
-	if (written > 0)
-		*fpos += written;
-
 	return written;
 }
 
@@ -7699,16 +7726,14 @@ static const struct file_operations tracing_free_buffer_fops = {
 };
 
 static const struct file_operations tracing_mark_fops = {
-	.open		= tracing_open_generic_tr,
+	.open		= tracing_mark_open,
 	.write		= tracing_mark_write,
-	.llseek		= generic_file_llseek,
 	.release	= tracing_release_generic_tr,
 };
 
 static const struct file_operations tracing_mark_raw_fops = {
-	.open		= tracing_open_generic_tr,
+	.open		= tracing_mark_open,
 	.write		= tracing_mark_raw_write,
-	.llseek		= generic_file_llseek,
 	.release	= tracing_release_generic_tr,
 };
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 90ab921884b1..a4a90bd3373b 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -591,6 +591,8 @@ void tracing_reset_all_online_cpus(void);
 void tracing_reset_all_online_cpus_unlocked(void);
 int tracing_open_generic(struct inode *inode, struct file *filp);
 int tracing_open_generic_tr(struct inode *inode, struct file *filp);
+int tracing_open_file_tr(struct inode *inode, struct file *filp);
+int tracing_release_file_tr(struct inode *inode, struct file *filp);
 bool tracing_is_disabled(void);
 bool tracer_tracing_is_on(struct trace_array *tr);
 void tracer_tracing_on(struct trace_array *tr);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 2a2a59999767..c626d02776a5 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2078,9 +2078,10 @@ static const struct file_operations ftrace_set_event_notrace_pid_fops = {
 };
 
 static const struct file_operations ftrace_enable_fops = {
-	.open = tracing_open_generic,
+	.open = tracing_open_file_tr,
 	.read = event_enable_read,
 	.write = event_enable_write,
+	.release = tracing_release_file_tr,
 	.llseek = default_llseek,
 };
 
@@ -2097,9 +2098,10 @@ static const struct file_operations ftrace_event_id_fops = {
 };
 
 static const struct file_operations ftrace_event_filter_fops = {
-	.open = tracing_open_generic,
+	.open = tracing_open_file_tr,
 	.read = event_filter_read,
 	.write = event_filter_write,
+	.release = tracing_release_file_tr,
 	.llseek = default_llseek,
 };
 
diff --git a/kernel/trace/trace_events_inject.c b/kernel/trace/trace_events_inject.c
index c188045c5f97..b1fce64e126c 100644
--- a/kernel/trace/trace_events_inject.c
+++ b/kernel/trace/trace_events_inject.c
@@ -321,7 +321,8 @@ event_inject_read(struct file *file, char __user *buf, size_t size,
 }
 
 const struct file_operations event_inject_fops = {
-	.open = tracing_open_generic,
+	.open = tracing_open_file_tr,
 	.read = event_inject_read,
 	.write = event_inject_write,
+	.release = tracing_release_file_tr,
 };
diff --git a/net/bridge/br_forward.c b/net/bridge/br_forward.c
index 3d69ad5463a9..011bd3c59da1 100644
--- a/net/bridge/br_forward.c
+++ b/net/bridge/br_forward.c
@@ -124,7 +124,7 @@ static int deliver_clone(const struct net_bridge_port *prev,
 
 	skb = skb_clone(skb, GFP_ATOMIC);
 	if (!skb) {
-		dev->stats.tx_dropped++;
+		DEV_STATS_INC(dev, tx_dropped);
 		return -ENOMEM;
 	}
 
@@ -263,7 +263,7 @@ static void maybe_deliver_addr(struct net_bridge_port *p, struct sk_buff *skb,
 
 	skb = skb_copy(skb, GFP_ATOMIC);
 	if (!skb) {
-		dev->stats.tx_dropped++;
+		DEV_STATS_INC(dev, tx_dropped);
 		return;
 	}
 
diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index 6743c8a0fe8e..54bfcdf69273 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -146,12 +146,12 @@ int br_handle_frame_finish(struct net *net, struct sock *sk, struct sk_buff *skb
 			if ((mdst && mdst->host_joined) ||
 			    br_multicast_is_router(brmctx, skb)) {
 				local_rcv = true;
-				br->dev->stats.multicast++;
+				DEV_STATS_INC(br->dev, multicast);
 			}
 			mcast_hit = true;
 		} else {
 			local_rcv = true;
-			br->dev->stats.multicast++;
+			DEV_STATS_INC(br->dev, multicast);
 		}
 		break;
 	case BR_PKT_UNICAST:
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 2596a54c2fe7..a1efbd0f2ad3 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1278,7 +1278,7 @@ bool __skb_flow_dissect(const struct net *net,
 			break;
 		}
 
-		nhoff += ntohs(hdr->message_length);
+		nhoff += sizeof(struct ptp_header);
 		fdret = FLOW_DISSECT_RET_OUT_GOOD;
 		break;
 	}
diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index 1490ba960365..b44e46dc8e04 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -250,13 +250,8 @@ static int dccp_v4_err(struct sk_buff *skb, u32 info)
 	int err;
 	struct net *net = dev_net(skb->dev);
 
-	/* For the first __dccp_basic_hdr_len() check, we only need dh->dccph_x,
-	 * which is in byte 7 of the dccp header.
-	 * Our caller (icmp_socket_deliver()) already pulled 8 bytes for us.
-	 *
-	 * Later on, we want to access the sequence number fields, which are
-	 * beyond 8 bytes, so we have to pskb_may_pull() ourselves.
-	 */
+	if (!pskb_may_pull(skb, offset + sizeof(*dh)))
+		return -EINVAL;
 	dh = (struct dccp_hdr *)(skb->data + offset);
 	if (!pskb_may_pull(skb, offset + __dccp_basic_hdr_len(dh)))
 		return -EINVAL;
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index c9f11f86266c..0ddf64845a06 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -83,13 +83,8 @@ static int dccp_v6_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 	__u64 seq;
 	struct net *net = dev_net(skb->dev);
 
-	/* For the first __dccp_basic_hdr_len() check, we only need dh->dccph_x,
-	 * which is in byte 7 of the dccp header.
-	 * Our caller (icmpv6_notify()) already pulled 8 bytes for us.
-	 *
-	 * Later on, we want to access the sequence number fields, which are
-	 * beyond 8 bytes, so we have to pskb_may_pull() ourselves.
-	 */
+	if (!pskb_may_pull(skb, offset + sizeof(*dh)))
+		return -EINVAL;
 	dh = (struct dccp_hdr *)(skb->data + offset);
 	if (!pskb_may_pull(skb, offset + __dccp_basic_hdr_len(dh)))
 		return -EINVAL;
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index bc6240d327a8..968cc4aa6e96 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1220,6 +1220,7 @@ EXPORT_INDIRECT_CALLABLE(ipv4_dst_check);
 
 static void ipv4_send_dest_unreach(struct sk_buff *skb)
 {
+	struct net_device *dev;
 	struct ip_options opt;
 	int res;
 
@@ -1237,7 +1238,8 @@ static void ipv4_send_dest_unreach(struct sk_buff *skb)
 		opt.optlen = ip_hdr(skb)->ihl * 4 - sizeof(struct iphdr);
 
 		rcu_read_lock();
-		res = __ip_options_compile(dev_net(skb->dev), &opt, skb, NULL);
+		dev = skb->dev ? skb->dev : skb_rtable(skb)->dst.dev;
+		res = __ip_options_compile(dev_net(dev), &opt, skb, NULL);
 		rcu_read_unlock();
 
 		if (res)
diff --git a/net/ncsi/ncsi-aen.c b/net/ncsi/ncsi-aen.c
index 62fb1031763d..f8854bff286c 100644
--- a/net/ncsi/ncsi-aen.c
+++ b/net/ncsi/ncsi-aen.c
@@ -89,6 +89,11 @@ static int ncsi_aen_handler_lsc(struct ncsi_dev_priv *ndp,
 	if ((had_link == has_link) || chained)
 		return 0;
 
+	if (had_link)
+		netif_carrier_off(ndp->ndev.dev);
+	else
+		netif_carrier_on(ndp->ndev.dev);
+
 	if (!ndp->multi_package && !nc->package->multi_channel) {
 		if (had_link) {
 			ndp->flags |= NCSI_DEV_RESHUFFLE;
diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index c911fc09f363..33869db42bb6 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -682,6 +682,14 @@ __ip_set_put(struct ip_set *set)
 /* set->ref can be swapped out by ip_set_swap, netlink events (like dump) need
  * a separate reference counter
  */
+static void
+__ip_set_get_netlink(struct ip_set *set)
+{
+	write_lock_bh(&ip_set_ref_lock);
+	set->ref_netlink++;
+	write_unlock_bh(&ip_set_ref_lock);
+}
+
 static void
 __ip_set_put_netlink(struct ip_set *set)
 {
@@ -1695,11 +1703,11 @@ call_ad(struct net *net, struct sock *ctnl, struct sk_buff *skb,
 
 	do {
 		if (retried) {
-			__ip_set_get(set);
+			__ip_set_get_netlink(set);
 			nfnl_unlock(NFNL_SUBSYS_IPSET);
 			cond_resched();
 			nfnl_lock(NFNL_SUBSYS_IPSET);
-			__ip_set_put(set);
+			__ip_set_put_netlink(set);
 		}
 
 		ip_set_lock(set);
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index d84da11aaee5..8a4cd1c16e0e 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -31,7 +31,9 @@ static LIST_HEAD(nf_tables_expressions);
 static LIST_HEAD(nf_tables_objects);
 static LIST_HEAD(nf_tables_flowtables);
 static LIST_HEAD(nf_tables_destroy_list);
+static LIST_HEAD(nf_tables_gc_list);
 static DEFINE_SPINLOCK(nf_tables_destroy_list_lock);
+static DEFINE_SPINLOCK(nf_tables_gc_list_lock);
 
 enum {
 	NFT_VALIDATE_SKIP	= 0,
@@ -122,6 +124,9 @@ static void nft_validate_state_update(struct net *net, u8 new_validate_state)
 static void nf_tables_trans_destroy_work(struct work_struct *w);
 static DECLARE_WORK(trans_destroy_work, nf_tables_trans_destroy_work);
 
+static void nft_trans_gc_work(struct work_struct *work);
+static DECLARE_WORK(trans_gc_work, nft_trans_gc_work);
+
 static void nft_ctx_init(struct nft_ctx *ctx,
 			 struct net *net,
 			 const struct sk_buff *skb,
@@ -583,10 +588,6 @@ static int nft_trans_set_add(const struct nft_ctx *ctx, int msg_type,
 	return __nft_trans_set_add(ctx, msg_type, set, NULL);
 }
 
-static void nft_setelem_data_deactivate(const struct net *net,
-					const struct nft_set *set,
-					struct nft_set_elem *elem);
-
 static int nft_mapelem_deactivate(const struct nft_ctx *ctx,
 				  struct nft_set *set,
 				  const struct nft_set_iter *iter,
@@ -1158,6 +1159,10 @@ static int nf_tables_updtable(struct nft_ctx *ctx)
 	     flags & NFT_TABLE_F_OWNER))
 		return -EOPNOTSUPP;
 
+	/* No dormant off/on/off/on games in single transaction */
+	if (ctx->table->flags & __NFT_TABLE_F_UPDATE)
+		return -EINVAL;
+
 	trans = nft_trans_alloc(ctx, NFT_MSG_NEWTABLE,
 				sizeof(struct nft_trans_table));
 	if (trans == NULL)
@@ -1343,7 +1348,7 @@ static int nft_flush_table(struct nft_ctx *ctx)
 		if (!nft_is_active_next(ctx->net, chain))
 			continue;
 
-		if (nft_chain_is_bound(chain))
+		if (nft_chain_binding(chain))
 			continue;
 
 		ctx->chain = chain;
@@ -1357,8 +1362,7 @@ static int nft_flush_table(struct nft_ctx *ctx)
 		if (!nft_is_active_next(ctx->net, set))
 			continue;
 
-		if (nft_set_is_anonymous(set) &&
-		    !list_empty(&set->bindings))
+		if (nft_set_is_anonymous(set))
 			continue;
 
 		err = nft_delset(ctx, set);
@@ -1388,7 +1392,7 @@ static int nft_flush_table(struct nft_ctx *ctx)
 		if (!nft_is_active_next(ctx->net, chain))
 			continue;
 
-		if (nft_chain_is_bound(chain))
+		if (nft_chain_binding(chain))
 			continue;
 
 		ctx->chain = chain;
@@ -2693,6 +2697,9 @@ static int nf_tables_delchain(struct sk_buff *skb, const struct nfnl_info *info,
 		return PTR_ERR(chain);
 	}
 
+	if (nft_chain_binding(chain))
+		return -EOPNOTSUPP;
+
 	if (info->nlh->nlmsg_flags & NLM_F_NONREC &&
 	    chain->use > 0)
 		return -EBUSY;
@@ -3670,6 +3677,11 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
 	}
 
 	if (info->nlh->nlmsg_flags & NLM_F_REPLACE) {
+		if (nft_chain_binding(chain)) {
+			err = -EOPNOTSUPP;
+			goto err_destroy_flow_rule;
+		}
+
 		err = nft_delrule(&ctx, old_rule);
 		if (err < 0)
 			goto err_destroy_flow_rule;
@@ -3773,7 +3785,7 @@ static int nf_tables_delrule(struct sk_buff *skb, const struct nfnl_info *info,
 			NL_SET_BAD_ATTR(extack, nla[NFTA_RULE_CHAIN]);
 			return PTR_ERR(chain);
 		}
-		if (nft_chain_is_bound(chain))
+		if (nft_chain_binding(chain))
 			return -EOPNOTSUPP;
 	}
 
@@ -3803,7 +3815,7 @@ static int nf_tables_delrule(struct sk_buff *skb, const struct nfnl_info *info,
 		list_for_each_entry(chain, &table->chains, list) {
 			if (!nft_is_active_next(net, chain))
 				continue;
-			if (nft_chain_is_bound(chain))
+			if (nft_chain_binding(chain))
 				continue;
 
 			ctx.chain = chain;
@@ -4757,6 +4769,7 @@ static int nf_tables_newset(struct sk_buff *skb, const struct nfnl_info *info,
 
 	INIT_LIST_HEAD(&set->bindings);
 	INIT_LIST_HEAD(&set->catchall_list);
+	refcount_set(&set->refs, 1);
 	set->table = table;
 	write_pnet(&set->net, net);
 	set->ops = ops;
@@ -4824,6 +4837,14 @@ static void nft_set_catchall_destroy(const struct nft_ctx *ctx,
 	}
 }
 
+static void nft_set_put(struct nft_set *set)
+{
+	if (refcount_dec_and_test(&set->refs)) {
+		kfree(set->name);
+		kvfree(set);
+	}
+}
+
 static void nft_set_destroy(const struct nft_ctx *ctx, struct nft_set *set)
 {
 	int i;
@@ -4836,8 +4857,7 @@ static void nft_set_destroy(const struct nft_ctx *ctx, struct nft_set *set)
 
 	set->ops->destroy(ctx, set);
 	nft_set_catchall_destroy(ctx, set);
-	kfree(set->name);
-	kvfree(set);
+	nft_set_put(set);
 }
 
 static int nf_tables_delset(struct sk_buff *skb, const struct nfnl_info *info,
@@ -5289,8 +5309,12 @@ static int nf_tables_dump_setelem(const struct nft_ctx *ctx,
 				  const struct nft_set_iter *iter,
 				  struct nft_set_elem *elem)
 {
+	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
 	struct nft_set_dump_args *args;
 
+	if (nft_set_elem_expired(ext))
+		return 0;
+
 	args = container_of(iter, struct nft_set_dump_args, iter);
 	return nf_tables_fill_setelem(args->skb, set, elem);
 }
@@ -5902,7 +5926,8 @@ struct nft_set_ext *nft_set_catchall_lookup(const struct net *net,
 	list_for_each_entry_rcu(catchall, &set->catchall_list, list) {
 		ext = nft_set_elem_ext(set, catchall->elem);
 		if (nft_set_elem_active(ext, genmask) &&
-		    !nft_set_elem_expired(ext))
+		    !nft_set_elem_expired(ext) &&
+		    !nft_set_elem_is_dead(ext))
 			return ext;
 	}
 
@@ -5910,29 +5935,6 @@ struct nft_set_ext *nft_set_catchall_lookup(const struct net *net,
 }
 EXPORT_SYMBOL_GPL(nft_set_catchall_lookup);
 
-void *nft_set_catchall_gc(const struct nft_set *set)
-{
-	struct nft_set_elem_catchall *catchall, *next;
-	struct nft_set_ext *ext;
-	void *elem = NULL;
-
-	list_for_each_entry_safe(catchall, next, &set->catchall_list, list) {
-		ext = nft_set_elem_ext(set, catchall->elem);
-
-		if (!nft_set_elem_expired(ext) ||
-		    nft_set_elem_mark_busy(ext))
-			continue;
-
-		elem = catchall->elem;
-		list_del_rcu(&catchall->list);
-		kfree_rcu(catchall, rcu);
-		break;
-	}
-
-	return elem;
-}
-EXPORT_SYMBOL_GPL(nft_set_catchall_gc);
-
 static int nft_setelem_catchall_insert(const struct net *net,
 				       struct nft_set *set,
 				       const struct nft_set_elem *elem,
@@ -5994,7 +5996,6 @@ static void nft_setelem_activate(struct net *net, struct nft_set *set,
 
 	if (nft_setelem_is_catchall(set, elem)) {
 		nft_set_elem_change_active(net, set, ext);
-		nft_set_elem_clear_busy(ext);
 	} else {
 		set->ops->activate(net, set, elem);
 	}
@@ -6009,8 +6010,7 @@ static int nft_setelem_catchall_deactivate(const struct net *net,
 
 	list_for_each_entry(catchall, &set->catchall_list, list) {
 		ext = nft_set_elem_ext(set, catchall->elem);
-		if (!nft_is_active(net, ext) ||
-		    nft_set_elem_mark_busy(ext))
+		if (!nft_is_active(net, ext))
 			continue;
 
 		kfree(elem->priv);
@@ -6399,7 +6399,7 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 		goto err_elem_expr;
 	}
 
-	ext->genmask = nft_genmask_cur(ctx->net) | NFT_SET_ELEM_BUSY_MASK;
+	ext->genmask = nft_genmask_cur(ctx->net);
 
 	err = nft_setelem_insert(ctx->net, set, &elem, &ext2, flags);
 	if (err) {
@@ -6547,9 +6547,9 @@ static void nft_setelem_data_activate(const struct net *net,
 		nft_use_inc_restore(&(*nft_set_ext_obj(ext))->use);
 }
 
-static void nft_setelem_data_deactivate(const struct net *net,
-					const struct nft_set *set,
-					struct nft_set_elem *elem)
+void nft_setelem_data_deactivate(const struct net *net,
+				 const struct nft_set *set,
+				 struct nft_set_elem *elem)
 {
 	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
 
@@ -6711,8 +6711,7 @@ static int nft_set_catchall_flush(const struct nft_ctx *ctx,
 
 	list_for_each_entry_rcu(catchall, &set->catchall_list, list) {
 		ext = nft_set_elem_ext(set, catchall->elem);
-		if (!nft_set_elem_active(ext, genmask) ||
-		    nft_set_elem_mark_busy(ext))
+		if (!nft_set_elem_active(ext, genmask))
 			continue;
 
 		elem.priv = catchall->elem;
@@ -6764,8 +6763,10 @@ static int nf_tables_delsetelem(struct sk_buff *skb,
 	if (IS_ERR(set))
 		return PTR_ERR(set);
 
-	if (!list_empty(&set->bindings) &&
-	    (set->flags & (NFT_SET_CONSTANT | NFT_SET_ANONYMOUS)))
+	if (nft_set_is_anonymous(set))
+		return -EOPNOTSUPP;
+
+	if (!list_empty(&set->bindings) && (set->flags & NFT_SET_CONSTANT))
 		return -EBUSY;
 
 	nft_ctx_init(&ctx, net, skb, info->nlh, family, table, NULL, nla);
@@ -6781,29 +6782,6 @@ static int nf_tables_delsetelem(struct sk_buff *skb,
 	return err;
 }
 
-void nft_set_gc_batch_release(struct rcu_head *rcu)
-{
-	struct nft_set_gc_batch *gcb;
-	unsigned int i;
-
-	gcb = container_of(rcu, struct nft_set_gc_batch, head.rcu);
-	for (i = 0; i < gcb->head.cnt; i++)
-		nft_set_elem_destroy(gcb->head.set, gcb->elems[i], true);
-	kfree(gcb);
-}
-
-struct nft_set_gc_batch *nft_set_gc_batch_alloc(const struct nft_set *set,
-						gfp_t gfp)
-{
-	struct nft_set_gc_batch *gcb;
-
-	gcb = kzalloc(sizeof(*gcb), gfp);
-	if (gcb == NULL)
-		return gcb;
-	gcb->head.set = set;
-	return gcb;
-}
-
 /*
  * Stateful objects
  */
@@ -8883,6 +8861,234 @@ void nft_chain_del(struct nft_chain *chain)
 	list_del_rcu(&chain->list);
 }
 
+static void nft_trans_gc_setelem_remove(struct nft_ctx *ctx,
+					struct nft_trans_gc *trans)
+{
+	void **priv = trans->priv;
+	unsigned int i;
+
+	for (i = 0; i < trans->count; i++) {
+		struct nft_set_elem elem = {
+			.priv = priv[i],
+		};
+
+		nft_setelem_data_deactivate(ctx->net, trans->set, &elem);
+		nft_setelem_remove(ctx->net, trans->set, &elem);
+	}
+}
+
+void nft_trans_gc_destroy(struct nft_trans_gc *trans)
+{
+	nft_set_put(trans->set);
+	put_net(trans->net);
+	kfree(trans);
+}
+
+static void nft_trans_gc_trans_free(struct rcu_head *rcu)
+{
+	struct nft_set_elem elem = {};
+	struct nft_trans_gc *trans;
+	struct nft_ctx ctx = {};
+	unsigned int i;
+
+	trans = container_of(rcu, struct nft_trans_gc, rcu);
+	ctx.net	= read_pnet(&trans->set->net);
+
+	for (i = 0; i < trans->count; i++) {
+		elem.priv = trans->priv[i];
+		if (!nft_setelem_is_catchall(trans->set, &elem))
+			atomic_dec(&trans->set->nelems);
+
+		nf_tables_set_elem_destroy(&ctx, trans->set, elem.priv);
+	}
+
+	nft_trans_gc_destroy(trans);
+}
+
+static bool nft_trans_gc_work_done(struct nft_trans_gc *trans)
+{
+	struct nftables_pernet *nft_net;
+	struct nft_ctx ctx = {};
+
+	nft_net = nft_pernet(trans->net);
+
+	mutex_lock(&nft_net->commit_mutex);
+
+	/* Check for race with transaction, otherwise this batch refers to
+	 * stale objects that might not be there anymore. Skip transaction if
+	 * set has been destroyed from control plane transaction in case gc
+	 * worker loses race.
+	 */
+	if (READ_ONCE(nft_net->gc_seq) != trans->seq || trans->set->dead) {
+		mutex_unlock(&nft_net->commit_mutex);
+		return false;
+	}
+
+	ctx.net = trans->net;
+	ctx.table = trans->set->table;
+
+	nft_trans_gc_setelem_remove(&ctx, trans);
+	mutex_unlock(&nft_net->commit_mutex);
+
+	return true;
+}
+
+static void nft_trans_gc_work(struct work_struct *work)
+{
+	struct nft_trans_gc *trans, *next;
+	LIST_HEAD(trans_gc_list);
+
+	spin_lock(&nf_tables_gc_list_lock);
+	list_splice_init(&nf_tables_gc_list, &trans_gc_list);
+	spin_unlock(&nf_tables_gc_list_lock);
+
+	list_for_each_entry_safe(trans, next, &trans_gc_list, list) {
+		list_del(&trans->list);
+		if (!nft_trans_gc_work_done(trans)) {
+			nft_trans_gc_destroy(trans);
+			continue;
+		}
+		call_rcu(&trans->rcu, nft_trans_gc_trans_free);
+	}
+}
+
+struct nft_trans_gc *nft_trans_gc_alloc(struct nft_set *set,
+					unsigned int gc_seq, gfp_t gfp)
+{
+	struct net *net = read_pnet(&set->net);
+	struct nft_trans_gc *trans;
+
+	trans = kzalloc(sizeof(*trans), gfp);
+	if (!trans)
+		return NULL;
+
+	trans->net = maybe_get_net(net);
+	if (!trans->net) {
+		kfree(trans);
+		return NULL;
+	}
+
+	refcount_inc(&set->refs);
+	trans->set = set;
+	trans->seq = gc_seq;
+
+	return trans;
+}
+
+void nft_trans_gc_elem_add(struct nft_trans_gc *trans, void *priv)
+{
+	trans->priv[trans->count++] = priv;
+}
+
+static void nft_trans_gc_queue_work(struct nft_trans_gc *trans)
+{
+	spin_lock(&nf_tables_gc_list_lock);
+	list_add_tail(&trans->list, &nf_tables_gc_list);
+	spin_unlock(&nf_tables_gc_list_lock);
+
+	schedule_work(&trans_gc_work);
+}
+
+static int nft_trans_gc_space(struct nft_trans_gc *trans)
+{
+	return NFT_TRANS_GC_BATCHCOUNT - trans->count;
+}
+
+struct nft_trans_gc *nft_trans_gc_queue_async(struct nft_trans_gc *gc,
+					      unsigned int gc_seq, gfp_t gfp)
+{
+	struct nft_set *set;
+
+	if (nft_trans_gc_space(gc))
+		return gc;
+
+	set = gc->set;
+	nft_trans_gc_queue_work(gc);
+
+	return nft_trans_gc_alloc(set, gc_seq, gfp);
+}
+
+void nft_trans_gc_queue_async_done(struct nft_trans_gc *trans)
+{
+	if (trans->count == 0) {
+		nft_trans_gc_destroy(trans);
+		return;
+	}
+
+	nft_trans_gc_queue_work(trans);
+}
+
+struct nft_trans_gc *nft_trans_gc_queue_sync(struct nft_trans_gc *gc, gfp_t gfp)
+{
+	struct nft_set *set;
+
+	if (WARN_ON_ONCE(!lockdep_commit_lock_is_held(gc->net)))
+		return NULL;
+
+	if (nft_trans_gc_space(gc))
+		return gc;
+
+	set = gc->set;
+	call_rcu(&gc->rcu, nft_trans_gc_trans_free);
+
+	return nft_trans_gc_alloc(set, 0, gfp);
+}
+
+void nft_trans_gc_queue_sync_done(struct nft_trans_gc *trans)
+{
+	WARN_ON_ONCE(!lockdep_commit_lock_is_held(trans->net));
+
+	if (trans->count == 0) {
+		nft_trans_gc_destroy(trans);
+		return;
+	}
+
+	call_rcu(&trans->rcu, nft_trans_gc_trans_free);
+}
+
+static struct nft_trans_gc *nft_trans_gc_catchall(struct nft_trans_gc *gc,
+						  unsigned int gc_seq,
+						  bool sync)
+{
+	struct nft_set_elem_catchall *catchall;
+	const struct nft_set *set = gc->set;
+	struct nft_set_ext *ext;
+
+	list_for_each_entry_rcu(catchall, &set->catchall_list, list) {
+		ext = nft_set_elem_ext(set, catchall->elem);
+
+		if (!nft_set_elem_expired(ext))
+			continue;
+		if (nft_set_elem_is_dead(ext))
+			goto dead_elem;
+
+		nft_set_elem_dead(ext);
+dead_elem:
+		if (sync)
+			gc = nft_trans_gc_queue_sync(gc, GFP_ATOMIC);
+		else
+			gc = nft_trans_gc_queue_async(gc, gc_seq, GFP_ATOMIC);
+
+		if (!gc)
+			return NULL;
+
+		nft_trans_gc_elem_add(gc, catchall->elem);
+	}
+
+	return gc;
+}
+
+struct nft_trans_gc *nft_trans_gc_catchall_async(struct nft_trans_gc *gc,
+						 unsigned int gc_seq)
+{
+	return nft_trans_gc_catchall(gc, gc_seq, false);
+}
+
+struct nft_trans_gc *nft_trans_gc_catchall_sync(struct nft_trans_gc *gc)
+{
+	return nft_trans_gc_catchall(gc, 0, true);
+}
+
 static void nf_tables_module_autoload_cleanup(struct net *net)
 {
 	struct nftables_pernet *nft_net = nft_pernet(net);
@@ -9041,15 +9247,31 @@ static void nft_set_commit_update(struct list_head *set_update_list)
 	}
 }
 
+static unsigned int nft_gc_seq_begin(struct nftables_pernet *nft_net)
+{
+	unsigned int gc_seq;
+
+	/* Bump gc counter, it becomes odd, this is the busy mark. */
+	gc_seq = READ_ONCE(nft_net->gc_seq);
+	WRITE_ONCE(nft_net->gc_seq, ++gc_seq);
+
+	return gc_seq;
+}
+
+static void nft_gc_seq_end(struct nftables_pernet *nft_net, unsigned int gc_seq)
+{
+	WRITE_ONCE(nft_net->gc_seq, ++gc_seq);
+}
+
 static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 {
 	struct nftables_pernet *nft_net = nft_pernet(net);
 	struct nft_trans *trans, *next;
+	unsigned int base_seq, gc_seq;
 	LIST_HEAD(set_update_list);
 	struct nft_trans_elem *te;
 	struct nft_chain *chain;
 	struct nft_table *table;
-	unsigned int base_seq;
 	LIST_HEAD(adl);
 	int err;
 
@@ -9126,6 +9348,8 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 
 	WRITE_ONCE(nft_net->base_seq, base_seq);
 
+	gc_seq = nft_gc_seq_begin(nft_net);
+
 	/* step 3. Start new generation, rules_gen_X now in use. */
 	net->nft.gencursor = nft_gencursor_next(net);
 
@@ -9214,6 +9438,7 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_DELSET:
+			nft_trans_set(trans)->dead = 1;
 			list_del_rcu(&nft_trans_set(trans)->list);
 			nf_tables_set_notify(&trans->ctx, nft_trans_set(trans),
 					     NFT_MSG_DELSET, GFP_KERNEL);
@@ -9313,6 +9538,8 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 	nft_commit_notify(net, NETLINK_CB(skb).portid);
 	nf_tables_gen_notify(net, skb, NFT_MSG_NEWGEN);
 	nf_tables_commit_audit_log(&adl, nft_net->base_seq);
+
+	nft_gc_seq_end(nft_net, gc_seq);
 	nf_tables_commit_release(net);
 
 	return 0;
@@ -9571,7 +9798,12 @@ static int nf_tables_abort(struct net *net, struct sk_buff *skb,
 			   enum nfnl_abort_action action)
 {
 	struct nftables_pernet *nft_net = nft_pernet(net);
-	int ret = __nf_tables_abort(net, action);
+	unsigned int gc_seq;
+	int ret;
+
+	gc_seq = nft_gc_seq_begin(nft_net);
+	ret = __nf_tables_abort(net, action);
+	nft_gc_seq_end(nft_net, gc_seq);
 
 	mutex_unlock(&nft_net->commit_mutex);
 
@@ -10234,7 +10466,7 @@ static void __nft_release_table(struct net *net, struct nft_table *table)
 	ctx.family = table->family;
 	ctx.table = table;
 	list_for_each_entry(chain, &table->chains, list) {
-		if (nft_chain_is_bound(chain))
+		if (nft_chain_binding(chain))
 			continue;
 
 		ctx.chain = chain;
@@ -10295,6 +10527,7 @@ static int nft_rcv_nl_event(struct notifier_block *this, unsigned long event,
 	struct net *net = n->net;
 	unsigned int deleted;
 	bool restart = false;
+	unsigned int gc_seq;
 
 	if (event != NETLINK_URELEASE || n->protocol != NETLINK_NETFILTER)
 		return NOTIFY_DONE;
@@ -10302,6 +10535,9 @@ static int nft_rcv_nl_event(struct notifier_block *this, unsigned long event,
 	nft_net = nft_pernet(net);
 	deleted = 0;
 	mutex_lock(&nft_net->commit_mutex);
+
+	gc_seq = nft_gc_seq_begin(nft_net);
+
 	if (!list_empty(&nf_tables_destroy_list))
 		nf_tables_trans_destroy_flush_work();
 again:
@@ -10324,6 +10560,8 @@ static int nft_rcv_nl_event(struct notifier_block *this, unsigned long event,
 		if (restart)
 			goto again;
 	}
+	nft_gc_seq_end(nft_net, gc_seq);
+
 	mutex_unlock(&nft_net->commit_mutex);
 
 	return NOTIFY_DONE;
@@ -10345,6 +10583,7 @@ static int __net_init nf_tables_init_net(struct net *net)
 	mutex_init(&nft_net->commit_mutex);
 	nft_net->base_seq = 1;
 	nft_net->validate_state = NFT_VALIDATE_SKIP;
+	nft_net->gc_seq = 0;
 
 	return 0;
 }
@@ -10361,22 +10600,36 @@ static void __net_exit nf_tables_pre_exit_net(struct net *net)
 static void __net_exit nf_tables_exit_net(struct net *net)
 {
 	struct nftables_pernet *nft_net = nft_pernet(net);
+	unsigned int gc_seq;
 
 	mutex_lock(&nft_net->commit_mutex);
+
+	gc_seq = nft_gc_seq_begin(nft_net);
+
 	if (!list_empty(&nft_net->commit_list) ||
 	    !list_empty(&nft_net->module_list))
 		__nf_tables_abort(net, NFNL_ABORT_NONE);
+
 	__nft_release_tables(net);
+
+	nft_gc_seq_end(nft_net, gc_seq);
+
 	mutex_unlock(&nft_net->commit_mutex);
 	WARN_ON_ONCE(!list_empty(&nft_net->tables));
 	WARN_ON_ONCE(!list_empty(&nft_net->module_list));
 	WARN_ON_ONCE(!list_empty(&nft_net->notify_list));
 }
 
+static void nf_tables_exit_batch(struct list_head *net_exit_list)
+{
+	flush_work(&trans_gc_work);
+}
+
 static struct pernet_operations nf_tables_net_ops = {
 	.init		= nf_tables_init_net,
 	.pre_exit	= nf_tables_pre_exit_net,
 	.exit		= nf_tables_exit_net,
+	.exit_batch	= nf_tables_exit_batch,
 	.id		= &nf_tables_net_id,
 	.size		= sizeof(struct nftables_pernet),
 };
@@ -10448,6 +10701,7 @@ static void __exit nf_tables_module_exit(void)
 	nft_chain_filter_fini();
 	nft_chain_route_fini();
 	unregister_pernet_subsys(&nf_tables_net_ops);
+	cancel_work_sync(&trans_gc_work);
 	cancel_work_sync(&trans_destroy_work);
 	rcu_barrier();
 	rhltable_destroy(&nft_objname_ht);
diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index 3609680831a1..daee46cf62ab 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -245,7 +245,12 @@ static void nft_exthdr_tcp_set_eval(const struct nft_expr *expr,
 	if (!tcph)
 		goto err;
 
+	if (skb_ensure_writable(pkt->skb, nft_thoff(pkt) + tcphdr_len))
+		goto err;
+
+	tcph = (struct tcphdr *)(pkt->skb->data + nft_thoff(pkt));
 	opt = (u8 *)tcph;
+
 	for (i = sizeof(*tcph); i < tcphdr_len - 1; i += optl) {
 		union {
 			__be16 v16;
@@ -260,15 +265,6 @@ static void nft_exthdr_tcp_set_eval(const struct nft_expr *expr,
 		if (i + optl > tcphdr_len || priv->len + priv->offset > optl)
 			goto err;
 
-		if (skb_ensure_writable(pkt->skb,
-					nft_thoff(pkt) + i + priv->len))
-			goto err;
-
-		tcph = nft_tcp_header_pointer(pkt, sizeof(buff), buff,
-					      &tcphdr_len);
-		if (!tcph)
-			goto err;
-
 		offset = i + priv->offset;
 
 		switch (priv->len) {
@@ -315,6 +311,63 @@ static void nft_exthdr_tcp_set_eval(const struct nft_expr *expr,
 	regs->verdict.code = NFT_BREAK;
 }
 
+static void nft_exthdr_tcp_strip_eval(const struct nft_expr *expr,
+				      struct nft_regs *regs,
+				      const struct nft_pktinfo *pkt)
+{
+	u8 buff[sizeof(struct tcphdr) + MAX_TCP_OPTION_SPACE];
+	struct nft_exthdr *priv = nft_expr_priv(expr);
+	unsigned int i, tcphdr_len, optl;
+	struct tcphdr *tcph;
+	u8 *opt;
+
+	tcph = nft_tcp_header_pointer(pkt, sizeof(buff), buff, &tcphdr_len);
+	if (!tcph)
+		goto err;
+
+	if (skb_ensure_writable(pkt->skb, nft_thoff(pkt) + tcphdr_len))
+		goto drop;
+
+	tcph = (struct tcphdr *)(pkt->skb->data + nft_thoff(pkt));
+	opt = (u8 *)tcph;
+
+	for (i = sizeof(*tcph); i < tcphdr_len - 1; i += optl) {
+		unsigned int j;
+
+		optl = optlen(opt, i);
+		if (priv->type != opt[i])
+			continue;
+
+		if (i + optl > tcphdr_len)
+			goto drop;
+
+		for (j = 0; j < optl; ++j) {
+			u16 n = TCPOPT_NOP;
+			u16 o = opt[i+j];
+
+			if ((i + j) % 2 == 0) {
+				o <<= 8;
+				n <<= 8;
+			}
+			inet_proto_csum_replace2(&tcph->check, pkt->skb, htons(o),
+						 htons(n), false);
+		}
+		memset(opt + i, TCPOPT_NOP, optl);
+		return;
+	}
+
+	/* option not found, continue. This allows to do multiple
+	 * option removals per rule.
+	 */
+	return;
+err:
+	regs->verdict.code = NFT_BREAK;
+	return;
+drop:
+	/* can't remove, no choice but to drop */
+	regs->verdict.code = NF_DROP;
+}
+
 static void nft_exthdr_sctp_eval(const struct nft_expr *expr,
 				 struct nft_regs *regs,
 				 const struct nft_pktinfo *pkt)
@@ -463,6 +516,28 @@ static int nft_exthdr_tcp_set_init(const struct nft_ctx *ctx,
 				       priv->len);
 }
 
+static int nft_exthdr_tcp_strip_init(const struct nft_ctx *ctx,
+				     const struct nft_expr *expr,
+				     const struct nlattr * const tb[])
+{
+	struct nft_exthdr *priv = nft_expr_priv(expr);
+
+	if (tb[NFTA_EXTHDR_SREG] ||
+	    tb[NFTA_EXTHDR_DREG] ||
+	    tb[NFTA_EXTHDR_FLAGS] ||
+	    tb[NFTA_EXTHDR_OFFSET] ||
+	    tb[NFTA_EXTHDR_LEN])
+		return -EINVAL;
+
+	if (!tb[NFTA_EXTHDR_TYPE])
+		return -EINVAL;
+
+	priv->type = nla_get_u8(tb[NFTA_EXTHDR_TYPE]);
+	priv->op = NFT_EXTHDR_OP_TCPOPT;
+
+	return 0;
+}
+
 static int nft_exthdr_ipv4_init(const struct nft_ctx *ctx,
 				const struct nft_expr *expr,
 				const struct nlattr * const tb[])
@@ -523,6 +598,13 @@ static int nft_exthdr_dump_set(struct sk_buff *skb, const struct nft_expr *expr)
 	return nft_exthdr_dump_common(skb, priv);
 }
 
+static int nft_exthdr_dump_strip(struct sk_buff *skb, const struct nft_expr *expr)
+{
+	const struct nft_exthdr *priv = nft_expr_priv(expr);
+
+	return nft_exthdr_dump_common(skb, priv);
+}
+
 static const struct nft_expr_ops nft_exthdr_ipv6_ops = {
 	.type		= &nft_exthdr_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_exthdr)),
@@ -555,6 +637,14 @@ static const struct nft_expr_ops nft_exthdr_tcp_set_ops = {
 	.dump		= nft_exthdr_dump_set,
 };
 
+static const struct nft_expr_ops nft_exthdr_tcp_strip_ops = {
+	.type		= &nft_exthdr_type,
+	.size		= NFT_EXPR_SIZE(sizeof(struct nft_exthdr)),
+	.eval		= nft_exthdr_tcp_strip_eval,
+	.init		= nft_exthdr_tcp_strip_init,
+	.dump		= nft_exthdr_dump_strip,
+};
+
 static const struct nft_expr_ops nft_exthdr_sctp_ops = {
 	.type		= &nft_exthdr_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_exthdr)),
@@ -582,7 +672,7 @@ nft_exthdr_select_ops(const struct nft_ctx *ctx,
 			return &nft_exthdr_tcp_set_ops;
 		if (tb[NFTA_EXTHDR_DREG])
 			return &nft_exthdr_tcp_ops;
-		break;
+		return &nft_exthdr_tcp_strip_ops;
 	case NFT_EXTHDR_OP_IPV6:
 		if (tb[NFTA_EXTHDR_DREG])
 			return &nft_exthdr_ipv6_ops;
diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index 0b73cb0e752f..2013de934cef 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -59,6 +59,8 @@ static inline int nft_rhash_cmp(struct rhashtable_compare_arg *arg,
 
 	if (memcmp(nft_set_ext_key(&he->ext), x->key, x->set->klen))
 		return 1;
+	if (nft_set_elem_is_dead(&he->ext))
+		return 1;
 	if (nft_set_elem_expired(&he->ext))
 		return 1;
 	if (!nft_set_elem_active(&he->ext, x->genmask))
@@ -188,7 +190,6 @@ static void nft_rhash_activate(const struct net *net, const struct nft_set *set,
 	struct nft_rhash_elem *he = elem->priv;
 
 	nft_set_elem_change_active(net, set, &he->ext);
-	nft_set_elem_clear_busy(&he->ext);
 }
 
 static bool nft_rhash_flush(const struct net *net,
@@ -196,12 +197,9 @@ static bool nft_rhash_flush(const struct net *net,
 {
 	struct nft_rhash_elem *he = priv;
 
-	if (!nft_set_elem_mark_busy(&he->ext) ||
-	    !nft_is_active(net, &he->ext)) {
-		nft_set_elem_change_active(net, set, &he->ext);
-		return true;
-	}
-	return false;
+	nft_set_elem_change_active(net, set, &he->ext);
+
+	return true;
 }
 
 static void *nft_rhash_deactivate(const struct net *net,
@@ -218,9 +216,8 @@ static void *nft_rhash_deactivate(const struct net *net,
 
 	rcu_read_lock();
 	he = rhashtable_lookup(&priv->ht, &arg, nft_rhash_params);
-	if (he != NULL &&
-	    !nft_rhash_flush(net, set, he))
-		he = NULL;
+	if (he)
+		nft_set_elem_change_active(net, set, &he->ext);
 
 	rcu_read_unlock();
 
@@ -252,7 +249,9 @@ static bool nft_rhash_delete(const struct nft_set *set,
 	if (he == NULL)
 		return false;
 
-	return rhashtable_remove_fast(&priv->ht, &he->node, nft_rhash_params) == 0;
+	nft_set_elem_dead(&he->ext);
+
+	return true;
 }
 
 static void nft_rhash_walk(const struct nft_ctx *ctx, struct nft_set *set,
@@ -278,8 +277,6 @@ static void nft_rhash_walk(const struct nft_ctx *ctx, struct nft_set *set,
 
 		if (iter->count < iter->skip)
 			goto cont;
-		if (nft_set_elem_expired(&he->ext))
-			goto cont;
 		if (!nft_set_elem_active(&he->ext, iter->genmask))
 			goto cont;
 
@@ -314,25 +311,48 @@ static bool nft_rhash_expr_needs_gc_run(const struct nft_set *set,
 
 static void nft_rhash_gc(struct work_struct *work)
 {
+	struct nftables_pernet *nft_net;
 	struct nft_set *set;
 	struct nft_rhash_elem *he;
 	struct nft_rhash *priv;
-	struct nft_set_gc_batch *gcb = NULL;
 	struct rhashtable_iter hti;
+	struct nft_trans_gc *gc;
+	struct net *net;
+	u32 gc_seq;
 
 	priv = container_of(work, struct nft_rhash, gc_work.work);
 	set  = nft_set_container_of(priv);
+	net  = read_pnet(&set->net);
+	nft_net = nft_pernet(net);
+	gc_seq = READ_ONCE(nft_net->gc_seq);
+
+	if (nft_set_gc_is_pending(set))
+		goto done;
+
+	gc = nft_trans_gc_alloc(set, gc_seq, GFP_KERNEL);
+	if (!gc)
+		goto done;
 
 	rhashtable_walk_enter(&priv->ht, &hti);
 	rhashtable_walk_start(&hti);
 
 	while ((he = rhashtable_walk_next(&hti))) {
 		if (IS_ERR(he)) {
-			if (PTR_ERR(he) != -EAGAIN)
-				break;
-			continue;
+			nft_trans_gc_destroy(gc);
+			gc = NULL;
+			goto try_later;
+		}
+
+		/* Ruleset has been updated, try later. */
+		if (READ_ONCE(nft_net->gc_seq) != gc_seq) {
+			nft_trans_gc_destroy(gc);
+			gc = NULL;
+			goto try_later;
 		}
 
+		if (nft_set_elem_is_dead(&he->ext))
+			goto dead_elem;
+
 		if (nft_set_ext_exists(&he->ext, NFT_SET_EXT_EXPRESSIONS) &&
 		    nft_rhash_expr_needs_gc_run(set, &he->ext))
 			goto needs_gc_run;
@@ -340,26 +360,26 @@ static void nft_rhash_gc(struct work_struct *work)
 		if (!nft_set_elem_expired(&he->ext))
 			continue;
 needs_gc_run:
-		if (nft_set_elem_mark_busy(&he->ext))
-			continue;
+		nft_set_elem_dead(&he->ext);
+dead_elem:
+		gc = nft_trans_gc_queue_async(gc, gc_seq, GFP_ATOMIC);
+		if (!gc)
+			goto try_later;
 
-		gcb = nft_set_gc_batch_check(set, gcb, GFP_ATOMIC);
-		if (gcb == NULL)
-			break;
-		rhashtable_remove_fast(&priv->ht, &he->node, nft_rhash_params);
-		atomic_dec(&set->nelems);
-		nft_set_gc_batch_add(gcb, he);
+		nft_trans_gc_elem_add(gc, he);
 	}
+
+	gc = nft_trans_gc_catchall_async(gc, gc_seq);
+
+try_later:
+	/* catchall list iteration requires rcu read side lock. */
 	rhashtable_walk_stop(&hti);
 	rhashtable_walk_exit(&hti);
 
-	he = nft_set_catchall_gc(set);
-	if (he) {
-		gcb = nft_set_gc_batch_check(set, gcb, GFP_ATOMIC);
-		if (gcb)
-			nft_set_gc_batch_add(gcb, he);
-	}
-	nft_set_gc_batch_complete(gcb);
+	if (gc)
+		nft_trans_gc_queue_async_done(gc);
+
+done:
 	queue_delayed_work(system_power_efficient_wq, &priv->gc_work,
 			   nft_set_gc_interval(set));
 }
@@ -394,7 +414,7 @@ static int nft_rhash_init(const struct nft_set *set,
 		return err;
 
 	INIT_DEFERRABLE_WORK(&priv->gc_work, nft_rhash_gc);
-	if (set->flags & NFT_SET_TIMEOUT)
+	if (set->flags & (NFT_SET_TIMEOUT | NFT_SET_EVAL))
 		nft_rhash_gc_init(set);
 
 	return 0;
@@ -422,7 +442,6 @@ static void nft_rhash_destroy(const struct nft_ctx *ctx,
 	};
 
 	cancel_delayed_work_sync(&priv->gc_work);
-	rcu_barrier();
 	rhashtable_free_and_destroy(&priv->ht, nft_rhash_elem_destroy,
 				    (void *)&rhash_ctx);
 }
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 8c16681884b7..deea6196d992 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -566,8 +566,9 @@ static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 			goto out;
 
 		if (last) {
-			if (nft_set_elem_expired(&f->mt[b].e->ext) ||
-			    (genmask &&
+			if (nft_set_elem_expired(&f->mt[b].e->ext))
+				goto next_match;
+			if ((genmask &&
 			     !nft_set_elem_active(&f->mt[b].e->ext, genmask)))
 				goto next_match;
 
@@ -602,7 +603,7 @@ static void *nft_pipapo_get(const struct net *net, const struct nft_set *set,
 			    const struct nft_set_elem *elem, unsigned int flags)
 {
 	return pipapo_get(net, set, (const u8 *)elem->key.val.data,
-			  nft_genmask_cur(net));
+			 nft_genmask_cur(net));
 }
 
 /**
@@ -1536,16 +1537,34 @@ static void pipapo_drop(struct nft_pipapo_match *m,
 	}
 }
 
+static void nft_pipapo_gc_deactivate(struct net *net, struct nft_set *set,
+				     struct nft_pipapo_elem *e)
+
+{
+	struct nft_set_elem elem = {
+		.priv	= e,
+	};
+
+	nft_setelem_data_deactivate(net, set, &elem);
+}
+
 /**
  * pipapo_gc() - Drop expired entries from set, destroy start and end elements
- * @set:	nftables API set representation
+ * @_set:	nftables API set representation
  * @m:		Matching data
  */
-static void pipapo_gc(const struct nft_set *set, struct nft_pipapo_match *m)
+static void pipapo_gc(const struct nft_set *_set, struct nft_pipapo_match *m)
 {
+	struct nft_set *set = (struct nft_set *) _set;
 	struct nft_pipapo *priv = nft_set_priv(set);
+	struct net *net = read_pnet(&set->net);
 	int rules_f0, first_rule = 0;
 	struct nft_pipapo_elem *e;
+	struct nft_trans_gc *gc;
+
+	gc = nft_trans_gc_alloc(set, 0, GFP_KERNEL);
+	if (!gc)
+		return;
 
 	while ((rules_f0 = pipapo_rules_same_key(m->f, first_rule))) {
 		union nft_pipapo_map_bucket rulemap[NFT_PIPAPO_MAX_FIELDS];
@@ -1569,13 +1588,20 @@ static void pipapo_gc(const struct nft_set *set, struct nft_pipapo_match *m)
 		f--;
 		i--;
 		e = f->mt[rulemap[i].to].e;
-		if (nft_set_elem_expired(&e->ext) &&
-		    !nft_set_elem_mark_busy(&e->ext)) {
+
+		/* synchronous gc never fails, there is no need to set on
+		 * NFT_SET_ELEM_DEAD_BIT.
+		 */
+		if (nft_set_elem_expired(&e->ext)) {
 			priv->dirty = true;
-			pipapo_drop(m, rulemap);
 
-			rcu_barrier();
-			nft_set_elem_destroy(set, e, true);
+			gc = nft_trans_gc_queue_sync(gc, GFP_ATOMIC);
+			if (!gc)
+				return;
+
+			nft_pipapo_gc_deactivate(net, set, e);
+			pipapo_drop(m, rulemap);
+			nft_trans_gc_elem_add(gc, e);
 
 			/* And check again current first rule, which is now the
 			 * first we haven't checked.
@@ -1585,11 +1611,11 @@ static void pipapo_gc(const struct nft_set *set, struct nft_pipapo_match *m)
 		}
 	}
 
-	e = nft_set_catchall_gc(set);
-	if (e)
-		nft_set_elem_destroy(set, e, true);
-
-	priv->last_gc = jiffies;
+	gc = nft_trans_gc_catchall_sync(gc);
+	if (gc) {
+		nft_trans_gc_queue_sync_done(gc);
+		priv->last_gc = jiffies;
+	}
 }
 
 /**
@@ -1718,14 +1744,9 @@ static void nft_pipapo_activate(const struct net *net,
 				const struct nft_set *set,
 				const struct nft_set_elem *elem)
 {
-	struct nft_pipapo_elem *e;
-
-	e = pipapo_get(net, set, (const u8 *)elem->key.val.data, 0);
-	if (IS_ERR(e))
-		return;
+	struct nft_pipapo_elem *e = elem->priv;
 
 	nft_set_elem_change_active(net, set, &e->ext);
-	nft_set_elem_clear_busy(&e->ext);
 }
 
 /**
@@ -1937,10 +1958,6 @@ static void nft_pipapo_remove(const struct net *net, const struct nft_set *set,
 
 	data = (const u8 *)nft_set_ext_key(&e->ext);
 
-	e = pipapo_get(net, set, data, 0);
-	if (IS_ERR(e))
-		return;
-
 	while ((rules_f0 = pipapo_rules_same_key(m->f, first_rule))) {
 		union nft_pipapo_map_bucket rulemap[NFT_PIPAPO_MAX_FIELDS];
 		const u8 *match_start, *match_end;
@@ -2024,8 +2041,6 @@ static void nft_pipapo_walk(const struct nft_ctx *ctx, struct nft_set *set,
 			goto cont;
 
 		e = f->mt[r].e;
-		if (nft_set_elem_expired(&e->ext))
-			goto cont;
 
 		elem.priv = e;
 
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 8d73fffd2d09..487572dcd614 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -46,6 +46,12 @@ static int nft_rbtree_cmp(const struct nft_set *set,
 		      set->klen);
 }
 
+static bool nft_rbtree_elem_expired(const struct nft_rbtree_elem *rbe)
+{
+	return nft_set_elem_expired(&rbe->ext) ||
+	       nft_set_elem_is_dead(&rbe->ext);
+}
+
 static bool __nft_rbtree_lookup(const struct net *net, const struct nft_set *set,
 				const u32 *key, const struct nft_set_ext **ext,
 				unsigned int seq)
@@ -80,7 +86,7 @@ static bool __nft_rbtree_lookup(const struct net *net, const struct nft_set *set
 				continue;
 			}
 
-			if (nft_set_elem_expired(&rbe->ext))
+			if (nft_rbtree_elem_expired(rbe))
 				return false;
 
 			if (nft_rbtree_interval_end(rbe)) {
@@ -98,7 +104,7 @@ static bool __nft_rbtree_lookup(const struct net *net, const struct nft_set *set
 
 	if (set->flags & NFT_SET_INTERVAL && interval != NULL &&
 	    nft_set_elem_active(&interval->ext, genmask) &&
-	    !nft_set_elem_expired(&interval->ext) &&
+	    !nft_rbtree_elem_expired(interval) &&
 	    nft_rbtree_interval_start(interval)) {
 		*ext = &interval->ext;
 		return true;
@@ -215,6 +221,18 @@ static void *nft_rbtree_get(const struct net *net, const struct nft_set *set,
 	return rbe;
 }
 
+static void nft_rbtree_gc_remove(struct net *net, struct nft_set *set,
+				 struct nft_rbtree *priv,
+				 struct nft_rbtree_elem *rbe)
+{
+	struct nft_set_elem elem = {
+		.priv	= rbe,
+	};
+
+	nft_setelem_data_deactivate(net, set, &elem);
+	rb_erase(&rbe->node, &priv->root);
+}
+
 static int nft_rbtree_gc_elem(const struct nft_set *__set,
 			      struct nft_rbtree *priv,
 			      struct nft_rbtree_elem *rbe,
@@ -222,11 +240,12 @@ static int nft_rbtree_gc_elem(const struct nft_set *__set,
 {
 	struct nft_set *set = (struct nft_set *)__set;
 	struct rb_node *prev = rb_prev(&rbe->node);
+	struct net *net = read_pnet(&set->net);
 	struct nft_rbtree_elem *rbe_prev;
-	struct nft_set_gc_batch *gcb;
+	struct nft_trans_gc *gc;
 
-	gcb = nft_set_gc_batch_check(set, NULL, GFP_ATOMIC);
-	if (!gcb)
+	gc = nft_trans_gc_alloc(set, 0, GFP_ATOMIC);
+	if (!gc)
 		return -ENOMEM;
 
 	/* search for end interval coming before this element.
@@ -244,17 +263,28 @@ static int nft_rbtree_gc_elem(const struct nft_set *__set,
 
 	if (prev) {
 		rbe_prev = rb_entry(prev, struct nft_rbtree_elem, node);
+		nft_rbtree_gc_remove(net, set, priv, rbe_prev);
+
+		/* There is always room in this trans gc for this element,
+		 * memory allocation never actually happens, hence, the warning
+		 * splat in such case. No need to set NFT_SET_ELEM_DEAD_BIT,
+		 * this is synchronous gc which never fails.
+		 */
+		gc = nft_trans_gc_queue_sync(gc, GFP_ATOMIC);
+		if (WARN_ON_ONCE(!gc))
+			return -ENOMEM;
 
-		rb_erase(&rbe_prev->node, &priv->root);
-		atomic_dec(&set->nelems);
-		nft_set_gc_batch_add(gcb, rbe_prev);
+		nft_trans_gc_elem_add(gc, rbe_prev);
 	}
 
-	rb_erase(&rbe->node, &priv->root);
-	atomic_dec(&set->nelems);
+	nft_rbtree_gc_remove(net, set, priv, rbe);
+	gc = nft_trans_gc_queue_sync(gc, GFP_ATOMIC);
+	if (WARN_ON_ONCE(!gc))
+		return -ENOMEM;
+
+	nft_trans_gc_elem_add(gc, rbe);
 
-	nft_set_gc_batch_add(gcb, rbe);
-	nft_set_gc_batch_complete(gcb);
+	nft_trans_gc_queue_sync_done(gc);
 
 	return 0;
 }
@@ -282,6 +312,7 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 	struct nft_rbtree_elem *rbe, *rbe_le = NULL, *rbe_ge = NULL;
 	struct rb_node *node, *next, *parent, **p, *first = NULL;
 	struct nft_rbtree *priv = nft_set_priv(set);
+	u8 cur_genmask = nft_genmask_cur(net);
 	u8 genmask = nft_genmask_next(net);
 	int d, err;
 
@@ -327,8 +358,11 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 		if (!nft_set_elem_active(&rbe->ext, genmask))
 			continue;
 
-		/* perform garbage collection to avoid bogus overlap reports. */
-		if (nft_set_elem_expired(&rbe->ext)) {
+		/* perform garbage collection to avoid bogus overlap reports
+		 * but skip new elements in this transaction.
+		 */
+		if (nft_set_elem_expired(&rbe->ext) &&
+		    nft_set_elem_active(&rbe->ext, cur_genmask)) {
 			err = nft_rbtree_gc_elem(set, priv, rbe, genmask);
 			if (err < 0)
 				return err;
@@ -482,7 +516,6 @@ static void nft_rbtree_activate(const struct net *net,
 	struct nft_rbtree_elem *rbe = elem->priv;
 
 	nft_set_elem_change_active(net, set, &rbe->ext);
-	nft_set_elem_clear_busy(&rbe->ext);
 }
 
 static bool nft_rbtree_flush(const struct net *net,
@@ -490,12 +523,9 @@ static bool nft_rbtree_flush(const struct net *net,
 {
 	struct nft_rbtree_elem *rbe = priv;
 
-	if (!nft_set_elem_mark_busy(&rbe->ext) ||
-	    !nft_is_active(net, &rbe->ext)) {
-		nft_set_elem_change_active(net, set, &rbe->ext);
-		return true;
-	}
-	return false;
+	nft_set_elem_change_active(net, set, &rbe->ext);
+
+	return true;
 }
 
 static void *nft_rbtree_deactivate(const struct net *net,
@@ -552,8 +582,6 @@ static void nft_rbtree_walk(const struct nft_ctx *ctx,
 
 		if (iter->count < iter->skip)
 			goto cont;
-		if (nft_set_elem_expired(&rbe->ext))
-			goto cont;
 		if (!nft_set_elem_active(&rbe->ext, iter->genmask))
 			goto cont;
 
@@ -572,26 +600,42 @@ static void nft_rbtree_walk(const struct nft_ctx *ctx,
 
 static void nft_rbtree_gc(struct work_struct *work)
 {
-	struct nft_rbtree_elem *rbe, *rbe_end = NULL, *rbe_prev = NULL;
-	struct nft_set_gc_batch *gcb = NULL;
+	struct nft_rbtree_elem *rbe, *rbe_end = NULL;
+	struct nftables_pernet *nft_net;
 	struct nft_rbtree *priv;
+	struct nft_trans_gc *gc;
 	struct rb_node *node;
 	struct nft_set *set;
+	unsigned int gc_seq;
 	struct net *net;
-	u8 genmask;
 
 	priv = container_of(work, struct nft_rbtree, gc_work.work);
 	set  = nft_set_container_of(priv);
 	net  = read_pnet(&set->net);
-	genmask = nft_genmask_cur(net);
+	nft_net = nft_pernet(net);
+	gc_seq  = READ_ONCE(nft_net->gc_seq);
 
-	write_lock_bh(&priv->lock);
-	write_seqcount_begin(&priv->count);
+	if (nft_set_gc_is_pending(set))
+		goto done;
+
+	gc = nft_trans_gc_alloc(set, gc_seq, GFP_KERNEL);
+	if (!gc)
+		goto done;
+
+	read_lock_bh(&priv->lock);
 	for (node = rb_first(&priv->root); node != NULL; node = rb_next(node)) {
+
+		/* Ruleset has been updated, try later. */
+		if (READ_ONCE(nft_net->gc_seq) != gc_seq) {
+			nft_trans_gc_destroy(gc);
+			gc = NULL;
+			goto try_later;
+		}
+
 		rbe = rb_entry(node, struct nft_rbtree_elem, node);
 
-		if (!nft_set_elem_active(&rbe->ext, genmask))
-			continue;
+		if (nft_set_elem_is_dead(&rbe->ext))
+			goto dead_elem;
 
 		/* elements are reversed in the rbtree for historical reasons,
 		 * from highest to lowest value, that is why end element is
@@ -604,46 +648,35 @@ static void nft_rbtree_gc(struct work_struct *work)
 		if (!nft_set_elem_expired(&rbe->ext))
 			continue;
 
-		if (nft_set_elem_mark_busy(&rbe->ext)) {
-			rbe_end = NULL;
+		nft_set_elem_dead(&rbe->ext);
+
+		if (!rbe_end)
 			continue;
-		}
 
-		if (rbe_prev) {
-			rb_erase(&rbe_prev->node, &priv->root);
-			rbe_prev = NULL;
-		}
-		gcb = nft_set_gc_batch_check(set, gcb, GFP_ATOMIC);
-		if (!gcb)
-			break;
+		nft_set_elem_dead(&rbe_end->ext);
 
-		atomic_dec(&set->nelems);
-		nft_set_gc_batch_add(gcb, rbe);
-		rbe_prev = rbe;
+		gc = nft_trans_gc_queue_async(gc, gc_seq, GFP_ATOMIC);
+		if (!gc)
+			goto try_later;
 
-		if (rbe_end) {
-			atomic_dec(&set->nelems);
-			nft_set_gc_batch_add(gcb, rbe_end);
-			rb_erase(&rbe_end->node, &priv->root);
-			rbe_end = NULL;
-		}
-		node = rb_next(node);
-		if (!node)
-			break;
-	}
-	if (rbe_prev)
-		rb_erase(&rbe_prev->node, &priv->root);
-	write_seqcount_end(&priv->count);
-	write_unlock_bh(&priv->lock);
+		nft_trans_gc_elem_add(gc, rbe_end);
+		rbe_end = NULL;
+dead_elem:
+		gc = nft_trans_gc_queue_async(gc, gc_seq, GFP_ATOMIC);
+		if (!gc)
+			goto try_later;
 
-	rbe = nft_set_catchall_gc(set);
-	if (rbe) {
-		gcb = nft_set_gc_batch_check(set, gcb, GFP_ATOMIC);
-		if (gcb)
-			nft_set_gc_batch_add(gcb, rbe);
+		nft_trans_gc_elem_add(gc, rbe);
 	}
-	nft_set_gc_batch_complete(gcb);
 
+	gc = nft_trans_gc_catchall_async(gc, gc_seq);
+
+try_later:
+	read_unlock_bh(&priv->lock);
+
+	if (gc)
+		nft_trans_gc_queue_async_done(gc);
+done:
 	queue_delayed_work(system_power_efficient_wq, &priv->gc_work,
 			   nft_set_gc_interval(set));
 }
diff --git a/net/rds/rdma_transport.c b/net/rds/rdma_transport.c
index a9e4ff948a7d..f71f073fd27a 100644
--- a/net/rds/rdma_transport.c
+++ b/net/rds/rdma_transport.c
@@ -86,11 +86,13 @@ static int rds_rdma_cm_event_handler_cmn(struct rdma_cm_id *cm_id,
 		break;
 
 	case RDMA_CM_EVENT_ADDR_RESOLVED:
-		rdma_set_service_type(cm_id, conn->c_tos);
-		rdma_set_min_rnr_timer(cm_id, IB_RNR_TIMER_000_32);
-		/* XXX do we need to clean up if this fails? */
-		ret = rdma_resolve_route(cm_id,
-					 RDS_RDMA_RESOLVE_TIMEOUT_MS);
+		if (conn) {
+			rdma_set_service_type(cm_id, conn->c_tos);
+			rdma_set_min_rnr_timer(cm_id, IB_RNR_TIMER_000_32);
+			/* XXX do we need to clean up if this fails? */
+			ret = rdma_resolve_route(cm_id,
+						 RDS_RDMA_RESOLVE_TIMEOUT_MS);
+		}
 		break;
 
 	case RDMA_CM_EVENT_ROUTE_RESOLVED:
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index b9c54c03c30a..7756c62e0c3e 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2392,8 +2392,7 @@ call_status(struct rpc_task *task)
 		goto out_exit;
 	}
 	task->tk_action = call_encode;
-	if (status != -ECONNRESET && status != -ECONNABORTED)
-		rpc_check_timeout(task);
+	rpc_check_timeout(task);
 	return;
 out_exit:
 	rpc_call_rpcerror(task, status);
@@ -2668,6 +2667,7 @@ rpc_decode_header(struct rpc_task *task, struct xdr_stream *xdr)
 	case rpc_autherr_rejectedverf:
 	case rpcsec_gsserr_credproblem:
 	case rpcsec_gsserr_ctxproblem:
+		rpcauth_invalcred(task);
 		if (!task->tk_cred_retry)
 			break;
 		task->tk_cred_retry--;
@@ -2821,19 +2821,22 @@ static const struct rpc_call_ops rpc_cb_add_xprt_call_ops = {
  * @clnt: pointer to struct rpc_clnt
  * @xps: pointer to struct rpc_xprt_switch,
  * @xprt: pointer struct rpc_xprt
- * @dummy: unused
+ * @in_max_connect: pointer to the max_connect value for the passed in xprt transport
  */
 int rpc_clnt_test_and_add_xprt(struct rpc_clnt *clnt,
 		struct rpc_xprt_switch *xps, struct rpc_xprt *xprt,
-		void *dummy)
+		void *in_max_connect)
 {
 	struct rpc_cb_add_xprt_calldata *data;
 	struct rpc_task *task;
+	int max_connect = clnt->cl_max_connect;
 
-	if (xps->xps_nunique_destaddr_xprts + 1 > clnt->cl_max_connect) {
+	if (in_max_connect)
+		max_connect = *(int *)in_max_connect;
+	if (xps->xps_nunique_destaddr_xprts + 1 > max_connect) {
 		rcu_read_lock();
 		pr_warn("SUNRPC: reached max allowed number (%d) did not add "
-			"transport to server: %s\n", clnt->cl_max_connect,
+			"transport to server: %s\n", max_connect,
 			rpc_peeraddr2str(clnt, RPC_DISPLAY_ADDR));
 		rcu_read_unlock();
 		return -EINVAL;
diff --git a/security/smack/smack.h b/security/smack/smack.h
index 99c3422596ab..a71b7a1ca24c 100644
--- a/security/smack/smack.h
+++ b/security/smack/smack.h
@@ -120,6 +120,7 @@ struct inode_smack {
 struct task_smack {
 	struct smack_known	*smk_task;	/* label for access control */
 	struct smack_known	*smk_forked;	/* label when forked */
+	struct smack_known	*smk_transmuted;/* label when transmuted */
 	struct list_head	smk_rules;	/* per task access rules */
 	struct mutex		smk_rules_lock;	/* lock for the rules */
 	struct list_head	smk_relabel;	/* transit allowed labels */
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 3f3f56f6be4d..39f564f47fea 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -955,8 +955,9 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr, const char **name,
 				     void **value, size_t *len)
 {
+	struct task_smack *tsp = smack_cred(current_cred());
 	struct inode_smack *issp = smack_inode(inode);
-	struct smack_known *skp = smk_of_current();
+	struct smack_known *skp = smk_of_task(tsp);
 	struct smack_known *isp = smk_of_inode(inode);
 	struct smack_known *dsp = smk_of_inode(dir);
 	int may;
@@ -965,20 +966,34 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 		*name = XATTR_SMACK_SUFFIX;
 
 	if (value && len) {
-		rcu_read_lock();
-		may = smk_access_entry(skp->smk_known, dsp->smk_known,
-				       &skp->smk_rules);
-		rcu_read_unlock();
+		/*
+		 * If equal, transmuting already occurred in
+		 * smack_dentry_create_files_as(). No need to check again.
+		 */
+		if (tsp->smk_task != tsp->smk_transmuted) {
+			rcu_read_lock();
+			may = smk_access_entry(skp->smk_known, dsp->smk_known,
+					       &skp->smk_rules);
+			rcu_read_unlock();
+		}
 
 		/*
-		 * If the access rule allows transmutation and
-		 * the directory requests transmutation then
-		 * by all means transmute.
+		 * In addition to having smk_task equal to smk_transmuted,
+		 * if the access rule allows transmutation and the directory
+		 * requests transmutation then by all means transmute.
 		 * Mark the inode as changed.
 		 */
-		if (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
-		    smk_inode_transmutable(dir)) {
-			isp = dsp;
+		if ((tsp->smk_task == tsp->smk_transmuted) ||
+		    (may > 0 && ((may & MAY_TRANSMUTE) != 0) &&
+		     smk_inode_transmutable(dir))) {
+			/*
+			 * The caller of smack_dentry_create_files_as()
+			 * should have overridden the current cred, so the
+			 * inode label was already set correctly in
+			 * smack_inode_alloc_security().
+			 */
+			if (tsp->smk_task != tsp->smk_transmuted)
+				isp = dsp;
 			issp->smk_flags |= SMK_INODE_CHANGED;
 		}
 
@@ -1414,10 +1429,19 @@ static int smack_inode_getsecurity(struct user_namespace *mnt_userns,
 	struct super_block *sbp;
 	struct inode *ip = (struct inode *)inode;
 	struct smack_known *isp;
+	struct inode_smack *ispp;
+	size_t label_len;
+	char *label = NULL;
 
-	if (strcmp(name, XATTR_SMACK_SUFFIX) == 0)
+	if (strcmp(name, XATTR_SMACK_SUFFIX) == 0) {
 		isp = smk_of_inode(inode);
-	else {
+	} else if (strcmp(name, XATTR_SMACK_TRANSMUTE) == 0) {
+		ispp = smack_inode(inode);
+		if (ispp->smk_flags & SMK_INODE_TRANSMUTE)
+			label = TRANS_TRUE;
+		else
+			label = "";
+	} else {
 		/*
 		 * The rest of the Smack xattrs are only on sockets.
 		 */
@@ -1439,13 +1463,18 @@ static int smack_inode_getsecurity(struct user_namespace *mnt_userns,
 			return -EOPNOTSUPP;
 	}
 
+	if (!label)
+		label = isp->smk_known;
+
+	label_len = strlen(label);
+
 	if (alloc) {
-		*buffer = kstrdup(isp->smk_known, GFP_KERNEL);
+		*buffer = kstrdup(label, GFP_KERNEL);
 		if (*buffer == NULL)
 			return -ENOMEM;
 	}
 
-	return strlen(isp->smk_known);
+	return label_len;
 }
 
 
@@ -4634,7 +4663,7 @@ static int smack_inode_copy_up(struct dentry *dentry, struct cred **new)
 	/*
 	 * Get label from overlay inode and set it in create_sid
 	 */
-	isp = smack_inode(d_inode(dentry->d_parent));
+	isp = smack_inode(d_inode(dentry));
 	skp = isp->smk_inode;
 	tsp->smk_task = skp;
 	*new = new_creds;
@@ -4685,8 +4714,10 @@ static int smack_dentry_create_files_as(struct dentry *dentry, int mode,
 		 * providing access is transmuting use the containing
 		 * directory label instead of the process label.
 		 */
-		if (may > 0 && (may & MAY_TRANSMUTE))
+		if (may > 0 && (may & MAY_TRANSMUTE)) {
 			ntsp->smk_task = isp->smk_inode;
+			ntsp->smk_transmuted = ntsp->smk_task;
+		}
 	}
 	return 0;
 }
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 1379ac07df35..1e9092d7e9e8 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2203,6 +2203,7 @@ static const struct snd_pci_quirk power_save_denylist[] = {
 	SND_PCI_QUIRK(0x8086, 0x2068, "Intel NUC7i3BNB", 0),
 	/* https://bugzilla.kernel.org/show_bug.cgi?id=198611 */
 	SND_PCI_QUIRK(0x17aa, 0x2227, "Lenovo X1 Carbon 3rd Gen", 0),
+	SND_PCI_QUIRK(0x17aa, 0x316e, "Lenovo ThinkCentre M70q", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1689623 */
 	SND_PCI_QUIRK(0x17aa, 0x367b, "Lenovo IdeaCentre B550", 0),
 	/* https://bugzilla.redhat.com/show_bug.cgi?id=1572975 */
diff --git a/sound/soc/fsl/imx-audmix.c b/sound/soc/fsl/imx-audmix.c
index d991e457060c..0363255c39ea 100644
--- a/sound/soc/fsl/imx-audmix.c
+++ b/sound/soc/fsl/imx-audmix.c
@@ -320,7 +320,7 @@ static int imx_audmix_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->cpu_mclk)) {
 		ret = PTR_ERR(priv->cpu_mclk);
 		dev_err(&cpu_pdev->dev, "failed to get DAI mclk1: %d\n", ret);
-		return -EINVAL;
+		return ret;
 	}
 
 	priv->audmix_pdev = audmix_pdev;
diff --git a/sound/soc/fsl/imx-pcm-rpmsg.c b/sound/soc/fsl/imx-pcm-rpmsg.c
index 35049043e532..933bac7ea186 100644
--- a/sound/soc/fsl/imx-pcm-rpmsg.c
+++ b/sound/soc/fsl/imx-pcm-rpmsg.c
@@ -19,6 +19,7 @@
 static struct snd_pcm_hardware imx_rpmsg_pcm_hardware = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED |
 		SNDRV_PCM_INFO_BLOCK_TRANSFER |
+		SNDRV_PCM_INFO_BATCH |
 		SNDRV_PCM_INFO_MMAP |
 		SNDRV_PCM_INFO_MMAP_VALID |
 		SNDRV_PCM_INFO_NO_PERIOD_WAKEUP |
diff --git a/sound/soc/fsl/imx-rpmsg.c b/sound/soc/fsl/imx-rpmsg.c
index f96fe4ff8425..d208b05051fd 100644
--- a/sound/soc/fsl/imx-rpmsg.c
+++ b/sound/soc/fsl/imx-rpmsg.c
@@ -66,6 +66,14 @@ static int imx_rpmsg_probe(struct platform_device *pdev)
 			    SND_SOC_DAIFMT_NB_NF |
 			    SND_SOC_DAIFMT_CBS_CFS;
 
+	/*
+	 * i.MX rpmsg sound cards work on codec slave mode. MCLK will be
+	 * disabled by CPU DAI driver in hw_free(). Some codec requires MCLK
+	 * present at power up/down sequence. So need to set ignore_pmdown_time
+	 * to power down codec immediately before MCLK is turned off.
+	 */
+	data->dai.ignore_pmdown_time = 1;
+
 	/* Optional codec node */
 	ret = of_parse_phandle_with_fixed_args(np, "audio-codec", 0, 0, &args);
 	if (ret) {
diff --git a/sound/soc/meson/axg-spdifin.c b/sound/soc/meson/axg-spdifin.c
index d0d09f945b48..7aaded1fc376 100644
--- a/sound/soc/meson/axg-spdifin.c
+++ b/sound/soc/meson/axg-spdifin.c
@@ -112,34 +112,6 @@ static int axg_spdifin_prepare(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int axg_spdifin_startup(struct snd_pcm_substream *substream,
-			       struct snd_soc_dai *dai)
-{
-	struct axg_spdifin *priv = snd_soc_dai_get_drvdata(dai);
-	int ret;
-
-	ret = clk_prepare_enable(priv->refclk);
-	if (ret) {
-		dev_err(dai->dev,
-			"failed to enable spdifin reference clock\n");
-		return ret;
-	}
-
-	regmap_update_bits(priv->map, SPDIFIN_CTRL0, SPDIFIN_CTRL0_EN,
-			   SPDIFIN_CTRL0_EN);
-
-	return 0;
-}
-
-static void axg_spdifin_shutdown(struct snd_pcm_substream *substream,
-				 struct snd_soc_dai *dai)
-{
-	struct axg_spdifin *priv = snd_soc_dai_get_drvdata(dai);
-
-	regmap_update_bits(priv->map, SPDIFIN_CTRL0, SPDIFIN_CTRL0_EN, 0);
-	clk_disable_unprepare(priv->refclk);
-}
-
 static void axg_spdifin_write_mode_param(struct regmap *map, int mode,
 					 unsigned int val,
 					 unsigned int num_per_reg,
@@ -251,25 +223,38 @@ static int axg_spdifin_dai_probe(struct snd_soc_dai *dai)
 	ret = axg_spdifin_sample_mode_config(dai, priv);
 	if (ret) {
 		dev_err(dai->dev, "mode configuration failed\n");
-		clk_disable_unprepare(priv->pclk);
-		return ret;
+		goto pclk_err;
 	}
 
+	ret = clk_prepare_enable(priv->refclk);
+	if (ret) {
+		dev_err(dai->dev,
+			"failed to enable spdifin reference clock\n");
+		goto pclk_err;
+	}
+
+	regmap_update_bits(priv->map, SPDIFIN_CTRL0, SPDIFIN_CTRL0_EN,
+			   SPDIFIN_CTRL0_EN);
+
 	return 0;
+
+pclk_err:
+	clk_disable_unprepare(priv->pclk);
+	return ret;
 }
 
 static int axg_spdifin_dai_remove(struct snd_soc_dai *dai)
 {
 	struct axg_spdifin *priv = snd_soc_dai_get_drvdata(dai);
 
+	regmap_update_bits(priv->map, SPDIFIN_CTRL0, SPDIFIN_CTRL0_EN, 0);
+	clk_disable_unprepare(priv->refclk);
 	clk_disable_unprepare(priv->pclk);
 	return 0;
 }
 
 static const struct snd_soc_dai_ops axg_spdifin_ops = {
 	.prepare	= axg_spdifin_prepare,
-	.startup	= axg_spdifin_startup,
-	.shutdown	= axg_spdifin_shutdown,
 };
 
 static int axg_spdifin_iec958_info(struct snd_kcontrol *kcontrol,
diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
index 57890b357f85..eca91e7a4d39 100644
--- a/tools/include/linux/btf_ids.h
+++ b/tools/include/linux/btf_ids.h
@@ -38,7 +38,7 @@ asm(							\
 	____BTF_ID(symbol)
 
 #define __ID(prefix) \
-	__PASTE(prefix, __COUNTER__)
+	__PASTE(__PASTE(prefix, __COUNTER__), __LINE__)
 
 /*
  * The BTF_ID defines unique symbol for each ID pointing
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 8330e3ca8fbf..1e3e3f16eabc 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1762,7 +1762,9 @@ union bpf_attr {
  * 		performed again, if the helper is used in combination with
  * 		direct packet access.
  * 	Return
- * 		0 on success, or a negative error in case of failure.
+ * 		0 on success, or a negative error in case of failure. Positive
+ * 		error indicates a potential drop or congestion in the target
+ * 		device. The particular positive error codes are not defined.
  *
  * u64 bpf_get_current_pid_tgid(void)
  * 	Return
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index f2914d5bed6e..7d085927da41 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -263,6 +263,12 @@ ifeq ($(BISON_GE_35),1)
 else
   bison_flags += -w
 endif
+
+BISON_LT_381 := $(shell expr $(shell $(BISON) --version | grep bison | sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \< 381)
+ifeq ($(BISON_LT_381),1)
+  bison_flags += -DYYNOMEM=YYABORT
+endif
+
 CFLAGS_parse-events-bison.o += $(bison_flags)
 CFLAGS_pmu-bison.o          += -DYYLTYPE_IS_TRIVIAL=0 $(bison_flags)
 CFLAGS_expr-bison.o         += -DYYLTYPE_IS_TRIVIAL=0 $(bison_flags)
diff --git a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
index 0eb47fbb3f44..42422e425107 100644
--- a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
+++ b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
@@ -39,7 +39,7 @@ instance_read() {
 
 instance_set() {
         while :; do
-                echo 1 > foo/events/sched/sched_switch
+                echo 1 > foo/events/sched/sched_switch/enable
         done 2> /dev/null
 }
 
diff --git a/tools/testing/selftests/kselftest_deps.sh b/tools/testing/selftests/kselftest_deps.sh
index 00e60d6eb16b..7e51f4a373d3 100755
--- a/tools/testing/selftests/kselftest_deps.sh
+++ b/tools/testing/selftests/kselftest_deps.sh
@@ -46,11 +46,11 @@ fi
 print_targets=0
 
 while getopts "p" arg; do
-    case $arg in
-        p)
+	case $arg in
+		p)
 		print_targets=1
 	shift;;
-    esac
+	esac
 done
 
 if [ $# -eq 0 ]
@@ -92,6 +92,10 @@ pass_cnt=0
 # Get all TARGETS from selftests Makefile
 targets=$(egrep "^TARGETS +|^TARGETS =" Makefile | cut -d "=" -f2)
 
+# Initially, in LDLIBS related lines, the dep checker needs
+# to ignore lines containing the following strings:
+filter="\$(VAR_LDLIBS)\|pkg-config\|PKG_CONFIG\|IOURING_EXTRA_LIBS"
+
 # Single test case
 if [ $# -eq 2 ]
 then
@@ -100,6 +104,8 @@ then
 	l1_test $test
 	l2_test $test
 	l3_test $test
+	l4_test $test
+	l5_test $test
 
 	print_results $1 $2
 	exit $?
@@ -113,7 +119,7 @@ fi
 # Append space at the end of the list to append more tests.
 
 l1_tests=$(grep -r --include=Makefile "^LDLIBS" | \
-		grep -v "VAR_LDLIBS" | awk -F: '{print $1}')
+		grep -v "$filter" | awk -F: '{print $1}' | uniq)
 
 # Level 2: LDLIBS set dynamically.
 #
@@ -126,7 +132,7 @@ l1_tests=$(grep -r --include=Makefile "^LDLIBS" | \
 # Append space at the end of the list to append more tests.
 
 l2_tests=$(grep -r --include=Makefile ": LDLIBS" | \
-		grep -v "VAR_LDLIBS" | awk -F: '{print $1}')
+		grep -v "$filter" | awk -F: '{print $1}' | uniq)
 
 # Level 3
 # memfd and others use pkg-config to find mount and fuse libs
@@ -138,11 +144,32 @@ l2_tests=$(grep -r --include=Makefile ": LDLIBS" | \
 #	VAR_LDLIBS := $(shell pkg-config fuse --libs 2>/dev/null)
 
 l3_tests=$(grep -r --include=Makefile "^VAR_LDLIBS" | \
-		grep -v "pkg-config" | awk -F: '{print $1}')
+		grep -v "pkg-config\|PKG_CONFIG" | awk -F: '{print $1}' | uniq)
 
-#echo $l1_tests
-#echo $l2_1_tests
-#echo $l3_tests
+# Level 4
+# some tests may fall back to default using `|| echo -l<libname>`
+# if pkg-config doesn't find the libs, instead of using VAR_LDLIBS
+# as per level 3 checks.
+# e.g:
+# netfilter/Makefile
+#	LDLIBS += $(shell $(HOSTPKG_CONFIG) --libs libmnl 2>/dev/null || echo -lmnl)
+l4_tests=$(grep -r --include=Makefile "^LDLIBS" | \
+		grep "pkg-config\|PKG_CONFIG" | awk -F: '{print $1}' | uniq)
+
+# Level 5
+# some tests may use IOURING_EXTRA_LIBS to add extra libs to LDLIBS,
+# which in turn may be defined in a sub-Makefile
+# e.g.:
+# mm/Makefile
+#	$(OUTPUT)/gup_longterm: LDLIBS += $(IOURING_EXTRA_LIBS)
+l5_tests=$(grep -r --include=Makefile "LDLIBS +=.*\$(IOURING_EXTRA_LIBS)" | \
+	awk -F: '{print $1}' | uniq)
+
+#echo l1_tests $l1_tests
+#echo l2_tests $l2_tests
+#echo l3_tests $l3_tests
+#echo l4_tests $l4_tests
+#echo l5_tests $l5_tests
 
 all_tests
 print_results $1 $2
@@ -164,24 +191,32 @@ all_tests()
 	for test in $l3_tests; do
 		l3_test $test
 	done
+
+	for test in $l4_tests; do
+		l4_test $test
+	done
+
+	for test in $l5_tests; do
+		l5_test $test
+	done
 }
 
 # Use same parsing used for l1_tests and pick libraries this time.
 l1_test()
 {
 	test_libs=$(grep --include=Makefile "^LDLIBS" $test | \
-			grep -v "VAR_LDLIBS" | \
+			grep -v "$filter" | \
 			sed -e 's/\:/ /' | \
 			sed -e 's/+/ /' | cut -d "=" -f 2)
 
 	check_libs $test $test_libs
 }
 
-# Use same parsing used for l2__tests and pick libraries this time.
+# Use same parsing used for l2_tests and pick libraries this time.
 l2_test()
 {
 	test_libs=$(grep --include=Makefile ": LDLIBS" $test | \
-			grep -v "VAR_LDLIBS" | \
+			grep -v "$filter" | \
 			sed -e 's/\:/ /' | sed -e 's/+/ /' | \
 			cut -d "=" -f 2)
 
@@ -197,6 +232,24 @@ l3_test()
 	check_libs $test $test_libs
 }
 
+l4_test()
+{
+	test_libs=$(grep --include=Makefile "^VAR_LDLIBS\|^LDLIBS" $test | \
+			grep "\(pkg-config\|PKG_CONFIG\).*|| echo " | \
+			sed -e 's/.*|| echo //' | sed -e 's/)$//')
+
+	check_libs $test $test_libs
+}
+
+l5_test()
+{
+	tests=$(find $(dirname "$test") -type f -name "*.mk")
+	test_libs=$(grep "^IOURING_EXTRA_LIBS +\?=" $tests | \
+			cut -d "=" -f 2)
+
+	check_libs $test $test_libs
+}
+
 check_libs()
 {
 
diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 97fceb9be9ed..3bdb09373135 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -441,11 +441,11 @@ TEST_F(tls, sendmsg_large)
 
 		msg.msg_iov = &vec;
 		msg.msg_iovlen = 1;
-		EXPECT_EQ(sendmsg(self->cfd, &msg, 0), send_len);
+		EXPECT_EQ(sendmsg(self->fd, &msg, 0), send_len);
 	}
 
 	while (recvs++ < sends) {
-		EXPECT_NE(recv(self->fd, mem, send_len, 0), -1);
+		EXPECT_NE(recv(self->cfd, mem, send_len, 0), -1);
 	}
 
 	free(mem);
@@ -474,9 +474,9 @@ TEST_F(tls, sendmsg_multiple)
 	msg.msg_iov = vec;
 	msg.msg_iovlen = iov_len;
 
-	EXPECT_EQ(sendmsg(self->cfd, &msg, 0), total_len);
+	EXPECT_EQ(sendmsg(self->fd, &msg, 0), total_len);
 	buf = malloc(total_len);
-	EXPECT_NE(recv(self->fd, buf, total_len, 0), -1);
+	EXPECT_NE(recv(self->cfd, buf, total_len, 0), -1);
 	for (i = 0; i < iov_len; i++) {
 		EXPECT_EQ(memcmp(test_strs[i], buf + len_cmp,
 				 strlen(test_strs[i])),
