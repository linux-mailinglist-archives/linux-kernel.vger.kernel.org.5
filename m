Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C84E75EE1F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjGXIpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbjGXIow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:44:52 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E69184
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:44:32 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R8Yc25Bq7zBRx5N
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 16:44:02 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1690188242; x=1692780243; bh=GSjQh+24fDmg268C3FAmWe759o+
        e7JqjQBA0Ouu1xsQ=; b=LOuLu5N3qJAUG+I53obzAL1Noiw+URzi25qlxflJmnM
        xwlZwQp4s13ZM5OGa+A1C5SWe0hG7pqJ9r/3gEgBsvtMkjFJtjiB2e46RoVNChTw
        GyHyria8Xz/yYLYExUiDzvw8TFt2lT9miSDretauoyUdJsV2fcdpaDKQIg1beqhv
        v9CFV8pwzsW2F0d5QCeTiBgtkbtzOz6lyjnh/a4zTu/OM070b8Ok6tLCdf0J9R0W
        WUrojCGYlhSSmPgyXhWWOEIKNg5RZRF4FmFXy7hmFEv2SCiUuIryheAznOE5dCWS
        io2+XHCDyy+vnQG8w4NP+CFx0kSbMBACfxvcW9OGezQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RhTae7fa2xP3 for <linux-kernel@vger.kernel.org>;
        Mon, 24 Jul 2023 16:44:02 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R8Yc23Y15zB7Bvn;
        Mon, 24 Jul 2023 16:44:02 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 24 Jul 2023 16:44:02 +0800
From:   sunran001@208suo.com
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/pm: open brace '{' following function definitions go
 on the next line
In-Reply-To: <be6d6605aa504964eba3476910f7140a@208suo.com>
References: <20230724071121.8710-1-xujianghui@cdjrlc.com>
 <be6d6605aa504964eba3476910f7140a@208suo.com>
User-Agent: Roundcube Webmail
Message-ID: <a026386d6759911afbb1446a9145bdec@208suo.com>
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

ERROR: open brace '{' following function definitions go on the next line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c 
b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
index c788aa7a99a9..5e408a195860 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
@@ -205,7 +205,8 @@ int smu_v12_0_set_default_dpm_tables(struct 
smu_context *smu)
  	return smu_cmn_update_table(smu, SMU_TABLE_DPMCLOCKS, 0, 
smu_table->clocks_table, false);
  }

-int smu_v12_0_mode2_reset(struct smu_context *smu){
+int smu_v12_0_mode2_reset(struct smu_context *smu)
+{
  	return smu_cmn_send_smc_msg_with_param(smu, 
SMU_MSG_GfxDeviceDriverReset, SMU_RESET_MODE_2, NULL);
  }
