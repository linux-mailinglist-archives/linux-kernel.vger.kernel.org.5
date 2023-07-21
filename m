Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A6875BCC7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 05:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjGUD11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 23:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjGUD1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 23:27:25 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C083C272C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 20:27:22 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R6Zjy5p3XzBRDtB
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 11:27:18 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689910038; x=1692502039; bh=GFS1RVSDskw7M+0vgWeM0LHygVB
        jO70fllpv2LJSd1k=; b=yXTCfkw3FIFTiJtmRfrphb0qpChmyyT/UXr6szwaRcb
        WVS+Q8RHbxpbJekhbcZ1KN6CQWuxSsgnSC2b7EqNgAQH3SxMKHkbj6fX1jChqBJu
        pdQfshkyvOqhGCSAeW2LMgOnwG+dLrx751wIAtkrCAdF7Ta5d7Z6IVgUnp4/MK+2
        Ssxb0citSIEOjRE/2wDu23VOF3aLIX5COjb/C8I5SAJOIzhcynSV5hJmvlyVMg+8
        mJmCu/+lhQ+vlnbo8ZkAqtO88E+WjTqKkpXz+LCEXDO1hqz9Bc2geYo2bnvrD9OV
        zK1gYQUKgUr1hXs5EIjU1CQPLKA4F3UqJywU0uO1ckA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ktf03sXYHmYt for <linux-kernel@vger.kernel.org>;
        Fri, 21 Jul 2023 11:27:18 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R6Zjy2tzYzBRDrd;
        Fri, 21 Jul 2023 11:27:18 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 21 Jul 2023 11:27:18 +0800
From:   sunran001@208suo.com
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/pm: open brace '{' following struct go on the same
 line
In-Reply-To: <20230721032537.4727-1-xujianghui@cdjrlc.com>
References: <20230721032537.4727-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <9bb658b64109e1e60afdf82906ae3e03@208suo.com>
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
  .../gpu/drm/amd/pm/inc/smu_v13_0_0_pptable.h  | 21 +++++++------------
  1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_0_pptable.h 
b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_0_pptable.h
index 1dc7a065a6d4..251ed011b3b0 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_0_pptable.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_0_pptable.h
@@ -41,8 +41,7 @@
  #define SMU_13_0_0_PP_OVERDRIVE_VERSION 0x83        // OverDrive 8 
Table Version 0.2
  #define SMU_13_0_0_PP_POWERSAVINGCLOCK_VERSION 0x01 // Power Saving 
Clock Table Version 1.00

-enum SMU_13_0_0_ODFEATURE_CAP
-{
+enum SMU_13_0_0_ODFEATURE_CAP {
      SMU_13_0_0_ODCAP_GFXCLK_LIMITS = 0,
      SMU_13_0_0_ODCAP_UCLK_LIMITS,
      SMU_13_0_0_ODCAP_POWER_LIMIT,
@@ -62,8 +61,7 @@ enum SMU_13_0_0_ODFEATURE_CAP
      SMU_13_0_0_ODCAP_COUNT,
  };

-enum SMU_13_0_0_ODFEATURE_ID
-{
+enum SMU_13_0_0_ODFEATURE_ID {
      SMU_13_0_0_ODFEATURE_GFXCLK_LIMITS           = 1 << 
SMU_13_0_0_ODCAP_GFXCLK_LIMITS,           //GFXCLK Limit feature
      SMU_13_0_0_ODFEATURE_UCLK_LIMITS             = 1 << 
SMU_13_0_0_ODCAP_UCLK_LIMITS,             //UCLK Limit feature
      SMU_13_0_0_ODFEATURE_POWER_LIMIT             = 1 << 
SMU_13_0_0_ODCAP_POWER_LIMIT,             //Power Limit feature
@@ -85,8 +83,7 @@ enum SMU_13_0_0_ODFEATURE_ID

  #define SMU_13_0_0_MAX_ODFEATURE 32 //Maximum Number of OD Features

-enum SMU_13_0_0_ODSETTING_ID
-{
+enum SMU_13_0_0_ODSETTING_ID {
      SMU_13_0_0_ODSETTING_GFXCLKFMAX = 0,
      SMU_13_0_0_ODSETTING_GFXCLKFMIN,
      SMU_13_0_0_ODSETTING_UCLKFMIN,
@@ -123,8 +120,7 @@ enum SMU_13_0_0_ODSETTING_ID
  };
  #define SMU_13_0_0_MAX_ODSETTING 64 //Maximum Number of ODSettings

-enum SMU_13_0_0_PWRMODE_SETTING
-{
+enum SMU_13_0_0_PWRMODE_SETTING {
      SMU_13_0_0_PMSETTING_POWER_LIMIT_QUIET = 0,
      SMU_13_0_0_PMSETTING_POWER_LIMIT_BALANCE,
      SMU_13_0_0_PMSETTING_POWER_LIMIT_TURBO,
@@ -144,8 +140,7 @@ enum SMU_13_0_0_PWRMODE_SETTING
  };
  #define SMU_13_0_0_MAX_PMSETTING 32 //Maximum Number of PowerMode 
Settings

-struct smu_13_0_0_overdrive_table
-{
+struct smu_13_0_0_overdrive_table {
      uint8_t revision;                             //Revision = 
SMU_13_0_0_PP_OVERDRIVE_VERSION
      uint8_t reserve[3];                           //Zero filled field 
reserved for future use
      uint32_t feature_count;                       //Total number of 
supported features
@@ -156,8 +151,7 @@ struct smu_13_0_0_overdrive_table
      int16_t pm_setting[SMU_13_0_0_MAX_PMSETTING]; //Optimized power 
mode feature settings
  };

-enum SMU_13_0_0_PPCLOCK_ID
-{
+enum SMU_13_0_0_PPCLOCK_ID {
      SMU_13_0_0_PPCLOCK_GFXCLK = 0,
      SMU_13_0_0_PPCLOCK_SOCCLK,
      SMU_13_0_0_PPCLOCK_UCLK,
@@ -175,8 +169,7 @@ enum SMU_13_0_0_PPCLOCK_ID
  };
  #define SMU_13_0_0_MAX_PPCLOCK 16 //Maximum Number of PP Clocks

-struct smu_13_0_0_powerplay_table
-{
+struct smu_13_0_0_powerplay_table {
      struct atom_common_table_header header; //For SMU13, 
header.format_revision = 15, header.content_revision = 0
      uint8_t table_revision;                 //For SMU13, table_revision 
= 2
      uint8_t padding;
