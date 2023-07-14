Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BD6753032
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbjGNDxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234920AbjGNDxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:53:37 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38BB2D79
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:53:24 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2HdD4tjTzBRSVj
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 11:53:20 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689306800; x=1691898801; bh=H7Hb8eUO+kbWVHQppS8k4ZwpO67
        +dUJb9HgXomBv17g=; b=OKBRLz93NvnK/HMQrs9SRiM4YwwG72eR+vXj/WQXmtZ
        g+0OOPP3XKahriNdb7BBHhRNZvrK1EoT53aMDWTY8jHVZu1lcHFAMNo8AecAswHG
        MIOpijx7LlxaG+BK11pWcZOiN5laImOlWzfXyGiQyrsGxQZyvdCFADmm7Z9oOiNA
        yNvQ6Ye6B9vIcXsKksqGdhYNU9VaJeN17lWaYJ8Jbv0nYO+8stlLyyDIFCIITS9f
        QEyDfLArGSNzBFtj8yVuP47UH1/H9NuDXSOcRPJCp1NulGcbVem0tobbGUd5ut3e
        fcYS7OFgCzREUodkwjYHcoTvmsmCXOrBsF1TD9FLAGw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iKgyTRh4_9es for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 11:53:20 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2HdD21wDzBJk54;
        Fri, 14 Jul 2023 11:53:20 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 11:53:20 +0800
From:   hanyu001@208suo.com
To:     bp@alien8.de, tony.luck@intel.com, james.morse@arm.com,
        mchehab@kernel.org, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: edac: add missing spaces after ','
In-Reply-To: <tencent_9292C0A2AD2275684250A6AD5447F83C1706@qq.com>
References: <tencent_9292C0A2AD2275684250A6AD5447F83C1706@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <89259619b487552623c8ab80c143e550@208suo.com>
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

drivers/edac/edac_device_sysfs.c:322: ERROR: space required after that 
',' (ctx:VxV)
drivers/edac/edac_device_sysfs.c:322: ERROR: space required after that 
',' (ctx:VxV)

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/edac/edac_device_sysfs.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/edac_device_sysfs.c 
b/drivers/edac/edac_device_sysfs.c
index 95e4249..05d4353 100644
--- a/drivers/edac/edac_device_sysfs.c
+++ b/drivers/edac/edac_device_sysfs.c
@@ -319,7 +319,7 @@ static ssize_t instance_ce_count_show(struct 
edac_device_instance *instance,
  }

  #define to_instance(k) container_of(k, struct edac_device_instance, 
kobj)
-#define to_instance_attr(a) container_of(a,struct 
instance_attribute,attr)
+#define to_instance_attr(a) container_of(a, struct instance_attribute, 
attr)

  /* DEVICE instance kobject release() function */
  static void edac_device_ctrl_instance_release(struct kobject *kobj)
