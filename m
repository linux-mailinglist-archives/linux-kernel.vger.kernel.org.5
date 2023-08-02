Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88BA76C2BC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 04:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjHBCPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 22:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjHBCPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 22:15:16 -0400
Received: from out28-93.mail.aliyun.com (out28-93.mail.aliyun.com [115.124.28.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2B31B1
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 19:15:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4795925|-1;CH=blue;DM=|OVERLOAD|false|;DS=CONTINUE|ham_alarm|0.198135-0.00156503-0.8003;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6L.8nL_1690942507;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6L.8nL_1690942507)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 10:15:09 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/pm: Clean up errors in r600_dpm.h
Date:   Wed,  2 Aug 2023 02:15:04 +0000
Message-Id: <20230802021504.9439-1-sunran001@208suo.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: that open brace { should be on the previous line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/r600_dpm.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/r600_dpm.h b/drivers/gpu/drm/amd/pm/legacy-dpm/r600_dpm.h
index 055321f61ca7..3e7caa715533 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/r600_dpm.h
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/r600_dpm.h
@@ -117,8 +117,7 @@ enum r600_display_watermark {
 	R600_DISPLAY_WATERMARK_HIGH = 1,
 };
 
-enum r600_display_gap
-{
+enum r600_display_gap {
     R600_PM_DISPLAY_GAP_VBLANK_OR_WM = 0,
     R600_PM_DISPLAY_GAP_VBLANK       = 1,
     R600_PM_DISPLAY_GAP_WATERMARK    = 2,
-- 
2.17.1

