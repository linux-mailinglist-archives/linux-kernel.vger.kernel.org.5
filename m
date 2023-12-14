Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AAE813436
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 16:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573748AbjLNPLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 10:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573698AbjLNPKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 10:10:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6540A11D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 07:10:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00082C433CA;
        Thu, 14 Dec 2023 15:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702566625;
        bh=zdcPAZnAA+fnlDDoOYRTGowddn9N6RX9Wu2qUUDSKFw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=U+RJZv5r0gLIx1b3cdJt/uFDST4E6gp7GYxQJeBvkUc2GzO+4DjPNLFelmqSpuwWn
         Z0b1KPzxRPu7M4knGDGvD+M3hfJ3mxnvw/LPHA+Rn+J5ayq6MHVO3w7mjFgAU9xqut
         wx6ziqUtWJ2fGWpgUoqcZ6tyekdhUTOpygbSA/pfBBLlr+erR+L/8U2lq7hfNOSUT7
         ebgCoiHesHIsOvd1F6fDdEevhBF4xvdPuQs7QH2ur0Y1aqcZ5QvtwPchHQDSoVDs0q
         KZa3yvx8QSqHHxT6bgjVGbc3jLx+jsn91tktRCTIKouLnDSv6z0QXB9qQpYiTrNO6i
         aI+jcgLBnOcdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9BBCDD4EFB;
        Thu, 14 Dec 2023 15:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: mvpp2: add support for mii
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170256662488.26207.4155748684872594821.git-patchwork-notify@kernel.org>
Date:   Thu, 14 Dec 2023 15:10:24 +0000
References: <20231212141200.62579-1-eichest@gmail.com>
In-Reply-To: <20231212141200.62579-1-eichest@gmail.com>
To:     Stefan Eichenberger <eichest@gmail.com>
Cc:     maxime.chevallier@bootlin.com, mw@semihalf.com,
        linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, 12 Dec 2023 15:12:00 +0100 you wrote:
> Currently, mvpp2 only supports RGMII. This commit adds support for MII.
> The description in Marvell's functional specification seems to be wrong.
> To enable MII, we need to set GENCONF_CTRL0_PORT3_RGMII, while for RGMII
> we need to clear it. This is also how U-Boot handles it.
> 
> Signed-off-by: Stefan Eichenberger <eichest@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: mvpp2: add support for mii
    https://git.kernel.org/netdev/net-next/c/1b666016d0ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


