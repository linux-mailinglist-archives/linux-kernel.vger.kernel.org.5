Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6015678E02A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242463AbjH3T3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245249AbjH3Ozv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:55:51 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7786F198
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:55:49 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:6c13:6b1b:7366:87c0])
        by andre.telenet-ops.be with bizsmtp
        id fqvn2A0123874jb01qvnET; Wed, 30 Aug 2023 16:55:48 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qbMbX-0023mw-RV;
        Wed, 30 Aug 2023 16:55:47 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qbMbj-005LjI-N8;
        Wed, 30 Aug 2023 16:55:47 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <atenart@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] ARM: Alpine: Spelling s/initialiing/initializing/
Date:   Wed, 30 Aug 2023 16:55:46 +0200
Message-Id: <08ed8b62ab64c5f52600000c4d53e01387e6a79d.1693407307.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a misspelling of "initializing".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-alpine/alpine_cpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-alpine/alpine_cpu_pm.c b/arch/arm/mach-alpine/alpine_cpu_pm.c
index 13ae8412e9ce6451..b48da6f12b6cc46a 100644
--- a/arch/arm/mach-alpine/alpine_cpu_pm.c
+++ b/arch/arm/mach-alpine/alpine_cpu_pm.c
@@ -29,7 +29,7 @@ int alpine_cpu_wakeup(unsigned int phys_cpu, uint32_t phys_resume_addr)
 	/*
 	 * Set CPU resume address -
 	 * secure firmware running on boot will jump to this address
-	 * after setting proper CPU mode, and initialiing e.g. secure
+	 * after setting proper CPU mode, and initializing e.g. secure
 	 * regs (the same mode all CPUs are booted to - usually HYP)
 	 */
 	writel(phys_resume_addr,
-- 
2.34.1

