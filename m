Return-Path: <linux-kernel+bounces-16109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B71823911
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 618FC2874B3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB17B2032D;
	Wed,  3 Jan 2024 23:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0Wj0YSN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F78320321;
	Wed,  3 Jan 2024 23:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B242C433CD;
	Wed,  3 Jan 2024 23:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704323781;
	bh=yEGR043qt+dE+WGZhZAa/guimX9DAzWuYhf0RWwWwTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o0Wj0YSNTzVks0rALhjRa4xpZwN5ZmC1OCaIkkn+oakPQ9TkUBgkhbBOD/2Kp6IHD
	 8hZSob74XUQ3eLSP0JFpFbzerMRDSMwcePQUIhXAlJpkpc7oQtFsYBuRcJ73XViXkl
	 3zUgkOj9PEQKy1enSUgvd3mPiagVlpcSAnufbQOktG8RkbV029zyIvihcETvky01FM
	 GMTZafbzu67TTgXSVGDhJuNLbSOXAnTnna35KymIbltqQsHItMGz25u+DV5FPYBtSh
	 BoBn1xDjQ7ccMvDN1X5Z5OhN+I6Sja2UN/FwAMNJo6O6pnSzcmDgGERoGZGFlJqEXv
	 zEp+MSdUeevJQ==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Subject: [PATCH 4/8] arm64: dts: Fix typos
Date: Wed,  3 Jan 2024 17:16:01 -0600
Message-Id: <20240103231605.1801364-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240103231605.1801364-1-helgaas@kernel.org>
References: <20240103231605.1801364-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Fix typos, most reported by "codespell arch/arm64/boot/dts".  Only touches
comments, no code changes.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts | 2 +-
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi                 | 2 +-
 arch/arm64/boot/dts/apm/apm-storm.dtsi                     | 2 +-
 arch/arm64/boot/dts/exynos/exynos7.dtsi                    | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi             | 2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts        | 2 +-
 arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi           | 2 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi                      | 4 ++--
 arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi   | 2 +-
 arch/arm64/boot/dts/qcom/sa8155p.dtsi                      | 2 +-
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi                 | 4 ++--
 arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts           | 2 +-
 arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi      | 2 +-
 arch/arm64/boot/dts/renesas/draak.dtsi                     | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts        | 2 +-
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi                 | 2 +-
 16 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
index 723af64a9cee..bac2a1ecfb9e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
@@ -16,7 +16,7 @@ &backlight {
 	 * PWM backlight circuit on this PinePhone revision was changed since
 	 * 1.0, and the lowest PWM duty cycle that doesn't lead to backlight
 	 * being off is around 20%. Duty cycle for the lowest brightness level
-	 * also varries quite a bit between individual boards, so the lowest
+	 * also varies quite a bit between individual boards, so the lowest
 	 * value here was chosen as a safe default.
 	 */
 	brightness-levels = <
diff --git a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
index 65ebac3082e2..8891a6c17347 100644
--- a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
@@ -123,7 +123,7 @@ gic: interrupt-controller@78090000 {
 		#address-cells = <2>;
 		#size-cells = <2>;
 		interrupt-controller;
-		interrupts = <1 9 0xf04>;	/* GIC Maintenence IRQ */
+		interrupts = <1 9 0xf04>;	/* GIC Maintenance IRQ */
 		ranges = <0 0 0 0x79000000 0x0 0x800000>; /* MSI Range */
 		reg = <0x0 0x78090000 0x0 0x10000>,	/* GIC Dist */
 		      <0x0 0x780a0000 0x0 0x20000>,	/* GIC CPU */
diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index 988928c60f15..ee1303a68d50 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -109,7 +109,7 @@ gic: interrupt-controller@78010000 {
 		      <0x0 0x78020000 0x0 0x1000>,	/* GIC CPU */
 		      <0x0 0x78040000 0x0 0x2000>,	/* GIC VCPU Control */
 		      <0x0 0x78060000 0x0 0x2000>;	/* GIC VCPU */
-		interrupts = <1 9 0xf04>;	/* GIC Maintenence IRQ */
+		interrupts = <1 9 0xf04>;	/* GIC Maintenance IRQ */
 	};
 
 	timer {
diff --git a/arch/arm64/boot/dts/exynos/exynos7.dtsi b/arch/arm64/boot/dts/exynos/exynos7.dtsi
index 6ed80ddf3369..6e83d288de53 100644
--- a/arch/arm64/boot/dts/exynos/exynos7.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7.dtsi
@@ -645,7 +645,7 @@ tmuctrl_0: tmu@10060000 {
 		ufs: ufs@15570000 {
 			compatible = "samsung,exynos7-ufs";
 			reg = <0x15570000 0x100>,  /* 0: HCI standard */
-				<0x15570100 0x100>,  /* 1: Vendor specificed */
+				<0x15570100 0x100>,  /* 1: Vendor specified */
 				<0x15571000 0x200>,  /* 2: UNIPRO */
 				<0x15572000 0x300>;  /* 3: UFS protector */
 			reg-names = "hci", "vs_hci", "unipro", "ufsp";
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index eefe3577d94e..459e43785c83 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -150,7 +150,7 @@ gic: interrupt-controller@6000000 {
 		its: msi-controller@6020000 {
 			compatible = "arm,gic-v3-its";
 			msi-controller;
-			reg = <0x0 0x06020000 0 0x20000>;/* GIC Translater */
+			reg = <0x0 0x06020000 0 0x20000>;/* GIC Translator */
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
index d4867d6cf47c..7436d041cca4 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-ten64.dts
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
 /*
- * Device Tree file for Travese Ten64 (LS1088) board
+ * Device Tree file for Traverse Ten64 (LS1088) board
  * Based on fsl-ls1088a-rdb.dts
  * Copyright 2017-2020 NXP
  * Copyright 2019-2021 Traverse Technologies
diff --git a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
index 49d105eb4769..2b41fbdf136e 100644
--- a/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8x-colibri.dtsi
@@ -504,7 +504,7 @@ pinctrl_hog2: hog2grp {
 
 	/*
 	 * This pin is used in the SCFW as a UART. Using it from
-	 * Linux would require rewritting the SCFW board file.
+	 * Linux would require rewriting the SCFW board file.
 	 */
 	pinctrl_hog_scfw: hogscfwgrp {
 		fsl,pins = <IMX8QXP_SCU_GPIO0_00_LSIO_GPIO2_IO03		0x20>;		/* SODIMM 144 */
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 4f799b536a92..34fa2843fdc7 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -666,12 +666,12 @@ in-ports {
 
 				/*
 				 * Not described input ports:
-				 * 0 - connected to Resource and Power Manger CPU ETM
+				 * 0 - connected to Resource and Power Manager CPU ETM
 				 * 1 - not-connected
 				 * 2 - connected to Modem CPU ETM
 				 * 3 - not-connected
 				 * 5 - not-connected
-				 * 6 - connected trought funnel to Wireless CPU ETM
+				 * 6 - connected through funnel to Wireless CPU ETM
 				 * 7 - connected to STM component
 				 */
 
diff --git a/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi b/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
index cbc84459a5ae..4e0e7dfe1b4a 100644
--- a/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon.dtsi
@@ -857,7 +857,7 @@ &sdhc1 {
 	status = "okay";
 
 	/*
-	 * This device is shipped with HS400 capabable eMMCs
+	 * This device is shipped with HS400 capable eMMCs
 	 * However various brands have been used in various product batches,
 	 * including a Samsung eMMC (BGND3R) which features a quirk with HS400.
 	 * Set the speed to HS200 as a safety measure.
diff --git a/arch/arm64/boot/dts/qcom/sa8155p.dtsi b/arch/arm64/boot/dts/qcom/sa8155p.dtsi
index ffb7ab695213..1bc86a8529e1 100644
--- a/arch/arm64/boot/dts/qcom/sa8155p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8155p.dtsi
@@ -4,7 +4,7 @@
  *
  * SA8155P is an automotive variant of SM8150, with some minor changes.
  * Most notably, the RPMhPD setup differs: MMCX and LCX/LMX rails are gone,
- * though the cmd-db doesn't reflect that and access attemps result in a bite.
+ * though the cmd-db doesn't reflect that and access attempts result in a bite.
  */
 
 #include "sm8150.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
index f9b96bd2477e..9dae5931dead 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
@@ -563,8 +563,8 @@ &sdc1_rclk {
  *
  * This has entries that are defined by Qcard even if they go to the main
  * board. In cases where the pulls may be board dependent we defer those
- * settings to the board device tree. Drive strengths tend to be assinged here
- * but could conceivably be overwridden by board device trees.
+ * settings to the board device tree. Drive strengths tend to be assigned here
+ * but could conceivably be overridden by board device trees.
  */
 
 &pm8350c_gpios {
diff --git a/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts b/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
index 32a7bd59e1ec..8f89352aeb73 100644
--- a/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
+++ b/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
@@ -168,7 +168,7 @@ vph_pwr: vph-pwr-regulator {
 	 * Supply map from xiaomi-lavender specifies this as the supply for
 	 * ldob1, ldob9, ldob10, ldoa2, and ldoa3, while downstream specifies
 	 * this as a power domain. Set this as a fixed regulator with the same
-	 * voltage as lavender until display is needed to avoid unneccessarily
+	 * voltage as lavender until display is needed to avoid unnecessarily
 	 * using a deprecated binding (regulator-fixed-domain).
 	 */
 	vreg_s2b_1p05: vreg-s2b-regulator {
diff --git a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
index b02a1dc5fecd..a4be5c6ebb47 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama.dtsi
@@ -305,7 +305,7 @@ vreg_l19a_2p7: ldo19 {
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 
 			/*
-			 * The driver *really* doesn't want this regualtor to exist,
+			 * The driver *really* doesn't want this regulator to exist,
 			 * saying that it could not get the current voltage (-ENOTRECOVERABLE)
 			 * even though it surely is used on these devices (as a voltage
 			 * source for camera autofocus)
diff --git a/arch/arm64/boot/dts/renesas/draak.dtsi b/arch/arm64/boot/dts/renesas/draak.dtsi
index ef3bb835d5c0..67c36f71f4cb 100644
--- a/arch/arm64/boot/dts/renesas/draak.dtsi
+++ b/arch/arm64/boot/dts/renesas/draak.dtsi
@@ -226,7 +226,7 @@ &audio_clk_b {
 	/*
 	 * X11 is connected to VI4_FIELD/SCIF_CLK/AUDIO_CLKB,
 	 * and R-Car Sound uses AUDIO_CLKB.
-	 * Note is that schematic indicates VI4_FIELD conection only
+	 * Note is that schematic indicates VI4_FIELD connection only
 	 * not AUDIO_CLKB at SoC page.
 	 * And this VI4_FIELD/SCIF_CLK/AUDIO_CLKB is connected to SW60.
 	 * SW60 should be 1-2.
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts
index 7ba1c28f70a9..ce55f82268b2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts
@@ -9,7 +9,7 @@
 /*
  * Notice:
  * 1. rk3399-roc-pc-plus is powered by dc_12v directly.
- * 2. rk3399-roc-pc-plus has only vcc_bus_typec0 in schematic, which is coresponding
+ * 2. rk3399-roc-pc-plus has only vcc_bus_typec0 in schematic, which is corresponding
  *    to vcc_vbus_typec1 in rk3399-roc-pc.
  *    For simplicity, reserve the node name of vcc_vbus_typec1.
  * 3. vcc5v0_host is actually 2 regulators (host0, 1) controlled by the same gpio.
diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
index 5db52f237253..e99e69027125 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
@@ -1415,7 +1415,7 @@ &usbss0 {
 	status = "disabled";
 };
 
-/* TODO: role swich using ID pin */
+/* TODO: role switch using ID pin */
 &usb0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usb0>, <&pinctrl_usb0_id>;
-- 
2.34.1


