Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E277D2D7F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjJWJA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjJWJA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:00:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5487598;
        Mon, 23 Oct 2023 02:00:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE44CC433C8;
        Mon, 23 Oct 2023 09:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698051624;
        bh=ZlNpwhUkebIo3i3YOLtax4PKr90vncJVlptPpqAmTzY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WGrAye67GjP4iFW9muOWZAiOfYPRghgFf7X0BhCqiJa1e/h1oHH4dPHGbka/pYkGx
         dZacYXs2sbTKxn1cMrzNqdj+Td9UvaxdxGSqI9DHvnMC30He47mwRFP0k6mYlwCmcm
         nw2s7f6ybZKP10AoM46ruCuWlkTB8TghOMKtGjqjxSiqPhYoblmscQpHjzZDvc6lBf
         Wy32p3uz0vYXfvk7ozWUJE0Jj9dSaehcKUiIAXDp/TyukmAoQYzwWiHHD55mNuI6f+
         p4/WvOM4iCl3BLlun3OQM1SDWfJCswObZvc15CkJhHrG2pCrZqm4wQYLEXybkgWF4p
         3j6G9IEpzUXWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2C03E4CC13;
        Mon, 23 Oct 2023 09:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: lan966x: remove useless code in lan966x_xtr_irq_handler
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169805162379.8476.6620826650761032188.git-patchwork-notify@kernel.org>
Date:   Mon, 23 Oct 2023 09:00:23 +0000
References: <20231020091625.206561-1-suhui@nfschina.com>
In-Reply-To: <20231020091625.206561-1-suhui@nfschina.com>
To:     Su Hui <suhui@nfschina.com>
Cc:     horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
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
by David S. Miller <davem@davemloft.net>:

On Fri, 20 Oct 2023 17:16:26 +0800 you wrote:
> 'err' is useless after break, remove this to save space and
> be more clear.
> 
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/net/ethernet/microchip/lan966x/lan966x_main.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - net: lan966x: remove useless code in lan966x_xtr_irq_handler
    https://git.kernel.org/netdev/net-next/c/6e7ce2d71bb9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


