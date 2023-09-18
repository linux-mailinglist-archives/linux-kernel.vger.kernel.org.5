Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA7E7A43DB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 10:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240611AbjIRIEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 04:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240675AbjIRIA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:00:57 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B2BCFB;
        Mon, 18 Sep 2023 00:59:30 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7888E20003;
        Mon, 18 Sep 2023 07:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1695023968;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=A60OSmANdEj1qdlQAPPS0Wy4M2HCzCwvUt3i18ClpfU=;
        b=WoNKxA2JwenWUdbj4rcD0ooJY/T0jemtRMr1pLi0jbUxp0obE6v/QGaZ25JniMN8dnv4Bm
        yKcjINMmqKJ0R9bR9UmSie4I1NGz/xvHmzSlvuNVkceS5+O5SlgPkVybsiYVI55mc58NTF
        A8Td2/fNDiMsSUDfbpDoJ9YHNvXrL6AQGw5JcTuVZ29A/cu+djArUiUBi5I3GRRyX4kBIH
        VlvaJb1k4aZxm7fOEDAoix1KashvQGL+qDZuaH+KaXN+4TAxtK6oJqIrY+7Bmy9lt/wNm8
        q8AKShrI4Za+QHqbX5sHPuQitldi3hXGADn/9e5XS7nTvv2jI2SYcmJtb13sVg==
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] mips: dts: ralink: mt7621: rename to GnuBee GB-PC1 and GnuBee GB-PC2
Date:   Mon, 18 Sep 2023 10:59:15 +0300
Message-Id: <20230918075915.87029-1-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename GB-PC1 to GnuBee GB-PC1, and GB-PC2 to GnuBee GB-PC2 to include
brand and model name.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts | 2 +-
 arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts b/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts
index 129b6710b699..f9c262cc2e96 100644
--- a/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts
+++ b/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts
@@ -8,7 +8,7 @@
 
 / {
 	compatible = "gnubee,gb-pc1", "mediatek,mt7621-soc";
-	model = "GB-PC1";
+	model = "GnuBee GB-PC1";
 
 	memory@0 {
 		device_type = "memory";
diff --git a/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts b/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts
index f810cd10f4f4..b281e13f22ed 100644
--- a/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts
+++ b/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts
@@ -8,7 +8,7 @@
 
 / {
 	compatible = "gnubee,gb-pc2", "mediatek,mt7621-soc";
-	model = "GB-PC2";
+	model = "GnuBee GB-PC2";
 
 	memory@0 {
 		device_type = "memory";
-- 
2.39.2

