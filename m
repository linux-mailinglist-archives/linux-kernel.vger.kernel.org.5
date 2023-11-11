Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C327E8C5F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 20:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjKKTwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 14:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKKTwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 14:52:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83913861
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 11:51:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B01EC433CA;
        Sat, 11 Nov 2023 19:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699732318;
        bh=E1tQyCqMl32KOMn+s1uC72GC67R6UlVPaP/XKC05Z64=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bBZFJzcwfIRtJaSJdUT9oBGipMInwM26YtLFNrGBRPRK/b9gZRvHjidZoOrBxR8IQ
         PkirNHeM3j9ArzSPqPFWBpbhfgZzrtt9BuxDdDiT+NvQi9BPpCdeKO+t+h9EC1cFzj
         uETugurYIK7GDZhB7FGy+zUg3CVHY2X/JmI9lnQ8rtgkO7yoSX1zsgzSe4h3HsuRKx
         n0JJKwkLKxfhs4jv1eHkq86rIDMnWzhYDVg2x0aJrbZCmF8dIvgaEr8imD46gR8BI5
         9Bb+SjzNBJvGBQmgZqMj5RlnMqsDqoFCv4hgOGu+mR/3eeEYHpPN4/PSz7uF/J19Za
         nUjaXBDBf5pHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E734CC691EF;
        Sat, 11 Nov 2023 19:51:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: ti: icssg-prueth: Fix error cleanup on failing
 pruss_request_mem_region
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169973231793.11806.1960922852884307805.git-patchwork-notify@kernel.org>
Date:   Sat, 11 Nov 2023 19:51:57 +0000
References: <bbc536dd-f64e-4ccf-89df-3afbe02b59ca@siemens.com>
In-Reply-To: <bbc536dd-f64e-4ccf-89df-3afbe02b59ca@siemens.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, danishanwar@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, diogo.ivo@siemens.com, nm@ti.com,
        baocheng.su@siemens.com, wojciech.drewek@intel.com,
        rogerq@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 10 Nov 2023 17:13:08 +0100 you wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> We were just continuing in this case, surely not desired.
> 
> Fixes: 128d5874c082 ("net: ti: icssg-prueth: Add ICSSG ethernet driver")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> 
> [...]

Here is the summary with links:
  - [net,v3] net: ti: icssg-prueth: Fix error cleanup on failing pruss_request_mem_region
    https://git.kernel.org/netdev/net/c/2bd5b559a1f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


