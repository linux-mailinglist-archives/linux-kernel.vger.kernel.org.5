Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3B47E82F6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbjKJTeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235804AbjKJTdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:33:45 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73512BE39;
        Fri, 10 Nov 2023 01:27:55 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AA9RqtS007745;
        Fri, 10 Nov 2023 03:27:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1699608472;
        bh=BLiCtDU8nsdSlSYXr+3R3b3TK6oRBbRtfnrRbMla3fQ=;
        h=From:To:CC:Subject:Date;
        b=wg4lb0nM28xuVFrj7xZbsG+0ulGees5j9LtTlUXzsOLNq/re+764g8EUYZaetn0X1
         WjqduiTMzPHqW18sn6CUfnQGZ8DKCwokL+YsV4bKBKgW8S4dMeUHNyJHiKQGK9AFQ0
         jJvv6orpPe63CS2BLXhlOm0k9XHEYCK7Mk+CGg4Y=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AA9Rqfm006658
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Nov 2023 03:27:52 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 10
 Nov 2023 03:27:52 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 10 Nov 2023 03:27:52 -0600
Received: from uda0500640.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AA9RnX8016335;
        Fri, 10 Nov 2023 03:27:50 -0600
From:   Ravi Gunasekaran <r-gunasekaran@ti.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <s-vadapalli@ti.com>, <nm@ti.com>, <srk@ti.com>,
        <rogerq@kernel.org>, <r-gunasekaran@ti.com>
Subject: [PATCH v2] MAINTAINERS: net: Update reviewers for TI's Ethernet drivers
Date:   Fri, 10 Nov 2023 14:57:49 +0530
Message-ID: <20231110092749.3618-1-r-gunasekaran@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Grygorii is no longer associated with TI and messages addressed to
him bounce.

Add Siddharth, Roger and myself as reviewers.

Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
---
Changes from v1:
--------------
* Added Roger as reviewer upon on his request

v1: https://lore.kernel.org/all/20231110084227.2616-1-r-gunasekaran@ti.com/

 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b151710e8c5..1466699fbaaf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21775,7 +21775,9 @@ F:	Documentation/devicetree/bindings/counter/ti-eqep.yaml
 F:	drivers/counter/ti-eqep.c
 
 TI ETHERNET SWITCH DRIVER (CPSW)
-R:	Grygorii Strashko <grygorii.strashko@ti.com>
+R:	Siddharth Vadapalli <s-vadapalli@ti.com>
+R:	Ravi Gunasekaran <r-gunasekaran@ti.com>
+R:	Roger Quadros <rogerq@kernel.org>
 L:	linux-omap@vger.kernel.org
 L:	netdev@vger.kernel.org
 S:	Maintained
-- 
2.17.1

