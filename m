Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C71787F94
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 08:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240995AbjHYGLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 02:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240886AbjHYGLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 02:11:07 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B7A1BF2;
        Thu, 24 Aug 2023 23:11:04 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VqW0QDj_1692943852;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VqW0QDj_1692943852)
          by smtp.aliyun-inc.com;
          Fri, 25 Aug 2023 14:11:01 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        p.zabel@pengutronix.de, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] thermal/drivers/mediatek/lvts_thermal: remove unneeded semicolon
Date:   Fri, 25 Aug 2023 14:10:50 +0800
Message-Id: <20230825061050.7002-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional modification involved.

./drivers/thermal/mediatek/lvts_thermal.c:595:2-3: Unneeded semicolon.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=6228
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index effd9b00a424..4a5324aa503f 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -592,7 +592,7 @@ static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
 
 		lvts_sensor[i].low_thresh = INT_MIN;
 		lvts_sensor[i].high_thresh = INT_MIN;
-	};
+	}
 
 	lvts_ctrl->num_lvts_sensor = lvts_ctrl_data->num_lvts_sensor;
 
-- 
2.20.1.7.g153144c

