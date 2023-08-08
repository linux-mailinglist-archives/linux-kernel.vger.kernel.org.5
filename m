Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8807736A5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 04:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjHHCaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 22:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHHCaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 22:30:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E397E185
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 19:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E8E66228D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 02:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C990DC433C7;
        Tue,  8 Aug 2023 02:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691461822;
        bh=D2kRQ3VkoXpE7PFHE2sUAvnpdHo0xTZ3G87gfM9SOuM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ljFwLa0qtBLf8m8oR/N6vC+zI7mySw8vbP5MEob2vEBz+fE0V9SJvmWUcfWOA4u7w
         U1RhWk+ljnE0PnKoq0usXp6gVXMzWB1QeD/0iDHTdWCr3fgKhjqbNvH+wGXHNqyNUy
         NGl8OMcw+iFH5ViCol0Gg/Sklj9ox8Iabtj5gSDcLP2iEn9Bq+MkOInZsdF3IaKgCT
         DqL3h7wy66xzqm4WnATLf/uyRHNtPtmUlXIZC2XEQzfh9LwIgNIs64aVNDokmbvA+X
         BVVbBkApOlRuH0yUfQVTZIB99G5AnU5uoOP3dYZzuAnlUC41oQyjekd0I3jNmME2Pl
         XX1FX2NI60Nzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8E33E505D5;
        Tue,  8 Aug 2023 02:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH V5 0/2] octeontx2-af: TC flower offload changes
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169146182268.15123.9072085629750422211.git-patchwork-notify@kernel.org>
Date:   Tue, 08 Aug 2023 02:30:22 +0000
References: <20230804045935.3010554-1-sumang@marvell.com>
In-Reply-To: <20230804045935.3010554-1-sumang@marvell.com>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lcherian@marvell.com,
        jerinj@marvell.com, simon.horman@corigine.com,
        jesse.brandeburg@intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 4 Aug 2023 10:29:33 +0530 you wrote:
> This patchset includes minor code restructuring related to TC
> flower offload for outer vlan and adding support for TC inner
> vlan offload.
> 
> Patch #1 Code restructure to handle TC flower outer vlan offload
> 
> Patch #2 Add TC flower offload support for inner vlan
> 
> [...]

Here is the summary with links:
  - [net-next,V5,1/2] octeontx2-af: Code restructure to handle TC outer VLAN offload
    https://git.kernel.org/netdev/net-next/c/aa07a0f421b5
  - [net-next,V5,2/2] octeontx2-af: TC flower offload support for inner VLAN
    https://git.kernel.org/netdev/net-next/c/21e748354ec2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


