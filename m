Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9DB7C02AC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 19:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343595AbjJJR2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 13:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbjJJR1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:27:48 -0400
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109EAD8;
        Tue, 10 Oct 2023 10:27:44 -0700 (PDT)
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 5AB7B864B4;
        Tue, 10 Oct 2023 19:27:43 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Tue, 10 Oct 2023 19:27:26 +0200
Subject: [PATCH v6 9/9] MAINTAINERS: add myself as Marvell PXA1908
 maintainer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231010-pxa1908-lkml-v6-9-b2fe09240cf8@skole.hr>
References: <20231010-pxa1908-lkml-v6-0-b2fe09240cf8@skole.hr>
In-Reply-To: <20231010-pxa1908-lkml-v6-0-b2fe09240cf8@skole.hr>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=908;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=DFkFmWpL42a9uWB0nGtydXY8FHW5qBEo4bLkmrXA9us=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBlJYl5WjZg8QhwIAcaDKEP/msa5uKIqJUNjcPss
 i4vg/GKSJOJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZSWJeQAKCRCaEZ6wQi2W
 4VUKEACSbAQnaBn9klVqvXdvLM+kNm6pUAIIE/rRn5J4k7jpcW+wOLHoGTNjnXkgq7aW7L720yF
 aHCrch53X5gfWk47u8QIU2r1SN+3L+Mq6Z6zG75CevWDxRlMu6nzVQyVEE57TsihLBvzxvury8c
 lX28gLPUymfkl8u2fqJ9WF6/S9gUUYj5UuX3Pr/c37OEPC4TGJAI1PCc2gWsa/T0UVIim82vSEm
 uwiLFD2dOXZdwK8xyscziKphAdYf4hl+jPXmg24bZIqpe507PSUW/XFOk9tC2k/5ypJvIP8mcT8
 VtjiVVfI+RpAWw3VWJ51j1uy1S61PoreeG/qcxSR8DrYEZYpo+XOzGXEfw7beWf9+QJbR0zvexN
 S1l5kYonPYq1AEg+DPb84mw6ceNF577y981dXr9B9MXEYrrUg4aQqGjDrE1FdufmDHI4SllfrEt
 ZU8ZnCjzy84T+v+LPPuDHHfImEorL49fJagk7jTom2R/86PBlUT05wf0XGftC/o84gcJ9V/OgmF
 9ZneerNcwzowvRd1E58Fc8NI0TXaDJfoKAW8jzYc876A0vDRkvlhykO6hrBujwqMgWbtGMSJFFE
 v1wGrv0sMcRmJdldPv1Rdv0duqPdLElUv1y9syDwZv25iIaIangQgQhKseh1qVWQdGGEIJt83+a
 CsxeEqUHFfyEpOw==
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
index 6c4cce45a09d..38c99e687976 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2312,6 +2312,15 @@ F:	drivers/irqchip/irq-mvebu-*
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


