Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920DB7701E3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjHDNfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjHDNfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:35:02 -0400
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC281BF6;
        Fri,  4 Aug 2023 06:34:58 -0700 (PDT)
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id B3E3A83B60;
        Fri,  4 Aug 2023 15:34:56 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Fri, 04 Aug 2023 15:32:38 +0200
Subject: [PATCH v3 8/8] MAINTAINERS: add myself as Marvell PXA1908
 maintainer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230804-pxa1908-lkml-v3-8-8e48fca37099@skole.hr>
References: <20230804-pxa1908-lkml-v3-0-8e48fca37099@skole.hr>
In-Reply-To: <20230804-pxa1908-lkml-v3-0-8e48fca37099@skole.hr>
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
        afaerber@suse.de
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=908;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=J+tkAfKG4/JapSnekYuI2msG8RQ0Bd8sAcsOrk80DCw=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBkzP494ox7VQ9VePX5RAWhcmNku78MtBJh/7etQ
 3u87r3V1qSJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZMz+PQAKCRCaEZ6wQi2W
 4V1UEACZuW/lQkkoP0g8ypElzs+P80P80czpq7/YSV+wseQsyQeKcX4Cbzr/Ixq8okXWUIA+CUm
 g7B9tINtYYKhkKr+oxSiIovZDctWeZE9L4naKiSMIHVeb/Qz9xKPlV0d3ZkpXpeur8ELs995czl
 QQLMabbJfXPTUWZfQkIZYJoxkBjZKPHoDRAr4PAr2GzMMhd7t7unnaPXGLQSxAPiVQRgT5OPRGs
 fHWodZE8B8aAa7gtxwykn6GbD+NOrq0bwUSzL4Yl8Vk7/cIrYy1ODO5Sv+43Pq5reepwgZXDAKc
 bodUVQ19J/rjoCoSsrdg3Xtp/mi4z6TM1Qa0eU1pVMqyofPHgcTAHhjtdR1C1+bhpsddkukPrKm
 CjqTt7gf47kJUB0bCwhSVLCnVvBpyPrpQme9UawWxeyZ2Dpd3qFQyH8UcmZjiFFs6aLsPgLHTWo
 0na5MtW9YrGmV29cfbHyevcrKqbWMYJZwxuk4ZS8zzPk/zARMNsCblcfIx3k0LL6wV17QTBccMH
 XiYBsgE0VdLJmwLcRQ6BaIXXfCZnWPb38CGi6tRgcACw4Ny1XFa3D5jr9HlEaysEYkU/ja79Yhc
 2hBVoQqIRHMQP96lWL7t7i0vqqK1LDd4e7HseRdA3bnIerOPgtMJBEARqOVdQqZS6WhLcyGhhrO
 40f93ow9a4PbPTw==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 53b7ca804465..79173056e5cc 100644
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
2.41.0


