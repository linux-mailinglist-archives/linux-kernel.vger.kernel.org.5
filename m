Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D3C757708
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 10:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjGRItG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 04:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjGRItD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 04:49:03 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40895103
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 01:49:01 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4t0V710WzBR9sm
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 16:48:58 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689670138; x=1692262139; bh=ZmsCnoE/TNdGMu1ZrbDsT2jx8Zy
        AM7rGQ51xY8N+IW8=; b=uytp9GPa4Ej/t60Q3jfDErwfevA2JTIe9cwO1jYyrIP
        e0AieGGtZnaGAp6E/2WzxtMPrMkTqn5TaZoK/2K1xBMVuyQ9TxtE9itRx5cKX/Cx
        fDAbOaJBdCIl4RciTflzRRjn+5WXOPT6N9DNqA3AwV9wuJHGEGffmWIKGRlTWEM3
        6TchjS/BrCNVV+rU0s6lmpQfDm4lyTC9b5d0cBxHUB18QitcFzvTSdB+S1PeCew5
        mY9BlPBqI3HFNpg1bGPucHV7j7uG25TemC3zGVLm0epnAmjw3CoB/B5sZ6S4UmtR
        DxKE5ubi9IpBB1Wtr+AyYKemtYpHyeCKTM5MgMKqs4A==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id osVmW8PvO3XR for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 16:48:58 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4t0V4y0rzBR7bp;
        Tue, 18 Jul 2023 16:48:58 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 16:48:58 +0800
From:   sunran001@208suo.com
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH] writeback: add missing spaces after ','
In-Reply-To: <20230718084743.17293-1-xujianghui@cdjrlc.com>
References: <20230718084743.17293-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <87543d97fbdac210ccf3ba75eb9ce9fc@208suo.com>
X-Sender: sunran001@208suo.com
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

Remove spaces to clear checkpatch errors.

ERROR: space required after that ',' (ctx:VxV)

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  include/trace/events/writeback.h | 8 ++++----
  1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/writeback.h 
b/include/trace/events/writeback.h
index 54e353c9f919..43cdecf362e3 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -26,8 +26,8 @@
  /* enums need to be exported to user space */
  #undef EM
  #undef EMe
-#define EM(a,b)     TRACE_DEFINE_ENUM(a);
-#define EMe(a,b)    TRACE_DEFINE_ENUM(a);
+#define EM(a, b)     TRACE_DEFINE_ENUM(a);
+#define EMe(a, b)    TRACE_DEFINE_ENUM(a);

  #define WB_WORK_REASON                            \
      EM( WB_REASON_BACKGROUND,        "background")        \
@@ -47,8 +47,8 @@ WB_WORK_REASON
   */
  #undef EM
  #undef EMe
-#define EM(a,b)        { a, b },
-#define EMe(a,b)    { a, b }
+#define EM(a, b)    { a, b },
+#define EMe(a, b)    { a, b }

  struct wb_writeback_work;
