Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9CF7F5DD0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 12:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345075AbjKWL2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 06:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345035AbjKWL2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 06:28:31 -0500
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2ED31BD;
        Thu, 23 Nov 2023 03:28:37 -0800 (PST)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id E2B652070A;
        Thu, 23 Nov 2023 12:28:35 +0100 (CET)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Joao Paulo Goncalves <joao.goncalves@toradex.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 2/3] dt-bindings: arm: ti: add verdin am62 mallow board
Date:   Thu, 23 Nov 2023 12:28:25 +0100
Message-Id: <20231123112826.16549-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231123112826.16549-1-francesco@dolcini.it>
References: <20231123112826.16549-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joao Paulo Goncalves <joao.goncalves@toradex.com>

Add Mallow carrier board for wifi and nonwifi variants of Toradex Verdin
AM62 SoM. Mallow is a low-cost carrier board in the Verdin family with
a small form factor and build for volume production making it ideal for
industrial and embedded applications.

https://www.toradex.com/products/carrier-board/mallow-carrier-board

Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 Documentation/devicetree/bindings/arm/ti/k3.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
index 03d2a0d79fb0..c6506bccfe88 100644
--- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
@@ -50,6 +50,7 @@ properties:
           - enum:
               - toradex,verdin-am62-nonwifi-dahlia # Verdin AM62 Module on Dahlia
               - toradex,verdin-am62-nonwifi-dev    # Verdin AM62 Module on Verdin Development Board
+              - toradex,verdin-am62-nonwifi-mallow # Verdin AM62 Module on Mallow
               - toradex,verdin-am62-nonwifi-yavia  # Verdin AM62 Module on Yavia
           - const: toradex,verdin-am62-nonwifi     # Verdin AM62 Module without Wi-Fi / BT
           - const: toradex,verdin-am62             # Verdin AM62 Module
@@ -60,6 +61,7 @@ properties:
           - enum:
               - toradex,verdin-am62-wifi-dahlia # Verdin AM62 Wi-Fi / BT Module on Dahlia
               - toradex,verdin-am62-wifi-dev    # Verdin AM62 Wi-Fi / BT M. on Verdin Development B.
+              - toradex,verdin-am62-wifi-mallow # Verdin AM62 Wi-Fi / BT Module on Mallow
               - toradex,verdin-am62-wifi-yavia  # Verdin AM62 Wi-Fi / BT Module on Yavia
           - const: toradex,verdin-am62-wifi     # Verdin AM62 Wi-Fi / BT Module
           - const: toradex,verdin-am62          # Verdin AM62 Module
-- 
2.25.1

