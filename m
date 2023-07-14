Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AFC753011
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234879AbjGNDkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbjGNDkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:40:04 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B37330CB
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:39:59 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2HKn30GbzBRSVM
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 11:39:57 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689305997; x=1691897998; bh=AWHTAkZRkjR1ieZ+VfDcALBX0gH
        03nLgnO5QP0evr1o=; b=wZgyKLkYA3Sgz7+jQOBoNarATB82iFT3I3KC96eSqVq
        34SZT4c0k05+jRVHBSmh4flTgnLmIHM+RVde8L+oee2erdWHIlUug6oeI4DujN7a
        qvMdppR9rj3lL/j4HcSVpAkDCtv+m47taxY5YM//aHUofAEqKsyoy0oiy+CFob4h
        xLBXKjN8JVlThQwY4TWrrQxc2HkIhn3y0snZvq7M+hbJH5eQGKWqceI3zL2uSvQo
        iAlaoX0uQU+hdTgbqW2ViL+LF6Gm9PjG7JDJZTCiPxyeVZkfOEizdUDkuLrZO/5I
        3zkeH655e4raUQQi8fp6lZzId61fgL4EBU3bEFJVQCQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id H5HGTyNtVges for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 11:39:57 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2HKm6ql1zBHXhN;
        Fri, 14 Jul 2023 11:39:56 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 11:39:56 +0800
From:   hanyu001@208suo.com
To:     bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: edac: add missing spaces after ','
In-Reply-To: <tencent_3DB677F4CD0F222D2C0E29A2858205A5D80A@qq.com>
References: <tencent_3DB677F4CD0F222D2C0E29A2858205A5D80A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <12fb0185376456c91666476e9949c54f@208suo.com>
X-Sender: hanyu001@208suo.com
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

Fixes checkpatch.pl error:

drivers/edac/edac_device_sysfs.c:480: ERROR: space required after that 
',' (ctx:VxV)
drivers/edac/edac_device_sysfs.c:480: ERROR: space required after that 
',' (ctx:VxV)
drivers/edac/edac_device_sysfs.c:480: ERROR: space required after that 
',' (ctx:VxV)

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/edac/edac_device_sysfs.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/edac_device_sysfs.c 
b/drivers/edac/edac_device_sysfs.c
index 010c26b..95e4249 100644
--- a/drivers/edac/edac_device_sysfs.c
+++ b/drivers/edac/edac_device_sysfs.c
@@ -477,7 +477,7 @@ static ssize_t edac_dev_block_store(struct kobject 
*kobj,
      .store = edac_dev_block_store
  };

-#define BLOCK_ATTR(_name,_mode,_show,_store)        \
+#define BLOCK_ATTR(_name, _mode, _show, _store)        \
  static struct edac_dev_sysfs_block_attribute attr_block_##_name = {    
\
      .attr = {.name = __stringify(_name), .mode = _mode },   \
      .show   = _show,                                        \
