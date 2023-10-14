Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A6E7C91B5
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 02:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbjJNAK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 20:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjJNAK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 20:10:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326C0C2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 17:10:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AAB43C433C9;
        Sat, 14 Oct 2023 00:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697242224;
        bh=YQ1O9PYmm8sxHyNuoIlrdyVOinwFtmn8ZaOM9uEyT9g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pIrakdREaMHdBdCmvtlgQ+x3HMmObnug6sS9TzVPl01Kp8zAPup/UjHtsTHfnUHWS
         v9/B74Qegjp6pDzTT1emoUu2B1BRHPtZcB5bZWsYzgHa7fiFkupwswwUzLB91VtJd4
         /yLWTeOgHJhJlPvAgqydrTf5aVfefwj6f7vDzUcJtzRBNDb4sOs7wyuxbqZUT8o/As
         uI0dPki2rB+0Ce03HjDZJb6PeI/iKzY7+yVdVLXK6c8DHk1W4dgRjJff1bhYUv4BTB
         S6zWs9gJJIR3CT/ANRlc9bJ1Kv2vTlT4hGK6z/69y8X5pKuWnN0ulL0RBaGu2qdCG+
         1tJDUy7s74t1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8DD44C73FEA;
        Sat, 14 Oct 2023 00:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] octeontx2-af: Enable hardware timestamping for VFs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169724222457.16074.4480556425524593039.git-patchwork-notify@kernel.org>
Date:   Sat, 14 Oct 2023 00:10:24 +0000
References: <20231011121551.1205211-1-saikrishnag@marvell.com>
In-Reply-To: <20231011121551.1205211-1-saikrishnag@marvell.com>
To:     Sai Krishna <saikrishnag@marvell.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sgoutham@marvell.com,
        gakula@marvell.com, richardcochran@gmail.com, lcherian@marvell.com,
        jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com
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
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Oct 2023 17:45:51 +0530 you wrote:
> From: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> Currently for VFs, mailbox returns ENODEV error when hardware timestamping
> enable is requested. This patch fixes this issue. Modified this patch to
> return EPERM error for the PF/VFs which are not attached to CGX/RPM.
> 
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> Signed-off-by: Sunil Kovvuri Goutham <sgoutham@marvell.com>
> Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-af: Enable hardware timestamping for VFs
    https://git.kernel.org/netdev/net-next/c/5ee0a3bd1509

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


