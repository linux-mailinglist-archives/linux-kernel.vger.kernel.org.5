Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D52175EE8C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjGXI5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjGXI51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:57:27 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0552E7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:57:25 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R8YvR3P9tzBRx5P
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 16:57:23 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1690189043; x=1692781044; bh=xivezc9+8JHiL00mjjAuXmu9/dh
        6CnD4VSummcQwwCI=; b=Ya+vjcJtXItCFpr45KLzkeaU+9IEOl4dqQIscZkT2BN
        IOeCP3LYrQMCJKAIWx8oW5VBQ7v1lvsgK1fnQiGuWiBzGXKeQUqQciq4VVN6DYfi
        56XEvCmQzECasKhXPbSl81WFItw0MDq5e3n3y12FlFxfqxDn7PrTqX4Kh8qnZJTz
        I3xxYrU+lJzo6TpVfOaQhpMasLmbJ+EDJNYCpcSdfFM42wkSMCFUXZU95QUWWdbA
        JZ76S4ZkA8+d/k3fJpTW9wAig3OHSwnVtbcQ9nUwbHmWy6OAYPt/vHmTkAZw9GKF
        t+860evOWu8dTk5Ev3sXra3I8zmpD/OTM6UgcVskbLA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4LAsxi-vdODt for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jul 2023 16:57:23 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R8YvR182NzBKnld;
        Mon, 24 Jul 2023 16:57:23 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 24 Jul 2023 16:57:23 +0800
From:   sunran001@208suo.com
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/pm: Clean up errors in smu_v13_0_1_pmfw.h
In-Reply-To: <20230724083344.9285-1-xujianghui@cdjrlc.com>
References: <20230724083344.9285-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <7e638628f942fe7989fe2da3da537c28@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following errors reported by checkpatch:

ERROR: trailing whitespace

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_1_pmfw.h | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_1_pmfw.h 
b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_1_pmfw.h
index c5e26d619bf0..8ec588248aac 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_1_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_1_pmfw.h
@@ -30,7 +30,7 @@

  #define ENABLE_DEBUG_FEATURES

-// Firmware features
+// Firmware features
  // Feature Control Defines
  #define FEATURE_CCLK_DPM_BIT                 0
  #define FEATURE_FAN_CONTROLLER_BIT           1
@@ -92,7 +92,7 @@
  #define FEATURE_ZSTATES_ECO_BIT             57
  #define FEATURE_CC6_BIT                     58
  #define FEATURE_DS_UMCCLK_BIT               59
-#define FEATURE_DS_HSPCLK_BIT               60
+#define FEATURE_DS_HSPCLK_BIT               60
  #define NUM_FEATURES                        61

  typedef struct {
