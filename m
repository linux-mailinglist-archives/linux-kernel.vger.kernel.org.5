Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD0175A738
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjGTHGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjGTHGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:06:08 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7026E213D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:05:56 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R63cZ4twYzBRDsN
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 15:05:50 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689836750; x=1692428751; bh=qrWNtrc5VN97OTDvxvlf/+l0vBs
        nH6jqf6iPZAMxb/k=; b=kjhXejBi6GsJ6XUi9Q/sPq+ppv8O6rKmp0i2/BEdxT4
        KAdNBs3KjlrinIK0qj3fC9IYcCQP7dbb2ABi0y7p74M5c+91JYry5yTi0XZrcL72
        cFwKNTLfnTg4u0lMp6cH0rS/s8RkmWO46EE/53tiqmRan/4tuzYWegK0n5ppMfVp
        Xi7VAK+W1iGa3gtIKPqrUhZtgWidxFWkkbP+Fy/l4MuvM0EkN5VVfda+cKbdQue/
        xZCo29peYq8KDf0sxiYZlhFr2EODJCtQ4WJHBpZL00RNrZi7FBSWwjCp6B6+QQvX
        /ip9mJDPM8Eze2/4/jofKUb3zwUeVM4YVXazMCpjoJQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4vh2fpw4rea1 for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 15:05:50 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R63cZ20L3zBRDsD;
        Thu, 20 Jul 2023 15:05:50 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 15:05:50 +0800
From:   hanyu001@208suo.com
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powernv: vas-trace: remove space after '('
In-Reply-To: <tencent_17F68D4711DDD23ED72A9E0708C4549F540A@qq.com>
References: <tencent_17F68D4711DDD23ED72A9E0708C4549F540A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <28bb80fbf964a6c110b17ae1908e68de@208suo.com>
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

Fix below checkpatch errors:

/platforms/powernv/vas-trace.h:ERROR:space prohibited after that open 
parenthesis '('
/platforms/powernv/vas-trace.h:ERROR:space prohibited after that open 
parenthesis '('
/platforms/powernv/vas-trace.h:ERROR:space prohibited after that open 
parenthesis '('

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  arch/powerpc/platforms/powernv/vas-trace.h | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/vas-trace.h 
b/arch/powerpc/platforms/powernv/vas-trace.h
index ca2e08f2ddc0..64acc0dccca8 100644
--- a/arch/powerpc/platforms/powernv/vas-trace.h
+++ b/arch/powerpc/platforms/powernv/vas-trace.h
@@ -10,7 +10,7 @@
  #include <linux/sched.h>
  #include <asm/vas.h>

-TRACE_EVENT(    vas_rx_win_open,
+TRACE_EVENT(vas_rx_win_open,

          TP_PROTO(struct task_struct *tsk,
               int vasid,
@@ -45,7 +45,7 @@ TRACE_EVENT(    vas_rx_win_open,
              __entry->lnotify_tid)
  );

-TRACE_EVENT(    vas_tx_win_open,
+TRACE_EVENT(vas_tx_win_open,

          TP_PROTO(struct task_struct *tsk,
               int vasid,
@@ -77,7 +77,7 @@ TRACE_EVENT(    vas_tx_win_open,
              __entry->lpid, __entry->pidr)
  );

-TRACE_EVENT(    vas_paste_crb,
+TRACE_EVENT(vas_paste_crb,

          TP_PROTO(struct task_struct *tsk,
              struct pnv_vas_window *win),
