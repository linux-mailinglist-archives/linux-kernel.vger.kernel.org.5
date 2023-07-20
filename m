Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB7975A66D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjGTG3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjGTG2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:28:34 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669752126
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:28:25 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R62nG5ClczBRDsF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 14:28:18 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689834498; x=1692426499; bh=IOV3qiBQV+RUOfvrjkV8vy3/eaO
        I20uhGpmge99PRuA=; b=JnV2Uf1G7Tbeo3KNMVwUgO09nKasmcIlZUt5ojzwNbq
        kzD4Sdz7quu/PFhrGNIGezy/w1fnAnTy/DlU2KgktuabRt7Lt3FeOB9BVjeBixuf
        4vm4RB9okGFR6utUHbQjc+lM77UVh+NGyozCF4zzP0XZXz/9NeueIHEAhGY68Zwl
        +4kD0kRTrJD6EAkRD9u+Y4IhXpTEH2hWgAwnk2snvxlpXrc9OB+2b/ibsZW2waRW
        92sD/9Jqhjy1oqtyN66WB8o/XTY/zWk8RxAbUPLJQ62X4ZKaDDIKSSdav8iY8SMC
        BY1cLLLYKFXa6G7V975hqRhmFG0W4S2y00VSDs6y2fg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id y1ajNWXD4ZJ8 for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 14:28:18 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R62nG2wRyzBR1P6;
        Thu, 20 Jul 2023 14:28:18 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 14:28:14 +0800
From:   hanyu001@208suo.com
To:     James.Bottomley@HansenPartnership.com, deller@gmx.de
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] risc: kernel: Added missing spaces
In-Reply-To: <tencent_E7295E87DE0495D80A75B8CCAB23C12E260A@qq.com>
References: <tencent_E7295E87DE0495D80A75B8CCAB23C12E260A@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <bdb970b5a7c7253d43e4be3470b73f1e@208suo.com>
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

Fix checkpatch warnings:

./arch/parisc/kernel/unaligned.c:339: ERROR: spaces required around that 
'=' (ctx:VxV)
./arch/parisc/kernel/unaligned.c:339: ERROR: space required after that 
',' (ctx:VxV)
./arch/parisc/kernel/unaligned.c:339: ERROR: spaces required around that 
'=' (ctx:VxV)

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  arch/parisc/kernel/unaligned.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/unaligned.c 
b/arch/parisc/kernel/unaligned.c
index e8a4d77..752d0d0 100644
--- a/arch/parisc/kernel/unaligned.c
+++ b/arch/parisc/kernel/unaligned.c
@@ -336,7 +336,7 @@ static int emulate_std(struct pt_regs *regs, int 
frreg, int flop)
      : "r19", "r20", "r21", "r22", "r1" );
  #else
      {
-    unsigned long valh=(val>>32),vall=(val&0xffffffffl);
+    unsigned long valh = (val>>32), vall = (val&0xffffffffl);
      __asm__ __volatile__ (
  "    mtsp    %4, %%sr1\n"
  "    zdep    %2, 29, 2, %%r19\n"
