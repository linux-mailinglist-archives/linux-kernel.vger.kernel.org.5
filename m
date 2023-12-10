Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0550380BABB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 13:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231945AbjLJMxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 07:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjLJMxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 07:53:33 -0500
Received: from smtp.outgoing.loopia.se (smtp.outgoing.loopia.se [93.188.3.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD7D102
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 04:53:37 -0800 (PST)
Received: from s807.loopia.se (localhost [127.0.0.1])
        by s807.loopia.se (Postfix) with ESMTP id B8E1A2FC9E76
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 13:48:17 +0100 (CET)
Received: from s981.loopia.se (unknown [172.22.191.5])
        by s807.loopia.se (Postfix) with ESMTP id A98B62E274F0;
        Sun, 10 Dec 2023 13:48:17 +0100 (CET)
Received: from s898.loopia.se (unknown [172.22.191.5])
        by s981.loopia.se (Postfix) with ESMTP id A6D3822B17B5;
        Sun, 10 Dec 2023 13:48:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at amavis.loopia.se
X-Spam-Score: -1.01
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from s981.loopia.se ([172.22.191.5])
        by s898.loopia.se (s898.loopia.se [172.22.190.17]) (amavisd-new, port 10024)
        with LMTP id yo_ORE4WT41Y; Sun, 10 Dec 2023 13:48:17 +0100 (CET)
X-Loopia-Auth: user
X-Loopia-User: fredrik@frelon.se
X-Loopia-Originating-IP: 81.233.40.252
Received: from localhost.localdomain (81-233-40-252-no600.tbcn.telia.com [81.233.40.252])
        (Authenticated sender: fredrik@frelon.se)
        by s981.loopia.se (Postfix) with ESMTPSA id 3734622B179D;
        Sun, 10 Dec 2023 13:48:17 +0100 (CET)
From:   =?UTF-8?q?Fredrik=20L=C3=B6nnegren?= <fredrik@frelon.se>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, fredrik.lonnegren@gmail.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Fredrik=20L=C3=B6nnegren?= <fredrik@frelon.se>
Subject: [PATCH 2/2] RISC-V: sort includes alphabetically
Date:   Sun, 10 Dec 2023 13:42:25 +0100
Message-ID: <20231210124811.26204-2-fredrik@frelon.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231210124811.26204-1-fredrik@frelon.se>
References: <20231210124811.26204-1-fredrik@frelon.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort includes in arch/riscv/kernel/smpboot.c alphabetically.

Signed-off-by: Fredrik Lönnegren <fredrik@frelon.se>
---
 arch/riscv/kernel/smpboot.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 1b461570d456..98ebb5e3f173 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -10,19 +10,19 @@
 
 #include <linux/acpi.h>
 #include <linux/arch_topology.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/sched.h>
-#include <linux/kernel_stat.h>
-#include <linux/notifier.h>
 #include <linux/cpu.h>
-#include <linux/percpu.h>
 #include <linux/delay.h>
 #include <linux/err.h>
+#include <linux/init.h>
 #include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/kernel_stat.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
 #include <linux/of.h>
+#include <linux/percpu.h>
+#include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 #include <linux/sched/mm.h>
 
@@ -31,11 +31,11 @@
 #include <asm/irq.h>
 #include <asm/mmu_context.h>
 #include <asm/numa.h>
-#include <asm/tlbflush.h>
 #include <asm/sections.h>
 #include <asm/smp.h>
-#include <uapi/asm/hwcap.h>
+#include <asm/tlbflush.h>
 #include <asm/vector.h>
+#include <uapi/asm/hwcap.h>
 
 #include "head.h"
 
-- 
2.43.0

