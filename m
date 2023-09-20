Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04797A79E7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 13:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbjITLAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 07:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjITLAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 07:00:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486FC97;
        Wed, 20 Sep 2023 04:00:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E498FC433CD;
        Wed, 20 Sep 2023 11:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695207623;
        bh=rPiOUM5aaPiWdfVsIO/cyE3yqhenjHG0uI9o5H+GhkU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=c4uykEEPwEbr8zdbbSliJKEUBvRYSJjrN5AghndhxVSToOBFQbQXaXWS/acoVkMh0
         1dGt0z+PYTgMdyaAFwh1eoyXuLRgoYxThzE7aGUJW66AXvMczPNaiIkaRgT+Ww0Thu
         PwyQr0UbEgfGcJbdz0xOw8WjRQq/EtkoDDOiaaBuuwxGduEmHByahc12iHhz+/tZRx
         Zd6Ng/kWGjsx7G0SxGY2LZJFNMCF0SDfZivVx/0wls4ctLTwGQclXzsNtkJLz6tO0n
         kgb7lBM+ZE7UjMXEo89/L+EsZqO6ychFHcQdGSMhcJxTPNzGo60joUiXY3hvPhEomB
         5FsAlUa2dTfuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CFDF7C41671;
        Wed, 20 Sep 2023 11:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] wifi: cfg80211: make read-only array centers_80mhz
 static const
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169520762384.31903.1385774049535484165.git-patchwork-notify@kernel.org>
Date:   Wed, 20 Sep 2023 11:00:23 +0000
References: <20230919095205.24949-1-colin.i.king@gmail.com>
In-Reply-To: <20230919095205.24949-1-colin.i.king@gmail.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, 19 Sep 2023 10:52:05 +0100 you wrote:
> Don't populate the read-only array lanes on the stack, instead make
> it static const.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  net/mac80211/tdls.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [next] wifi: cfg80211: make read-only array centers_80mhz static const
    https://git.kernel.org/netdev/net-next/c/6c0da8406382

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


