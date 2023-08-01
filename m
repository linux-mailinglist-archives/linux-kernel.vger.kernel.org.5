Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6B876A8CC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjHAGPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjHAGPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:15:40 -0400
Received: from out28-193.mail.aliyun.com (out28-193.mail.aliyun.com [115.124.28.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFD518E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 23:15:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08867355|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0219141-0.000104645-0.977981;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047209;MF=sunran001@208suo.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.U5foOkY_1690870530;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U5foOkY_1690870530)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 14:15:32 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amdgpu: Clean up errors in smu7_powertune.c
Date:   Tue,  1 Aug 2023 06:15:29 +0000
Message-Id: <20230801061529.6269-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: that open brace { should be on the previous line
ERROR: space required after that ',' (ctx:VxV)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_powertune.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_powertune.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_powertune.c
index 21be23ec3c79..edab3ef09d33 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_powertune.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_powertune.c
@@ -520,8 +520,7 @@ static const struct gpu_pt_config_reg DIDTConfig_Polaris12[] = {
 	{   0xFFFFFFFF  }
 };
 
-static const struct gpu_pt_config_reg DIDTConfig_Polaris11_Kicker[] =
-{
+static const struct gpu_pt_config_reg DIDTConfig_Polaris11_Kicker[] = {
 /* ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  *      Offset                             Mask                                                Shift                                               Value       Type
  * ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@@ -646,7 +645,7 @@ static const struct gpu_pt_config_reg DIDTConfig_Polaris11_Kicker[] =
 	{   ixDIDT_TCP_STALL_CTRL,             DIDT_TCP_STALL_CTRL__DIDT_STALL_CTRL_ENABLE_MASK,   DIDT_TCP_STALL_CTRL__DIDT_STALL_CTRL_ENABLE__SHIFT, 0x0001,     GPU_CONFIGREG_DIDT_IND },
 	{   ixDIDT_TCP_STALL_CTRL,             DIDT_TCP_STALL_CTRL__DIDT_STALL_DELAY_HI_MASK,      DIDT_TCP_STALL_CTRL__DIDT_STALL_DELAY_HI__SHIFT,    0x0001,     GPU_CONFIGREG_DIDT_IND },
 	{   ixDIDT_TCP_STALL_CTRL,             DIDT_TCP_STALL_CTRL__DIDT_STALL_DELAY_LO_MASK,      DIDT_TCP_STALL_CTRL__DIDT_STALL_DELAY_LO__SHIFT,    0x0001,     GPU_CONFIGREG_DIDT_IND },
-	{   ixDIDT_TCP_STALL_CTRL,             DIDT_TCP_STALL_CTRL__DIDT_HI_POWER_THRESHOLD_MASK,  DIDT_TCP_STALL_CTRL__DIDT_HI_POWER_THRESHOLD__SHIFT,0x01aa,     GPU_CONFIGREG_DIDT_IND },
+	{   ixDIDT_TCP_STALL_CTRL,             DIDT_TCP_STALL_CTRL__DIDT_HI_POWER_THRESHOLD_MASK,  DIDT_TCP_STALL_CTRL__DIDT_HI_POWER_THRESHOLD__SHIFT, 0x01aa,     GPU_CONFIGREG_DIDT_IND },
 	{   ixDIDT_TCP_STALL_CTRL,             DIDT_TCP_STALL_CTRL__UNUSED_0_MASK,                 DIDT_TCP_STALL_CTRL__UNUSED_0__SHIFT,               0x0000,     GPU_CONFIGREG_DIDT_IND },
 
 	{   ixDIDT_TCP_TUNING_CTRL,            DIDT_TCP_TUNING_CTRL__DIDT_TUNING_ENABLE_MASK,      DIDT_TCP_TUNING_CTRL__DIDT_TUNING_ENABLE__SHIFT,    0x0001,     GPU_CONFIGREG_DIDT_IND },
@@ -666,8 +665,7 @@ static const struct gpu_pt_config_reg DIDTConfig_Polaris11_Kicker[] =
 	{   0xFFFFFFFF  }  /* End of list */
 };
 
-static const struct gpu_pt_config_reg GCCACConfig_VegaM[] =
-{
+static const struct gpu_pt_config_reg GCCACConfig_VegaM[] = {
 // ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 //      Offset                             Mask                                                Shift                                               Value       Type
 // ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@@ -703,8 +701,7 @@ static const struct gpu_pt_config_reg GCCACConfig_VegaM[] =
     {   0xFFFFFFFF  }  // End of list
 };
 
-static const struct gpu_pt_config_reg DIDTConfig_VegaM[] =
-{
+static const struct gpu_pt_config_reg DIDTConfig_VegaM[] = {
 // ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 //      Offset                             Mask                                                Shift                                               Value       Type
 // ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
@@ -831,7 +828,7 @@ static const struct gpu_pt_config_reg DIDTConfig_VegaM[] =
     {   ixDIDT_TCP_STALL_CTRL,             DIDT_TCP_STALL_CTRL__DIDT_STALL_CTRL_ENABLE_MASK,   DIDT_TCP_STALL_CTRL__DIDT_STALL_CTRL_ENABLE__SHIFT, 0x0001,     GPU_CONFIGREG_DIDT_IND },
     {   ixDIDT_TCP_STALL_CTRL,             DIDT_TCP_STALL_CTRL__DIDT_STALL_DELAY_HI_MASK,      DIDT_TCP_STALL_CTRL__DIDT_STALL_DELAY_HI__SHIFT,    0x0001,     GPU_CONFIGREG_DIDT_IND },
     {   ixDIDT_TCP_STALL_CTRL,             DIDT_TCP_STALL_CTRL__DIDT_STALL_DELAY_LO_MASK,      DIDT_TCP_STALL_CTRL__DIDT_STALL_DELAY_LO__SHIFT,    0x0001,     GPU_CONFIGREG_DIDT_IND },
-    {   ixDIDT_TCP_STALL_CTRL,             DIDT_TCP_STALL_CTRL__DIDT_HI_POWER_THRESHOLD_MASK,  DIDT_TCP_STALL_CTRL__DIDT_HI_POWER_THRESHOLD__SHIFT,0x01aa,     GPU_CONFIGREG_DIDT_IND },
+    {   ixDIDT_TCP_STALL_CTRL,             DIDT_TCP_STALL_CTRL__DIDT_HI_POWER_THRESHOLD_MASK,  DIDT_TCP_STALL_CTRL__DIDT_HI_POWER_THRESHOLD__SHIFT, 0x01aa,     GPU_CONFIGREG_DIDT_IND },
     {   ixDIDT_TCP_STALL_CTRL,             DIDT_TCP_STALL_CTRL__UNUSED_0_MASK,                 DIDT_TCP_STALL_CTRL__UNUSED_0__SHIFT,               0x0000,     GPU_CONFIGREG_DIDT_IND },
 
     {   ixDIDT_TCP_TUNING_CTRL,            DIDT_TCP_TUNING_CTRL__DIDT_TUNING_ENABLE_MASK,      DIDT_TCP_TUNING_CTRL__DIDT_TUNING_ENABLE__SHIFT,    0x0001,     GPU_CONFIGREG_DIDT_IND },
-- 
2.17.1

