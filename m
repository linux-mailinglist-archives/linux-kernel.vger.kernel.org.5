Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844557703C3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjHDPBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjHDPBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:01:48 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04636AC;
        Fri,  4 Aug 2023 08:01:45 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id BDAB483DA2;
        Fri,  4 Aug 2023 17:01:43 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Fri, 04 Aug 2023 17:00:40 +0200
Subject: [PATCH] arm: marvell: Fix maxium->maxim typo for brownstone dts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230804-brownstone-typo-fix-v1-1-4832d84c0509@skole.hr>
X-B4-Tracking: v=1; b=H4sIAJcSzWQC/x2MywqAIBAAfyX23IKWmfQr0aFyq72oaPQg+vek4
 wzMPJAoMiXoigciHZzYuwyyLGDeRrcSss0MlahqYYTCKfrTpd07wv0OHhe+cGkmqWfVWqMbyGW
 IlPV/7Yf3/QBAwLDpZQAAAA==
To:     Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=920;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=BzBGNFzIsGV0WTqakdf4OEopghd/zw0ZcjsFp1vPeY0=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBkzRKmPoPQxgn2Ah22tj4dcKdsa+y4W5vfKtiw2
 4gPAglBKTKJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZM0SpgAKCRCaEZ6wQi2W
 4R19D/9cQJx6W4yZ76Yv4pAWMZdjZhnIkCSvHLLqQywWLOFoljmbM67XxmWCbdsPGjab9PkRxGC
 JELau3UO6UFw+FTClYJ8HsoIQME5q/h6hPHqhrrbpPXa9x5DRcjuaoAqXFYnaaX6mI71nKnUcOL
 PcBUCNXmNLexBzF6N4QvHBFmFqzxbSvNVgJOThf+WETD/1outLmlgY85GNLYE7v7Be/k4sOUjHi
 /Y42LHjXhV4h+VDcf4LCBh4LvXpvcnXDKS3ybTP9GW8gAaCoXDDx8IzMNA1LIJEQTadKcIsmVKY
 QIxiXR54Jxy3mOhwhk41CcZlfnvZAJ3PxttkO27d41EXk4sHNLdDLxZhGeBdRN1ooRffMmzXrZh
 ++pKnHWzCpx0WF1Ihjd1DPJsSanOUc0ZJd9IbPvO+4maokxDkBwJbIkMqBRm82/VEn9pUzg2aR+
 VqtGC2KEsgwRHIzG3LXy3DSCZKhJvQC7Oc8zl8G5+Tvzh8EIc/9BySFWxyBu6yaaldaaHZqWLda
 aTxo/ohqp5rRkrQg40fMt5GmGCD0gL3+UWlljggf06QDs94Dt7YJjCVeCISb6+zP2Dl77O77p5G
 bArng0AIKoicfMgvAIye5seGHSYuXL4m6HY8+SFV7sxpS1aPf8dOPMx82kEproeddxButqY3sYe
 Yp1mzt4fGc5RyXQ==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an obvious spelling error in the PMIC compatible in the MMP2
Brownstone DTS file.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 arch/arm/boot/dts/marvell/mmp2-brownstone.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/marvell/mmp2-brownstone.dts b/arch/arm/boot/dts/marvell/mmp2-brownstone.dts
index 04f1ae1382e7..bc64348b8218 100644
--- a/arch/arm/boot/dts/marvell/mmp2-brownstone.dts
+++ b/arch/arm/boot/dts/marvell/mmp2-brownstone.dts
@@ -28,7 +28,7 @@ &uart3 {
 &twsi1 {
 	status = "okay";
 	pmic: max8925@3c {
-		compatible = "maxium,max8925";
+		compatible = "maxim,max8925";
 		reg = <0x3c>;
 		interrupts = <1>;
 		interrupt-parent = <&intcmux4>;

---
base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
change-id: 20230804-brownstone-typo-fix-f5b16c47d865

Best regards,
-- 
Duje Mihanović <duje.mihanovic@skole.hr>


