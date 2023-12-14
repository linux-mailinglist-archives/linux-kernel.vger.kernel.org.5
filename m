Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1A281254B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 03:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443055AbjLNCaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 21:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443043AbjLNCaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 21:30:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E42F7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 18:30:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 837DFC433C7;
        Thu, 14 Dec 2023 02:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702521025;
        bh=2rh5zd3eRWzbgWaG0DG7tz4dpLVJ0PbF7iaFPCvyK7o=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fGm2N+wqKwRZO7KtLKH70EqnEzcVBpSySY3SOgYBeH58ln3U3VBtm2jkKnhaDEpl2
         pIggMbIorNvi58HQM4DERaFrzlDqmjO0DFzNK2TRKTSHDsnXH2riE3fh1g+MCRh7Zz
         Zu92F1Ys4AE6S4ZbRLQSfG8njdXVxnWk9aSbewnrvwamqUHKkkKAhait5++zEIfZEG
         zG2Ks2T2h8X71s/Qcw/IxU93deAOwe2leOToX1dRcwwyAQw7aMhqJwM7a1YI+TCYRk
         4SjKg+r/L544GBv3GIEFbCMnP0i+7c9P9SyimIk10tS/Bx4wyYKYegC13Bnh+UWO2C
         cE6I1dKQn64OA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6DD80C4314C;
        Thu, 14 Dec 2023 02:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] add support for DP83TG720S PHY
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170252102544.28832.9970361300187316766.git-patchwork-notify@kernel.org>
Date:   Thu, 14 Dec 2023 02:30:25 +0000
References: <20231212054144.87527-1-o.rempel@pengutronix.de>
In-Reply-To: <20231212054144.87527-1-o.rempel@pengutronix.de>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
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

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Dec 2023 06:41:42 +0100 you wrote:
> changes v2:
> - reorder DP83TG720_PHY in Kconfig in Makefile
> - use dp83tg720_config_aneg() directly
> - add Reviewed-by to the first patch
> 
> Oleksij Rempel (2):
>   net: phy: c45: add genphy_c45_pma_read_ext_abilities() function
>   net: phy: Add support for the DP83TG720S Ethernet PHY
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: phy: c45: add genphy_c45_pma_read_ext_abilities() function
    https://git.kernel.org/netdev/net-next/c/0c476157085f
  - [net-next,v2,2/2] net: phy: Add support for the DP83TG720S Ethernet PHY
    https://git.kernel.org/netdev/net-next/c/cb80ee2f9bee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


