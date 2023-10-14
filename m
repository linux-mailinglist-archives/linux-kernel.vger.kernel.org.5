Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA3D7C9209
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 03:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjJNBKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 21:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJNBK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 21:10:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B0491;
        Fri, 13 Oct 2023 18:10:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1FE2C43395;
        Sat, 14 Oct 2023 01:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697245827;
        bh=UQUTbUeDYB4EVNdj0uFAZ0IRog8SALj0h3eKfdROwbU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OlIpxPBEDKy71M3/wXUHpmfwfMiRuXQJuc7vu9vcN4bRvboYGv6MX39ZqiCG8LQxw
         ORYRgT1Oz/FmepyeUkvMzzYa1uV+Cow8IOigjtozcSxtN/U+oo94v9OaPstaw7TvAf
         3jG6uJ+zFjNe8IZITiwRJYoQ8/WB/QxGXp2o9FxueB2hEJDgCi/TCuRnKUyxsaCXeW
         h37aEcUX9v/gO/ES2zWGdknMZz2NMzsDoOLXyi5fUnouAnWW8qVpNuEu0wZlRBwDux
         ss5jGW050T3/jIot4c7bv2dK7xPNgvzNVuIQWwLB/EDO0SU29nMqWYTEGhgfKXPiaL
         rhrHDi6oFiVaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE98AE1F666;
        Sat, 14 Oct 2023 01:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] appletalk: remove special handling code for ipddp
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169724582690.12217.13440898400700144351.git-patchwork-notify@kernel.org>
Date:   Sat, 14 Oct 2023 01:10:26 +0000
References: <20231012063443.22368-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20231012063443.22368-1-lukas.bulwahn@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, arnd@arndb.de, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Oct 2023 08:34:43 +0200 you wrote:
> After commit 1dab47139e61 ("appletalk: remove ipddp driver") removes the
> config IPDDP, there is some minor code clean-up possible in the appletalk
> network layer.
> 
> Remove some code in appletalk layer after the ipddp driver is gone.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> 
> [...]

Here is the summary with links:
  - appletalk: remove special handling code for ipddp
    https://git.kernel.org/netdev/net-next/c/85605fb694f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


