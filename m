Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7398C7FDDA1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjK2QuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjK2QuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:50:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5B612A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:50:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA8F7C433CA;
        Wed, 29 Nov 2023 16:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701276628;
        bh=QbVMk2yZXzADl36dPyGkoug0MgugmBpHzfmlEiYqjzg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SLZU+YbvnVxffL1w2LpApJpaVLtadIVFAPImSI9JwmzQM92uD/99yU0uieazUu1gR
         NiT9guODT0AlqsUB52xmTyKqoZgKSUkpA4kvzZFu2NXipaNDJ9Co4uZ44duQo0ZROl
         V/WilQaJEwcn02d9sAkYmWj+h3vk8DJyBZWIR5uZWKDF272AsAOYvriWQBZIaZRBgy
         h5mSGrQ5BUxx5g+wv4YiLrXI7YnTKRX/vsVuI+1BhgoiDESdMWmzzH1FzRI5HyYseP
         76GBDco0SKlNaGo+Yv3YeDJktBggrmCjAOf+r+OaPCkAJJJHPE0xRTSunt9t+RZqzU
         /+wm7zWoZUusw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 95EBEDFAA82;
        Wed, 29 Nov 2023 16:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 0/3] Fine-Tune Flow Control and Speed
 Configurations in Microchip KSZ8xxx DSA Driver
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170127662861.14566.16878537775861868899.git-patchwork-notify@kernel.org>
Date:   Wed, 29 Nov 2023 16:50:28 +0000
References: <20231127145101.3039399-1-o.rempel@pengutronix.de>
In-Reply-To: <20231127145101.3039399-1-o.rempel@pengutronix.de>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     davem@davemloft.net, andrew@lunn.ch, edumazet@google.com,
        f.fainelli@gmail.com, kuba@kernel.org, pabeni@redhat.com,
        olteanv@gmail.com, woojung.huh@microchip.com,
        arun.ramadoss@microchip.com, linux@armlinux.org.uk,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
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
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Nov 2023 15:50:58 +0100 you wrote:
> changes v7:
> - make pause configuration depend on MLO_PAUSE_AN
> - use duplex == DUPLEX_HALF
> 
> changes v6:
> - move pause controls out of duplex scope
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/3] net: dsa: microchip: ksz8: Make flow control, speed, and duplex on CPU port configurable
    https://git.kernel.org/netdev/net-next/c/87f062ed853c
  - [net-next,v7,2/3] net: dsa: microchip: ksz8: Add function to configure ports with integrated PHYs
    https://git.kernel.org/netdev/net-next/c/2f58148c41e2
  - [net-next,v7,3/3] net: dsa: microchip: make phylink_mac_link_up() not optional
    https://git.kernel.org/netdev/net-next/c/71cd5ce7e2f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


