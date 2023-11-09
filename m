Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0587E648A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 08:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbjKIHk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 02:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbjKIHkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 02:40:11 -0500
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6640530E5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 23:39:37 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Vw00z7y_1699515566;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Vw00z7y_1699515566)
          by smtp.aliyun-inc.com;
          Thu, 09 Nov 2023 15:39:31 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] regulator: stpmic1: Fix kernel-doc notation warnings
Date:   Thu,  9 Nov 2023 15:39:25 +0800
Message-Id: <20231109073925.98783-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional modification involved.

drivers/regulator/stpmic1_regulator.c:31: warning: expecting prototype for struct stpmic1. Prototype was for struct stpmic1_regulator_cfg instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7206
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/regulator/stpmic1_regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/stpmic1_regulator.c b/drivers/regulator/stpmic1_regulator.c
index 79d1a3eb18d4..a498df7cb016 100644
--- a/drivers/regulator/stpmic1_regulator.c
+++ b/drivers/regulator/stpmic1_regulator.c
@@ -15,7 +15,7 @@
 #include <dt-bindings/mfd/st,stpmic1.h>
 
 /**
- * struct stpmic1 regulator description: this structure is used as driver data
+ * struct stpmic1_regulator_cfg - this structure is used as driver data
  * @desc: regulator framework description
  * @mask_reset_reg: mask reset register address
  * @mask_reset_mask: mask rank and mask reset register mask
-- 
2.20.1.7.g153144c

