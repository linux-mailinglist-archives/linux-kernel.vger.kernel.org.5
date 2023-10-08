Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E997BCE70
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 15:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344787AbjJHNGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 09:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344772AbjJHNGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 09:06:12 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAB6B9
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 06:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1696770368; bh=SGueJWzRUgwjjh8gQok9lNmS9RZL18PVUdYVO6wswxM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Vl/UOEyQifLbMzsnIH/o3Z1kNXYmYAFI3U2C/EsSJuQw4AI3Liq5r4meui1nAJjzf
         /8FqZzIDVgsQMf+yb4SmCEymsNLDY64FI3KMgvodwOOrXQ3zLVcRSJVI+HCdiIPetv
         bqT2bBngbwCTcodtYrI9d58zzTWbAwnfZPNqeR8k=
From:   =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Ondrej Jirman <megi@xff.cz>, Jagan Teki <jagan@edgeble.ai>,
        Jonas Karlman <jonas@kwiboo.se>,
        Chris Morgan <macromorgan@hotmail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] dt-bindings: arm: rockchip: Add Orange Pi 5 Plus
Date:   Sun,  8 Oct 2023 15:05:01 +0200
Message-ID: <20231008130515.1155664-4-megi@xff.cz>
In-Reply-To: <20231008130515.1155664-1-megi@xff.cz>
References: <20231008130515.1155664-1-megi@xff.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megi@xff.cz>

Add devicetree binding documentation for Orange Pi 5 Plus SBC made by
Xunlong.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index ca5389862887..1a636ad540ce 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -870,6 +870,11 @@ properties:
           - const: tronsmart,orion-r68-meta
           - const: rockchip,rk3368
 
+      - description: Xunlong Orange Pi 5 Plus
+        items:
+          - const: xunlong,orangepi-5-plus
+          - const: rockchip,rk3588
+
       - description: Xunlong Orange Pi R1 Plus / LTS
         items:
           - enum:
-- 
2.42.0

