Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9E47EEA1A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 00:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345557AbjKPXua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 18:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKPXu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 18:50:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E09B2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 15:50:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FBD7C433C9;
        Thu, 16 Nov 2023 23:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700178624;
        bh=iZTHuCWoor6S98kuCs5ovo7lTycGWu73FgexY+9G6bs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SWUmcUsOK11BN37F+HI7fUbMsLqLW+sPxdEC2CN+rACWDAL3tBcMELD9z4q+KxTF0
         1unyubO0oyh8RB3mlwzIB9RI3zovNGDtI0PHiHOr1UavW3roI7RCQxIGwupEwmzlsZ
         kwHG+rYz/EIDjhhmnB5Ctmu8wdZIYZ552ksavUMMAOIctVrJzlGgfxy6w/0X4T54HD
         dws8ebNQZTlOwLfSrxUvO6qZodpZ+ITzTKJ1RsP2N3JxNnQur31MQmRHVyKopSwGAb
         SZbRVB09EsE26JCeEmIa0K+W4sSMuVjLoHkMB49PJhpXFr+p6snvBoJK5KJN6LQJMg
         AR9t4MbXd93BA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56C71C4166E;
        Thu, 16 Nov 2023 23:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] stmmac: dwmac-loongson: Add architecture dependency
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170017862435.24110.14803700607535582296.git-patchwork-notify@kernel.org>
Date:   Thu, 16 Nov 2023 23:50:24 +0000
References: <20231115115331.19eb0c24@endymion.delvare>
In-Reply-To: <20231115115331.19eb0c24@endymion.delvare>
To:     Jean Delvare <jdelvare@suse.de>
Cc:     keguang.zhang@gmail.com, linux-mips@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        horms@kernel.org
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 15 Nov 2023 11:53:31 +0100 you wrote:
> Only present the DWMAC_LOONGSON option on architectures where it can
> actually be used.
> 
> This follows the same logic as the DWMAC_INTEL option.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Keguang Zhang <keguang.zhang@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v2] stmmac: dwmac-loongson: Add architecture dependency
    https://git.kernel.org/netdev/net/c/7fbd5fc2b35a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


