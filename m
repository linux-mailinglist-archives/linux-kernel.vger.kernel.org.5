Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A235779FF4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 14:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjHLMWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 08:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjHLMWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 08:22:21 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5670F136;
        Sat, 12 Aug 2023 05:22:23 -0700 (PDT)
Received: from i53875bbf.versanet.de ([83.135.91.191] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qUndI-0000MO-DZ; Sat, 12 Aug 2023 14:22:16 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Stefan Nagy <stefan.nagy@ixypsilon.net>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Enable internal SPI flash for ROCK Pi 4A/B/C
Date:   Sat, 12 Aug 2023 14:22:14 +0200
Message-Id: <169184288415.3581838.14510219011425272419.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230811201118.15066-1-stefan.nagy@ixypsilon.net>
References: <20230811201118.15066-1-stefan.nagy@ixypsilon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2023 22:11:18 +0200, Stefan Nagy wrote:
> The ROCK Pi 4A, ROCK Pi 4B and ROCK Pi 4C boards contain a nor-flash chip
> connected to spi1. Enable spi1 and add the device node.
> 
> This patch has been tested on ROCK Pi 4A.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Enable internal SPI flash for ROCK Pi 4A/B/C
      commit: eddf7302977023980b717a468e12c40738cd12f3

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
