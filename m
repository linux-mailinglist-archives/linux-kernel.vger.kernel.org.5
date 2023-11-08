Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3B67E57F8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 14:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344741AbjKHN1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 08:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235508AbjKHN1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 08:27:24 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA3D1BEB;
        Wed,  8 Nov 2023 05:27:21 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD159C0003;
        Wed,  8 Nov 2023 13:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699450038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hy1Mu3fgGqWYCaplIaWzGyfL87iaK86z7WjJbhldhz4=;
        b=i+eZKK+H7BjQ1WWqqbC406UIAzzlP0dxUP8utafEGD2g78OFsHgbk1lCfMUatQOexynjoA
        Mu5FFfDZThzdz1uNZkyaUTmXpn5R4MVMe5/KcSmdv0kHLE959SJE3qKZhSyrGyqM4rBO1I
        UvLjKl1ZGhQPAsq2X6KnzvBjJbQ7VbodPqpOpwl4q1ZVfShLE7ADQ1HUTqGfP0LJYuhlON
        235w3/Y/p0Nut37yzs+R74CovgEI7P04S2xCIhEy5JSLb30TrL75ehiw1dVwfdMClhN2H9
        bJ924Udekq3rMhvgeCLhbvMAG7nmJ75eQ+Gs1GqyPaMpJC2GY7a8mAbE/MhMQg==
From:   Mehdi Djait <mehdi.djait@bootlin.com>
To:     mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, maxime.chevallier@bootlin.com,
        paul.kocialkowski@bootlin.com,
        Mehdi Djait <mehdi.djait@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 1/3] dt-bindings: vendor-prefixes: Add techwell vendor prefix
Date:   Wed,  8 Nov 2023 14:27:12 +0100
Message-ID: <310675901114f45444557d06658100d9b690abd7.1699449537.git.mehdi.djait@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699449537.git.mehdi.djait@bootlin.com>
References: <cover.1699449537.git.mehdi.djait@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: mehdi.djait@bootlin.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add prefix for Techwell, Inc.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 573578db9509..08b74f725142 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1357,6 +1357,8 @@ patternProperties:
     description: Technologic Systems
   "^techstar,.*":
     description: Shenzhen Techstar Electronics Co., Ltd.
+  "^techwell,.*":
+    description: Techwell, Inc.
   "^teejet,.*":
     description: TeeJet
   "^teltonika,.*":
-- 
2.41.0

