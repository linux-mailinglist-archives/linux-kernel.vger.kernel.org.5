Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E664B8044E9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344133AbjLECaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346471AbjLECaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:30:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B91199
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 18:30:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDBFDC433CA;
        Tue,  5 Dec 2023 02:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701743430;
        bh=qBYsl6aQ0xQMITE2+m9eIkoeSdh8tA2Vgeem4Qdn+R4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mFBb47JnuNElMtudHzZw9C7J9KrVDHLBiGbrtwPgPWrbvgrA6AwevhgHyV0+oIfqc
         vIaFizmHIyVEqZIhJ+bV0+gha1BpomkegBMj3U2ICms/ctxwauqfqkbRHz26/QKbuy
         UunXlDrW2KQmRglEZ6KslXWF5LBIZQjcWbv3xyZqJh4lcVIT33tzWSeEehrAKLKIfy
         2g2IEUEZKe0wmMZjrxBViObpE7u+80QHWIN+2H1C2l5iSdRrkwz7sjlUHaZKowEzKr
         Jb8YIKXL7W0TQ3FMwPH54+dBmVYoiRTTxiLPpR+r3+kc3I1Ov+sMVoMgpPfqDXZThT
         8O4bTh3eIUvew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D035FDD4EEF;
        Tue,  5 Dec 2023 02:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: ethernet: ti: davinci_mdio: Update K3 SoCs
 list for errata i2329
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170174342984.25370.2136959719621862059.git-patchwork-notify@kernel.org>
Date:   Tue, 05 Dec 2023 02:30:29 +0000
References: <20231201132033.29576-1-r-gunasekaran@ti.com>
In-Reply-To: <20231201132033.29576-1-r-gunasekaran@ti.com>
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc:     s-vadapalli@ti.com, rogerq@kernel.org, nm@ti.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, andrew@lunn.ch, f.fainelli@gmail.com,
        horms@kernel.org, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org, srk@ti.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 1 Dec 2023 18:50:33 +0530 you wrote:
> The errata i2329 affects all the currently available silicon revisions of
> AM62x, AM64x, AM65x, J7200, J721E and J721S2. So remove the revision
> string from the SoC list.
> 
> The silicon revisions affected by the errata i2329 can be found under
> the MDIO module in the "Advisories by Modules" section of each
> SoC errata document listed below
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: ethernet: ti: davinci_mdio: Update K3 SoCs list for errata i2329
    https://git.kernel.org/netdev/net-next/c/be5fc78a0084

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


