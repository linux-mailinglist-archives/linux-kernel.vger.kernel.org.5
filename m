Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D60D76ADBD
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjHAJcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbjHAJcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:32:08 -0400
Received: from out28-122.mail.aliyun.com (out28-122.mail.aliyun.com [115.124.28.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F1B4487
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 02:30:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4867433|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.143503-0.00113365-0.855363;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047209;MF=sunran001@208suo.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.U5rwF-m_1690882224;
Received: from localhost.localdomain(mailfrom:sunran001@208suo.com fp:SMTPD_---.U5rwF-m_1690882224)
          by smtp.aliyun-inc.com;
          Tue, 01 Aug 2023 17:30:26 +0800
From:   Ran Sun <sunran001@208suo.com>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Ran Sun <sunran001@208suo.com>
Subject: [PATCH] gpu: amd: Clean up errors in ppatomfwctrl.h
Date:   Tue,  1 Aug 2023 09:30:23 +0000
Message-Id: <20230801093023.7584-1-sunran001@208suo.com>
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
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.h
index 2fc1733bcdcf..e86e05c786d9 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomfwctrl.h
@@ -147,8 +147,7 @@ struct pp_atomfwctrl_bios_boot_up_values {
 	uint8_t    ucCoolingID;
 };
 
-struct pp_atomfwctrl_smc_dpm_parameters
-{
+struct pp_atomfwctrl_smc_dpm_parameters {
   uint8_t  liquid1_i2c_address;
   uint8_t  liquid2_i2c_address;
   uint8_t  vr_i2c_address;
-- 
2.17.1

