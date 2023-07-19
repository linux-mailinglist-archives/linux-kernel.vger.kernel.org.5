Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79066759C5A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjGSR0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjGSR0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:26:50 -0400
Received: from mail.croughan.sh (mail.croughan.sh [135.181.193.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F84310D4;
        Wed, 19 Jul 2023 10:26:49 -0700 (PDT)
From:   Matthew Croughan <matthew.croughan@nix.how>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nix.how; s=mail;
        t=1689787607; bh=Kl1bbgDh4iMm1+vSgagWufSTTMaoLlte7UopHUY/0nM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=MX8/ebo0sAFOkpHnTaKaJsrl1Hs9hsCRS9Ez/WkKSPdt+rUcetHopUr9y1rQIN1CT
         NS0wJ/aVTdzAousrI5gclu9pir/8RB8WjS3/OPp4p6Y2dDwpP+Y+kwGRyrYvbE+JKl
         18fsX9wJqsevGTLwCI+aB7Ce8h6FYf4af9tgE+RU=
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Matthew Croughan <matthew.croughan@nix.how>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/2] dt-bindings: arm: sunxi: add Mango Pi MQ-Quad binding
Date:   Wed, 19 Jul 2023 18:25:40 +0100
Message-ID: <20230719172551.3248166-3-matthew.croughan@nix.how>
In-Reply-To: <20230719172551.3248166-1-matthew.croughan@nix.how>
References: <20230719172551.3248166-1-matthew.croughan@nix.how>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document board compatible names for Mango Pi MQ-Quad

Signed-off-by: Matthew Croughan <matthew.croughan@nix.how>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index ee8fdd2da869..2dee815fd45e 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -862,6 +862,11 @@ properties:
           - const: wexler,tab7200
           - const: allwinner,sun7i-a20
 
+      - description: MangoPi MQ-Quad
+        items:
+          - const: widora,mangopi-mq-quad
+          - const: allwinner,sun50i-h616
+
       - description: MangoPi MQ-R board
         items:
           - const: widora,mangopi-mq-r-t113
-- 
2.41.0

