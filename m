Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB72753036
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbjGNDy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234875AbjGNDyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:54:54 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02C026A5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:54:52 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2Hfy3hgjzBRSVj
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 11:54:50 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689306890; x=1691898891; bh=iTXZlIcRdyK6o3+wDm/UapfqCgm
        g6WekFBy6SQamdR0=; b=Nok34jzjPVafwrRrSRNa78LuU/gf5f63GOJ39mTJ7LC
        cobjTiBXs/8nOmpsUZTvDxOmIOo+7cx3cgGhuNz+U6Zc9NAB9rxq8S3dirFxlHCm
        7q87gKe04TpTQyfgHXfr/j7fP5RI4lbtjUqdfSNyru0rVZu7eN2riO0thnxCXBWy
        QHOI5tpTRy7twmcJUwFVCoCw/8CGybNDafhtqyzTVZ4BGt5xDsVH2zWKL7G25Ftn
        VLZCqOmCi1vEKOJtWyB3aosMjId51PyLTtyhTC/DzP7YuQvG1I+rsWxEA7rVm6bE
        +HcDd8XtTtwu5YbLWQ0iJAjsc1uQ072hQzlwOJHdzLg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Um03sBqfwWTe for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 11:54:50 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2Hfy0G1bzBR7b2;
        Fri, 14 Jul 2023 11:54:50 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 11:54:49 +0800
From:   shijie001@208suo.com
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon: ERROR: that open brace { should be on the
 previous line
In-Reply-To: <tencent_996261255FBE1BF185353D65C90BFB5FDF0A@qq.com>
References: <tencent_996261255FBE1BF185353D65C90BFB5FDF0A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <8d7c6d7599c0f56403c920985f646e34@208suo.com>
X-Sender: shijie001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix eight occurrences of the checkpatch.pl error:
ERROR: that open brace { should be on the previous line
ERROR: space prohibited before that close parenthesis ')'
ERROR: spaces required around that '?' (ctx:VxW)

Signed-off-by: Jie Shi <shijie001@208suo.com>
---
  drivers/gpu/drm/radeon/sumo_dpm.c | 18 ++++++++----------
  1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/radeon/sumo_dpm.c 
b/drivers/gpu/drm/radeon/sumo_dpm.c
index f74f381af05f..8af793c89fd1 100644
--- a/drivers/gpu/drm/radeon/sumo_dpm.c
+++ b/drivers/gpu/drm/radeon/sumo_dpm.c
@@ -33,8 +33,7 @@
  #define SUMO_MINIMUM_ENGINE_CLOCK 800
  #define BOOST_DPM_LEVEL 7

-static const u32 sumo_utc[SUMO_PM_NUMBER_OF_TC] =
-{
+static const u32 sumo_utc[SUMO_PM_NUMBER_OF_TC] = {
      SUMO_UTC_DFLT_00,
      SUMO_UTC_DFLT_01,
      SUMO_UTC_DFLT_02,
@@ -52,8 +51,7 @@ static const u32 sumo_utc[SUMO_PM_NUMBER_OF_TC] =
      SUMO_UTC_DFLT_14,
  };

-static const u32 sumo_dtc[SUMO_PM_NUMBER_OF_TC] =
-{
+static const u32 sumo_dtc[SUMO_PM_NUMBER_OF_TC] = {
      SUMO_DTC_DFLT_00,
      SUMO_DTC_DFLT_01,
      SUMO_DTC_DFLT_02,
@@ -109,11 +107,11 @@ static void sumo_mg_clockgating_enable(struct 
radeon_device *rdev, bool enable)
      local1 = RREG32(CG_CGTT_LOCAL_1);

      if (enable) {
-        WREG32(CG_CGTT_LOCAL_0, (0 & CGCG_CGTT_LOCAL0_MASK) | (local0 & 
~CGCG_CGTT_LOCAL0_MASK) );
-        WREG32(CG_CGTT_LOCAL_1, (0 & CGCG_CGTT_LOCAL1_MASK) | (local1 & 
~CGCG_CGTT_LOCAL1_MASK) );
+        WREG32(CG_CGTT_LOCAL_0, (0 & CGCG_CGTT_LOCAL0_MASK) | (local0 & 
~CGCG_CGTT_LOCAL0_MASK));
+        WREG32(CG_CGTT_LOCAL_1, (0 & CGCG_CGTT_LOCAL1_MASK) | (local1 & 
~CGCG_CGTT_LOCAL1_MASK));
      } else {
-        WREG32(CG_CGTT_LOCAL_0, (0xFFFFFFFF & CGCG_CGTT_LOCAL0_MASK) | 
(local0 & ~CGCG_CGTT_LOCAL0_MASK) );
-        WREG32(CG_CGTT_LOCAL_1, (0xFFFFCFFF & CGCG_CGTT_LOCAL1_MASK) | 
(local1 & ~CGCG_CGTT_LOCAL1_MASK) );
+        WREG32(CG_CGTT_LOCAL_0, (0xFFFFFFFF & CGCG_CGTT_LOCAL0_MASK) | 
(local0 & ~CGCG_CGTT_LOCAL0_MASK));
+        WREG32(CG_CGTT_LOCAL_1, (0xFFFFCFFF & CGCG_CGTT_LOCAL1_MASK) | 
(local1 & ~CGCG_CGTT_LOCAL1_MASK));
      }
  }

@@ -702,9 +700,9 @@ static void sumo_post_notify_alt_vddnb_change(struct 
radeon_device *rdev,
      u32 nbps1_new = 0;

      if (old_ps != NULL)
-        nbps1_old = (old_ps->flags & 
SUMO_POWERSTATE_FLAGS_FORCE_NBPS1_STATE)? 1 : 0;
+        nbps1_old = (old_ps->flags & 
SUMO_POWERSTATE_FLAGS_FORCE_NBPS1_STATE) ? 1 : 0;

-    nbps1_new = (new_ps->flags & 
SUMO_POWERSTATE_FLAGS_FORCE_NBPS1_STATE)? 1 : 0;
+    nbps1_new = (new_ps->flags & 
SUMO_POWERSTATE_FLAGS_FORCE_NBPS1_STATE) ? 1 : 0;

      if (nbps1_old == 0 && nbps1_new == 1)
          sumo_smu_notify_alt_vddnb_change(rdev, 1, 1);
