Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E317BC2D5
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 01:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbjJFXK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 19:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbjJFXK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 19:10:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458DE93
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 16:10:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D7ADDC433C8;
        Fri,  6 Oct 2023 23:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696633826;
        bh=iGGXiHCPBXXGPLXYhogX0uB7dLIdsJIP9zkVVpjuKN0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=F64NvOSFDHsstNMHh/SPk3qVziCEuAiomhF3rSTAMMJAsQ1zlFgE74kyesOYKvUMS
         n8VoBTGLsCBEleUfSFgihbCSJXoULN6BiZRouCdDpmYLXgXL0u0GoVR0v+LzvHp45u
         1uoumfnl2mQgu0NsMcXj75J7bDvezdnX6MdhhSv5YGh06h4+uEv6rrYuxPC/tD/iwj
         2nC1AKvVjzYtUTuOTJwawcA7Zhbimro8U/dIsmkeoAc9a3C5TOy8ROYHtXxHxjDY2a
         iYYqfIngm1P46/VVF/Su1jIPF7IjiTMAzD9yDNjW8IqzEzz/YaNPJjAWRqbHLtPo8X
         1zhXzDhT9tOZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5572E632D2;
        Fri,  6 Oct 2023 23:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] net: phy: broadcom: add support for BCM5221 phy
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169663382673.5705.11227398287831475925.git-patchwork-notify@kernel.org>
Date:   Fri, 06 Oct 2023 23:10:26 +0000
References: <20231005182915.153815-1-giulio.benetti@benettiengineering.com>
In-Reply-To: <20231005182915.153815-1-giulio.benetti@benettiengineering.com>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, giulio.benetti+tekvox@benettiengineering.com,
        jimr@tekvox.com, jautry@tekvox.com, matthewm@tekvox.com
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
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Oct 2023 20:29:15 +0200 you wrote:
> From: Giulio Benetti <giulio.benetti+tekvox@benettiengineering.com>
> 
> This patch adds the BCM5221 PHY support by reusing brcm_fet_*()
> callbacks and adding quirks for BCM5221 when needed.
> 
> Cc: Jim Reinhart <jimr@tekvox.com>
> Cc: James Autry <jautry@tekvox.com>
> Cc: Matthew Maron <matthewm@tekvox.com>
> Signed-off-by: Giulio Benetti <giulio.benetti+tekvox@benettiengineering.com>
> 
> [...]

Here is the summary with links:
  - [v4] net: phy: broadcom: add support for BCM5221 phy
    https://git.kernel.org/netdev/net-next/c/3abbd0699b67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


