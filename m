Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39135800DFD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 16:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379309AbjLAPHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 10:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379284AbjLAPHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 10:07:34 -0500
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2105A8;
        Fri,  1 Dec 2023 07:07:40 -0800 (PST)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 0DB9D211B5;
        Fri,  1 Dec 2023 16:07:39 +0100 (CET)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Cc:     Joao Paulo Goncalves <joao.goncalves@toradex.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 1/2] dt-bindings: arm: fsl: add verdin imx8mm mallow board
Date:   Fri,  1 Dec 2023 16:07:32 +0100
Message-Id: <20231201150733.24454-2-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231201150733.24454-1-francesco@dolcini.it>
References: <20231201150733.24454-1-francesco@dolcini.it>
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
IMX8MM SoM. Mallow is a low-cost carrier board in the Verdin family with
a small form factor and build for volume production making it ideal for
industrial and embedded applications.

https://www.toradex.com/products/carrier-board/mallow-carrier-board

Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 32b195852a75..d7f55acff3d7 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -967,6 +967,7 @@ properties:
               - menlo,mx8menlo                       # Verdin iMX8M Mini Module on i.MX8MM Menlo board
               - toradex,verdin-imx8mm-nonwifi-dahlia # Verdin iMX8M Mini Module on Dahlia
               - toradex,verdin-imx8mm-nonwifi-dev    # Verdin iMX8M Mini Module on Verdin Development Board
+              - toradex,verdin-imx8mm-nonwifi-mallow # Verdin iMX8M Mini Module on Mallow
               - toradex,verdin-imx8mm-nonwifi-yavia  # Verdin iMX8M Mini Module on Yavia
           - const: toradex,verdin-imx8mm-nonwifi     # Verdin iMX8M Mini Module without Wi-Fi / BT
           - const: toradex,verdin-imx8mm             # Verdin iMX8M Mini Module
@@ -977,6 +978,7 @@ properties:
           - enum:
               - toradex,verdin-imx8mm-wifi-dahlia # Verdin iMX8M Mini Wi-Fi / BT Module on Dahlia
               - toradex,verdin-imx8mm-wifi-dev    # Verdin iMX8M Mini Wi-Fi / BT M. on Verdin Development B.
+              - toradex,verdin-imx8mm-wifi-mallow # Verdin iMX8M Mini Wi-Fi / BT Module on Mallow
               - toradex,verdin-imx8mm-wifi-yavia  # Verdin iMX8M Mini Wi-Fi / BT Module on Yavia
           - const: toradex,verdin-imx8mm-wifi     # Verdin iMX8M Mini Wi-Fi / BT Module
           - const: toradex,verdin-imx8mm          # Verdin iMX8M Mini Module
-- 
2.25.1

