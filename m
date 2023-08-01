Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD5876A6BF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 04:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjHACIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 22:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjHACIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 22:08:50 -0400
Received: from out28-3.mail.aliyun.com (out28-3.mail.aliyun.com [115.124.28.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15EF8B8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 19:08:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4466546|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0186576-0.00180561-0.979537;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047213;MF=sunran001@208suo.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.U5DrTdc_1690855720;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U5DrTdc_1690855720)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 10:08:42 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/pm: Clean up errors in smu_v13_0_5_ppt.c
Date:   Tue,  1 Aug 2023 02:08:39 +0000
Message-Id: <20230801020839.4369-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: space prohibited before that ',' (ctx:WxW)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index 42f110602eb1..87a79e6f983b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -75,7 +75,7 @@ static struct cmn2asic_msg_mapping smu_v13_0_5_message_map[SMU_MSG_MAX_COUNT] =
 	MSG_MAP(SetDriverDramAddrHigh,            PPSMC_MSG_SetDriverDramAddrHigh,      1),
 	MSG_MAP(SetDriverDramAddrLow,          PPSMC_MSG_SetDriverDramAddrLow,	1),
 	MSG_MAP(TransferTableSmu2Dram,           PPSMC_MSG_TransferTableSmu2Dram,		1),
-	MSG_MAP(TransferTableDram2Smu,          PPSMC_MSG_TransferTableDram2Smu ,	1),
+	MSG_MAP(TransferTableDram2Smu,          PPSMC_MSG_TransferTableDram2Smu,	1),
 	MSG_MAP(GetGfxclkFrequency,          PPSMC_MSG_GetGfxclkFrequency,	1),
 	MSG_MAP(GetEnabledSmuFeatures,           PPSMC_MSG_GetEnabledSmuFeatures,		1),
 	MSG_MAP(SetSoftMaxVcn,          PPSMC_MSG_SetSoftMaxVcn,	1),
-- 
2.17.1

