Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365B4777AFB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235837AbjHJOl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbjHJOl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:41:27 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209C7D7;
        Thu, 10 Aug 2023 07:41:26 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPA id E806AFF803;
        Thu, 10 Aug 2023 14:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691678485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IyUXDREdoK5KpDJLjt4F6V+kTmb3e3jKUO9hAJV9buU=;
        b=ZgLU/UZ/OL7yBVxcfBH1xx7n+TJz4FIl8iltYgWqaAbmmkVE/41YRFMp+FPBkYeIu9k6Ez
        oRsKvAJno8tFLB4ykSuflOaLZf0GB+mpatdZHXl8ztIWkQTkjFHj4c87uUiLNodvy0z8Rn
        syEXlTdUw52bxhIDi35AtwEneFHwNGQXjNa7gK9eeVeLcWGrQEWCgZSZyBsY2y+MQdBF4b
        Y65dPOzdskTjPyJ20YrvGCO/OaKBv8mwyGGEdsEmZIDtwJyUvMdlD086bbz8clRd01LA3b
        B4NvKq25S7CLwBGBssD713B9P9fQ1piNf3KVK6lYJd+yQQx7ngV1XOFBt3Ogjw==
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
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add ShenZhen New Display Co.
Date:   Thu, 10 Aug 2023 16:41:14 +0200
Message-Id: <20230810144116.855951-1-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: luca.ceresoli@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ShenZhen New Display Co., Limited is the manufacturer of the
NDS040480800-V3 LCD panel according the datasheet.

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v2: none
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

