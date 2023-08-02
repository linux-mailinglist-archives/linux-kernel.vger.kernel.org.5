Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615A376C2B5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 04:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjHBCJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 22:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjHBCJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 22:09:53 -0400
Received: from out28-112.mail.aliyun.com (out28-112.mail.aliyun.com [115.124.28.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5573319A0
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 19:09:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07440748|-1;CH=blue;DM=|OVERLOAD|false|;DS=CONTINUE|ham_system_inform|0.0531706-0.0119323-0.934897;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6LRrkh_1690942184;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6LRrkh_1690942184)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 10:09:45 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drivers/amd/pm: Clean up errors in smu8_smumgr.h
Date:   Wed,  2 Aug 2023 02:09:43 +0000
Message-Id: <20230802020943.9322-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: that open brace { should be on the previous line
ERROR: space prohibited before that ',' (ctx:WxW)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c | 48 ++++++++--------------
 1 file changed, 17 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index 36c831b280ed..5d28c951a319 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -191,8 +191,7 @@ static void sumo_construct_vid_mapping_table(struct amdgpu_device *adev,
 }
 
 #if 0
-static const struct kv_lcac_config_values sx_local_cac_cfg_kv[] =
-{
+static const struct kv_lcac_config_values sx_local_cac_cfg_kv[] = {
 	{  0,       4,        1    },
 	{  1,       4,        1    },
 	{  2,       5,        1    },
@@ -204,32 +203,27 @@ static const struct kv_lcac_config_values sx_local_cac_cfg_kv[] =
 	{ 0xffffffff }
 };
 
-static const struct kv_lcac_config_values mc0_local_cac_cfg_kv[] =
-{
+static const struct kv_lcac_config_values mc0_local_cac_cfg_kv[] = {
 	{  0,       4,        1    },
 	{ 0xffffffff }
 };
 
-static const struct kv_lcac_config_values mc1_local_cac_cfg_kv[] =
-{
+static const struct kv_lcac_config_values mc1_local_cac_cfg_kv[] = {
 	{  0,       4,        1    },
 	{ 0xffffffff }
 };
 
-static const struct kv_lcac_config_values mc2_local_cac_cfg_kv[] =
-{
+static const struct kv_lcac_config_values mc2_local_cac_cfg_kv[] = {
 	{  0,       4,        1    },
 	{ 0xffffffff }
 };
 
-static const struct kv_lcac_config_values mc3_local_cac_cfg_kv[] =
-{
+static const struct kv_lcac_config_values mc3_local_cac_cfg_kv[] = {
 	{  0,       4,        1    },
 	{ 0xffffffff }
 };
 
-static const struct kv_lcac_config_values cpl_local_cac_cfg_kv[] =
-{
+static const struct kv_lcac_config_values cpl_local_cac_cfg_kv[] = {
 	{  0,       4,        1    },
 	{  1,       4,        1    },
 	{  2,       5,        1    },
@@ -260,39 +254,32 @@ static const struct kv_lcac_config_values cpl_local_cac_cfg_kv[] =
 	{ 0xffffffff }
 };
 
-static const struct kv_lcac_config_reg sx0_cac_config_reg[] =
-{
+static const struct kv_lcac_config_reg sx0_cac_config_reg[] = {
 	{ 0xc0400d00, 0x003e0000, 17, 0x3fc00000, 22, 0x0001fffe, 1, 0x00000001, 0 }
 };
 
-static const struct kv_lcac_config_reg mc0_cac_config_reg[] =
-{
+static const struct kv_lcac_config_reg mc0_cac_config_reg[] = {
 	{ 0xc0400d30, 0x003e0000, 17, 0x3fc00000, 22, 0x0001fffe, 1, 0x00000001, 0 }
 };
 
-static const struct kv_lcac_config_reg mc1_cac_config_reg[] =
-{
+static const struct kv_lcac_config_reg mc1_cac_config_reg[] = {
 	{ 0xc0400d3c, 0x003e0000, 17, 0x3fc00000, 22, 0x0001fffe, 1, 0x00000001, 0 }
 };
 
-static const struct kv_lcac_config_reg mc2_cac_config_reg[] =
-{
+static const struct kv_lcac_config_reg mc2_cac_config_reg[] = {
 	{ 0xc0400d48, 0x003e0000, 17, 0x3fc00000, 22, 0x0001fffe, 1, 0x00000001, 0 }
 };
 
-static const struct kv_lcac_config_reg mc3_cac_config_reg[] =
-{
+static const struct kv_lcac_config_reg mc3_cac_config_reg[] = {
 	{ 0xc0400d54, 0x003e0000, 17, 0x3fc00000, 22, 0x0001fffe, 1, 0x00000001, 0 }
 };
 
-static const struct kv_lcac_config_reg cpl_cac_config_reg[] =
-{
+static const struct kv_lcac_config_reg cpl_cac_config_reg[] = {
 	{ 0xc0400d80, 0x003e0000, 17, 0x3fc00000, 22, 0x0001fffe, 1, 0x00000001, 0 }
 };
 #endif
 
-static const struct kv_pt_config_reg didt_config_kv[] =
-{
+static const struct kv_pt_config_reg didt_config_kv[] = {
 	{ 0x10, 0x000000ff, 0, 0x0, KV_CONFIGREG_DIDT_IND },
 	{ 0x10, 0x0000ff00, 8, 0x0, KV_CONFIGREG_DIDT_IND },
 	{ 0x10, 0x00ff0000, 16, 0x0, KV_CONFIGREG_DIDT_IND },
@@ -1173,9 +1160,9 @@ static void kv_calculate_dfs_bypass_settings(struct amdgpu_device *adev)
 					pi->graphics_level[i].ClkBypassCntl = 2;
 				else if (kv_get_clock_difference(table->entries[i].clk, 26600) < 200)
 					pi->graphics_level[i].ClkBypassCntl = 7;
-				else if (kv_get_clock_difference(table->entries[i].clk , 20000) < 200)
+				else if (kv_get_clock_difference(table->entries[i].clk, 20000) < 200)
 					pi->graphics_level[i].ClkBypassCntl = 6;
-				else if (kv_get_clock_difference(table->entries[i].clk , 10000) < 200)
+				else if (kv_get_clock_difference(table->entries[i].clk, 10000) < 200)
 					pi->graphics_level[i].ClkBypassCntl = 8;
 				else
 					pi->graphics_level[i].ClkBypassCntl = 0;
@@ -1825,7 +1812,7 @@ static void kv_set_valid_clock_range(struct amdgpu_device *adev,
 			if ((new_ps->levels[0].sclk -
 			     table->entries[pi->highest_valid].sclk_frequency) >
 			    (table->entries[pi->lowest_valid].sclk_frequency -
-			     new_ps->levels[new_ps->num_levels -1].sclk))
+			     new_ps->levels[new_ps->num_levels - 1].sclk))
 				pi->highest_valid = pi->lowest_valid;
 			else
 				pi->lowest_valid =  pi->highest_valid;
@@ -3333,8 +3320,7 @@ static const struct amd_ip_funcs kv_dpm_ip_funcs = {
 	.set_powergating_state = kv_dpm_set_powergating_state,
 };
 
-const struct amdgpu_ip_block_version kv_smu_ip_block =
-{
+const struct amdgpu_ip_block_version kv_smu_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_SMC,
 	.major = 1,
 	.minor = 0,
-- 
2.17.1

