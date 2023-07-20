Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BD975A4AA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 05:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjGTDOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 23:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjGTDOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 23:14:12 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F041A1BFC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 20:14:11 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R5yTD43QCzBRDs0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:14:08 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689822848; x=1692414849; bh=DRHauRo+7WKP7Polxn7tiISl8C9
        yARAZh5b+LzQT6j0=; b=HxPqYSWkVQx7g2r9GCop22zuIE11ZZ59PsdoOr29O8W
        OHZhKZ34fsJbrV4NtNcaC73fQkk5+lY5hhklcDl+aAyxxxcaomlrmBArGw5VeqtL
        AP/CNoiQ3axDS8ndqZVrXA+fGMZ9M8WgwxOgfaV4XC6KGpkKl0VJPwP6JCjjWydJ
        fyqWbNc/0ijQZ0LiqdFpNZgHEqUxO7gJUH09nC23YhZF8klwF/+C6Fsz8+a+SMbo
        8FBDgA70osIpWwj39rh0ongJCi5zAzOMe6onXM+oLHIN+3dr47jPx5KEft2hlJPL
        hfKeBF1ZdFBb8pzDeAcnIUxvjJkpYF2pRy/ZNdGZSYw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4rqnxsHeFyHc for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 11:14:08 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R5yTD20yRzBR1P6;
        Thu, 20 Jul 2023 11:14:08 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 11:14:08 +0800
From:   sunran001@208suo.com
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] synclink_gt: add missing spaces after ','
In-Reply-To: <20230720031306.1618-1-xujianghui@cdjrlc.com>
References: <20230720031306.1618-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <12a55af5478fd079690f11f6871e986f@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing spaces to clear checkpatch errors.

ERROR: space required after that ',' (ctx:VxV)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  include/linux/synclink.h | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/synclink.h b/include/linux/synclink.h
index f1405b1c71ba..a1d4b9ed4342 100644
--- a/include/linux/synclink.h
+++ b/include/linux/synclink.h
@@ -31,7 +31,7 @@ struct MGSL_PARAMS32 {
  	unsigned char	stop_bits;
  	unsigned char	parity;
  };
-#define MGSL_IOCSPARAMS32 _IOW(MGSL_MAGIC_IOC,0,struct MGSL_PARAMS32)
-#define MGSL_IOCGPARAMS32 _IOR(MGSL_MAGIC_IOC,1,struct MGSL_PARAMS32)
+#define MGSL_IOCSPARAMS32 _IOW(MGSL_MAGIC_IOC, 0, struct MGSL_PARAMS32)
+#define MGSL_IOCGPARAMS32 _IOR(MGSL_MAGIC_IOC, 1, struct MGSL_PARAMS32)
  #endif
  #endif /* _SYNCLINK_H_ */
