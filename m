Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7965A7F08A9
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 20:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjKSTwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 14:52:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbjKSTw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 14:52:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC45F2D73
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:50:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7136CC43215;
        Sun, 19 Nov 2023 19:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700423424;
        bh=tVeuXGTjXiBVtcnJmX6Q1zvoplSP6zrWO7tX6XrTLrg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bnkx0MQ6uo/+qoOQt9g4OLuU3tLuQDIpn9kTfscLSKBzkq9H9NHqMYD6xkETw7dTN
         VT2gC++oK4FyycSG0N8KYBV94ieTX78+i4zxN+Sv1iUDCmDl55DfaB78L9NfkSdr9j
         ngzksPxu48R2kN8TYxkkpQsz1FUvRPY7peF0O6pQhSkMMb2b2FASF1brWcFgQkuy2X
         jiKMItTSSgBTgjg99hEz6eKCtBCItbKIh8j1l+2iq8bH5s+91NhCen70Wf6QdtmshX
         7hGrcj0q08rEF0lrQcCHjJAkvs94aVtBB9HA1ZQQzJWzJoo+cco8ct3ujdS0KmDAWw
         bUeL0SiTZGJfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5CF00E000A4;
        Sun, 19 Nov 2023 19:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/4] net: eth: am65-cpsw: add ethtool MAC stats
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170042342437.11006.17023033767080082631.git-patchwork-notify@kernel.org>
Date:   Sun, 19 Nov 2023 19:50:24 +0000
References: <20231117121755.104547-1-rogerq@kernel.org>
In-Reply-To: <20231117121755.104547-1-rogerq@kernel.org>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, vladimir.oltean@nxp.com, s-vadapalli@ti.com,
        r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com, andrew@lunn.ch,
        u.kleine-koenig@pengutronix.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 17 Nov 2023 14:17:51 +0200 you wrote:
> Hi,
> 
> Gets 'ethtool -S eth0 --groups eth-mac' command to work.
> 
> Also set default TX channels to maximum available and does
> cleanup in am65_cpsw_nuss_common_open() error path.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/4] net: ethernet: am65-cpsw: Add standard Ethernet MAC stats to ethtool
    https://git.kernel.org/netdev/net-next/c/67372d7a85fc
  - [v2,net-next,2/4] net: ethernet: ti: am65-cpsw: Re-arrange functions to avoid forward declaration
    https://git.kernel.org/netdev/net-next/c/ac099466961b
  - [v2,net-next,3/4] net: ethernet: am65-cpsw: Set default TX channels to maximum
    https://git.kernel.org/netdev/net-next/c/be397ea3473d
  - [v2,net-next,4/4] net: ethernet: ti: am65-cpsw: Fix error handling in am65_cpsw_nuss_common_open()
    https://git.kernel.org/netdev/net-next/c/ebd7bf60e21c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


