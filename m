Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E13759973
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjGSPWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjGSPWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:22:03 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88185CC;
        Wed, 19 Jul 2023 08:22:00 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id 537981C000B;
        Wed, 19 Jul 2023 15:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689780119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=z7LeJpkpUdhoFv0e9eqWbQ9CWTKgq+xXZByhqOo66tA=;
        b=bAexir4VCi2pGfTcj5tOmnZu6VIjuODeLgGTSBy2VUTxxTDAf+urTgSkc7PNv121vRpzSy
        AfvLGVlGOWnN4QwnFGha/P8JRiy/hEnqcw6gs5ihCFv20rVYz027F1plsQV79uzNxdZDOR
        dp/QOIMoUXb3FWzJAsJWeT1CP9LchtejpJ58/ZfzOaxLN0a2GQfKuvi7DlL3Ghq7f2cg91
        uFrwE1Hwhuh9tlSpRCAAFilVkDKXbfvUEWlpKskt/Xb+EjZHyTejI0TRsMiSfqmqkM0Ya8
        c4JFZXe6Tze3bC76bwqrcYOoxP+6vVBV5WcoiUSCB6z1puHE3+jjz2FYbFj3Tg==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: add ShenZhen New Display Co.
Date:   Wed, 19 Jul 2023 17:21:45 +0200
Message-Id: <20230719152147.355486-1-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: luca.ceresoli@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ShenZhen New Display Co., Limited is the manufacturer of the
NDS040480800-V3 LCD panel according the datasheet.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index af60bf1a6664..f73d6d4eabbe 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -929,6 +929,8 @@ patternProperties:
     description: Netronix, Inc.
   "^netxeon,.*":
     description: Shenzhen Netxeon Technology CO., LTD
+  "^newdisplay,.*":
+    description: ShenZhen New Display Co., Limited
   "^neweast,.*":
     description: Guangdong Neweast Optoelectronics CO., LTD
   "^newhaven,.*":
-- 
2.34.1

