Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF52C800A9B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 13:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378770AbjLAMPZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 1 Dec 2023 07:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378803AbjLAMPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 07:15:18 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7CE1721;
        Fri,  1 Dec 2023 04:15:24 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id DEB9024E2A8;
        Fri,  1 Dec 2023 20:15:22 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 1 Dec
 2023 20:15:22 +0800
Received: from jsia-virtual-machine.localdomain (60.54.3.230) by
 EXMBX066.cuchost.com (172.16.6.66) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Fri, 1 Dec 2023 20:15:10 +0800
From:   Sia Jee Heng <jeeheng.sia@starfivetech.com>
To:     <kernel@esmil.dk>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <krzk@kernel.org>,
        <conor+dt@kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <conor@kernel.org>, <anup@brainfault.org>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <michal.simek@amd.com>, <michael.zhu@starfivetech.com>,
        <drew@beagleboard.org>
CC:     <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <jeeheng.sia@starfivetech.com>,
        <leyfoon.tan@starfivetech.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 4/6] dt-bindings: interrupt-controller: Add StarFive JH8100 plic
Date:   Fri, 1 Dec 2023 20:14:08 +0800
Message-ID: <20231201121410.95298-5-jeeheng.sia@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201121410.95298-1-jeeheng.sia@starfivetech.com>
References: <20231201121410.95298-1-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [60.54.3.230]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for StarFive JH8100 plic.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 0c07e8dda445..8f5c6044cef7 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -61,6 +61,7 @@ properties:
               - sifive,fu540-c000-plic
               - starfive,jh7100-plic
               - starfive,jh7110-plic
+              - starfive,jh8100-plic
           - const: sifive,plic-1.0.0
       - items:
           - enum:
-- 
2.34.1

