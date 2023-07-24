Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7FA75EBF7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 08:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjGXGwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 02:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjGXGwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 02:52:04 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D827F4;
        Sun, 23 Jul 2023 23:52:02 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id CF6CF81DC;
        Mon, 24 Jul 2023 14:52:00 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 24 Jul
 2023 14:52:00 +0800
Received: from SD-Server.starfivetech.com (183.27.99.135) by
 EXMBX068.cuchost.com (172.16.6.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Mon, 24 Jul 2023 14:51:59 +0800
From:   Walker Chen <walker.chen@starfivetech.com>
To:     Conor Dooley <conor+dt@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hal Feng <hal.feng@starfivetech.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Walker Chen <walker.chen@starfivetech.com>
Subject: [PATCH v1 0/2] Add dma and tdm nodes for StarFive JH7110 SOC
Date:   Mon, 24 Jul 2023 14:51:56 +0800
Message-ID: <20230724065158.925-1-walker.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.99.135]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

These patches add dma and tdm nodes for the StarFive JH7110 SoC, they
are based on linux-next. I have tested them on the VisionFive2 board.
Thanks.

Best regards,
Walker

Walker Chen (2):
  riscv: dts: starfive: jh7110: add dma controller node
  riscv: dts: starfive: jh7110: add the node and pins configuration for
    tdm

 .../jh7110-starfive-visionfive-2.dtsi         | 40 +++++++++++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 39 ++++++++++++++++++
 2 files changed, 79 insertions(+)

-- 
2.17.1

