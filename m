Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82707C9B76
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 22:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjJOU0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 16:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjJOU0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 16:26:11 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAFBE3;
        Sun, 15 Oct 2023 13:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1697401566; bh=pdQHKOu9t+/50xiGW2M4xBTmedySUgBgfg2nCpLmelI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=avpSesLluDv8IXS1K2V6/xdqPoVb73E/fHD2zkbf3pu60duvsd7G7I0mdSEdsHIkM
         edBBrV8bB9OuqQB7nDBJxSRggwPa4Svf5pQRWFUOmVBV/9mV4ESoTMpPiMtIyqqUAz
         /J3CB37CKPlyHw7wxgiJZu9nUgZ9nmO7m7fGkR4U=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sun, 15 Oct 2023 22:26:01 +0200
Subject: [PATCH 1/2] arm64: dts: qcom: msm8953: Set initial address for
 memory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231015-msm8953-misc-fixes-v1-1-b800deca9e46@z3ntu.xyz>
References: <20231015-msm8953-misc-fixes-v1-0-b800deca9e46@z3ntu.xyz>
In-Reply-To: <20231015-msm8953-misc-fixes-v1-0-b800deca9e46@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=791; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=pdQHKOu9t+/50xiGW2M4xBTmedySUgBgfg2nCpLmelI=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlLErbT6cFv2lgpENb1CvpAMNGXkA0xOmpL3PwX
 AhKvnHbHheJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZSxK2wAKCRBy2EO4nU3X
 VkDIEACtyr7+cPw/ykT67wSsZ20DIKwyfwXBPisvzvp/cA3NsGRgqpsgTwegVeqgBp/tQ3RqLtl
 2hpjWhtiF4XAIRtl8Zfwc7d0z4QIGg168w147C0KlJbCBaV+T1BQ9tFukp47z8D66AvVkzAHyLu
 lY+xasEAJ6s5Bi63JDAUgDKK3vbEk/89hOYQXp9oXHPmkTOodIKGFjOKeY4XQ6cE6PvITWfEKTV
 9VGSFf8q3QFF4WRJreqF5L3MSPkP1J6HokhAuir6Qt4b/HloqVs2baCqXdX0LgaJ+rVkb5EBblA
 oVmJy+xwgQYXzIOOcU4tC+RaetQtDzalgu1klocs6v4uQBZaVmcbjKXnHIKQuILgGMNspaYMYVO
 MFIZElkRWxC8FKI4KqFzOFxkdd6/8yTcup7dKS1010r6VgkzUqma5ESCyHt9VTLREZxkwjtCRHu
 7XfLj/n1hnFmaCEnTd11xFqp/9W5S8z4KqX3pgIcF8AEUZv7DA5I/5xmJRV4yOSVckpuLhXRVpb
 5iHqoE8er2XClxPHrIUHNmJey8OuUMAkSdyNoOiUfF8baGwjJrdA3sUN3Bcw0mIhT8O4eSvsmkM
 uG0o7DihtZ71Qg3gadbTfSmrYGY8L8CX9CRHW/xGTKXQelKyV03fZ6SCkmWZ32fL7d51bCJGsKm
 OuqqHlsifg0wt6g==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dtbs_check really doesn't like having memory without reg set.
Address this by setting it to 0x10000000 which seems to be the value
filled in by the bootloader.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm64/boot/dts/qcom/msm8953.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index e7de7632669a..a3ba24ca599b 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -174,10 +174,10 @@ scm: scm {
 		};
 	};
 
-	memory {
+	memory@10000000 {
 		device_type = "memory";
 		/* We expect the bootloader to fill in the reg */
-		reg = <0 0 0 0>;
+		reg = <0 0x10000000 0 0>;
 	};
 
 	pmu {

-- 
2.42.0

