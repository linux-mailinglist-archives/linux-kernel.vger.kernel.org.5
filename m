Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDA07FF8EF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 18:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346674AbjK3R6e convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Nov 2023 12:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjK3R6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 12:58:32 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B232103;
        Thu, 30 Nov 2023 09:58:34 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 59AD38008;
        Fri,  1 Dec 2023 01:58:26 +0800 (CST)
Received: from EXMBX063.cuchost.com (172.16.7.63) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 1 Dec
 2023 01:58:26 +0800
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX063.cuchost.com
 (172.16.6.63) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 1 Dec
 2023 01:58:25 +0800
Received: from EXMBX061.cuchost.com ([fe80::413f:35c8:bf4f:599a]) by
 EXMBX061.cuchost.com ([fe80::413f:35c8:bf4f:599a%14]) with mapi id
 15.00.1497.044; Fri, 1 Dec 2023 01:58:25 +0800
From:   Leyfoon Tan <leyfoon.tan@starfivetech.com>
To:     JeeHeng Sia <jeeheng.sia@starfivetech.com>,
        "kernel@esmil.dk" <kernel@esmil.dk>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "conor@kernel.org" <conor@kernel.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        "drew@beagleboard.org" <drew@beagleboard.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 6/6] riscv: dts: starfive: Add initial StarFive JH8100
 device tree
Thread-Topic: [PATCH v2 6/6] riscv: dts: starfive: Add initial StarFive JH8100
 device tree
Thread-Index: AQHaIomdVH7y9/ivgUi9tWc7QoZ0WLCTJ8TA
Date:   Thu, 30 Nov 2023 17:58:25 +0000
Message-ID: <21e2d194efee4bb6b870735e6fe2d65c@EXMBX061.cuchost.com>
References: <20231129060043.368874-1-jeeheng.sia@starfivetech.com>
 <20231129060043.368874-7-jeeheng.sia@starfivetech.com>
In-Reply-To: <20231129060043.368874-7-jeeheng.sia@starfivetech.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.16.6.8]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: JeeHeng Sia <jeeheng.sia@starfivetech.com> 
Sent: Wednesday, November 29, 2023 2:01 PM
To: kernel@esmil.dk; robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; krzk@kernel.org; conor+dt@kernel.org; paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu; daniel.lezcano@linaro.org; tglx@linutronix.de; conor@kernel.org; anup@brainfault.org; gregkh@linuxfoundation.org; jirislaby@kernel.org; michal.simek@amd.com; Michael Zhu <michael.zhu@starfivetech.com>; drew@beagleboard.org
Cc: devicetree@vger.kernel.org; linux-riscv@lists.infradead.org; linux-kernel@vger.kernel.org; JeeHeng Sia <jeeheng.sia@starfivetech.com>; Leyfoon Tan <leyfoon.tan@starfivetech.com>
Subject: [PATCH v2 6/6] riscv: dts: starfive: Add initial StarFive JH8100 device tree

Add initial device tree for the StarFive JH8100 RISC-V SoC.

Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
---
 arch/riscv/boot/dts/starfive/Makefile       |   1 +
 arch/riscv/boot/dts/starfive/jh8100-evb.dts |  28 ++
 arch/riscv/boot/dts/starfive/jh8100.dtsi    | 378 ++++++++++++++++++++
 3 files changed, 407 insertions(+)
 create mode 100644 arch/riscv/boot/dts/starfive/jh8100-evb.dts
 create mode 100644 arch/riscv/boot/dts/starfive/jh8100.dtsi

diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
index 0141504c0f5c..fbb0dc619102 100644
--- a/arch/riscv/boot/dts/starfive/Makefile
+++ b/arch/riscv/boot/dts/starfive/Makefile
@@ -10,3 +10,4 @@ dtb-$(CONFIG_ARCH_STARFIVE) += jh7100-starfive-visionfive-v1.dtb
 
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.2a.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.3b.dtb
+dtb-$(CONFIG_ARCH_STARFIVE) += jh8100-evb.dtb
Add empty line before this.

[....]

Regards
Ley Foon
