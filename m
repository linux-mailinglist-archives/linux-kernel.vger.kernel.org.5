Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB7880F330
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376718AbjLLQgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235115AbjLLQfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:35:40 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620C412A;
        Tue, 12 Dec 2023 08:35:43 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BA11DE000F;
        Tue, 12 Dec 2023 16:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1702398942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SUlSGy+v8U/B/CDpSFqLosOixqHv6uGhrQGTRWI6pDQ=;
        b=oqQEgVe/Dd/JReCgjC5wwGG9MR6+X388hmrdrkSJtD5LOLPOc5QWrlVNeZGEu10wOUCvJj
        IHv6Q72yaX6rSiZu1DiS0azddfC/Nhl3Sz+TckBokeLjRxn++eBD2njei09oPqtRAcZShC
        hSsH9GPohbyzcGr01czNchzc5+2mTclRhB8lqBSC8v/5Wg2Nwj65AM3zdEOeVquSdxFTBx
        c7DYLPUKKY1F1VrnbTdUUszK8bQKiiBxX7GFe2eftPWSEWJPP6KpeDRtndhRdQ004e7+ay
        f/xTU3r+LZ56lkpDPE71awFmjnhMa/p6AAqNohqa8bWa4m0D401njEGGw4S1DA==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v5 22/22] MAINTAINERS: Add entry for Mobileye MIPS SoCs
Date:   Tue, 12 Dec 2023 17:34:54 +0100
Message-ID: <20231212163459.1923041-23-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231212163459.1923041-1-gregory.clement@bootlin.com>
References: <20231212163459.1923041-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Vlad, Théo and myself as co-maintainers for the Mobileye MIPS
SoCs.

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e2c6187a3ac80..4a7bd6b40d740 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14546,6 +14546,18 @@ W:	https://linuxtv.org
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 F:	drivers/media/dvb-frontends/mn88473*
 
+MOBILEYE MIPS SOCS
+M:	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
+M:	Gregory CLEMENT <gregory.clement@bootlin.com>
+M:	Théo Lebrun <theo.lebrun@bootlin.com>
+L:	linux-mips@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mips/mobileye.yaml
+F:	arch/mips/boot/dts/mobileye/
+F:	arch/mips/configs/generic/board-eyeq5.config
+F:	arch/mips/generic/board-epm5.its.S
+F:	include/dt-bindings/soc/mobileye,eyeq5.h
+
 MODULE SUPPORT
 M:	Luis Chamberlain <mcgrof@kernel.org>
 L:	linux-modules@vger.kernel.org
-- 
2.42.0

