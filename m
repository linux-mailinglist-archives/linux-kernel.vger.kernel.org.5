Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC063790CDD
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 18:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244551AbjICQPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 12:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjICQPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 12:15:09 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0896EFE
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 09:15:04 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 383GEui4021076;
        Sun, 3 Sep 2023 11:14:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1693757697;
        bh=4gcLlaEYGDGQOk6RQ1aDfmPPL3ddH9FwQ/oXw3nLfWY=;
        h=From:To:CC:Subject:Date;
        b=OXc3wHf5n3bPrDF2KhmSo/twCRcwTmR0QBK9nK7gbNN2mzBIhHOQG0Gbdgxtow/0P
         SdT41yFq/whmvCVnS6QQguwsTuFYl3DYL1KQCkLl/0alFETHeDvOpsWJs/hpuGYvc4
         DZ7t2YzfXzn3gOp8+tlh6JsZAEhCPtzM2dZXykkU=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 383GEuk8105599
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 3 Sep 2023 11:14:56 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 3
 Sep 2023 11:14:56 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 3 Sep 2023 11:14:56 -0500
Received: from LT5CG2035V3Q.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 383GEqlu016482;
        Sun, 3 Sep 2023 11:14:53 -0500
From:   Kevin-Lu <kevin-lu@ti.com>
To:     <broonie@kernel.org>, <peeyush@ti.com>, <navada@ti.com>,
        <baojun.xu@ti.com>
CC:     <shenghao-ding@ti.com>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, Kevin-Lu <kevin-lu@ti.com>
Subject: [PATCH v1] MAINTAINERS: Update the MAINTAINERS enties for TEXAS INSTRUMENTS ASoC DRIVERS
Date:   Mon, 4 Sep 2023 00:14:37 +0800
Message-ID: <20230903161439.85-1-kevin-lu@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the MAINTAINERS email for TEXAS INSTRUMENTS ASoC DRIVERS.

Signed-off-by: Kevin-Lu <kevin-lu@ti.com>

---
Change in v1:
Change Baojun Xu's email to a commonly used address
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 88174736be51..8c8857826a79 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21066,7 +21066,7 @@ F:	sound/soc/ti/
 TEXAS INSTRUMENTS AUDIO (ASoC/HDA) DRIVERS
 M:	Shenghao Ding <shenghao-ding@ti.com>
 M:	Kevin Lu <kevin-lu@ti.com>
-M:	Baojun Xu <x1077012@ti.com>
+M:	Baojun Xu <baojun.xu@ti.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/sound/tas2552.txt
-- 
2.34.1

