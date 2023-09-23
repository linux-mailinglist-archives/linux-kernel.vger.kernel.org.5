Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC8A7AC3BD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 18:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjIWQhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 12:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbjIWQhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 12:37:10 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED347192;
        Sat, 23 Sep 2023 09:36:58 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.03,171,1694703600"; 
   d="scan'208";a="176995320"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 24 Sep 2023 01:36:58 +0900
Received: from localhost.localdomain (unknown [10.226.92.12])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 403DD401DDF3;
        Sun, 24 Sep 2023 01:36:54 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo.mondi+renesas@ideasonboard.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 3/3] media: tvp541x: Sort header files
Date:   Sat, 23 Sep 2023 17:36:41 +0100
Message-Id: <20230923163641.31685-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230923163641.31685-1-biju.das.jz@bp.renesas.com>
References: <20230923163641.31685-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort header files alphabetically.

Suggested-by: Jacopo Mondi <jacopo.mondi+renesas@ideasonboard.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2:
 * New patch.
---
 drivers/media/i2c/tvp514x.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/media/i2c/tvp514x.c b/drivers/media/i2c/tvp514x.c
index 569a9437ec86..c37f605cb75f 100644
--- a/drivers/media/i2c/tvp514x.c
+++ b/drivers/media/i2c/tvp514x.c
@@ -16,24 +16,24 @@
  *     Prabhakar Lad <prabhakar.lad@ti.com>
  */
 
-#include <linux/i2c.h>
-#include <linux/slab.h>
 #include <linux/delay.h>
-#include <linux/videodev2.h>
+#include <linux/i2c.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/v4l2-mediabus.h>
 #include <linux/of.h>
 #include <linux/of_graph.h>
+#include <linux/slab.h>
+#include <linux/v4l2-mediabus.h>
+#include <linux/videodev2.h>
 
+#include <media/i2c/tvp514x.h>
+#include <media/media-entity.h>
 #include <media/v4l2-async.h>
-#include <media/v4l2-device.h>
 #include <media/v4l2-common.h>
-#include <media/v4l2-mediabus.h>
-#include <media/v4l2-fwnode.h>
 #include <media/v4l2-ctrls.h>
-#include <media/i2c/tvp514x.h>
-#include <media/media-entity.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-fwnode.h>
+#include <media/v4l2-mediabus.h>
 
 #include "tvp514x_regs.h"
 
-- 
2.25.1

