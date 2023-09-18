Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6047A435D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240440AbjIRHqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240368AbjIRHqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:46:00 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33731BE6;
        Mon, 18 Sep 2023 00:43:18 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 90B2624000D;
        Mon, 18 Sep 2023 07:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1695022997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4o9b0EdEagI/FVxfPGBCEgC2OjH+6DvLWQZYPHDD6DU=;
        b=UXqvSR9xSpiieP1etH1Vyl2cSN/ENa0irafGLBjjr8QSsr1PCkGhBMiU19eEQsmi7wjGlS
        JSrBrFRbzCmWrMaDy4xQTUlu3HRYtpwxStzFt5QMYzy3Cgk0jsthfGcxsfEH6kbXCzkKED
        DLtadljofsB8byIw7Ckm3wr8e5HSVSGZ/g0mvnqawmsXO/qGOFhQldKwQ++yAVsA/1PNBU
        Na8JGAVAQ15ySbgTuWyDPqv0M2tNjtlXkCPaWgo5VM73rw/MFxpy0ga/jXzOUo0LNoBXDR
        6SkQ5Esi68A82g2pQCH0pgdUVgS/Mjq5M8oBEZqc0iK2R9w5e1foPk6merh1GQ==
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        David Heidelberg <david@ixit.cz>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Alex Riabchenko <d3adme4t@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH] arm64: dts: replace Bananapi with Banana Pi
Date:   Mon, 18 Sep 2023 10:43:01 +0300
Message-Id: <20230918074301.74528-1-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The brand name is Banana Pi. Replace any mention of Bananapi with Banana
Pi.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts | 2 +-
 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts | 2 +-
 arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
index f2cc95d4a343..6b4e39c600af 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
@@ -14,7 +14,7 @@
 #include "mt6380.dtsi"
 
 / {
-	model = "Bananapi BPI-R64";
+	model = "Banana Pi BPI-R64";
 	chassis-type = "embedded";
 	compatible = "bananapi,bpi-r64", "mediatek,mt7622";
 
diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
index af4a4309bda4..d739eb0c7e56 100644
--- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
@@ -15,7 +15,7 @@
 #include "mt7986a.dtsi"
 
 / {
-	model = "Bananapi BPI-R3";
+	model = "Banana Pi BPI-R3";
 	chassis-type = "embedded";
 	compatible = "bananapi,bpi-r3", "mediatek,mt7986a";
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
index f9127ddfbb7d..a74db03a8698 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
@@ -12,7 +12,7 @@
 #include "rk3568.dtsi"
 
 / {
-	model = "Bananapi-R2 Pro (RK3568) DDR4 Board";
+	model = "Banana Pi BPI-R2 Pro (RK3568) DDR4 Board";
 	compatible = "rockchip,rk3568-bpi-r2pro", "rockchip,rk3568";
 
 	aliases {
-- 
2.39.2

