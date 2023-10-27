Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272DD7DA3F7
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 01:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjJ0XK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 19:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0XK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 19:10:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902481B1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 16:10:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CC94C433C9;
        Fri, 27 Oct 2023 23:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698448224;
        bh=oGAQr0kUPva3WFPGl1S5GoMtJcUApkO6sLUDwXbAZXA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XI4ClUQZQdam50fw5Qi23xJJ0U/mYc4ILcpo9DKIns0iKBd6girqioTvla/TBiXpe
         sb8KpZhMQX1K3CT/3hhfMNQfTuEQjPcgzIH2+PqHcMg5Ihja5n6UosiH4yuK3/3g0q
         umhix0j+bqbAUv5eEWAH/97O1JLYvwZKScCNZisaB2xDiJCFdrOdWw4Xj5eIlXiPvn
         fZmluJ5HacZ/+53r+DH9fLwhtVz6b310LwtBjC51YEhla4m/rVEMvs0BLgnUQXLtA1
         BiZt1tfzIeqHPM2MGM1jMSx7+2kLhEe7zz1f1eJcZt3wWCKDdKSOTg0a2f/EB4y4rd
         a3PFg8cRepiag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F4020C41620;
        Fri, 27 Oct 2023 23:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V3] net: pcs: xpcs: Add 2500BASE-X case in get state
 for XPCS drivers
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169844822399.29460.5135009526527266388.git-patchwork-notify@kernel.org>
Date:   Fri, 27 Oct 2023 23:10:23 +0000
References: <20231027044306.291250-1-Raju.Lakkaraju@microchip.com>
In-Reply-To: <20231027044306.291250-1-Raju.Lakkaraju@microchip.com>
To:     Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc:     netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, andrew@lunn.ch,
        Jose.Abreu@synopsys.com, linux@armlinux.org.uk,
        fancer.lancer@gmail.com, UNGLinuxDriver@microchip.com
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

On Fri, 27 Oct 2023 10:13:06 +0530 you wrote:
> Add DW_2500BASEX case in xpcs_get_state( ) to update speed, duplex and pause
> 
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> ---
>  drivers/net/pcs/pcs-xpcs.c | 29 +++++++++++++++++++++++++++++
>  drivers/net/pcs/pcs-xpcs.h |  2 ++
>  2 files changed, 31 insertions(+)

Here is the summary with links:
  - [net-next,V3] net: pcs: xpcs: Add 2500BASE-X case in get state for XPCS drivers
    https://git.kernel.org/netdev/net-next/c/f1c73396133c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


