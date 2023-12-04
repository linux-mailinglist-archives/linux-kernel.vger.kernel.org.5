Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFF48032B0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbjLDMa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbjLDMaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:30:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3F111F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:30:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DCAFC433D9;
        Mon,  4 Dec 2023 12:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701693025;
        bh=wMNLLARnVn7lDO7b2Jm3vUe6MR5XrNo0+puu3FIqXZI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=F49ToMju1wYi191gI0vXLW1YRMglQ7odTmHpDDeo4NPRrz2uJPpmqjQaPK27hw+HF
         6PTeRguPFNRhcObJkmdME5eLJgjFc993v/sVZgiGhCK9VqwhGJZx14LRH/8nhUFAn+
         qcJ7JNnPeOhvEukA37eBMN10Bl+Q0x54i6+BzLEmlSiGxlP/EoO4w4AB3oJ9uGUiWE
         7iXHE90xW30Ixv+zBWEPf54MKFo9/cDAaHw7ErjKvQec56O9UHIulErq56ttJwKUri
         dJtc8niwr7SgHprJpBRYy3CEc6PJI3nFrKVjtEPRW6sLG6dpzn8WBlbgHwG7L/uNBc
         W5b329P8PHaRw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6804FDD4EEF;
        Mon,  4 Dec 2023 12:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v5 0/2] octeontx2: Multicast/mirror offload changes
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170169302542.7913.11080314543417084382.git-patchwork-notify@kernel.org>
Date:   Mon, 04 Dec 2023 12:30:25 +0000
References: <20231130034324.3900445-1-sumang@marvell.com>
In-Reply-To: <20231130034324.3900445-1-sumang@marvell.com>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lcherian@marvell.com,
        jerinj@marvell.com, horms@kernel.org, wojciech.drewek@intel.com
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

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 30 Nov 2023 09:13:22 +0530 you wrote:
> This patchset includes changes to support TC multicast/mirror offload.
> 
> Patch #1: Adds changes to support new mailbox to offload multicast/mirror
> offload.
> 
> Patch #2: Adds TC related changes which uses the newly added mailboxes to
> offload multicast/mirror rules.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] octeontx2-af: Add new mbox to support multicast/mirror offload
    https://git.kernel.org/netdev/net-next/c/51b2804c19cd
  - [net-next,v5,2/2] octeontx2-pf: TC flower offload support for mirror
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


