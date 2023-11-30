Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0FB7FE842
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 05:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344481AbjK3EUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 23:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344411AbjK3EU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 23:20:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885B910C3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 20:20:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A162C43395;
        Thu, 30 Nov 2023 04:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701318034;
        bh=WRVSttbM2fI7ulLUAoIJ+/ythff6aYAnCIYagmH69MY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=o0I47ENzX4sYr9Yj/nkZ72naIeq1g82dvgq/Z9jELZElbBTQX4O6mflEVZl1VRubR
         fYg+MqAYxJIXuioSvukQiVbm23wqGjqwlFFvfzeIdkEZbHG5uoWHqUXY2E9ZpIpNEF
         OQkr2yaBqRIkrg5eX0gtxL5QPQeNPCtjZ59ckjRIkh+oE6FCtck8c8NlmbZBhY7EmY
         IqyGGJjq/afCWMxpgIZvYJB1ilsTtRE1Buggrb+eFXHiS/WN7EUsYmIcK/0u7BTDRW
         sQsJBKEPm7MyLmbT2eJy8TQP/1slhhvF4eGC4/Mb3HhFBpqaP0TSXGh1AxCieJrz3P
         UuP4Zs5N2SOXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F1699E00092;
        Thu, 30 Nov 2023 04:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 1/1] net: dsa: sja1105: Use units.h instead of the
 copy of a definition
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170131803397.31156.2720750102208492898.git-patchwork-notify@kernel.org>
Date:   Thu, 30 Nov 2023 04:20:33 +0000
References: <20231128175027.394754-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20231128175027.394754-1-andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     vladimir.oltean@nxp.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, olteanv@gmail.com, andrew@lunn.ch,
        f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
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

On Tue, 28 Nov 2023 19:50:27 +0200 you wrote:
> BYTES_PER_KBIT is defined in units.h, use that definition.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/net/dsa/sja1105/sja1105_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net-next,v1,1/1] net: dsa: sja1105: Use units.h instead of the copy of a definition
    https://git.kernel.org/netdev/net-next/c/4b86d7c64e8f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


