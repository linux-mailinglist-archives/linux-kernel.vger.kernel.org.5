Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93F978FE61
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349772AbjIANiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbjIANiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:38:19 -0400
X-Greylist: delayed 322 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Sep 2023 06:38:15 PDT
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFF5CC5;
        Fri,  1 Sep 2023 06:38:15 -0700 (PDT)
Received: from toolbox.int.toradex.com ([213.55.223.243]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0M6SuT-1pjA5T1zzf-00yNVJ; Fri, 01 Sep 2023 15:32:41 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: [PATCH v1] arm64: dts: ti: verdin-am62: add iw416 based bluetooth
Date:   Fri,  1 Sep 2023 15:32:32 +0200
Message-Id: <20230901133233.105546-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Y2b6Xok5Ab6kDR8NeHrJj30jRiKwp+d75tz42valdNq83GDoqqO
 TSyo4xfyK1JKB5YPkBkjepHa2Dz6yZEA9V4zt615SM1UGN09CaARAL5RlvqgxQFqOM3gDCs
 GB7bW8R7GwaHXCKtdQs7/XzT4x7Qb8G/gjp49dxlxcJxOgbq4jA7mjwMoaHfiYcIaixSbTi
 HV+IC/2ecMvEknEKV03pg==
UI-OutboundReport: notjunk:1;M01:P0:ioNU7onBA9M=;1FXsYta/Ly5GTixTlhk5eWTwqN4
 n0TyLpsNkyE465WwrK6fCopeQ4CYgf54wUfhMMEtmFIxTH7LI1rLJsQWbmbfe1hKrcInpDUE7
 2KC4oVcm8Rh/Vkytzd8oODhtSFWLALBbW8lVdvZnQoCCR2upY3clncPPqz2U+gNcEK2SmEmsZ
 GUKVre43AHq8zlwqxIknJsKvq6L4Vt+O/nIV4fGQ6O6fZi4E67H1OR0gBGXtey58Iz0eoyShV
 slNnM2lznLSBbpyr8VQaXppAug92vl4mBgbsngQMuFABb4FP1by0UcUnhZuQ3KvFPxTvBR5uo
 x7dQNwm6NriCtJS3VVAVSH9F3t5lPz1ZaOTtvHoMn1BV0vmHbhIr0utQJLJGIwbQMv6JB0EO0
 bvxDXlLoOdkgsz8Bq/edU6QzPKd6NugF9weiHg7wSKycHhsYl2USFAtxQpy4Asaj0F3m+N7ue
 g4Vgo9Ew43bEYmjzvTjvgODAtdbROztLQhPB0GQ+CN1x9ta4A9bgBygfZNtgqJHwIRZHjJzfj
 TYtEE4WHEesBQ69rxcQFBv9vB16zd4AM2MnIWCDCoU0iaLg66rAJBAvfOBL7lljAP2ysmX91n
 seMr/Xs7PTi1E/NjtJWgBXMrD4/osx6MD5TmkU4xooy2HkT/tAuZYxS+23XJbKHRElJrn9wR3
 r66ekNtXBkuRuhV0qmf5BGt4IeH74iZSdR7Z8Drl8KNBkHs/F71NqCjm9Qvj21dAIYhW0W/7E
 DgDmrR3Jjm2unwXZMzLwrIDqDI1jL9huHFMR4n0x9Ia+pUyreQbblwYd8pEjKt8e0HDrnKEtj
 M6PumVaVLFiNDQUtrfDHrlysWYnocmJJUY2lODiHzKcqbuwE+SDxdSOtwOVnY0Lk90R+mExev
 O2iIxmEfZvCz9gXvCwxayfyXqtLHvG46eXuE=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add NXP IW416 based u-blox MAYA-W1 Bluetooth (using btnxpuart) as used
on the V1.1 SoMs. Wi-Fi is and was already using mwifiex.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm64/boot/dts/ti/k3-am62-verdin-wifi.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-verdin-wifi.dtsi b/arch/arm64/boot/dts/ti/k3-am62-verdin-wifi.dtsi
index 90ddc71bcd30..a6808b10c7b2 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-verdin-wifi.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-verdin-wifi.dtsi
@@ -35,5 +35,11 @@ &sdhci2 {
 &main_uart5 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart5>;
+	uart-has-rtscts;
 	status = "okay";
+
+	bluetooth {
+		compatible = "nxp,88w8987-bt";
+		fw-init-baudrate = <3000000>;
+	};
 };
-- 
2.36.1

