Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FB77BBA83
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjJFOlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjJFOlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:41:24 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2D2D6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 07:41:21 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5e53:403c:300c:38ca])
        by michel.telenet-ops.be with bizsmtp
        id uehJ2A0020nPCdM06ehJJC; Fri, 06 Oct 2023 16:41:18 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qom10-005X4T-1Q;
        Fri, 06 Oct 2023 16:41:18 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qom0z-006v2J-Ue;
        Fri, 06 Oct 2023 16:41:17 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 0/5] m68k: Fix indentation by odd number of spaces
Date:   Fri,  6 Oct 2023 16:41:09 +0200
Message-Id: <cover.1696602993.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

This patch series fixes indentation by an odd number of spaces in a few
files I was working on.  I also fixed a few more whitespace errors in
reindented code while at it.  No functional changes.
    
To be queued in the m68k for-v6.7 branch.

Geert Uytterhoeven (5):
  m68k: Fix indentation by 7 spaces in <asm/io_mm.h>
  m68k: sun3: Fix indentation by 5 or 7 spaces
  m68k: kernel: Fix indentation by 7 spaces in traps.c
  m68k: Fix indentation by 2 or 5 spaces in <asm/page_mm.h>
  m68k: fpsp040: Fix indentation by 5 spaces

 arch/m68k/fpsp040/slogn.S            | 88 ++++++++++++++--------------
 arch/m68k/include/asm/io_mm.h        | 24 ++++----
 arch/m68k/include/asm/page_mm.h      | 45 +++++++-------
 arch/m68k/include/asm/sun3_pgalloc.h | 10 ++--
 arch/m68k/include/asm/tlbflush.h     | 72 +++++++++++------------
 arch/m68k/kernel/traps.c             |  8 +--
 arch/m68k/sun3/mmu_emu.c             | 40 ++++++-------
 7 files changed, 142 insertions(+), 145 deletions(-)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
