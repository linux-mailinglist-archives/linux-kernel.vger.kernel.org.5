Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780087C819A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjJMJML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjJMJMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:12:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB691FCA
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 02:10:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C5D0C43397;
        Fri, 13 Oct 2023 09:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697188231;
        bh=fNgj8+qjVsxjuL11aoLC+nDRAOAPyyV629SPtwAT8vo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=csMI5MLKLYDyjzx4ajKhBPgilE4taTjp+n16Fv9u4u8jtYoIkIGMSns8+uQV1ygFo
         gtiYhBKaWpXzC1Jhah2Pq9rjeiOfIREGHiYeYTtDzvwchagNRNgB1d0Nw7Prwy5Mvo
         kgoJhOWhhnr4Oin58NoR0oO1xSpPbTV/CFmnacBxjYrI7U47VqS/begKcWUMzWdxpZ
         JkS/YiguI2Wp0n51J+FGjC90we13Y0FCjAtf6+6Sxg/ZF41//RGnsP46K0FodPKEcO
         hq+BL9IW4sZ4zLfzPrlXYrtk4UzdhpPjZzJbNAfmy4WBDMJnmgxxPnPY+hi0HX2JRo
         noB1ALRqf6bdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE81DE1F66D;
        Fri, 13 Oct 2023 09:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: wiznet: Use
 spi_get_device_match_data()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169718823090.32613.4699597021374127801.git-patchwork-notify@kernel.org>
Date:   Fri, 13 Oct 2023 09:10:30 +0000
References: <20231009172923.2457844-5-robh@kernel.org>
In-Reply-To: <20231009172923.2457844-5-robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  9 Oct 2023 12:29:00 -0500 you wrote:
> Use preferred spi_get_device_match_data() instead of of_match_device() and
> spi_get_device_id() to get the driver match data. With this, adjust the
> includes to explicitly include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/net/ethernet/wiznet/w5100-spi.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)

Here is the summary with links:
  - [net-next] net: ethernet: wiznet: Use spi_get_device_match_data()
    https://git.kernel.org/netdev/net-next/c/13266ad9e52e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


