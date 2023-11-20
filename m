Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EB37F1E6B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 21:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjKTU6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 15:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjKTU6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 15:58:46 -0500
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AF7CF;
        Mon, 20 Nov 2023 12:58:41 -0800 (PST)
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id CB8F72071A;
        Mon, 20 Nov 2023 21:58:36 +0100 (CET)
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Hiago De Franco <hiago.franco@toradex.com>
Subject: [PATCH v1 0/3] ARM: dts: imx: Add mmc aliases to Toradex DTS
Date:   Mon, 20 Nov 2023 21:58:15 +0100
Message-Id: <20231120205818.33120-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add mmc aliases to ensure a consistent mmc device naming across the
Toradex SoM family, with this commit mmc0 is the on-module eMMC
boot device and the not available mmc interfaces are removed.

Hiago De Franco (3):
  ARM: dts: imx6qdl-apalis: Add usdhc aliases
  ARM: dts: imx6qdl-colibri: Add usdhc aliases
  ARM: dts: imx7d-colibri-emmc: Add usdhc aliases

 arch/arm/boot/dts/nxp/imx/imx6qdl-apalis.dtsi     | 7 +++++++
 arch/arm/boot/dts/nxp/imx/imx6qdl-colibri.dtsi    | 7 +++++++
 arch/arm/boot/dts/nxp/imx/imx7d-colibri-emmc.dtsi | 4 ++++
 3 files changed, 18 insertions(+)

-- 
2.25.1

