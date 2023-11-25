Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7E37F8A83
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 13:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjKYMGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 07:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjKYMGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 07:06:20 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B5519BD;
        Sat, 25 Nov 2023 04:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1700913954; bh=RAZ74Knzjdmb2BEEYQF0t/FZOb3VEv5E7RbVxw1ZbJY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=KwldGkRALilZUKj875SHMm/dFy6/JZdTLQszdVT1BDpM/PviYDNl3awaXd51x3HPr
         WzZPz3nenSkddmTg8wCvhmMPrqGzFChDEQ4h20ThRBzgCeaZqc+WJ545Sg0mbpxgoE
         TzbyRE71cusC0U6bgpsI6quUzPMb3nhusy2XiqgY=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Sat, 25 Nov 2023 13:05:34 +0100
Subject: [PATCH v3 2/3] dt-bindings: arm: qcom: Add HTC One Mini 2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231125-htc-memul-v3-2-e8f4c5839e23@z3ntu.xyz>
References: <20231125-htc-memul-v3-0-e8f4c5839e23@z3ntu.xyz>
In-Reply-To: <20231125-htc-memul-v3-0-e8f4c5839e23@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=768; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=RAZ74Knzjdmb2BEEYQF0t/FZOb3VEv5E7RbVxw1ZbJY=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlYeMeInpiHC6IX1Jiu/Qli+uWruxnoyq/ixb06
 jVlZGHIzjuJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZWHjHgAKCRBy2EO4nU3X
 VnZ+D/0drQsDA7qS79urMBWG7sPQgQDtpkuzbv5TTKlueDh7E735FEhJuZ34fDSDsMXU/bGcLlR
 Gu3WnPiMgLrMq67+et3SQQWYyPfnwEvXc3s2ZrK8PgZIRZ9R6LoPZxggxlDQS6WIvxxZCbIY11n
 gDKfRGPPeqivIMKmHve6+qW5F1mmwyMwYUkHewHFAhWn+57nWPiTUoiua+zJNHl3u6TKpcGEi7v
 gHnmu/w+NCHpKCs4uBhUAzhtRsqf49VLOWExNvbV4bP8/u0wZGpC7JEYSNui+QwgCFOXanFzzW6
 yUR1xEh6txMhvlUt4M/6ocVDSfGlQ2qf454s9KTMcKHTjKdxUAtG2pVI8t2M1hH3NvAS2Taw+mI
 zCGiRKlZQ2LCx3FthfK6oSxsA1TNQAq8BJyR6YeF0Y9s/BXfNMHQqpRwOEGbsxa4Q23ZKjylTfg
 1+pG9lx8MC8Asx0zb1ChVKK7FlmPE9lshpr0vhVrVgwLk0EAm4JBGAZP/tayj5lXiA+8CzNiel1
 vYYdtEZR3nEpYuVHSnMPFMnaS5ik6fCcAoiwPUPcTbdKj2kKbztt3eOCkCUrZ8u/Nzr0Ov7SEJ9
 A+gLAjwWnFtSyl+vJCaqHzmVrEG9LUp2kAn2/XOE+QKCPNMnUsP4PgFZC+A88Xu+sm8TK4MafR1
 RXe6Kh0LVH711+w==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible for the MSM8926-based HTC One Mini 2 smartphone.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 88b84035e7b1..60605f2d237b 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -194,6 +194,7 @@ properties:
 
       - items:
           - enum:
+              - htc,memul
               - microsoft,superman-lte
               - microsoft,tesla
           - const: qcom,msm8926

-- 
2.43.0

