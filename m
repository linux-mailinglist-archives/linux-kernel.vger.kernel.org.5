Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F9C75BFD6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjGUHfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjGUHf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:35:29 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7436319AD;
        Fri, 21 Jul 2023 00:34:48 -0700 (PDT)
Received: from rd02-sz.amlogic.software (10.28.11.83) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Fri, 21 Jul 2023
 15:34:31 +0800
From:   Huqiang Qin <huqiang.qin@amlogic.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>, <jbrunet@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <linus.walleij@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        Huqiang Qin <huqiang.qin@amlogic.com>
Subject: [PATCH 1/3] dt-bindings: interrupt-controller: Add header file for Amlogic Meson-G12A SoCs
Date:   Fri, 21 Jul 2023 15:32:12 +0800
Message-ID: <20230721073214.1876417-2-huqiang.qin@amlogic.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230721073214.1876417-1-huqiang.qin@amlogic.com>
References: <20230721073214.1876417-1-huqiang.qin@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.11.83]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new dt-binding header that details the interrupt number of the GPIO.

Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
---
 .../irq-meson-g12a-gpio.h                     | 126 ++++++++++++++++++
 1 file changed, 126 insertions(+)
 create mode 100644 include/dt-bindings/interrupt-controller/irq-meson-g12a-gpio.h

diff --git a/include/dt-bindings/interrupt-controller/irq-meson-g12a-gpio.h b/include/dt-bindings/interrupt-controller/irq-meson-g12a-gpio.h
new file mode 100644
index 000000000000..bd415cb7b669
--- /dev/null
+++ b/include/dt-bindings/interrupt-controller/irq-meson-g12a-gpio.h
@@ -0,0 +1,126 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (c) 2023 Amlogic, Inc. All rights reserved.
+ * Author: Huqiang Qin <huqiang.qin@amlogic.com>
+ */
+
+#ifndef _DT_BINDINGS_IRQ_MESON_G12A_GPIO_H
+#define _DT_BINDINGS_IRQ_MESON_G12A_GPIO_H
+
+/* IRQID[11:0] - GPIOAO[11:0] */
+#define IRQID_GPIOAO_0		0
+#define IRQID_GPIOAO_1		1
+#define IRQID_GPIOAO_2		2
+#define IRQID_GPIOAO_3		3
+#define IRQID_GPIOAO_4		4
+#define IRQID_GPIOAO_5		5
+#define IRQID_GPIOAO_6		6
+#define IRQID_GPIOAO_7		7
+#define IRQID_GPIOAO_8		8
+#define IRQID_GPIOAO_9		9
+#define IRQID_GPIOAO_10		10
+#define IRQID_GPIOAO_11		11
+
+/* IRQID[27:12] - GPIOZ[15:0] */
+#define IRQID_GPIOZ_0		12
+#define IRQID_GPIOZ_1		13
+#define IRQID_GPIOZ_2		14
+#define IRQID_GPIOZ_3		15
+#define IRQID_GPIOZ_4		16
+#define IRQID_GPIOZ_5		17
+#define IRQID_GPIOZ_6		18
+#define IRQID_GPIOZ_7		19
+#define IRQID_GPIOZ_8		20
+#define IRQID_GPIOZ_9		21
+#define IRQID_GPIOZ_10		22
+#define IRQID_GPIOZ_11		23
+#define IRQID_GPIOZ_12		24
+#define IRQID_GPIOZ_13		25
+#define IRQID_GPIOZ_14		26
+#define IRQID_GPIOZ_15		27
+
+/* IRQID[36:28] - GPIOH[8:0] */
+#define IRQID_GPIOH_0		28
+#define IRQID_GPIOH_1		29
+#define IRQID_GPIOH_2		30
+#define IRQID_GPIOH_3		31
+#define IRQID_GPIOH_4		32
+#define IRQID_GPIOH_5		33
+#define IRQID_GPIOH_6		34
+#define IRQID_GPIOH_7		35
+#define IRQID_GPIOH_8		36
+
+/* IRQID[52:37] - BOOT[15:0] */
+#define IRQID_BOOT_0		37
+#define IRQID_BOOT_1		38
+#define IRQID_BOOT_2		39
+#define IRQID_BOOT_3		40
+#define IRQID_BOOT_4		41
+#define IRQID_BOOT_5		42
+#define IRQID_BOOT_6		43
+#define IRQID_BOOT_7		44
+#define IRQID_BOOT_8		45
+#define IRQID_BOOT_9		46
+#define IRQID_BOOT_10		47
+#define IRQID_BOOT_11		48
+#define IRQID_BOOT_12		49
+#define IRQID_BOOT_13		50
+#define IRQID_BOOT_14		51
+#define IRQID_BOOT_15		52
+
+/* IRQID[60:53] - GPIOC[7:0] */
+#define IRQID_GPIOC_0		53
+#define IRQID_GPIOC_1		54
+#define IRQID_GPIOC_2		55
+#define IRQID_GPIOC_3		56
+#define IRQID_GPIOC_4		57
+#define IRQID_GPIOC_5		58
+#define IRQID_GPIOC_6		59
+#define IRQID_GPIOC_7		60
+
+/* IRQID[76:61] - GPIOA[15:0] */
+#define IRQID_GPIOA_0		61
+#define IRQID_GPIOA_1		62
+#define IRQID_GPIOA_2		63
+#define IRQID_GPIOA_3		64
+#define IRQID_GPIOA_4		65
+#define IRQID_GPIOA_5		66
+#define IRQID_GPIOA_6		67
+#define IRQID_GPIOA_7		68
+#define IRQID_GPIOA_8		69
+#define IRQID_GPIOA_9		70
+#define IRQID_GPIOA_10		71
+#define IRQID_GPIOA_11		72
+#define IRQID_GPIOA_12		73
+#define IRQID_GPIOA_13		74
+#define IRQID_GPIOA_14		75
+#define IRQID_GPIOA_15		76
+
+/* IRQID[96:77] - GPIOX[19:0] */
+#define IRQID_GPIOX_0		77
+#define IRQID_GPIOX_1		78
+#define IRQID_GPIOX_2		79
+#define IRQID_GPIOX_3		80
+#define IRQID_GPIOX_4		81
+#define IRQID_GPIOX_5		82
+#define IRQID_GPIOX_6		83
+#define IRQID_GPIOX_7		84
+#define IRQID_GPIOX_8		85
+#define IRQID_GPIOX_9		86
+#define IRQID_GPIOX_10		87
+#define IRQID_GPIOX_11		88
+#define IRQID_GPIOX_12		89
+#define IRQID_GPIOX_13		90
+#define IRQID_GPIOX_14		91
+#define IRQID_GPIOX_15		92
+#define IRQID_GPIOX_16		93
+#define IRQID_GPIOX_17		94
+#define IRQID_GPIOX_18		95
+#define IRQID_GPIOX_19		96
+
+/* IRQID[99:97] - GPIOE[2:0] */
+#define IRQID_GPIOE_0		97
+#define IRQID_GPIOE_1		98
+#define IRQID_GPIOE_2		99
+
+#endif /* _DT_BINDINGS_IRQ_MESON_G12A_GPIO_H */
-- 
2.37.1

