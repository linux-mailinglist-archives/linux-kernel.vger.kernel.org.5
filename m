Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB877EBC67
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbjKODu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjKODu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:50:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31F8C1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 19:50:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68E86C433CA;
        Wed, 15 Nov 2023 03:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700020223;
        bh=7f1IBddzYAwzEVP6KQYyZ8VTGi67vxdjPTEJySW1TIM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VD5rkWDjk91pY8UvSwHxsI19OVzsqsaa6OgEjOVzgw8xNi67sMsmpTQHje+oaP8SX
         o2KCRY1XDpjac7Do1rezgwu0782Z6ahjsY29QLW7ZRzFXq+DUEwuwx9WSUEanlQj4O
         imJ3kHV8cjcR+VVAiuYsFj4J4Zk3cfDt9cBwxdUMdoSXnEHTrwZ70z0iqW1UwS0Vpr
         W/nDyLfnJI1eMcsFQaA3vDqmQC9bCNRxKiyx9gq9uFn25BmC1IDeS1SeIX1jIURgU8
         3fUC9c+AKx7yy8dne2xhyo0nwA6xVQePGEzYEothP/yAGr02CXd3SoQ3CjymoGP9IX
         6+vQCv9aqxnTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4D172E1F671;
        Wed, 15 Nov 2023 03:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: tag_rtl4_a: Use existing ETH_P_REALTEK
 constant
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170002022331.9438.484108479461103553.git-patchwork-notify@kernel.org>
Date:   Wed, 15 Nov 2023 03:50:23 +0000
References: <20231113165030.2440083-1-florian.fainelli@broadcom.com>
In-Reply-To: <20231113165030.2440083-1-florian.fainelli@broadcom.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
        olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
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

On Mon, 13 Nov 2023 08:50:30 -0800 you wrote:
> No functional change, uses the existing ETH_P_REALTEK constant already
> defined in if_ether.h.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  net/dsa/tag_rtl4_a.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [net-next] net: dsa: tag_rtl4_a: Use existing ETH_P_REALTEK constant
    https://git.kernel.org/netdev/net-next/c/8fedaaca4071

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


