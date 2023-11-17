Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF0F7EF582
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 16:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346064AbjKQPmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 10:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjKQPmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 10:42:38 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05357127;
        Fri, 17 Nov 2023 07:42:34 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 19C6D1BF205;
        Fri, 17 Nov 2023 15:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700235753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hy1Mu3fgGqWYCaplIaWzGyfL87iaK86z7WjJbhldhz4=;
        b=QSeTgrgG4WwQHaLGKlBM92b0WXjNYvXTBVdJxQpMJMh58dPdm6LhsrqqfLJnwcsm1SO5gr
        h0fBZcb34sWKL2YyITHE1p7k/sbbHTIAoycJ0pwRwknzTMqFrxq9QTgP7Yt5f2Wr3MDsfC
        WAxYCamYhOrGwcKDIF308elEt7Q8TgAC7BooZuGSqUCO7Owgh28RMrX71T/tJXwl/Tuhub
        9xHsXIFUwVjhuzX8U6K8vf1gKwaJQsk0SbEt2RiAucnAGcuE7ESwcjtbMEG07b0xvrWU58
        0qf0NhEkg6W1eWAY+3USdLsAdq7YsuYUTiIguAqA155hWejV2J6i2UgY5Psnzw==
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
Subject: [PATCH v9 1/3] dt-bindings: vendor-prefixes: Add techwell vendor prefix
Date:   Fri, 17 Nov 2023 16:42:27 +0100
Message-ID: <d1fbec513568e3ca0535cac412e7b7807d28bbab.1700235276.git.mehdi.djait@bootlin.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700235276.git.mehdi.djait@bootlin.com>
References: <cover.1700235276.git.mehdi.djait@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: mehdi.djait@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

