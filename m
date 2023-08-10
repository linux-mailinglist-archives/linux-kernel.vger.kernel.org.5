Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D12776E43
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 04:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbjHJC5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 22:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjHJC5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 22:57:19 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7A91702
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 19:57:18 -0700 (PDT)
Received: from dggpemm100013.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RLs230VdCzNmdG;
        Thu, 10 Aug 2023 10:53:47 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100013.china.huawei.com (7.185.36.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 10:57:15 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 10:57:15 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <robh@kernel.org>, <lee@kernel.org>, <yangyingliang@huawei.com>
Subject: [PATCH -next] mfd: remove unexpected file drivers/mfd/rz-mtu3.c.rej
Date:   Thu, 10 Aug 2023 10:54:13 +0800
Message-ID: <20230810025413.3223814-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit bb60922c31d0 ("mfd: Explicitly include correct DT includes") added
an unexpected file drivers/mfd/rz-mtu3.c.rej, remove the file.

Fixes: bb60922c31d0 ("mfd: Explicitly include correct DT includes")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/mfd/rz-mtu3.c.rej | 12 ------------
 1 file changed, 12 deletions(-)
 delete mode 100644 drivers/mfd/rz-mtu3.c.rej

diff --git a/drivers/mfd/rz-mtu3.c.rej b/drivers/mfd/rz-mtu3.c.rej
deleted file mode 100644
index 9654d98cfedf..000000000000
--- a/drivers/mfd/rz-mtu3.c.rej
+++ /dev/null
@@ -1,12 +0,0 @@
-diff a/drivers/mfd/rz-mtu3.c b/drivers/mfd/rz-mtu3.c	(rejected hunks)
-@@ -11,7 +11,9 @@
- #include <linux/irq.h>
- #include <linux/mfd/core.h>
- #include <linux/mfd/rz-mtu3.h>
--#include <linux/of_platform.h>
-+#include <linux/mod_devicetable.h>
-+#include <linux/module.h>
-+#include <linux/platform_device.h>
- #include <linux/reset.h>
- #include <linux/spinlock.h>
- 
-- 
2.25.1

