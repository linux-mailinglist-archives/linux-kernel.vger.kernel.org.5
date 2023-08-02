Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F2576C264
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 03:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjHBBk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 21:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjHBBkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 21:40:12 -0400
Received: from out28-112.mail.aliyun.com (out28-112.mail.aliyun.com [115.124.28.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B6E2D4B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 18:39:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.5120696|-1;CH=blue;DM=|OVERLOAD|false|;DS=CONTINUE|ham_alarm|0.141021-0.000878557-0.858101;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=sunran001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U6Iz1dD_1690940380;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U6Iz1dD_1690940380)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 09:39:42 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd/pm: Clean up errors in hardwaremanager.h
Date:   Wed,  2 Aug 2023 01:39:39 +0000
Message-Id: <20230802013939.8855-1-sunran001@208suo.com>
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

ERROR: open brace '{' following struct go on the same line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h
index 01a7d66864f2..f4f9a104d170 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h
@@ -44,8 +44,7 @@ struct phm_fan_speed_info {
 };
 
 /* Automatic Power State Throttling */
-enum PHM_AutoThrottleSource
-{
+enum PHM_AutoThrottleSource {
     PHM_AutoThrottleSource_Thermal,
     PHM_AutoThrottleSource_External
 };
-- 
2.17.1

