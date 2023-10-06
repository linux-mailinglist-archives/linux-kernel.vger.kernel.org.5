Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F3E7BC2BA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 01:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbjJFXAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 19:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbjJFXA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 19:00:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD1AC6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 16:00:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1FB6C433CD;
        Fri,  6 Oct 2023 23:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696633225;
        bh=LfQooawKEYZwQA00sS7p2QtSAGgFWZXkm9YUOOhwqfI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Vjcbllhpiv6s+mK8HJDnSj2c9bsS8IZSy3RkRVqx8K0iky4mR+Yh9NsgAkLqtfEQH
         xth6Vri7SKUh7KZNkHv0HjzAIw613iribuO7rkyW9Z0nRsf5x2pVh40wj/Ml/BmG6z
         6uWLkoGIJy2nPgqadcqUy/yYmqxKy6abUg3FLzrG214CJ/xohDy8C5WyDKLPoX86m6
         X6bdu1UEXyFP83TKFgfIGO10T8DwN7QUunBgwaUsUFXkkRG7ipaJbdm192k0zEICR0
         tcnzDQyxoLiCzvvZ/yUIrWXUlj8XjHdNNu9P8a/8uiU7Q8G7vb2uH7WgZYsLvHu0En
         A42NMwIHy10KQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90C77C595CB;
        Fri,  6 Oct 2023 23:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: ixp4xx_eth: Support changing the MTU
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169663322558.31337.17347302646463011874.git-patchwork-notify@kernel.org>
Date:   Fri, 06 Oct 2023 23:00:25 +0000
References: <20231005-ixp4xx-eth-mtu-v4-1-08c66ed0bc69@linaro.org>
In-Reply-To: <20231005-ixp4xx-eth-mtu-v4-1-08c66ed0bc69@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     khalasa@piap.pl, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jacob.e.keller@intel.com
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

On Thu, 05 Oct 2023 00:43:53 +0200 you wrote:
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
  - [net-next,v4] net: ixp4xx_eth: Support changing the MTU
    https://git.kernel.org/netdev/net-next/c/4f08c2570239

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


