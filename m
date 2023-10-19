Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6427CED87
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 03:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbjJSBUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 21:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjJSBU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 21:20:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FB5118
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 18:20:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBF02C433BB;
        Thu, 19 Oct 2023 01:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697678425;
        bh=1VeVn9f9GXJSHSqi4WntOvylPGGVFII5L4gGzP6XraQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VUPjHnZwxAXjupZ8i3XJ+D6hsU5gzFDKm/xR9fdq8PI5ABHbiRdebLVtUSfk6WweT
         5ETzw+tI9ZNCEVIz0cV6RhCIT4dkJJUtXIasptwXhVYSuBleVFzIOqJdYbeyggK7CW
         wFbd3r/yOqt1ufYHRInKAy2wABJ3wjYHFecV1N29EDVkbsCBne6nznhSmU5mUDOMCc
         JJq87Dybd5kSt84BPiH/zxyN9YQFdZJRGMMSTZiAzd8utecvEmBOVYarTwv36in4aF
         Pz6SnuIKkdUaxLrIOarrqEpkmeeKvaBlQ68y0+5//Hi1EYhy9N8bxeSXy1KQ5Cz2C4
         OFqutEUculhFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD1C1E00086;
        Thu, 19 Oct 2023 01:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: phy: bcm7xxx: Add missing 16nm EPHY statistics
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169767842483.18183.2953568289650219207.git-patchwork-notify@kernel.org>
Date:   Thu, 19 Oct 2023 01:20:24 +0000
References: <20231017205119.416392-1-florian.fainelli@broadcom.com>
In-Reply-To: <20231017205119.416392-1-florian.fainelli@broadcom.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     netdev@vger.kernel.org, justin.chen@broadcom.com, andrew@lunn.ch,
        bcm-kernel-feedback-list@broadcom.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
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
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Oct 2023 13:51:19 -0700 you wrote:
> The .probe() function would allocate the necessary space and ensure that
> the library call sizes the nunber of statistics but the callbacks
> necessary to fetch the name and values were not wired up.
> 
> Reported-by: Justin Chen <justin.chen@broadcom.com>
> Fixes: f68d08c437f9 ("net: phy: bcm7xxx: Add EPHY entry for 72165")
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: phy: bcm7xxx: Add missing 16nm EPHY statistics
    https://git.kernel.org/netdev/net/c/6200e00e112c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


