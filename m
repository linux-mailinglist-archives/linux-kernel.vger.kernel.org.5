Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76A17D2BE3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 09:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbjJWHub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 03:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjJWHu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 03:50:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43AE10C1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 00:50:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5095EC433CA;
        Mon, 23 Oct 2023 07:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698047424;
        bh=+U7j2qtatUoFBI4oFqBF6orCmx8kUC87RsgM91a7bUI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bH3QDLOKGQvA/biusFOqlHRoUUS91fb7+7q/WrBL9iIhY8tZHG1aocjElZWFP8+uu
         kqADhWOjl1uJC73dbc95eD0cjCgJuA4LS8rulNs7Q9CWynHYgMcm4AJ4dh6ANqEDE8
         +H3MLXNLl7IJ7MzdiVFTuFn52Be8ON3QyrY7ugdP23MdAfryaTgapmOj3pXOhz02Xp
         GFE7+KEIhKMPP2EFdNs8NKR95A5I8yPUgBgmy75OVkgUjBeARx/aBJHN/fJyVPanPD
         sAHnBISE+9YUZ11BS0Tb5eu7vOoG4MYnnIWCH/3u617bRQVZniXEEHW8l2ynncwdmT
         Edt3UmNZ/SwlQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3298FE4CC1D;
        Mon, 23 Oct 2023 07:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: atm: Remove redundant check.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169804742420.31388.11517029296336664393.git-patchwork-notify@kernel.org>
Date:   Mon, 23 Oct 2023 07:50:24 +0000
References: <20231020121853.3454896-1-Ilia.Gavrilov@infotecs.ru>
In-Reply-To: <20231020121853.3454896-1-Ilia.Gavrilov@infotecs.ru>
To:     Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, gregkh@linuxfoundation.org, sre@kernel.org,
        rafael@kernel.org, chas@cmf.nrl.navy.mil, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
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
by David S. Miller <davem@davemloft.net>:

On Fri, 20 Oct 2023 12:21:16 +0000 you wrote:
> Checking the 'adev' variable is unnecessary,
> because 'cdev' has already been checked earlier.
> 
> Found by InfoTeCS on behalf of Linux Verification Center
> (linuxtesting.org) with SVACE.
> 
> Fixes: 656d98b09d57 ("[ATM]: basic sysfs support for ATM devices")
> Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
> 
> [...]

Here is the summary with links:
  - [net-next] net: atm: Remove redundant check.
    https://git.kernel.org/netdev/net-next/c/92fc97ae9cfd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


