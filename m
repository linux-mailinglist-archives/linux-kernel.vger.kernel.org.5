Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED385751944
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbjGMHDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbjGMHC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:02:58 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0A7212D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:02:55 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1ltN6Xw0zBL4kD
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 15:02:52 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689231772; x=1691823773; bh=ux/UlvltyFIL39oRt2Pw13EaJop
        G7fMscRK5tWErzkA=; b=OXnpDXuz03xe6vLFXv7smKxbSXCl7I3zzpVEsnBPtv8
        Aj5YhGwfED8QY3ZPQK2feseRfxf809V3uNR5CxitzjdnXFIcDFYXF6QKzOqztiWm
        EUprJDziV1aCeY3W8N+YshvDFGBxDZhRQ6TBkfxx0/mLqEP6HY7+LZAw9iES2DEZ
        mE+o4CRa1jygZe5bpy8ctvMAbT7jJCHqvRf0scuHbGAaSVK+N/fw/Yb3jpriZuoI
        0yUZZc1ykYYRPlvs4D9KJ/7oVOwiFwcloXsm8KM8tGlL8dLLf6htWWksVpHhn2U6
        2Cd7wCaAha/b/6n+8cvcmETJp4xHnQLUuyo3vAfewLQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id R2FbITJezuEj for <linux-kernel@vger.kernel.org>;
        Thu, 13 Jul 2023 15:02:52 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1ltN4vB0zBJDhy;
        Thu, 13 Jul 2023 15:02:52 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 13 Jul 2023 15:02:52 +0800
From:   hanyu001@208suo.com
To:     tglx@linutronix.de, maz@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: irqchip: add spaces around '=','<'
In-Reply-To: <tencent_1A41AAB66C1D66F32748618B4E8AB7A12E08@qq.com>
References: <tencent_1A41AAB66C1D66F32748618B4E8AB7A12E08@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <163ceb00f3a86951b5ad735a8a487305@208suo.com>
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

This fixes the checkpatch.pl errors:

drivers/irqchip/irq-vt8500.c:173: ERROR: spaces required around that '=' 
(ctx:VxV)
drivers/irqchip/irq-vt8500.c:173: ERROR: spaces required around that '<' 
(ctx:VxV)

Signed-off-by: maqimei <2433033762@qq.com>
---
  drivers/irqchip/irq-vt8500.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-vt8500.c b/drivers/irqchip/irq-vt8500.c
index e17dd3a..597881a 100644
--- a/drivers/irqchip/irq-vt8500.c
+++ b/drivers/irqchip/irq-vt8500.c
@@ -170,7 +170,7 @@ static void __exception_irq_entry 
vt8500_handle_irq(struct pt_regs *regs)
      void __iomem *base;

      /* Loop through each active controller */
-    for (i=0; i<active_cnt; i++) {
+    for (i = 0; i < active_cnt; i++) {
          base = intc[i].base;
          irqnr = readl_relaxed(base) & 0x3F;
          /*
