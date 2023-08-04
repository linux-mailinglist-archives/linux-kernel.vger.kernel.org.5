Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3457706C5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjHDRJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbjHDRJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:09:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDD0E4EC4;
        Fri,  4 Aug 2023 10:09:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4131E12FC;
        Fri,  4 Aug 2023 10:09:53 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F31F83F5A1;
        Fri,  4 Aug 2023 10:09:08 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Icenowy Zheng <uwu@icenowy.me>,
        Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: arm: sunxi: document Orange Pi Zero 3 board name
Date:   Fri,  4 Aug 2023 18:08:55 +0100
Message-Id: <20230804170856.1237202-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230804170856.1237202-1-andre.przywara@arm.com>
References: <20230804170856.1237202-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Orange Pi Zero 3 board is an updated version of the Zero 2 board.
It uses a SoC called H618, which just seems to be an H616 with more L2
cache.

Add the board/SoC compatible string pair to the list of known boards.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index ee8fdd2da869a..58f322b9585f2 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -997,4 +997,9 @@ properties:
           - const: xunlong,orangepi-zero2
           - const: allwinner,sun50i-h616
 
+      - description: Xunlong OrangePi Zero 3
+        items:
+          - const: xunlong,orangepi-zero3
+          - const: allwinner,sun50i-h618
+
 additionalProperties: true
-- 
2.25.1

