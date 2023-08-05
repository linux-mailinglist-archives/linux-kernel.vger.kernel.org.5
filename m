Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B25771307
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 01:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjHEXiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 19:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjHEXiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 19:38:17 -0400
Received: from mail.croughan.sh (mail.croughan.sh [IPv6:2a01:4f9:c011:cb0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322562120;
        Sat,  5 Aug 2023 16:38:15 -0700 (PDT)
From:   Matthew Croughan <matthew.croughan@nix.how>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nix.how; s=mail;
        t=1691278693; bh=2DZlbwxyrwSkLVnCD2OL6/PMldNs7f5UNXEqVfXqL9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Jei7ru5cIC4KLZ2F4SLtJA7heuAZ8vIQ2IKn+APPfjCPioB7LOnin8nERbGBJlbZl
         qoLaSMWncxCBOykY1I6szZs1/LAjT2uc3koYohSIAAgGuO483d4/izqoMHXH9O2PQN
         Zh7fIusMRhLonHzKLo7uu7xfCyeRT9Evnl/JZTX0=
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Matthew Croughan <matthew.croughan@nix.how>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] dt-bindings: arm: sunxi: add Mango Pi MQ-Quad binding
Date:   Sun,  6 Aug 2023 00:34:55 +0100
Message-ID: <20230805233715.1216456-2-matthew.croughan@nix.how>
In-Reply-To: <20230805233715.1216456-1-matthew.croughan@nix.how>
References: <20230805233715.1216456-1-matthew.croughan@nix.how>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document board compatible names for Mango Pi MQ-Quad

Signed-off-by: Matthew Croughan <matthew.croughan@nix.how>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

