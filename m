Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4387F08C2
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 21:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjKSUK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 15:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKSUK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 15:10:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899A4103
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 12:10:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A27CC433C9;
        Sun, 19 Nov 2023 20:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700424624;
        bh=HRD1g/Jg79BVdEVmw3D4m9NCyvHQqfhE4tHAafr4fOk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Nub3qUkigHguAg7eC2AAhWhFyQGOUkJYFA8zUnNTQZkonTbOr8q/NIZrVHHPKpZ++
         f7XLd8uxgstUvX+5nvjL4hxqrMHhDg0CVyZbF2stJj8BTj+IXQoIzYZUtF6u3VV6wd
         6og49FuA75kX6etW0XuvMl92WFDvECUfsl5TSsGB1mbfodx1vIUFXUuqN1RcxezA05
         FrCOlyr94U2h1FsNlmsH64Hc+RDNRLy4ZcFCaqJP5yNLR3h274IuZap6Sfxih+eKc3
         17wEGCixXzv9i4eGda8Sre0ixuAhTuBk1qDvZHBA/Edwi5SYkeierOmlG21M0zT4vj
         1ENzDW+pI3Qqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4BDFE000A4;
        Sun, 19 Nov 2023 20:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH v2] octeontx2-pf: Fix memory leak during interface down
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170042462393.21508.8737738082545699896.git-patchwork-notify@kernel.org>
Date:   Sun, 19 Nov 2023 20:10:23 +0000
References: <20231117104018.3435212-1-sumang@marvell.com>
In-Reply-To: <20231117104018.3435212-1-sumang@marvell.com>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, horms@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 17 Nov 2023 16:10:18 +0530 you wrote:
> During 'ifconfig <netdev> down' one RSS memory was not getting freed.
> This patch fixes the same.
> 
> Fixes: 81a4362016e7 ("octeontx2-pf: Add RSS multi group support")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
> v2 changes:
> - Updated fixes tag
> 
> [...]

Here is the summary with links:
  - [net,v2] octeontx2-pf: Fix memory leak during interface down
    https://git.kernel.org/netdev/net/c/5f228d7c8a53

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


