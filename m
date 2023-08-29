Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEA878C180
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234906AbjH2J3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbjH2J3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:29:17 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12399E1;
        Tue, 29 Aug 2023 02:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1693301353; x=1724837353;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=LgXW93cNR0No3c3s9Vctvqlqw/7SVjO9Zt3lCI5tOIE=;
  b=X7l3nz2i4qQ7O+u7PmQEhwgXM01Q+8y3zYgwVQdmac79goSXHbAPElPW
   TO2MUNHsWyEh5hu+1qdB0B8AEW17BAoEV3ye0N4EBH5KK5G9GL/tpTxD1
   Khrfa2OtHthUmw+V3BRPP2mB7dlQlwDOBYCuV4Xj1tnA/7opVWrjj2hId
   MegGAoHYo8trudawG6ofQaZ4XpZFH6l3hMv6RcdzAIEb/Xh2YYGe+07tC
   5FJf6ibbXLGPlinulNRpHMVssyseb/enJcCX18x2sgoyrkWAL+BauDkUT
   kkbj0CiwK8s/ImEnuTZy7hq7PLrX7j730s8ez59E6UqQ5Vl2gv0e5YqPE
   g==;
X-IronPort-AV: E=Sophos;i="6.02,210,1688421600"; 
   d="scan'208";a="32672408"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 29 Aug 2023 11:27:25 +0200
Received: from [127.0.1.1] (herburgerg-w2.tq-net.de [10.122.52.145])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 1BB7628008A;
        Tue, 29 Aug 2023 11:27:25 +0200 (CEST)
From:   Gregor Herburger <gregor.herburger@ew.tq-group.com>
Date:   Tue, 29 Aug 2023 11:27:02 +0200
Subject: [PATCH v2 6/6] MAINTAINERS: add tqml device trees to TQ-Systems
 entry
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230829-for-ml-tqmls10xxa-v2-test-v2-6-b1da63785b25@ew.tq-group.com>
References: <20230829-for-ml-tqmls10xxa-v2-test-v2-0-b1da63785b25@ew.tq-group.com>
In-Reply-To: <20230829-for-ml-tqmls10xxa-v2-test-v2-0-b1da63785b25@ew.tq-group.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@ew.tq-group.com,
        gregor.herburger@ew.tq-group.com
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693301244; l=843;
 i=gregor.herburger@ew.tq-group.com; s=20230829; h=from:subject:message-id;
 bh=hyzk0VJaY5oa0kF7IJm92NXpVzkmk+SifWkq//cYZEQ=;
 b=8DpA1nuYZoXWADDDqSoe6csCBf/CvRKbnMuLl+tChdWJVOL2zlx/lEpe2WP2gf/silV8Cgu0F
 HbQsbVghevYCYBFawOjEi/7RjzIyHeWnoYaD9A13LIWftN4WsW+ZPFZ
X-Developer-Key: i=gregor.herburger@ew.tq-group.com; a=ed25519;
 pk=+eRxwX7ikXwazcRjlOjj2/tbDmfVZdDLoW+xLZbQ4h4=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

