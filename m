Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16E6806FFF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378383AbjLFMkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378290AbjLFMkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:40:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F87A11F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 04:40:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECC58C433C9;
        Wed,  6 Dec 2023 12:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701866424;
        bh=23whyrM/zwY69KIWEu+dCCw5TwR1hxeXGhuFwFZBJs0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=eun0QNAbxYmsNTyBMLmLgNsP5fTkKKt8i2faFNcCecFFeVaU7dyz9uFMugKQUeOiy
         j7MTYAoH5gvkEQvmeKtUuJ70jV+/aFXnrqKyd+raSxLy5yz0qdlHQy+z5/FM1vForl
         VDIKOzV53iKAJlmq29YfhAuAYLvTGkfcKaTH1sBMj9CtvkY2eR7M1eHnE8HwBidqvS
         92COczrXCo3XKyZN++NXft6UuxQ6EtMXc+dc5KICtIXWSpac1vp3JBmkOCszgGHw1A
         2gfXyoBRv+P5Y3tWR3JBRgbXK4oRXIzxUW0HkfNBs8CP9WUa2/2KOeyMzBoKrurgsQ
         JoqKQgxGJmMKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0903C395DC;
        Wed,  6 Dec 2023 12:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v2 PATCH] octeontx2-af: cn10k: Increase outstanding LMTST
 transactions
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170186642385.15333.11014383603011832197.git-patchwork-notify@kernel.org>
Date:   Wed, 06 Dec 2023 12:40:23 +0000
References: <20231205055241.26355-1-gakula@marvell.com>
In-Reply-To: <20231205055241.26355-1-gakula@marvell.com>
To:     Geethasowjanya Akula <gakula@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        edumazet@google.com, sgoutham@marvell.com, lcherian@marvell.com,
        jerinj@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
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
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 5 Dec 2023 11:22:41 +0530 you wrote:
> From: Pavan Nikhilesh <pbhagavatula@marvell.com>
> 
> Currently the number of outstanding store transactions issued by AP as
> a part of LMTST operation is set to 1 i.e default value.
> This patch set to max supported value to increase the performance.
> 
> Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] octeontx2-af: cn10k: Increase outstanding LMTST transactions
    https://git.kernel.org/netdev/net-next/c/074ac38d5b95

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


