Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939527AAE3F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbjIVJgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjIVJgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:36:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322EACE;
        Fri, 22 Sep 2023 02:36:32 -0700 (PDT)
Date:   Fri, 22 Sep 2023 09:36:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695375390;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=677/MbUSA6vCYD0fUVtSForcHcp5I5+1QRye0EZZ3Gg=;
        b=b13Yz4vadWLPOgeIw0hY8ArL4B9roL5H6IDVglX17JsONYNwS3p1X3QJdWnaR2YjxGTFos
        msB0jO6Cy0S61ipxT/DGxjqd4QaZDIWL0Dk7lnA1uAE6RE5Su84sDb9k+G8C4V90F34Wjm
        KoYomWntJmCxnftAeIW/7CKwn/fw6iNS5j5ztAHkWasEea6O7AknhAd/Taauk6FZe5vhTM
        Ud9+qzMNpqxw2+jMqBlRo08tkH6iCiFh2qWPFMfLOYYi2mC2oDBqMhDgHPjQje5K3xjAgI
        EnUwyZWtjp6j1RXLH2l8X+Jq1sSoEhf+U010KdmLauSHuKtcguf9BjQF8svRGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695375390;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=677/MbUSA6vCYD0fUVtSForcHcp5I5+1QRye0EZZ3Gg=;
        b=atnUJ0o5liXp3EQu3OE2EFz2YGCLGJc3ma/2zQL0Qa1yn1DSVN+tQIIDA+zlNVzhU9LJzo
        fpgtRFuL/X3S2kCw==
From:   "tip-bot2 for Jianlin Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/sev/docs: Update document URL in amd-memory-encryption.rst
Cc:     Jianlin Li <ljianlin99@gmail.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230922082547.522689-1-ljianlin99@gmail.com>
References: <20230922082547.522689-1-ljianlin99@gmail.com>
MIME-Version: 1.0
Message-ID: <169537538957.27769.16136549034466194421.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     bad0524e242012ec626c766f4ea2d8e4d67347be
Gitweb:        https://git.kernel.org/tip/bad0524e242012ec626c766f4ea2d8e4d67347be
Author:        Jianlin Li <ljianlin99@gmail.com>
AuthorDate:    Fri, 22 Sep 2023 16:25:47 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 22 Sep 2023 11:29:23 +02:00

x86/sev/docs: Update document URL in amd-memory-encryption.rst

The previous link to AMD programmer's manual is no longer available,
replace it with the new one.

Signed-off-by: Jianlin Li <ljianlin99@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230922082547.522689-1-ljianlin99@gmail.com
---
 Documentation/arch/x86/amd-memory-encryption.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/amd-memory-encryption.rst b/Documentation/arch/x86/amd-memory-encryption.rst
index 934310c..07caa8f 100644
--- a/Documentation/arch/x86/amd-memory-encryption.rst
+++ b/Documentation/arch/x86/amd-memory-encryption.rst
@@ -130,4 +130,4 @@ SNP feature support.
 
 More details in AMD64 APM[1] Vol 2: 15.34.10 SEV_STATUS MSR
 
-[1] https://www.amd.com/system/files/TechDocs/40332.pdf
+[1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/programmer-references/24593.pdf
