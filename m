Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BFC7DAB99
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 08:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjJ2Hta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 03:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjJ2Ht2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 03:49:28 -0400
Received: from mail-m17214.xmail.ntesmail.com (mail-m17214.xmail.ntesmail.com [45.195.17.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BD2D3;
        Sun, 29 Oct 2023 00:49:25 -0700 (PDT)
Received: from localhost.localdomain (unknown [58.61.140.248])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id AAC6F80007F;
        Sun, 29 Oct 2023 15:40:14 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH v2 0/1] arm64: dts: allwinner: h616: update emac for Orange Pi Zero 3
Date:   Sun, 29 Oct 2023 15:40:08 +0800
Message-Id: <20231029074009.7820-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCT08YVh8eQ0pNTxhJTU1IGVUTARMWGhIXJBQOD1
        lXWRgSC1lBWU5DVU1KVUpPS1VJT0NZV1kWGg8SFR0UWUFZT0tIVUpKS0hKQ1VKS0tVS1kG
X-HM-Tid: 0a8b7a605328b03akuuuaac6f80007f
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MRw6Hgw6AjwwCykyLSEuHBxK
        MBwwCTFVSlVKTUJDTk1OSUpOTUNPVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWU5D
        VU1KVUpPS1VJT0NZV1kIAVlBSkxDTDcG
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Changes from v2:
> * Merge into one commit.
> * Update phy mode for Zero 3.

Chukun Pan (1):
  arm64: dts: allwinner: h616: update emac for Orange Pi Zero 3

 arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi | 3 ---
 arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero2.dts | 3 +++
 arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts | 2 ++
 3 files changed, 5 insertions(+), 3 deletions(-)

-- 
2.25.1

