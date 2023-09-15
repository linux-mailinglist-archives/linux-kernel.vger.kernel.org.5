Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E802D7A19E3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjIOJEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbjIOJEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:04:13 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8DB4684
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:01:11 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.187.55])
        by andre.telenet-ops.be with bizsmtp
        id m8y72A00F1C8whw018y7SS; Fri, 15 Sep 2023 10:58:07 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qh4e4-003lJJ-5b;
        Fri, 15 Sep 2023 10:58:07 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qh4eN-00GdiB-4j;
        Fri, 15 Sep 2023 10:58:07 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Magnus Damm <magnus.damm@gmail.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] soc: renesas: Kconfig: Remove blank line before ARCH_R9A07G043 help text
Date:   Fri, 15 Sep 2023 10:58:05 +0200
Message-Id: <2a3a9d595579b7cea416c12bf9abcfa2227243bb.1694768174.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There should not be a blank line before the "help" keyword in the
ARCH_R9A07G043 configuration section.

Fixes: c6a906cce61a8015 ("soc: renesas: Kconfig: For ARCH_R9A07G043 select the required configs if dependencies are met")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
To be queued in renesas-devel for v6.7.

 drivers/soc/renesas/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index bb1bb004b6a44b01..dd3f074d7b09b9bb 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -343,7 +343,6 @@ config ARCH_R9A07G043
 	select DMA_GLOBAL_POOL
 	select ERRATA_ANDES if RISCV_SBI
 	select ERRATA_ANDES_CMO if ERRATA_ANDES
-
 	help
 	  This enables support for the Renesas RZ/Five SoC.
 
-- 
2.34.1

