Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AD2800F94
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 17:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379494AbjLAPjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379468AbjLAPj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:39:29 -0500
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099751B2;
        Fri,  1 Dec 2023 07:39:36 -0800 (PST)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 2F57B211B3;
        Fri,  1 Dec 2023 16:39:34 +0100 (CET)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Cc:     Joao Paulo Goncalves <joao.goncalves@toradex.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: arm: fsl: add verdin imx8mp mallow board
Date:   Fri,  1 Dec 2023 16:39:28 +0100
Message-Id: <20231201153929.26590-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231201153929.26590-1-francesco@dolcini.it>
References: <20231201153929.26590-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joao Paulo Goncalves <joao.goncalves@toradex.com>

Add Mallow carrier board for wifi and nonwifi variants of Toradex Verdin
IMX8MP SoM. Mallow is a low-cost carrier board in the Verdin family with
a small form factor and build for volume production making it ideal for
industrial and embedded applications.

https://www.toradex.com/products/carrier-board/mallow-carrier-board

Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v2:
 - add Acked-by: Krzysztof
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 32b195852a75..e2e9a443937d 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1100,6 +1100,7 @@ properties:
           - enum:
               - toradex,verdin-imx8mp-nonwifi-dahlia # Verdin iMX8M Plus Module on Dahlia
               - toradex,verdin-imx8mp-nonwifi-dev    # Verdin iMX8M Plus Module on Verdin Development Board
+              - toradex,verdin-imx8mp-nonwifi-mallow # Verdin iMX8M Plus Module on Mallow
               - toradex,verdin-imx8mp-nonwifi-yavia  # Verdin iMX8M Plus Module on Yavia
           - const: toradex,verdin-imx8mp-nonwifi     # Verdin iMX8M Plus Module without Wi-Fi / BT
           - const: toradex,verdin-imx8mp             # Verdin iMX8M Plus Module
@@ -1110,6 +1111,7 @@ properties:
           - enum:
               - toradex,verdin-imx8mp-wifi-dahlia # Verdin iMX8M Plus Wi-Fi / BT Module on Dahlia
               - toradex,verdin-imx8mp-wifi-dev    # Verdin iMX8M Plus Wi-Fi / BT M. on Verdin Development B.
+              - toradex,verdin-imx8mp-wifi-mallow # Verdin iMX8M Plus Wi-Fi / BT Module on Mallow
               - toradex,verdin-imx8mp-wifi-yavia  # Verdin iMX8M Plus Wi-Fi / BT Module on Yavia
           - const: toradex,verdin-imx8mp-wifi     # Verdin iMX8M Plus Wi-Fi / BT Module
           - const: toradex,verdin-imx8mp          # Verdin iMX8M Plus Module
-- 
2.25.1

