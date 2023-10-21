Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8827D7D1CA3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 13:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjJULA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 07:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJULAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 07:00:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF60E9
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 04:00:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19345C433C9;
        Sat, 21 Oct 2023 11:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697886023;
        bh=EGGs2rA0P7U9N9aLbE/lY/EjgINVOXULfVH0cySWkuE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ap3CeC5+7iOeBoD0fcxnyUMsmfCWcXOinV7vMR404J+5p/GAfN0tt/iRahwah0Brj
         2sCYOn5zbG04/p/0yzGO0Wd61BBNKvNsKu2a/SE3UBHfDe1chjBkOe3H3RPlfC7jFp
         ugIZ3S8E0+oOkzx3d8rGctM1hsaBMnXUSpDXfk4gq2pJlzQba2JP/WI+C5l8HO7jJK
         SLQOxfYZe0UVWi6bGfUSiWH9jHqS08VdiPmg0iaBCu6SnMLbDtGUMSFHm+e86Zh0WG
         /PoaJG0MYH9c8Pt2CH+QOM+RG9shzIufHGLGkrESvrT//s5CDtn1lhkzoppt2rJHtW
         dxpGPLfLG4+1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F21FBC04DD9;
        Sat, 21 Oct 2023 11:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/1] net: stmmac: update MAC capabilities when tx
 queues are updated
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169788602298.24143.12150015949890853801.git-patchwork-notify@kernel.org>
Date:   Sat, 21 Oct 2023 11:00:22 +0000
References: <20231020032535.1777746-1-yi.fang.gan@intel.com>
In-Reply-To: <20231020032535.1777746-1-yi.fang.gan@intel.com>
To:     Gan@ci.codeaurora.org, Yi Fang <yi.fang.gan@intel.com>
Cc:     alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mcoquelin.stm32@gmail.com,
        linux@armlinux.org.uk, boon.leong.ong@intel.com,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hong.aun.looi@intel.com, weifeng.voon@intel.com,
        yoong.siang.song@intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 20 Oct 2023 11:25:35 +0800 you wrote:
> From: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>
> 
> Upon boot up, the driver will configure the MAC capabilities based on
> the maximum number of tx and rx queues. When the user changes the
> tx queues to single queue, the MAC should be capable of supporting Half
> Duplex, but the driver does not update the MAC capabilities when it is
> configured so.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] net: stmmac: update MAC capabilities when tx queues are updated
    https://git.kernel.org/netdev/net/c/95201f36f395

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


