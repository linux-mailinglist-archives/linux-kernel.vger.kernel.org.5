Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9FF7CACE2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjJPPFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjJPPFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:05:17 -0400
X-Greylist: delayed 562 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 16 Oct 2023 08:05:14 PDT
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 88AB1EE;
        Mon, 16 Oct 2023 08:05:14 -0700 (PDT)
Received: from mail.dh-electronics.com (unknown [77.24.89.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.securetransport.de (Postfix) with ESMTPSA id D24DA5E8E7;
        Mon, 16 Oct 2023 16:55:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1697468113;
        bh=Tf8nOfbtKfWYOFbWdHje3ndT0ZLjeTdxnZ+BtAhUWc0=;
        h=From:To:CC:Subject:Date:From;
        b=O+DXTNnJ5AoZBgALEOYFpU4aV5+Lvb3LAkMJLL0Iov0Zdi6fjmIJ8ugd8iZUbUhTI
         pMYCqXU+7+AHYCexwp5uxV1ATCoO/l8XRC9qa2GefcA67kJWwoQfuLG64h34N7Fv6W
         w0ybVCj0Z9PAnrGwsVpS+HhHRhqbyNRLDqlLMhzQYBf8SAcJJEqLh/h0xXDiapXHTk
         uDEfKT5EjpWUxLec6nvOeurF49x1XT5UV/wH/jaTwxeXaS7ACKABk0TFMUhskzRJxq
         ZMAnFqtuyzOZcv2fBf20jvmXRdjXH9+EVaEL1YOl/4eAOsMaK82k1F4ArMoPlPWmoJ
         CnFI0TNflwvlA==
Received: from DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27; Mon, 16 Oct 2023 16:55:08 +0200
Received: from localhost.localdomain (172.16.51.3) by
 DHPWEX01.DH-ELECTRONICS.ORG (10.64.2.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.27 via Frontend Transport; Mon, 16 Oct 2023 16:55:07 +0200
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
To:     <inux-arm-kernel@lists.infradead.org>
CC:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>,
        "Fabio Estevam" <festevam@denx.de>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V5] dt-bindings: Add Marantec vendor prefix
Date:   Mon, 16 Oct 2023 16:52:58 +0200
Message-ID: <20231016145258.2877-1-cniedermaier@dh-electronics.com>
X-Mailer: git-send-email 2.11.0
X-klartext: yes
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Marantec electronics GmbH.

Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@denx.de>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
---
V2: - Add this patch to the series
V3: - Add Acked-by tag
V4: - No changes
V5: - Rebase on current next 20231016
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 7ff33cf10fcc..e91787ded3fb 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -819,6 +819,8 @@ patternProperties:
     description: Mantix Display Technology Co.,Ltd.
   "^mapleboard,.*":
     description: Mapleboard.org
+  "^marantec,.*":
+    description: Marantec electronics GmbH
   "^marvell,.*":
     description: Marvell Technology Group Ltd.
   "^maxbotix,.*":
-- 
2.11.0

