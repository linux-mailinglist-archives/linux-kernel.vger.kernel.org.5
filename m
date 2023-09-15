Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5E37A1AE1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbjIOJl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233854AbjIOJlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:41:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59402111
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:40:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51841C43391;
        Fri, 15 Sep 2023 09:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694770829;
        bh=XXZXlu4jkSsFPBa7nCHCNpcv/hoVdsXUtmnPt8pFGKI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nGF/bVpGXs9tyr8j72SHZc9ENF+qPFoNAXs5UvZhc4hdQl+7QfErv65y5l4iFiARe
         56Roqqfr31QkVpl4ZnUU+4ORoamPjvzxGLcmEKUaXObC17vKW8S+zT/946CeuBrNpQ
         dwlo2Z+fK49dsfYDM7dMr65NKi3y4go7WdB94+mCI8hDTJPBVVh5dYw20xE95nVy/c
         7GBypUsV8vMRjDYb6X+Vze4rYb9f7LsurRI6LsxQGsqevXZe3qkic9n4OFQ8RYVHU/
         mGGDy+ejMX5grH+zCRtIsQe79f4ini5XBjL4zAeYgPZDwEt60Au0qk08E5qMyoah8G
         /lylLgCfAmBcQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C51AE22AF3;
        Fri, 15 Sep 2023 09:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] octeontx2-pf: Enable PTP PPS output support
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169477082924.23365.9688061553614275175.git-patchwork-notify@kernel.org>
Date:   Fri, 15 Sep 2023 09:40:29 +0000
References: <20230912175116.581412-1-saikrishnag@marvell.com>
In-Reply-To: <20230912175116.581412-1-saikrishnag@marvell.com>
To:     Sai Krishna <saikrishnag@marvell.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sgoutham@marvell.com,
        gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
        richardcochran@gmail.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 12 Sep 2023 23:21:16 +0530 you wrote:
> From: Hariprasad Kelam <hkelam@marvell.com>
> 
> PTP block supports generating PPS output signal on GPIO pin. This patch
> adds the support in the PTP PHC driver using standard periodic output
> interface.
> 
> User can enable/disable/configure PPS by writing to the below sysfs entry
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-pf: Enable PTP PPS output support
    https://git.kernel.org/netdev/net-next/c/35293cb392e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


