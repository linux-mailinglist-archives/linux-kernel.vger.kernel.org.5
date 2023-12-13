Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556B9810EA2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377226AbjLMKk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbjLMKkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:40:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A278DD5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:40:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4146BC433C9;
        Wed, 13 Dec 2023 10:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702464030;
        bh=gBGwDl1h9LJYFn7XjCQfrAYckTOg4O2XoBJu+aLw4kw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=buS71OSkhJhu14QoAMDVI6faG6jGOmaIg903IiEFe40jKr53Kboqu1lp7w+h2EEVw
         oq0bi8/3kXsVandcB4LSIRP7HWzl2rUtp8qcpFnI6WxtCkHyNgl+jylEBpDBLFBCjO
         YTnZgaMSoY3rn4Pznkg0GcB6DlFQhb247m8n6ZjYCtXVshnJc8bufWpQV6XRxWU4+f
         m/R/f7Ee2N+77LBQqe8CnZfUhCN3hHKdvhk4Vl6KN2THYvbV6CbqJeT+MMc4gKuVyQ
         Utk7KmhiIXyz4yjk7B2n8BEXdUhc57TG3EhGThmJWJOkmKFOB7JaqTCfHj3M53XX7T
         mNsVeHPkXOlJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2BB3CDD4EF0;
        Wed, 13 Dec 2023 10:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] net: stmmac: mmc: Support more counters for XGMAC
 Core
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170246403017.27343.5850945742501390562.git-patchwork-notify@kernel.org>
Date:   Wed, 13 Dec 2023 10:40:30 +0000
References: <20231211060828.1629247-1-0x1207@gmail.com>
In-Reply-To: <20231211060828.1629247-1-0x1207@gmail.com>
To:     Furong Xu <0x1207@gmail.com>
Cc:     davem@davemloft.net, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mcoquelin.stm32@gmail.com, jpinto@synopsys.com,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xfr@outlook.com, rock.xu@nio.com
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
by David S. Miller <davem@davemloft.net>:

On Mon, 11 Dec 2023 14:08:28 +0800 you wrote:
> Complete all counters on XGMAC Core.
> These can be useful for debugging.
> 
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/mmc.h     |  14 +++
>  .../net/ethernet/stmicro/stmmac/mmc_core.c    | 117 +++++++++++++++++-
>  .../ethernet/stmicro/stmmac/stmmac_ethtool.c  |  10 ++
>  3 files changed, 140 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net-next,v1] net: stmmac: mmc: Support more counters for XGMAC Core
    https://git.kernel.org/netdev/net-next/c/e5bc1f4c6554

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


