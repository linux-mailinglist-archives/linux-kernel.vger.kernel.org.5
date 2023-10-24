Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7017D5CC0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 22:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344338AbjJXU6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 16:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbjJXU6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 16:58:08 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C2010D5;
        Tue, 24 Oct 2023 13:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1698181080; bh=Xdweg3kGxC1585nKQgRroNBfyEYqynm2VFZ72xrmPLA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=hYp5izHi4ujX1ztvCr0xZ/BjPFo/fd0EaPo4YAKX0xsezn3z7hBiRGk6hp7KC+aK1
         slRsBBQ3gcjpbJZO6pOoG1HU+ACDp2OnXwIBO+OUmDMa7d87OXpebJUylRCtp2rQC5
         d7w9S1iDvlxDMaQMQQ5RsLK1C14Bmth166P8dFDo=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Tue, 24 Oct 2023 22:57:49 +0200
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: document HTC
 Corporation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231024-htc-memul-v2-1-8912940b6f95@z3ntu.xyz>
References: <20231024-htc-memul-v2-0-8912940b6f95@z3ntu.xyz>
In-Reply-To: <20231024-htc-memul-v2-0-8912940b6f95@z3ntu.xyz>
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
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=852; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=Xdweg3kGxC1585nKQgRroNBfyEYqynm2VFZ72xrmPLA=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBlOC/VcVEOs4MRayqgzipS1p22TAjFNc08+z2CM
 BiPVB1cdbOJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZTgv1QAKCRBy2EO4nU3X
 VmHQEADAvXCyS2uGmETYPzbQyz9wM97cnTm7RdST+Ldi090oIHvJq+wvSGFf0M3dDB5++wAjHFp
 Jd5Ck52K3WRSPGw9IrYbQTKGCf5zNb/XGltKI33i8KigS9v4cO9YMtBMy6F93T5pZS0kwKmyU/q
 VhTLVpjL/DEp+OV7iZCrqUsDRbuqsP9NOvod3n97Bioelphyqj4jR+GL4RlTLB/Ilve8T5qDY04
 +LivQVUXUhnk170XFoP5g9TktDNfaQDfrICZ8aqgd+Lxf7hze7kD6iJg7WRMd7gxWde74V1DoUG
 xHHlc8IsHXga2RgLSupWPV6woDAz7pfw2RyrMTEkI4R5iXJddwMVA2G79uHhecvqlsGE6AlDkgW
 3Ad/YfF2ADzGoyNTXfsJyFN1g+ogVG+JfsJCJHw6Tm47wQ2S+LgxNj87IVjMzfEehOgzGt3jmUi
 RfRmfEUc3ACytKmiUqci8NaFlNSGDfvBY5vp60M7E8BllQ0J0cFFjxP6liOQ07P6Vy7thdm4nb9
 JZqh0goKj7FQnbhrzkn153ChjGyFurtIL1y29hKX/wlPjXT5zqHcuoYt9t6diehlyK+YUb27wEb
 dqIHyWECcqu0BmWho2qJqASMxncfgwwXkQ1WqEFhLYtL/H7lqLOrV76quaD0WTUovdEnHFPrFbj
 dZVajwdbKCDfSsw==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the vendor prefix for HTC (https://www.htc.com/).

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 309b94c328c8..b752f8902367 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -597,6 +597,8 @@ patternProperties:
     description: Hewlett Packard Enterprise
   "^hsg,.*":
     description: HannStar Display Co.
+  "^htc,.*":
+    description: HTC Corporation
   "^huawei,.*":
     description: Huawei Technologies Co., Ltd.
   "^hugsun,.*":

-- 
2.42.0

