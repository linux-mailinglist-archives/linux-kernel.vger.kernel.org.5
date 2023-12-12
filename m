Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42A880EF27
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376999AbjLLOop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376924AbjLLOoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:44:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7A9EA;
        Tue, 12 Dec 2023 06:44:27 -0800 (PST)
Date:   Tue, 12 Dec 2023 14:44:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702392266;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=441iuVzYurGTJEGrq4PMa/GpWUIHw+S/X4m6khk84z4=;
        b=LOeR+Pak1LnfWRZksllF1O1tbifcVvk9N8edJxxSbChMAc7s6hX2n6VL+7F4sWyOMRuJS1
        ixt895QWm8yrgSidJrgUyZQld8YNqWd8B+SH/rxOuQ+/7xke/DDasuCoG90REZyqcg/30F
        NgXlq6wqKJCrMkaOVbIQbqsrjkiZlPz/nxb1yUeYOVqo60/YibPZUy29geis+qOfRxqATa
        ifAo0n2Gpk/JX7uBWPaQ/leBMDGSUPF0h4/4pGHn7/Qd+nXAvaDhRap/q4pSIBE5LKaTdt
        dUHAjSo/LQ/TWy8tP7kU3m1cvkZ8mcYSYTkBidLIOVNDOe+tRt6aY/Tl4f4AEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702392266;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=441iuVzYurGTJEGrq4PMa/GpWUIHw+S/X4m6khk84z4=;
        b=D5LcMp0A7FC/SoQ/opg5C0qHRQN9fzpPn91WG5HsEHQQtqGodAq3eyJ0skBpgVvS8n/pOZ
        AQ8E6MSsWpVvTaAg==
From:   "tip-bot2 for Claudiu Beznea" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/renesas-rzg2l: Use tabs instead of spaces
Cc:     Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20231120111820.87398-3-claudiu.beznea.uj@bp.renesas.com>
References: <20231120111820.87398-3-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Message-ID: <170239226580.398.17619159245954472388.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     c90b5c4e6554c1194d5f7cfe13dfd710a7661cab
Gitweb:        https://git.kernel.org/tip/c90b5c4e6554c1194d5f7cfe13dfd710a7661cab
Author:        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
AuthorDate:    Mon, 20 Nov 2023 13:18:13 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 Dec 2023 15:40:41 +01:00

irqchip/renesas-rzg2l: Use tabs instead of spaces

Use tabs instead of spaces in definition of TINT_EXTRACT_HWIRQ()
and TINT_EXTRACT_GPIOINT() macros to align with coding style
requirements described in Documentation/process/coding-style.rst,
"Indentation" chapter.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231120111820.87398-3-claudiu.beznea.uj@bp.renesas.com

---
 drivers/irqchip/irq-renesas-rzg2l.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index fe8d516..cc42cbd 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -53,8 +53,8 @@
 #define IITSR_IITSEL_EDGE_BOTH		3
 #define IITSR_IITSEL_MASK(n)		IITSR_IITSEL((n), 3)
 
-#define TINT_EXTRACT_HWIRQ(x)           FIELD_GET(GENMASK(15, 0), (x))
-#define TINT_EXTRACT_GPIOINT(x)         FIELD_GET(GENMASK(31, 16), (x))
+#define TINT_EXTRACT_HWIRQ(x)		FIELD_GET(GENMASK(15, 0), (x))
+#define TINT_EXTRACT_GPIOINT(x)		FIELD_GET(GENMASK(31, 16), (x))
 
 struct rzg2l_irqc_priv {
 	void __iomem *base;
