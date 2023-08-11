Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908C07799D0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 23:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbjHKVoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 17:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236047AbjHKVoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 17:44:19 -0400
Received: from out-116.mta0.migadu.com (out-116.mta0.migadu.com [91.218.175.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4DA2D57
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 14:44:17 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh; s=key1;
        t=1691789873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Xtt4yqpLsvUfjFz6kVuks/8AR6l3ZDCWG+KIcvWG2I=;
        b=i/oTtwxkpLtHxogS2A5CCLtHU1GBowWr8i4J+bbOTcyMuJzDDEpbbMEJAjmklAWblWDibZ
        AHvnwNtCTwyepS26mHR0udBiAsBFxaqk86lU1+vaSKsoZv1KQhGa/EOB9zhFRUaMQrYSrO
        FB8wPI8QQa6TIUDF+N9E6ky94SiC1xk=
From:   Rayyan Ansari <rayyan@ansari.sh>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Rayyan Ansari <rayyan@ansari.sh>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 1/7] dt-bindings: arm: qcom: Document MSM8x26-based Lumia phones
Date:   Fri, 11 Aug 2023 22:35:18 +0100
Message-ID: <20230811213728.23726-2-rayyan@ansari.sh>
In-Reply-To: <20230811213728.23726-1-rayyan@ansari.sh>
References: <20230811213728.23726-1-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document MSM8226 and MSM8926 Lumias.

Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 450f616774e0..ea4b1c530461 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -181,9 +181,18 @@ properties:
 
       - items:
           - enum:
+              - microsoft,dempsey
+              - microsoft,makepeace
+              - microsoft,moneypenny
               - samsung,s3ve3g
           - const: qcom,msm8226
 
+      - items:
+          - enum:
+              - microsoft,superman-lte
+              - microsoft,tesla
+          - const: qcom,msm8926
+
       - items:
           - enum:
               - sony,kanuti-tulip
-- 
2.41.0

