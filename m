Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAEE76AC09
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjHAJFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjHAJEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:04:40 -0400
Received: from out28-77.mail.aliyun.com (out28-77.mail.aliyun.com [115.124.28.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF32273F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 02:03:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08914465|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.0343368-0.000303458-0.96536;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=sunran001@208suo.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.U5pdWgb_1690880559;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U5pdWgb_1690880559)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 17:02:42 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] drm/amd: Clean up errors in pptable_v1_0.h
Date:   Tue,  1 Aug 2023 09:02:37 +0000
Message-Id: <20230801090237.7011-1-sunran001@208suo.com>
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

ERROR: open brace '{' following struct go on the same line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
index b0ac4d121adc..7a31cfa5e7fb 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/pptable_v1_0.h
@@ -419,8 +419,7 @@ typedef struct _ATOM_Fiji_PowerTune_Table {
 	USHORT usReserved;
 } ATOM_Fiji_PowerTune_Table;
 
-typedef struct _ATOM_Polaris_PowerTune_Table
-{
+typedef struct _ATOM_Polaris_PowerTune_Table {
     UCHAR  ucRevId;
     USHORT usTDP;
     USHORT usConfigurableTDP;
-- 
2.17.1

