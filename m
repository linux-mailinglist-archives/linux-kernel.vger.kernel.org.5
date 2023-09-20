Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF5D7A837F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbjITNfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235988AbjITNfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:35:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FE091
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:34:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C06CC433C7;
        Wed, 20 Sep 2023 13:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695216896;
        bh=Ze8kp/+7IbXTggqFK3LA6za8oqj1BVOOG3H/awXtntA=;
        h=From:To:Cc:Subject:Date:From;
        b=YfNZ000jzNQ/dRnvdDMm4qRb89YMSvrmXK7yKDJMUmcfKze+bdUnE5WglCrYOi0EL
         ys0VHJr1g6y6qYv1gSKOBU9bR5WC7CxuE+kUR6ZVjftVnqhSIDFhUiJeNba8zLV8Zq
         J1DRTA2mm+BryMb9h7P+8qqVsntLnJ3BL8/Eu+STZlOeNfQbIqJ5udX94OAY2s1WWv
         K7s7WX5lXvCJj15xP3GaRL5ApUeLVH04kVrkHrYS3NWzkD8gJclRDTuqetyunuqn3p
         JJfhsXnNqWNykFdMzae2Zeb0WrPpfGnjTonJEQBd2DHy943M5bPDw6J2mYs6Psr/Fe
         xomaUKdN80lTw==
From:   Roger Quadros <rogerq@kernel.org>
To:     nm@ti.com
Cc:     vigneshr@ti.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, srk@ti.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 0/2] arm64: dts: ti: Add overlay for AM642-EVM NAND expansion card
Date:   Wed, 20 Sep 2023 16:34:48 +0300
Message-Id: <20230920133450.54226-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds overlay for NAND expansion card for AM642-EVM.

cheers,
-roger

Roger Quadros (2):
  arm64: dts: ti: Enable support for overlays for relevant boards
  arm64: dts: ti: am642-evm: Add overlay for NAND expansion card

 arch/arm64/boot/dts/ti/Makefile               |   9 ++
 arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso | 140 ++++++++++++++++++
 2 files changed, 149 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso


base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
prerequisite-patch-id: 93eee303ffcec92f977eaab80e91fe900d85638e
-- 
2.34.1

