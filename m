Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8E976AFF5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbjHAJvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbjHAJv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:51:29 -0400
Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com [115.124.28.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E04171B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 02:51:04 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0973273|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0380037-4.3357e-05-0.961953;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047208;MF=sunran001@208suo.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.U5shFFo_1690883457;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U5shFFo_1690883457)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 17:50:58 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/pm: Clean up errors in smu9_driver_if.h
Date:   Tue,  1 Aug 2023 09:50:56 +0000
Message-Id: <20230801095056.8120-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: space prohibited before open square bracket '['

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 .../drm/amd/pm/powerplay/inc/smu9_driver_if.h | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/smu9_driver_if.h b/drivers/gpu/drm/amd/pm/powerplay/inc/smu9_driver_if.h
index faae4b918d90..2c69a5694f94 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/smu9_driver_if.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/smu9_driver_if.h
@@ -178,20 +178,20 @@ typedef struct {
   uint8_t      padding8_2[2];
 
   /* SOC Frequencies */
-  PllSetting_t GfxclkLevel        [NUM_GFXCLK_DPM_LEVELS];
+  PllSetting_t GfxclkLevel[NUM_GFXCLK_DPM_LEVELS];
 
-  uint8_t      SocclkDid          [NUM_SOCCLK_DPM_LEVELS];          /* DID */
-  uint8_t      SocDpmVoltageIndex [NUM_SOCCLK_DPM_LEVELS];
+  uint8_t      SocclkDid[NUM_SOCCLK_DPM_LEVELS];          /* DID */
+  uint8_t      SocDpmVoltageIndex[NUM_SOCCLK_DPM_LEVELS];
 
-  uint8_t      VclkDid            [NUM_UVD_DPM_LEVELS];            /* DID */
-  uint8_t      DclkDid            [NUM_UVD_DPM_LEVELS];            /* DID */
-  uint8_t      UvdDpmVoltageIndex [NUM_UVD_DPM_LEVELS];
+  uint8_t      VclkDid[NUM_UVD_DPM_LEVELS];            /* DID */
+  uint8_t      DclkDid[NUM_UVD_DPM_LEVELS];            /* DID */
+  uint8_t      UvdDpmVoltageIndex[NUM_UVD_DPM_LEVELS];
 
-  uint8_t      EclkDid            [NUM_VCE_DPM_LEVELS];            /* DID */
-  uint8_t      VceDpmVoltageIndex [NUM_VCE_DPM_LEVELS];
+  uint8_t      EclkDid[NUM_VCE_DPM_LEVELS];            /* DID */
+  uint8_t      VceDpmVoltageIndex[NUM_VCE_DPM_LEVELS];
 
-  uint8_t      Mp0clkDid          [NUM_MP0CLK_DPM_LEVELS];          /* DID */
-  uint8_t      Mp0DpmVoltageIndex [NUM_MP0CLK_DPM_LEVELS];
+  uint8_t      Mp0clkDid[NUM_MP0CLK_DPM_LEVELS];          /* DID */
+  uint8_t      Mp0DpmVoltageIndex[NUM_MP0CLK_DPM_LEVELS];
 
   DisplayClockTable_t DisplayClockTable[DSPCLK_COUNT][NUM_DSPCLK_LEVELS];
   QuadraticInt_t      DisplayClock2Gfxclk[DSPCLK_COUNT];
-- 
2.17.1

