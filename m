Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2009B7FCC75
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 02:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjK2Bzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 20:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK2Bzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 20:55:54 -0500
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF4410E2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 17:55:58 -0800 (PST)
X-UUID: cab1cce556d74a188f85ce9f77454e1b-20231129
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:ce7f5549-2247-485a-b997-199b689ed2d3,IP:5,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:0
X-CID-INFO: VERSION:1.1.33,REQID:ce7f5549-2247-485a-b997-199b689ed2d3,IP:5,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:64a12f73-1bd3-4f48-b671-ada88705968c,B
        ulkID:231129093703D52I3TJ5,BulkQuantity:1,Recheck:0,SF:19|44|66|38|24|72|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL
        :0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: cab1cce556d74a188f85ce9f77454e1b-20231129
X-User: zhongkaihua@kylinos.cn
Received: from kylin-pc.. [(112.64.161.44)] by mailgw
        (envelope-from <zhongkaihua@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 2058608997; Wed, 29 Nov 2023 09:55:44 +0800
From:   zhongkaihua <zhongkaihua@kylinos.cn>
To:     cw00.choi@samsung.com, krzysztof.kozlowski@linaro.org,
        lee@kernel.org, linux-kernel@vger.kernel.org
Cc:     huangwei@kylinos.cn, zhang.chen@cs2c.com.cn,
        Kaihua Zhong <zhongkaihua@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] mfd: fix comment typos
Date:   Wed, 29 Nov 2023 09:55:26 +0800
Message-Id: <20231129015526.3302865-1-zhongkaihua@kylinos.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaihua Zhong <zhongkaihua@kylinos.cn>

Fix four comment typos in mfd pmic header files.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Kaihua Zhong <zhongkaihua@kylinos.cn>
---
 include/linux/mfd/max77693-private.h | 2 +-
 include/linux/mfd/max77843-private.h | 2 +-
 include/linux/mfd/si476x-platform.h  | 2 +-
 include/linux/mfd/tps65910.h         | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/mfd/max77693-private.h b/include/linux/mfd/max77693-private.h
index 311f7d3d2323..54444ff2a5de 100644
--- a/include/linux/mfd/max77693-private.h
+++ b/include/linux/mfd/max77693-private.h
@@ -405,7 +405,7 @@ enum max77693_haptic_reg {
 	MAX77693_HAPTIC_REG_END,
 };
 
-/* max77693-pmic LSCNFG configuraton register */
+/* max77693-pmic LSCNFG configuration register */
 #define MAX77693_PMIC_LOW_SYS_MASK      0x80
 #define MAX77693_PMIC_LOW_SYS_SHIFT     7
 
diff --git a/include/linux/mfd/max77843-private.h b/include/linux/mfd/max77843-private.h
index 0bc7454c4dbe..2fb4db67f110 100644
--- a/include/linux/mfd/max77843-private.h
+++ b/include/linux/mfd/max77843-private.h
@@ -198,7 +198,7 @@ enum max77843_irq_muic {
 #define MAX77843_MCONFIG_MEN_MASK		BIT(MCONFIG_MEN_SHIFT)
 #define MAX77843_MCONFIG_PDIV_MASK		(0x3 << MCONFIG_PDIV_SHIFT)
 
-/* Max77843 charger insterrupts */
+/* Max77843 charger interrupts */
 #define MAX77843_CHG_BYP_I			BIT(0)
 #define MAX77843_CHG_BATP_I			BIT(2)
 #define MAX77843_CHG_BAT_I			BIT(3)
diff --git a/include/linux/mfd/si476x-platform.h b/include/linux/mfd/si476x-platform.h
index 18363b773d07..cb99e16ca947 100644
--- a/include/linux/mfd/si476x-platform.h
+++ b/include/linux/mfd/si476x-platform.h
@@ -10,7 +10,7 @@
 #ifndef __SI476X_PLATFORM_H__
 #define __SI476X_PLATFORM_H__
 
-/* It is possible to select one of the four adresses using pins A0
+/* It is possible to select one of the four addresses using pins A0
  * and A1 on SI476x */
 #define SI476X_I2C_ADDR_1	0x60
 #define SI476X_I2C_ADDR_2	0x61
diff --git a/include/linux/mfd/tps65910.h b/include/linux/mfd/tps65910.h
index 701925db75b3..f67ef0a4e041 100644
--- a/include/linux/mfd/tps65910.h
+++ b/include/linux/mfd/tps65910.h
@@ -749,7 +749,7 @@
 #define VDDCTRL_ST_SHIFT                                 0
 
 
-/*Register VDDCTRL_OP  (0x28) bit definitios */
+/*Register VDDCTRL_OP  (0x28) bit definitions */
 #define VDDCTRL_OP_CMD_MASK                              0x80
 #define VDDCTRL_OP_CMD_SHIFT                             7
 #define VDDCTRL_OP_SEL_MASK                              0x7F
-- 
2.34.1

