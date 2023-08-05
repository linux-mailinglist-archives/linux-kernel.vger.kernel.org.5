Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0710A770DC9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 06:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjHEEua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 00:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjHEEuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 00:50:21 -0400
Received: from mail.croughan.sh (mail.croughan.sh [IPv6:2a01:4f9:c011:cb0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129E04EDD;
        Fri,  4 Aug 2023 21:50:17 -0700 (PDT)
From:   Matthew Croughan <matthew.croughan@nix.how>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nix.how; s=mail;
        t=1691211015; bh=6dOEaEfP16oOvitY+UvPtUksmf4TSAu0+nGebF85QnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ZanlooQ+ww290ogJo0KT7s4omEY+KwsastcmeeVZ+Xc39uZajOj0HYBpSk1zCMdBr
         hXidERssyTwb6M+VSa5D8hskdjeK8P+gwWZda3EzhbxhpzlzUrJJqS1DIs8U6X4OFG
         vX7I11URJWYR+eg8G7EliDr5LXucXu87QKx6bZAA=
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
Subject: [PATCH v5 1/2] dt-bindings: arm: sunxi: add Mango Pi MQ-Quad binding
Date:   Sat,  5 Aug 2023 05:42:38 +0100
Message-ID: <20230805044558.279473-3-matthew.croughan@nix.how>
In-Reply-To: <20230805044558.279473-2-matthew.croughan@nix.how>
References: <20230805044558.279473-2-matthew.croughan@nix.how>
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

