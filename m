Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64037B84B4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243274AbjJDQM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243307AbjJDQLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:11:23 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1637D8;
        Wed,  4 Oct 2023 09:11:05 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0EBC760003;
        Wed,  4 Oct 2023 16:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696435864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wm36JSbVAUDkIx4csCo50tikiTYXJs3lG/TF9U0LJXc=;
        b=iFXBm38Jh0IUmcvxAckQnqBQLw/pn4Dw6yFwqjXM7p0VVng+QOlZjzNSmhjlhVEzgNDAdE
        Y734+xn/XEC9xqU/1VDZB9+Fiec2TwfKY0AmkZzlgh8IWKqg8SwxnADWkDRWvYFCqhRa4A
        zO+rs+X5aP6y8d7MhqIMAbBT/7MFf+BYnAzEs9nkXD4+DITcwKHH0bp8bZqfWHUzUt7NIW
        +uI7tV4VhtJnQKrW9qLwiVx6J/SZ+FMxtJRKfEes+7VYJubYj5ACtevlfD9p2u64F/BRRm
        tlzYpwqajKLGd58v/aX2VqwSFqh3LcPSFlABq+yON6qTNIHYFJ4FixkYZux+UQ==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH 11/11] MAINTAINERS: Add entry for Mobileye MIPS SoCs
Date:   Wed,  4 Oct 2023 18:10:38 +0200
Message-Id: <20231004161038.2818327-12-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004161038.2818327-1-gregory.clement@bootlin.com>
References: <20231004161038.2818327-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: gregory.clement@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Vlad, Théo and myself as co-maintainers for the Mobileye MIPS
SoCs.

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 90f13281d297..6aedeab5f07c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14423,6 +14423,18 @@ W:	http://palosaari.fi/linux/
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 F:	drivers/media/dvb-frontends/mn88473*
 
+MOBILEYE MIPS SOCS
+M:	Vladimir Kondratiev <vladimir.kondratiev@intel.com>
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
2.40.1

