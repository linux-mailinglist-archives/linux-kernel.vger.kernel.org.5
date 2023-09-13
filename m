Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBB679E1AC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238788AbjIMILL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235808AbjIMIK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:10:58 -0400
Received: from mail-sh.amlogic.com (mail-sh.amlogic.com [58.32.228.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFF81BD7;
        Wed, 13 Sep 2023 01:09:55 -0700 (PDT)
Received: from rd02-sz.amlogic.software (10.28.11.83) by mail-sh.amlogic.com
 (10.18.11.5) with Microsoft SMTP Server id 15.1.2507.13; Wed, 13 Sep 2023
 16:09:45 +0800
From:   Huqiang Qin <huqiang.qin@amlogic.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <hkallweit1@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        Huqiang Qin <huqiang.qin@amlogic.com>
Subject: [PATCH 0/3] Add GPIO interrupt support for Amlogic-T7 SoCs
Date:   Wed, 13 Sep 2023 16:09:21 +0800
Message-ID: <20230913080924.3336391-1-huqiang.qin@amlogic.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.11.83]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds GPIO interrupt support for Amloigc-T7 SoC (A311D2)

Huqiang Qin (3):
  dt-bindings: interrupt-controller: Add support for Amlogic-T7 SoCs
  irqchip: Add support for Amlogic-T7 SoCs
  arm64: dts: Add gpio_intc node for Amlogic-T7 SoCs

 .../interrupt-controller/amlogic,meson-gpio-intc.yaml  |  1 +
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi            | 10 ++++++++++
 drivers/irqchip/irq-meson-gpio.c                       |  5 +++++
 3 files changed, 16 insertions(+)


base-commit: e143016b56ecb0fcda5bb6026b0a25fe55274f56
-- 
2.37.1

