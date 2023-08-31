Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D8678E469
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 03:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345624AbjHaBb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 21:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345551AbjHaBbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 21:31:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB03CC2;
        Wed, 30 Aug 2023 18:31:35 -0700 (PDT)
Date:   Thu, 31 Aug 2023 01:31:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693445492;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9r8PoYAw6Qrqxw5pC9RXCK1xiDR+aA39MNiGmAaYyc0=;
        b=L21BhJkca/US3DkxTYrpyiyPPjF6rGf8Pa2VrJopd67d4bRHt/kAHPFxV4y0fby9pEbb6d
        UEO2hcJAOEbI1hoRZ0DfswTxzgN+vSS1MCxHVMwNxa6wJdHG0TeRPBvwWc43bjtW2QIYV4
        cH9LqG6P78f4ahl265B32EGSyce7VrsTL3unw4lD9ttkIu15J5T2wChcHD77bI7xWehlq2
        h+av+1OouAPk+MTGMyQAFZ9w+1IFA05tZCdNVH3LwMEc/BXh3lkFVoqo6xGQIoa3IME0Fu
        yRgMCANnD3iBwDM1JibW1+VaDEMnmtloBQR9+zsroZvyGvVTFdk0ryu8s/Gwew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693445492;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9r8PoYAw6Qrqxw5pC9RXCK1xiDR+aA39MNiGmAaYyc0=;
        b=iQlIDAeI/scl+p8Wi2E/Oo6pJKzYQ90qZrfcjVs+1liwMtmJWBFzv0jcMV2HD8xNqBknuY
        W5nSh7fkssBHqRBw==
From:   "tip-bot2 for Neil Armstrong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: oxsemi,rps-timer: remove
 obsolete bindings
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Golle <daniel@makrotopia.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Shevchenko <andy@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230630-topic-oxnas-upstream-remove-v2-4-fb6ab3dea87c@linaro.org>
References: <20230630-topic-oxnas-upstream-remove-v2-4-fb6ab3dea87c@linaro.org>
MIME-Version: 1.0
Message-ID: <169344549173.27769.17082972680739580078.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     c42b7a385286a99024ed2e6c2566929083b49ec8
Gitweb:        https://git.kernel.org/tip/c42b7a385286a99024ed2e6c2566929083b49ec8
Author:        Neil Armstrong <neil.armstrong@linaro.org>
AuthorDate:    Fri, 30 Jun 2023 18:58:29 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 13 Jul 2023 14:46:34 +02:00

dt-bindings: timer: oxsemi,rps-timer: remove obsolete bindings

Due to lack of maintenance and stall of development for a few years now,
and since no new features will ever be added upstream, remove the
OX810 and OX820 timer bindings.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Acked-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20230630-topic-oxnas-upstream-remove-v2-4-fb6ab3dea87c@linaro.org
---
 Documentation/devicetree/bindings/timer/oxsemi,rps-timer.txt | 17 +-------
 1 file changed, 17 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/oxsemi,rps-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/oxsemi,rps-timer.txt b/Documentation/devicetree/bindings/timer/oxsemi,rps-timer.txt
deleted file mode 100644
index d191612..0000000
--- a/Documentation/devicetree/bindings/timer/oxsemi,rps-timer.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Oxford Semiconductor OXNAS SoCs Family RPS Timer
-================================================
-
-Required properties:
-- compatible: Should be "oxsemi,ox810se-rps-timer" or "oxsemi,ox820-rps-timer"
-- reg : Specifies base physical address and size of the registers.
-- interrupts : The interrupts of the two timers
-- clocks : The phandle of the timer clock source
-
-example:
-
-timer0: timer@200 {
-	compatible = "oxsemi,ox810se-rps-timer";
-	reg = <0x200 0x40>;
-	clocks = <&rpsclk>;
-	interrupts = <4 5>;
-};
