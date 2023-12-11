Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0523780C788
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 12:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbjLKLAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 06:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjLKLAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 06:00:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E99D9A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 03:00:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94B90C433C8;
        Mon, 11 Dec 2023 11:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702292423;
        bh=EwaYZi8lnrqN42d+cQ73ITwWtF2b2+uMdvgzEC4w3m8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NoBPf+Vu+FUCIj+/MPxSIZT13YpM8n/viTikNMBMMmQv9hypsXNMB7ei+1jLJVhhO
         QJg0YAPAtMGyyPK+qAJWRaWLzHDbUlGXapC4CSmvWLdTj/pRaW37Q0AesdLX2hIdJf
         OjWiqraacvRoyj1bcv06kVHAzPvLT7sCwYWWzz2fxwBeX+7mCOmE2k/NfSJYdW7AFV
         0HGCMKNUlHmNat/Y1xcIms2cEpCt3MkW2mTspVUQwUwgdjuyss2ymGGUTy8p6dL1PG
         eiaUcPSUk19Hq0rlI5ckicqnSzIQCdCqg9ma0NR+YAQtS6xlpHZLLSy54Y+AzIEjEE
         MRPU+D+GWPjwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7309EDD4F0F;
        Mon, 11 Dec 2023 11:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net] octeontx2-af: Fix pause frame configuration
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170229242346.25377.10383723431789286643.git-patchwork-notify@kernel.org>
Date:   Mon, 11 Dec 2023 11:00:23 +0000
References: <20231208092754.23462-1-hkelam@marvell.com>
In-Reply-To: <20231208092754.23462-1-hkelam@marvell.com>
To:     Hariprasad Kelam <hkelam@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, sgoutham@marvell.com,
        gakula@marvell.com, jerinj@marvell.com, lcherian@marvell.com,
        sbhatta@marvell.com, naveenm@marvell.com, edumazet@google.com,
        pabeni@redhat.com
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

On Fri, 8 Dec 2023 14:57:54 +0530 you wrote:
> The current implementation's default Pause Forward setting is causing
> unnecessary network traffic. This patch disables Pause Forward to
> address this issue.
> 
> Fixes: 1121f6b02e7a ("octeontx2-af: Priority flow control configuration support")
> Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
> Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: Fix pause frame configuration
    https://git.kernel.org/netdev/net/c/e307b5a845c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


