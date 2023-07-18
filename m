Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C41B75728C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 05:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjGRDts convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jul 2023 23:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjGRDtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 23:49:42 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E674A134;
        Mon, 17 Jul 2023 20:49:40 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id B2DBC80A4;
        Tue, 18 Jul 2023 11:49:38 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 18 Jul
 2023 11:49:38 +0800
Received: from ubuntu.localdomain (113.72.147.86) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 18 Jul
 2023 11:49:37 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/3] riscv: dts: starfive: jh71x0: Add temperature sensor nodes and thermal-zones
Date:   Tue, 18 Jul 2023 11:49:34 +0800
Message-ID: <20230718034937.92999-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.147.86]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Conor,

These patches add temperature sensor nodes and thermal-zones for the
StarFive JH71X0 SoC. I have tested them on the BeagleV Starlight board
and StarFive VisionFive 1 / 2 board. Thanks.

Best regards,
Hal

Hal Feng (3):
  riscv: dts: starfive: jh7100: Add temperature sensor node and
    thermal-zones
  riscv: dts: starfive: jh7110: Add temperature sensor node and
    thermal-zones
  MAINTAINERS: Add Hal as a maintainer of SFCTEMP HWMON DRIVER

 MAINTAINERS                              |  1 +
 arch/riscv/boot/dts/starfive/jh7100.dtsi | 37 +++++++++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi | 53 ++++++++++++++++++++++++
 3 files changed, 91 insertions(+)


base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
-- 
2.38.1

