Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFF97857B1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbjHWMLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbjHWMLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:11:38 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B03410C3;
        Wed, 23 Aug 2023 05:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1692792677; x=1724328677;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OhUqQHZrKM9Y2dmf9u/+1SVT+ON2RLafzM6tN7nyuk4=;
  b=Cl9YOJla/2WsyRtmozbQpm0VQ6sx7Pow6FWuvhJ1C8jgAkamvjSnNH3r
   UTaYm4sg4KHPkNWhRnyOz0RIdVG/CQ2RJw8tE+w+Iwfp95ugC7r62tChO
   /rcI/I4g1yUFAf0jx4x1FdNsljMdJS0aiwWrD+t//9OdcjMYRyNiClX+0
   ZqR1W6wcDgDhdih6uUp/xguT4D19rOr7yC0Eu5yqAQKOUs05MBMB63UkF
   hvpZv9ZnHAleYVN2SWFOkveaUMHraYOUCLCr8L58xZRfluIiIC0AyLeqL
   jXRlHUqGOeRUpQyU5NcWH3nkAs4cGuT25N2Hm7Y9w7hh/TwV5QTp29Pog
   A==;
X-IronPort-AV: E=Sophos;i="6.01,195,1684792800"; 
   d="scan'208";a="32586567"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 23 Aug 2023 14:10:02 +0200
Received: from herburgerg-w2.tq-net.de (herburgerg-w2.tq-net.de [10.122.52.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id A7F3E280084;
        Wed, 23 Aug 2023 14:10:01 +0200 (CEST)
From:   Gregor Herburger <gregor.herburger@ew.tq-group.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com
Subject: [PATCH 6/6] MAINTAINERS: add tqml device trees to TQ-Systems entry
Date:   Wed, 23 Aug 2023 14:09:52 +0200
Message-Id: <20230823120952.317740-7-gregor.herburger@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823120952.317740-1-gregor.herburger@ew.tq-group.com>
References: <20230823120952.317740-1-gregor.herburger@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update file entries for TQ-Systems Layerscape modules.

Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 38ea23fa1b00..c1e9a5415d30 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21788,9 +21788,11 @@ W:	https://www.tq-group.com/en/products/tq-embedded/
 F:	arch/arm/boot/dts/imx*mba*.dts*
 F:	arch/arm/boot/dts/imx*tqma*.dts*
 F:	arch/arm/boot/dts/mba*.dtsi
+F:	arch/arm64/boot/dts/freescale/fsl-*tqml*.dts*
 F:	arch/arm64/boot/dts/freescale/imx*mba*.dts*
 F:	arch/arm64/boot/dts/freescale/imx*tqma*.dts*
 F:	arch/arm64/boot/dts/freescale/mba*.dtsi
+F:	arch/arm64/boot/dts/freescale/tqml*.dts*
 F:	drivers/gpio/gpio-tqmx86.c
 F:	drivers/mfd/tqmx86.c
 F:	drivers/watchdog/tqmx86_wdt.c
-- 
2.34.1

