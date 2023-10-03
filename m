Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FDE7B65AE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239670AbjJCJkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239669AbjJCJka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:40:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DB0B7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 02:40:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AEE5C433C7;
        Tue,  3 Oct 2023 09:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696326025;
        bh=IlM7vNLyYOgOVkMA9M5pBtwppAuMiD0RWKVDF7JJY5Q=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Sv4PsUsEx4OpAKJDgJ5D3j/UTfW7fC30A+hLDUnSoAwg2YZcRpYjWKEg2MUHhwEQV
         02l/qFC04f03sHNoqAtWk8rK4D9aclKpPa2iZ0EGpwj9mwy6G57o+Fp4imBWcFNkzu
         71JvimYYejq9VqDQu4cs/XkfRt31M+BkJM+xqqRWozB9AatQ6BxkCInQfYEUeoUCDh
         GmOGFov+aU4WCfetWYfc1jwg07DCis/WjIeQOxjkMuI1io/B/hYGxwEa8RkONXjaK5
         HyTjRHeGL6blKGgqD33/bZUVYzzHTOHlMYSWI3FZV5CAgykhLHPUDhofJ5T6B3V1ku
         haMqSETohWyVA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 48558E632D0;
        Tue,  3 Oct 2023 09:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ixp4xx_eth: Specify min/max MTU
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169632602529.26043.5537275057934582250.git-patchwork-notify@kernel.org>
Date:   Tue, 03 Oct 2023 09:40:25 +0000
References: <20230923-ixp4xx-eth-mtu-v1-1-9e88b908e1b2@linaro.org>
In-Reply-To: <20230923-ixp4xx-eth-mtu-v1-1-9e88b908e1b2@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     khalasa@piap.pl, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 23 Sep 2023 20:38:22 +0200 you wrote:
> As we don't specify the MTU in the driver, the framework
> will fall back to 1500 bytes and this doesn't work very
> well when we try to attach a DSA switch:
> 
>   eth1: mtu greater than device maximum
>   ixp4xx_eth c800a000.ethernet eth1: error -22 setting
>   MTU to 1504 to include DSA overhead
> 
> [...]

Here is the summary with links:
  - [net-next] net: ixp4xx_eth: Specify min/max MTU
    https://git.kernel.org/netdev/net-next/c/13efc44ca644

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


