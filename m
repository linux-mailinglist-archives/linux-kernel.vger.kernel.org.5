Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E774768984
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 03:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjGaBSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 21:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjGaBS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 21:18:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA99E1A2;
        Sun, 30 Jul 2023 18:18:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D634E1691;
        Sun, 30 Jul 2023 18:19:08 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C714D3F5A1;
        Sun, 30 Jul 2023 18:18:23 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Icenowy Zheng <uwu@icenowy.me>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: arm: sunxi: document Orange Pi Zero 3 board name
Date:   Mon, 31 Jul 2023 02:17:24 +0100
Message-Id: <20230731011725.7228-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20230731011725.7228-1-andre.przywara@arm.com>
References: <20230731011725.7228-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
2.35.8

