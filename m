Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B367B3728
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbjI2PnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233725AbjI2PnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:43:01 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9621A7;
        Fri, 29 Sep 2023 08:42:55 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 859A2834C9;
        Fri, 29 Sep 2023 17:42:54 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Fri, 29 Sep 2023 17:42:04 +0200
Subject: [PATCH RESEND v5 8/8] MAINTAINERS: add myself as Marvell PXA1908
 maintainer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230929-pxa1908-lkml-v5-8-5aa5a1109c5f@skole.hr>
References: <20230929-pxa1908-lkml-v5-0-5aa5a1109c5f@skole.hr>
In-Reply-To: <20230929-pxa1908-lkml-v5-0-5aa5a1109c5f@skole.hr>
To:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afaerber@suse.de, balejk@matfyz.cz
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=908;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=rZ0/2aarhuZmb4/RBctyFNylsa1DhpMnW4LU8kO7JSQ=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlFvBzztR/DmN/BrPp8VPfpH2DOR204+B0rFGw0
 yxH1jjmnVKJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZRbwcwAKCRCaEZ6wQi2W
 4dh5EACFr3lrsSwFYi4yZmCSHNc8n+hfwg/m1pLjQNkjuj2cl1ihInCd0B2fCurTjf1UHjVdSqZ
 bV8FF5OW7H9fzh0QrXZDiyitC3nBgEeeq+/Szn70GDb3zdBTkYXfbbJHWVCw6y6kekEVy8zMutw
 dvSL3Y0S9VqTzdRRtkpEiIp3MkOI39afEYk7eDZsMYFqugLl0gWQItz53w4ySmjQyaFWDi0wjeo
 vY0EFw5mPLyUZyDbwMO+QdTaowOgkRiGJDzY+E0c+21yQvTSpaIYekJXoU7v4t0N1hAbe56naDG
 S5UDfWHZN0A9d6p7PDNQjR6QR9XXhJqBpXka2yCbyl2YFL6L/jB9Vte4enhRDnI1FAKLxWjXSM1
 QbuhjxEBBF4j80VFq2NwhrKWOZggDD2xpwFNCzUv52JsNq5XWuZRTMW6gudVWajfYMf7nWS81Dt
 5H/m5kxEhD27+VqcLVwWYlqyIc69vupe3xzxVmX0KMbZxp8iq48G8xbLMFY3lDFz3wfbRoHacoC
 0+F1Ta0SCTK9lcbFmvIz62b9GdIgT8vN1sHxn1Bq7/87j2oJnzwo/Ykohs+z7lScqwvZz4rFHZf
 qHR1q1uTqL26HQQWR9edspD5/K7S7OkNgQYaQCgkztjf0qJuYfBZ3RyUlHEcyuLiE4ukZwXWIA8
 uy19OEOG8k8erug==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as the maintainer for Marvell PXA1908 SoC support.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f966f05fb0d..6f5233f3904b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2299,6 +2299,15 @@ F:	drivers/irqchip/irq-mvebu-*
 F:	drivers/pinctrl/mvebu/
 F:	drivers/rtc/rtc-armada38x.c
 
+ARM/Marvell PXA1908 SOC support
+M:	Duje Mihanović <duje.mihanovic@skole.hr>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+T:	git https://gitlab.com/LegoLivesMatter/linux
+F:	arch/arm64/boot/dts/marvell/pxa1908*
+F:	drivers/clk/mmp/clk-of-pxa1908.c
+F:	include/dt-bindings/clock/marvell,pxa1908.h
+
 ARM/Mediatek RTC DRIVER
 M:	Eddie Huang <eddie.huang@mediatek.com>
 M:	Sean Wang <sean.wang@mediatek.com>

-- 
2.42.0


