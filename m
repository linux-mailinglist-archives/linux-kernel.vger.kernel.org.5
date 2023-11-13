Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838447E9953
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 10:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjKMJrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 04:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjKMJrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 04:47:15 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1217410D;
        Mon, 13 Nov 2023 01:47:10 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AD9l0Ba084893;
        Mon, 13 Nov 2023 03:47:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1699868820;
        bh=of4k2PeamlWg6Nb98pCxHnJpq+bjdjc8wLWKzv6j9ts=;
        h=From:To:CC:Subject:Date;
        b=AgD5oCd/7T975Apo2vzNPL75LVP7NAIfae5p9VTaDi79znL2JIoJG5I7dQYJFlHUq
         Z+wwFUZfrzPqij4j2R1MdotkJCNjJHWvy1jxc09kFjpA/5OSfngkpaxMYNNBtUIBbb
         6eY3gdinzhVE3r7Oa5rCrysb0XQdhh/QM0gI890I=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AD9l0ev056917
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Nov 2023 03:47:00 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 13
 Nov 2023 03:47:00 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 13 Nov 2023 03:47:00 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AD9l0bu004910;
        Mon, 13 Nov 2023 03:47:00 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.31])
        by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 3AD9kx6t009722;
        Mon, 13 Nov 2023 03:47:00 -0600
From:   MD Danish Anwar <danishanwar@ti.com>
To:     <netdev@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <srk@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <r-gunasekaran@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>
Subject: [PATCH] MAINTAINERS: add entry for TI ICSSG Ethernet driver
Date:   Mon, 13 Nov 2023 15:16:56 +0530
Message-ID: <20231113094656.3939317-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add record for TI Industrial Communication Subsystem - Gigabit (ICSSG)
Ethernet driver.

Also add Roger and myself as maintainer.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e3acb36989f0..0443f4d9f736 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21795,6 +21795,15 @@ F:	Documentation/devicetree/bindings/media/i2c/ti,ds90*
 F:	drivers/media/i2c/ds90*
 F:	include/media/i2c/ds90*
 
+TI ICSSG ETHERNET DRIVER (ICSSG)
+R:	MD Danish Anwar <danishanwar@ti.com>
+R:	Roger Quadros <rogerq@kernel.org>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/ti,icss*.yaml
+F:	drivers/net/ethernet/ti/icssg/*
+
 TI J721E CSI2RX DRIVER
 M:	Jai Luthra <j-luthra@ti.com>
 L:	linux-media@vger.kernel.org
-- 
2.34.1

