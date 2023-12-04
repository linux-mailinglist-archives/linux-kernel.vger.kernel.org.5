Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4E28035EE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbjLDOFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344938AbjLDOFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:05:19 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298ACDF;
        Mon,  4 Dec 2023 06:05:23 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B686E1C0005;
        Mon,  4 Dec 2023 14:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701698722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PyU0MrPkAquO0yDvZ3LG19USjtRAx9Zi0FGDGYHw/pQ=;
        b=k6Bd1xjE7Ah6SkBfCIkOh9UQCOaph+ZnUsgd6y0a61ouCRM1z6pZcqD2/X5BNcJP572pxa
        eRNzILLQL6zf4jKi/E4DCewHH2kcBvaVqmwAKEa7EuE8qtXgwu5W6kgeh13tmO08HnkH5O
        PEA+zaGeACBBUiDDWXRcA4cj+0crk67f9JGMEn/jpnBr6Ckizh/BOHoWD/G2jlYM//2l7+
        69BLxnEJxhsFD8LSLGwOXz5HCqDJRCYFOTuy+PSlK6k31cXrbNIgYPELVMz+1HX4qkPXZ5
        mdwqeFVle8sZ1QngZF30MfETxh3zCoq/z6Baq4Hsg5uqCl1xCxMaXWnLzwLM7w==
From:   Kamel Bouhara <kamel.bouhara@bootlin.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        Jeff LaBundy <jeff@labundy.com>
Cc:     catalin.popescu@leica-geosystems.com,
        mark.satterthwaite@touchnetix.com, bartp@baasheep.co.uk,
        hannah.rossiter@touchnetix.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        bsp-development.geo@leica-geosystems.com,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/3] dt-bindings: vendor-prefixes: Add TouchNetix AS
Date:   Mon,  4 Dec 2023 15:05:02 +0100
Message-ID: <20231204140505.2838916-2-kamel.bouhara@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204140505.2838916-1-kamel.bouhara@bootlin.com>
References: <20231204140505.2838916-1-kamel.bouhara@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kamel.bouhara@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for TouchNetix AS (https://www.touchnetix.com/products/).

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 573578db9509..78581001a79c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1400,6 +1400,8 @@ patternProperties:
     description: Toradex AG
   "^toshiba,.*":
     description: Toshiba Corporation
+  "^touchnetix,.*":
+    description: TouchNetix AS
   "^toumaz,.*":
     description: Toumaz
   "^tpk,.*":
-- 
2.25.1

