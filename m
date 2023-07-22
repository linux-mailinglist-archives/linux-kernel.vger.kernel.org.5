Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DFA75DA61
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 08:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjGVGn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 02:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGVGnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 02:43:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E060270B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 23:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=RDTOVglspT4HTni3B80Sw/OghhiWJkFxBNnAYhNNCL0=; b=e1IKM/f2S/V1q7JtHnxH/o/X6L
        sxTGfTCRO4qbfVnoER104SVP9VM4LL/44MxDZJs88Cn/uOpxVCHF1zkAzdQYTXhf75f/HTcAzjprf
        ZZmhbdQYeKDQznZ++RjMyBt8Sx+byEaRBnNXaY4mya80chA8KCBaDFsABwzH9mSOTSt2hAV5iQqcI
        wKykTdrAATyoQwTe07udKmcBkLDkxuNwLX22dD5jMdozjg9fEqCka4kmSHvVCZi9+eCBbeOeh2flA
        KrwZ3Kw1IXXyMnyMCW4ZR8/eGuWFxtATkcR+x3Q/OJ/s7YFFAIt/9oTYHOLuUwmugVIsl5LnULNyj
        zqANaBVg==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qN6Kl-00Fy4w-2y;
        Sat, 22 Jul 2023 06:43:20 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        openwrt-devel@lists.openwrt.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] vlynq: fix typos in Kconfig
Date:   Fri, 21 Jul 2023 23:43:18 -0700
Message-ID: <20230722064318.29074-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix grammar and punctuation in the vlynq Kconfig file.

Fixes: 55e331cf7ebe ("drivers: add support for the TI VLYNQ bus")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: openwrt-devel@lists.openwrt.org
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/vlynq/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/drivers/vlynq/Kconfig b/drivers/vlynq/Kconfig
--- a/drivers/vlynq/Kconfig
+++ b/drivers/vlynq/Kconfig
@@ -7,10 +7,10 @@ config VLYNQ
 	help
 	  Support for Texas Instruments(R) VLYNQ bus.
 	  The VLYNQ bus is a high-speed, serial and packetized
-	  data bus which allows external peripherals of a SoC
+	  data bus which allows external peripherals of an SoC
 	  to appear into the system's main memory.
 
-	  If unsure, say N
+	  If unsure, say N.
 
 config VLYNQ_DEBUG
 	bool "VLYNQ bus debug"
