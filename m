Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505407FE82F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 05:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344460AbjK3EK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 23:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344393AbjK3EKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 23:10:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE23D5C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 20:10:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6B51C433CB;
        Thu, 30 Nov 2023 04:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701317430;
        bh=r3xidSqvuI0+dJ3RDOxCjVb9SdHepAtx4m+M0GnP89Q=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=TSuyBXkbXhWwCTY8S9nL1zuvnfSG99c+CCSNrA2sIdSAXJvWeauWLUN6cX8jDvamg
         6nxdmnWnXl0Kgu7kXXgls+I7QidSlkDce/zrnWwWqHHKnv692kvWzYU3/HA8VIvPZG
         yV6r76VVYz9qdalutNytV5gEJAmAZiGfkWgtaLFfvGWcqqEnwYT/TppqhjjDjGbUW7
         l55BcseHfm0bNOHMVT2j+el2skdHmbuWvtuCLMOMlwaswjLmBVt6AV9LUxNNn9LrHY
         VBbzHfe6jiQsDPFYxJb7s8t7ypzlXG3OvrXRLxCq4qSQt0/H4IZatroNZlx9ysVxzd
         VmBPwWgFe5xSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD19EE00090;
        Thu, 30 Nov 2023 04:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: adin: allow control of Fast Link Down
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170131743075.26382.16499099445744319831.git-patchwork-notify@kernel.org>
Date:   Thu, 30 Nov 2023 04:10:30 +0000
References: <20231127-adin-fld-v1-1-797f6423fd48@axis.com>
In-Reply-To: <20231127-adin-fld-v1-1-797f6423fd48@axis.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     michael.hennerich@analog.com, andrew@lunn.ch, hkallweit1@gmail.com,
        linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@axis.com
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

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Nov 2023 16:31:39 +0100 you wrote:
> Add support to allow Fast Link Down (aka "Enhanced link detection") to
> be controlled via the ETHTOOL_PHY_FAST_LINK_DOWN tunable.  These PHYs
> have this feature enabled by default.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  drivers/net/phy/adin.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: adin: allow control of Fast Link Down
    https://git.kernel.org/netdev/net-next/c/cb2f01b856ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


