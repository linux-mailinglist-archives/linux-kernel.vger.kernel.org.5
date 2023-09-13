Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B2A79E1A2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236567AbjIMIK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238782AbjIMIKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:10:14 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9A51BDB;
        Wed, 13 Sep 2023 01:09:56 -0700 (PDT)
Received: from rd02-sz.amlogic.software (10.28.11.83) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Wed, 13 Sep 2023
 16:09:46 +0800
From:   Huqiang Qin <huqiang.qin@amlogic.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <hkallweit1@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        Huqiang Qin <huqiang.qin@amlogic.com>
Subject: [PATCH 1/3] dt-bindings: interrupt-controller: Add support for Amlogic-T7 SoCs
Date:   Wed, 13 Sep 2023 16:09:22 +0800
Message-ID: <20230913080924.3336391-2-huqiang.qin@amlogic.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230913080924.3336391-1-huqiang.qin@amlogic.com>
References: <20230913080924.3336391-1-huqiang.qin@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.11.83]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update dt-binding document for GPIO interrupt controller
of Amlogic-T7 SoCs.

Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
---
 .../bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
index 3d06db98e978..a93744763787 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/amlogic,meson-gpio-intc.yaml
@@ -36,6 +36,7 @@ properties:
               - amlogic,meson-a1-gpio-intc
               - amlogic,meson-s4-gpio-intc
               - amlogic,c3-gpio-intc
+              - amlogic,t7-gpio-intc
           - const: amlogic,meson-gpio-intc
 
   reg:
-- 
2.37.1

