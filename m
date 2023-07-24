Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E337F75EC86
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjGXH3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjGXH3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:29:42 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11F2186
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 00:29:39 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R8Wy81hM9zBRx5B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 15:29:36 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1690183776; x=1692775777; bh=bZxSJWL9gZxd3WjJGHW8DK8u/U3
        6n7xiHmXhkTl1aFY=; b=O8EsWJ9l91SgOoq9KBTYlK1s9g3UoKPqyiKS4HM2Rv4
        DWofj04WUFpj/76O4E8smi/ou+ZeNeKBv11YWE1cYrQsCdlgcmK/l/Z4cRvCEEVu
        8+mh0LopektOMRigWAVKfAqIHRr1levUQmEq8L2pkyK3ERyFke/7/8xu7KF2LlRt
        jWwBUdMxQZf+irjwBUb7iolLxBeAzcf/EOE/p9rzfiZE/7FSL1rYnng3cvT11OWL
        vJOXrT+o633EsKNogWm15QNi5S4kt4qK/cV1LYHHipVNnk97pr0rF14AZ88SC4bl
        PEctlXF4NXrTPuicLRsOiL2Bs1CHOc80t49P/iMzY9g==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Gqbmf__Jyf0J for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jul 2023 15:29:36 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R8Wy76SW0zBRx4g;
        Mon, 24 Jul 2023 15:29:35 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 24 Jul 2023 15:29:35 +0800
From:   sunran001@208suo.com
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/pm: Clean up errors in sienna_cichlid_ppt.c
In-Reply-To: <20230724072835.8913-1-xujianghui@cdjrlc.com>
References: <20230724072835.8913-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <ea1cf43d5545fa917127694a294a57da@208suo.com>
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

ERROR: space required after that ',' (ctx:VxV)
ERROR: space required before the open parenthesis '('
ERROR: spaces required around that '=' (ctx:VxW)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  .../drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c  | 16 ++++++++--------
  1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c 
b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 0cda3b276f61..5c233eda09ee 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -78,7 +78,7 @@
  		(*member) = (smu->smu_table.driver_pptable + 
offsetof(PPTable_beige_goby_t, field));\
  	else\
  		(*member) = (smu->smu_table.driver_pptable + offsetof(PPTable_t, 
field));\
-} while(0)
+} while (0)

  /* STB FIFO depth is in 64bit units */
  #define SIENNA_CICHLID_STB_DEPTH_UNIT_BYTES 8
@@ -590,7 +590,7 @@ static int sienna_cichlid_tables_init(struct 
smu_context *smu)

  static uint32_t sienna_cichlid_get_throttler_status_locked(struct 
smu_context *smu)
  {
-	struct smu_table_context *smu_table= &smu->smu_table;
+	struct smu_table_context *smu_tabl = &smu->smu_table;
  	SmuMetricsExternal_t *metrics_ext =
  		(SmuMetricsExternal_t *)(smu_table->metrics_table);
  	uint32_t throttler_status = 0;
@@ -711,7 +711,7 @@ static int 
sienna_cichlid_get_smu_metrics_data(struct smu_context *smu,
  					       MetricsMember_t member,
  					       uint32_t *value)
  {
-	struct smu_table_context *smu_table= &smu->smu_table;
+	struct smu_table_context *smu_table = &smu->smu_table;
  	SmuMetrics_t *metrics =
  		&(((SmuMetricsExternal_t *)(smu_table->metrics_table))->SmuMetrics);
  	SmuMetrics_V2_t *metrics_v2 =
@@ -1461,7 +1461,7 @@ static int sienna_cichlid_force_clk_levels(struct 
smu_context *smu,
  			goto forec_level_out;
  		break;
  	case SMU_DCEFCLK:
-		dev_info(smu->adev->dev,"Setting DCEFCLK min/max dpm level is not 
supported!\n");
+		dev_info(smu->adev->dev, "Setting DCEFCLK min/max dpm level is not 
supported!\n");
  		break;
  	default:
  		break;
@@ -1881,7 +1881,7 @@ static int sienna_cichlid_read_sensor(struct 
smu_context *smu,
  	uint16_t *temp;
  	struct amdgpu_device *adev = smu->adev;

-	if(!data || !size)
+	if (!data || !size)
  		return -EINVAL;

  	switch (sensor) {
@@ -2067,15 +2067,15 @@ static int 
sienna_cichlid_display_disable_memory_clock_switch(struct smu_context
  	uint32_t min_memory_clock = smu->hard_min_uclk_req_from_dal;
  	uint32_t max_memory_clock = max_sustainable_clocks->uclock;

-	if(smu->disable_uclk_switch == disable_memory_clock_switch)
+	if (smu->disable_uclk_switch == disable_memory_clock_switch)
  		return 0;

-	if(disable_memory_clock_switch)
+	if (disable_memory_clock_switch)
  		ret = smu_v11_0_set_hard_freq_limited_range(smu, SMU_UCLK, 
max_memory_clock, 0);
  	else
  		ret = smu_v11_0_set_hard_freq_limited_range(smu, SMU_UCLK, 
min_memory_clock, 0);

-	if(!ret)
+	if (!ret)
  		smu->disable_uclk_switch = disable_memory_clock_switch;

  	return ret;
