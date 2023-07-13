Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E203A7518AA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 08:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbjGMGOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 02:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbjGMGN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 02:13:59 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CCF1992
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:13:56 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1knq6RCrzBJDhy
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 14:13:51 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689228831; x=1691820832; bh=nuqJ9pLuZuj+LOYyeUAtEV8eCHK
        xQiR4Si7qnX2+uNY=; b=GsZT9rGUJKRIH6/iu0UD4beHaxpn7Bg5cn9JXo57nuI
        nIdQEAvflBaKcwEpqtUUKCpK8AL7lnaMXPfv8/Y3Nn2rlv/b1EYXjkk1Mou9O1Og
        DUZlp1+r6t+YRmchEblGh9mwZ1ugUk2RuYnYYzOmNsziEyV3yZ3rNqmwKTXT+6Rw
        hpl+3Q7yhvgnZNN9i4eyB9xxdgCWxdRD+ZsMi13kqjUL7VcN7W1vQJMJKCjl7Ads
        +ABoy7i5YGSyDBniGH6TqPiB22mOdTvJMxwdKGWHDJVb0JqZZXZaouFb0j4pE5lp
        O0gpiCQ907luvlsooqXxmn34lMVo3Bub36FRTIO+fjw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Hlz3HVKQdJAH for <linux-kernel@vger.kernel.org>;
        Thu, 13 Jul 2023 14:13:51 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1knq4rCPzBJBfn;
        Thu, 13 Jul 2023 14:13:51 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 13 Jul 2023 14:13:51 +0800
From:   hanyu001@208suo.com
To:     geert@linux-m68k.org
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Fwd: [PATCH] m68k: q40: Add space around '='
In-Reply-To: <tencent_2AC782146D133A82E7D99024161D14AD4209@qq.com>
References: <tencent_2AC782146D133A82E7D99024161D14AD4209@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <b29994cca39551c7c3827a733e7c1246@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



This patch fixes the checkpatch.pl error:

./arch/m68k/q40/q40ints.c:135: ERROR: spaces required around that '=' 
(ctx:VxV)
./arch/m68k/q40/q40ints.c:137: ERROR: spaces required around that '=' 
(ctx:VxV)
./arch/m68k/q40/q40ints.c:138: ERROR: spaces required around that '=' 
(ctx:VxV)

Signed-off-by: maqimei <2433033762@qq.com>
---
  arch/m68k/q40/q40ints.c | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/q40/q40ints.c b/arch/m68k/q40/q40ints.c
index 127d7ec..bede94a 100644
--- a/arch/m68k/q40/q40ints.c
+++ b/arch/m68k/q40/q40ints.c
@@ -132,10 +132,10 @@ static irqreturn_t q40_timer_int(int irq, void 
*dev_id)
  {
      ql_ticks = ql_ticks ? 0 : 1;
      if (sound_ticks) {
-        unsigned char sval=(sound_ticks & 1) ? 128-SVOL : 128+SVOL;
+        unsigned char sval = (sound_ticks & 1) ? 128-SVOL : 128+SVOL;
          sound_ticks--;
-        *DAC_LEFT=sval;
-        *DAC_RIGHT=sval;
+        *DAC_LEFT = sval;
+        *DAC_RIGHT = sval;
      }

      if (!ql_ticks) {
