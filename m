Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557C476AEBE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbjHAJlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbjHAJkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:40:55 -0400
Received: from out28-125.mail.aliyun.com (out28-125.mail.aliyun.com [115.124.28.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45275246
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 02:38:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.5111754|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0993225-0.000355378-0.900322;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047192;MF=sunran001@208suo.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.U5s-DtI_1690882719;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U5s-DtI_1690882719)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 17:38:40 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/pm: Clean up errors in vega12_hwmgr.h
Date:   Tue,  1 Aug 2023 09:38:32 +0000
Message-Id: <20230801093832.7849-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: open brace '{' following enum go on the same line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.h
index aa63ae41942d..9f2ce4308548 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.h
@@ -38,8 +38,7 @@
 #define VG12_PSUEDO_NUM_DCEFCLK_DPM_LEVELS  8
 #define VG12_PSUEDO_NUM_UCLK_DPM_LEVELS     4
 
-enum
-{
+enum {
 	GNLD_DPM_PREFETCHER = 0,
 	GNLD_DPM_GFXCLK,
 	GNLD_DPM_UCLK,
-- 
2.17.1

