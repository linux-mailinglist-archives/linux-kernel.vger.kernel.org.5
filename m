Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891F07EA9F7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 06:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjKNFKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 00:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjKNFK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 00:10:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A8219B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 21:10:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4545AC433C7;
        Tue, 14 Nov 2023 05:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699938625;
        bh=kl87Qa43XrJVIA6SL4m5M4POINliuSrCNB/IdAlIdWw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PPzJ3I3q1sWetn+HLI5e73Qg9cqUFbZ/hKAyqJQ9kyis0HzSqiqGvOgLasy1pu0at
         EUSzIJ43At+eduuYD2LI3aMyowGfXMr+ps60XX2de2e7q5QiYtSY5UrxCq0K/0MJ5+
         Sl5LVfBPx9Vu8itQiM1aCL6L8n8S4hNqX9Ri6bsZw6b/845tlg2/1ydhO0P/CmpBfg
         cafbeBgPQvEqelo/z9336Mte943gSJ1OyLCWsKV49fojeZjOifLt+bHIPRO9Ol1gLI
         MMbHBRsXXSQzlPNVT3avfeb3T+GrGc+Je72d1ujeXT887KZdkD9M34068UhmNCPVHv
         gyhWzO9B5hRgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B652E1F674;
        Tue, 14 Nov 2023 05:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/2] r8169: fix DASH devices network lost issue
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169993862517.6042.11181056876450979289.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Nov 2023 05:10:25 +0000
References: <20231109173400.4573-1-hau@realtek.com>
In-Reply-To: <20231109173400.4573-1-hau@realtek.com>
To:     ChunHao Lin <hau@realtek.com>
Cc:     hkallweit1@gmail.com, nic_swsd@realtek.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 Nov 2023 01:33:58 +0800 you wrote:
> This series are used to fix network lost issue on systems that support
> DASH. It has been tested on rtl8168ep and rtl8168fp.
> 
> 
> V3 -> V4: Fix a coding style issue.
> V2 -> V3: Add 'Fixes' tag and correct indentation.
> V1 -> V2: Change variable and function name. And update DASH info message.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/2] r8169: add handling DASH when DASH is disabled
    https://git.kernel.org/netdev/net/c/0ab0c45d8aae
  - [net,v4,2/2] r8169: fix network lost after resume on DASH systems
    https://git.kernel.org/netdev/net/c/868c3b95afef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


