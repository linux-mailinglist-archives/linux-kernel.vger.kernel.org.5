Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2007F5BE1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344070AbjKWKGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbjKWKGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:06:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B12FD49;
        Thu, 23 Nov 2023 02:06:43 -0800 (PST)
Date:   Thu, 23 Nov 2023 10:06:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700734001;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=h0SJnC/KNkSD8PHqd8Ih4isqYZxX3DhKQPOlth8mHJE=;
        b=4m1SqpQ0GiHZqz/rFQ8GeT1Tz8UsQYEeRQWt1l78rDgvw2hrX7WjqsD61RRztsllPtKkqs
        H3KQZfsZLE+YwNFQQ55dv+XJVLYQJntah5sftMWf4cBIKoKzC/w230/44moFkTTt6DqIGS
        bN/vv21sOWDi0BDgpzFGDNZIg84lJ+slKelkuoL7sHOV2T081Gxtz27USFNTnuMPVQ5hg4
        h1CNlY2gP0Z93vh2PwWhTUnvbVsPjiyevcS8w2E2Lb7e0H3spCVPU7RTyCqEihdlS71FTP
        OT1B5kyLOKJrAG1E2F3Wuhrqna0xbk2TCEWN9xMzS0nvIcFVhWwMz1ze2lm24A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700734001;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=h0SJnC/KNkSD8PHqd8Ih4isqYZxX3DhKQPOlth8mHJE=;
        b=wXVX5LqmEq7FOfF4TIBU/OKC54OytD3bLWpFr4xw9cmfp61sHQYScU0ewPWnPTI54PK1Tl
        g/FGb1AQkEIZCEAQ==
From:   "tip-bot2 for Adrian Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/ioapic: Remove unfinished sentence from comment
Cc:     Adrian Huang <ahuang12@lenovo.com>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
MIME-Version: 1.0
Message-ID: <170073400034.398.12764232671726592445.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     5e1c8a47fc6ec6251ddd126f4245279fc072f1c0
Gitweb:        https://git.kernel.org/tip/5e1c8a47fc6ec6251ddd126f4245279fc072f1c0
Author:        Adrian Huang <ahuang12@lenovo.com>
AuthorDate:    Thu, 23 Nov 2023 12:13:37 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 23 Nov 2023 11:00:24 +01:00

x86/ioapic: Remove unfinished sentence from comment

[ mingo: Refine changelog. ]

Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/apic/io_apic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 00da6cf..40c7cf1 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -997,7 +997,7 @@ static int alloc_isa_irq_from_domain(struct irq_domain *domain,
 	/*
 	 * Legacy ISA IRQ has already been allocated, just add pin to
 	 * the pin list associated with this IRQ and program the IOAPIC
-	 * entry. The IOAPIC entry
+	 * entry.
 	 */
 	if (irq_data && irq_data->parent_data) {
 		if (!mp_check_pin_attr(irq, info))
