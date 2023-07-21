Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EEE75BD00
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 05:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjGUDxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 23:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGUDxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 23:53:33 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D751BC1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 20:53:31 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R6bJ82wBLzBRDtD
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 11:53:28 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689911608; x=1692503609; bh=EV1nMV2DEsYn3s4L7x/locP5eq+
        nsZH2TFRR4al9MOI=; b=P3hINwebdkVqLqRSRAURbCkxh+oG5TAgzlmV28pB8vx
        Ow99HynbMP32Ksri8TbAYYIacXwE2LQSETplBvAF+RdhIkJWxU4p8f7nL2LzLVCE
        svKWSjCoiQHug48PKTwSMDWTuxahbJhepMh37Dsyerjy+JO9xr8SaHkG1dXHNREv
        piGZJC9tOSVgszsGgxPII8wgH+vG92C2zRWzmJJ1b09MyokSzMZlBf9C53kucnBf
        YGmjV6hZ5Vlt1KZOx9GML11NDlb9GyhTwN5XnNscztrFRaNfELkhApXDZ+SWVZob
        HblGDIV/DgUKVvM5YZJlndmWBHeRiorF7uMOk5wTgBw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uLn5vkOH2r_r for <linux-kernel@vger.kernel.org>;
        Fri, 21 Jul 2023 11:53:28 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R6bJ80fkQzBHXhJ;
        Fri, 21 Jul 2023 11:53:28 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 21 Jul 2023 11:53:28 +0800
From:   sunran001@208suo.com
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/pm: open brace '{' following struct go on the same
 line
In-Reply-To: <20230721035225.4986-1-xujianghui@cdjrlc.com>
References: <20230721035225.4986-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <f2e8d7241330934429e19a960a232f9c@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ERROR: open brace '{' following struct go on the same line

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h | 8 ++++----
  1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h 
b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index ddc488251313..0cf564ea1ed8 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -429,10 +429,10 @@ int amdgpu_pm_load_smu_firmware(struct 
amdgpu_device *adev, uint32_t *smu_versio
  int amdgpu_dpm_handle_passthrough_sbr(struct amdgpu_device *adev, bool 
enable);
  int amdgpu_dpm_send_hbm_bad_pages_num(struct amdgpu_device *adev, 
uint32_t size);
  int amdgpu_dpm_send_hbm_bad_channel_flag(struct amdgpu_device *adev, 
uint32_t size);
-int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev,enum 
pp_clock_type type,
-				  uint32_t *min,uint32_t *max);
-int amdgpu_dpm_set_soft_freq_range(struct amdgpu_device *adev,enum 
pp_clock_type type,
-				   uint32_t min,uint32_t max);
+int amdgpu_dpm_get_dpm_freq_range(struct amdgpu_device *adev, enum 
pp_clock_type type,
+				  uint32_t *min, uint32_t *max);
+int amdgpu_dpm_set_soft_freq_range(struct amdgpu_device *adev, enum 
pp_clock_type type,
+				   uint32_t min, uint32_t max);
  int amdgpu_dpm_write_watermarks_table(struct amdgpu_device *adev);
  int amdgpu_dpm_wait_for_event(struct amdgpu_device *adev, enum 
smu_event_type event,
  		       	      uint64_t event_arg);
