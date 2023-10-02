Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDD37B54EE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbjJBONl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237555AbjJBONc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:13:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A6EE1
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 07:13:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DC3C433C8;
        Mon,  2 Oct 2023 14:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696256009;
        bh=7LLNcmYsHftHQa0+CuSBVHyYkjyXZIHGAdDDTLzjrsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=emJKdRUieLmsYIGjP8HySHxbGnlGadYlxJW987xvY0AdoRp/1qjhRCD34VFRfHhQe
         e3gyOZjTYQ/MqV05tyW86++f3FuYcL5LB2n895W1UtB1/Wk+jhZLTCQbg+BSzv12zK
         Bgd6sL4xcovcyhhuDI8eAmhjQj3MLVBJkUobxdun3Lqy4Tb8b6wK9Zql4tDOacIbSL
         40HyHseeu7lwmbFbbPyy6zzRdyJeu23AEcOUxWwBCOSEs3bJ1NzwKQ68bjYdO+R8+s
         1O7oLHa2FRChIdizIPBtvVj1B8GUtb19zEj4NhQD3+muGWUl4XixXKt0PHhPctpDNW
         q7huKoZUonxXQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1qnJfr-000Nzy-Dx;
        Mon, 02 Oct 2023 15:13:27 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 2/2] MAINTAINERS: Remove myself from the general IRQ subsystem maintenance
Date:   Mon,  2 Oct 2023 15:13:02 +0100
Message-Id: <20231002141302.3409485-3-maz@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002141302.3409485-1-maz@kernel.org>
References: <20231002141302.3409485-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is pretty obvious that I haven't done much on the IRQ side
for a while, and it is unlikely that I'll have more bandwidth
for it any time soon. People keep sending me patches that
I end-up reviewing in a cursory manner, which isn't great for
anyone.

So in everyone's interest, I'm removing myself from the list
of maintainers and leave the irqchip and irqdomain subsystems
in Thomas' capable hands.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f37f4ee96b20..0ffe42932d5b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11071,7 +11071,7 @@ F:	Documentation/devicetree/bindings/sound/irondevice,*
 F:	sound/soc/codecs/sma*
 
 IRQ DOMAINS (IRQ NUMBER MAPPING LIBRARY)
-M:	Marc Zyngier <maz@kernel.org>
+M:	Thomas Gleixner <tglx@linutronix.de>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
 F:	Documentation/core-api/irq/irq-domain.rst
@@ -11090,7 +11090,6 @@ F:	lib/group_cpus.c
 
 IRQCHIP DRIVERS
 M:	Thomas Gleixner <tglx@linutronix.de>
-M:	Marc Zyngier <maz@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
-- 
2.34.1

