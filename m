Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE61B7531B1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbjGNGCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbjGNGCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:02:37 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488E62D45
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 23:02:33 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2LVH0t1GzBR9tH
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 14:02:31 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689314551; x=1691906552; bh=BOqlYj16pxE1yFsKTH0Iq6Rg1ib
        Vab+e8hUqx1RutTQ=; b=x9pef2K4q5pMOJdv4cx9C/i2ZIq5p8xRMN1CBivzNVd
        xB/4mr+fknYyV5cSlasf1w8dCuhMnCGfTAiNIbabR/hnxX/VhnjAAcwWnxkLP8ef
        fs/OuXDkg5ISLDkIz8NdPVn9IN1iuvDML09urRZYADRABXZNAlhhKiNy9Ki9Djit
        Ci/ngjfo1NvgVRjAwCX0WIcK7S47HBxj61omfglXmZ4lXZ5FdN5m6PIjl/sdQQpU
        /WZGSuzvI20GnWwIIa2C+M7AXDF3ylgiIvPMzMBkAWeFJKVHP67fDm2Ie3FGm7Vv
        yXn8LjV8HwZDxPtoYtlOen1Rpf3o7OmzV5/GWNByQdw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LGmY4iK7FgDY for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 14:02:31 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2LVG5M24zBR9t9;
        Fri, 14 Jul 2023 14:02:30 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 14:02:30 +0800
From:   hanyu001@208suo.com
To:     bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: edac: add missing spaces after ','
In-Reply-To: <tencent_58287290BBAD4107FE7C2992CB229A625106@qq.com>
References: <tencent_58287290BBAD4107FE7C2992CB229A625106@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <1793c783600cfd750100cfad8c47cfea@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch.pl error

./drivers/edac/edac_device_sysfs.c:114: ERROR: space required after that 
',' (ctx:VxV)
./drivers/edac/edac_device_sysfs.c:114: ERROR: space required after that 
',' (ctx:VxV)
./drivers/edac/edac_device_sysfs.c:147: ERROR: space required after that 
',' (ctx:VxV)
./drivers/edac/edac_device_sysfs.c:147: ERROR: space required after that 
',' (ctx:VxV)
./drivers/edac/edac_device_sysfs.c:147: ERROR: space required after that 
',' (ctx:VxV)

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/edac/edac_device_sysfs.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/edac_device_sysfs.c 
b/drivers/edac/edac_device_sysfs.c
index 05d4353..f6d42bc 100644
--- a/drivers/edac/edac_device_sysfs.c
+++ b/drivers/edac/edac_device_sysfs.c
@@ -111,7 +111,7 @@ struct ctl_info_attribute {
  };

  #define to_ctl_info(k) container_of(k, struct edac_device_ctl_info, 
kobj)
-#define to_ctl_info_attr(a) container_of(a,struct 
ctl_info_attribute,attr)
+#define to_ctl_info_attr(a) container_of(a, struct ctl_info_attribute, 
attr)

  /* Function to 'show' fields from the edac_dev 'ctl_info' structure */
  static ssize_t edac_dev_ctl_info_show(struct kobject *kobj,
@@ -144,7 +144,7 @@ static ssize_t edac_dev_ctl_info_store(struct 
kobject *kobj,
      .store = edac_dev_ctl_info_store
  };

-#define CTL_INFO_ATTR(_name,_mode,_show,_store)        \
+#define CTL_INFO_ATTR(_name, _mode, _show, _store)        \
  static struct ctl_info_attribute attr_ctl_info_##_name = {      \
      .attr = {.name = __stringify(_name), .mode = _mode },   \
      .show   = _show,                                        \
