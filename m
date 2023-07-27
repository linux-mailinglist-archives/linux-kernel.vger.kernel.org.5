Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E50C7658B0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbjG0QaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbjG0QaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:30:17 -0400
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0190D198A;
        Thu, 27 Jul 2023 09:30:16 -0700 (PDT)
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 538C68390B;
        Thu, 27 Jul 2023 18:30:15 +0200 (CEST)
From:   =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
To:     =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afaerber@suse.com
Subject: [PATCH v2 6/9] dt-bindings: marvell: Document PXA1908 SoC
Date:   Thu, 27 Jul 2023 18:29:04 +0200
Message-ID: <20230727162909.6031-7-duje.mihanovic@skole.hr>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727162909.6031-1-duje.mihanovic@skole.hr>
References: <20230727162909.6031-1-duje.mihanovic@skole.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt bindings and documentation for Marvell PXA1908 SoC.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 .../bindings/arm/marvell/marvell,pxa1908.yaml | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/marvell,pxa1908.yaml

diff --git a/Documentation/devicetree/bindings/arm/marvell/marvell,pxa1908.yaml b/Documentation/devicetree/bindings/arm/marvell/marvell,pxa1908.yaml
new file mode 100644
index 000000000000..0cefb3e4c668
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/marvell/marvell,pxa1908.yaml
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/marvell/marvell,pxa1908.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell PXA1908 Platforms
+
+maintainers:
+  - Duje Mihanović <duje.mihanovic@skole.hr>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - samsung,coreprimevelte
+          - const: marvell,pxa1908
+
+additionalProperties: false
-- 
2.41.0


