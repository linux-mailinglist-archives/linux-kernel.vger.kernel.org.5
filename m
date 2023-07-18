Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2653D757802
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjGRJ2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjGRJ2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:28:33 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631D710C2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:28:27 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4tsz4Qs2zBR1P3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 17:28:23 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689672503; x=1692264504; bh=hAS+grwZbIyw2t0g0PBTUpkLyXc
        bK0qGakiu0DaoB3c=; b=FfPFpEqKrEKyiCQ9RAqBWlLjwXKzjMx7fzDngsHIZ+F
        XRSjxeqcXxcSOk5rteA4BIQrD5zgFn4DMV1G/1tqOKnJ58eFuVucXOhuy2sKIT2p
        Pv5tjf9WAzr+YZQF3bzRPVHc1QHUszlNayE2rBo3y8kmzW5TiyP+SUIExbvhVCWl
        PYmHF+67YktZWq0u1UY5aky71qgwLfsoHMDEStBZZCfhbKb2oDCgHvNUWIu8FVAu
        xRKwy2n549DbElboGJJO9yu+qMvCov36YCe22ErfHAm2PbM/5HVcojDwECCc3NRC
        h3Nm/jNnGRZnXE0q9goSnaTLEIQmyNCYmFZvvy40wuA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9JoDkwa1HKYv for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 17:28:23 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4tsz21h1zBJBfd;
        Tue, 18 Jul 2023 17:28:23 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 17:28:23 +0800
From:   hanyu001@208suo.com
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: platforms: chrp: Add require space after that ','
In-Reply-To: <tencent_541AA1B260FC8E0892D6A696F01C5600AD05@qq.com>
References: <tencent_541AA1B260FC8E0892D6A696F01C5600AD05@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <8e586ffecc673079ad58045ddc6e3ea6@208suo.com>
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

Fixes checkpatch errors:

./arch/powerpc/platforms/chrp/time.c:109: ERROR: space required after 
that ',' (ctx:VxV)
./arch/powerpc/platforms/chrp/time.c:110: ERROR: space required after 
that ',' (ctx:VxV)
./arch/powerpc/platforms/chrp/time.c:111: ERROR: space required after 
that ',' (ctx:VxV)
./arch/powerpc/platforms/chrp/time.c:112: ERROR: space required after 
that ',' (ctx:VxV)
./arch/powerpc/platforms/chrp/time.c:113: ERROR: space required after 
that ',' (ctx:VxV)
./arch/powerpc/platforms/chrp/time.c:114: ERROR: space required after 
that ',' (ctx:VxV)

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  arch/powerpc/platforms/chrp/time.c | 12 ++++++------
  1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/chrp/time.c 
b/arch/powerpc/platforms/chrp/time.c
index d46417e3d8e0..6bd40be22c33 100644
--- a/arch/powerpc/platforms/chrp/time.c
+++ b/arch/powerpc/platforms/chrp/time.c
@@ -106,12 +106,12 @@ int chrp_set_rtc_time(struct rtc_time *tmarg)
          tm.tm_mday = bin2bcd(tm.tm_mday);
          tm.tm_year = bin2bcd(tm.tm_year);
      }
-    chrp_cmos_clock_write(tm.tm_sec,RTC_SECONDS);
-    chrp_cmos_clock_write(tm.tm_min,RTC_MINUTES);
-    chrp_cmos_clock_write(tm.tm_hour,RTC_HOURS);
-    chrp_cmos_clock_write(tm.tm_mon,RTC_MONTH);
-    chrp_cmos_clock_write(tm.tm_mday,RTC_DAY_OF_MONTH);
-    chrp_cmos_clock_write(tm.tm_year,RTC_YEAR);
+    chrp_cmos_clock_write(tm.tm_sec, RTC_SECONDS);
+    chrp_cmos_clock_write(tm.tm_min, RTC_MINUTES);
+    chrp_cmos_clock_write(tm.tm_hour, RTC_HOURS);
+    chrp_cmos_clock_write(tm.tm_mon, RTC_MONTH);
+    chrp_cmos_clock_write(tm.tm_mday, RTC_DAY_OF_MONTH);
+    chrp_cmos_clock_write(tm.tm_year, RTC_YEAR);

      /* The following flags have to be released exactly in this order,
       * otherwise the DS12887 (popular MC146818A clone with integrated
