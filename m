Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4D77A304E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 14:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjIPMvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 08:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjIPMub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 08:50:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AD21AB
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 05:50:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1F67C433C8;
        Sat, 16 Sep 2023 12:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694868625;
        bh=is763Roi5ov/kMNn626EbxklsD+DxMGwEaaeBVrFqco=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tPoK2KD8Fm7XkcJhxu92PANpJplpWgdqVnxJRQ4ejRLlxH7B5ACMxlp1VfLFXpe8h
         g2wi15walmPvn0U06nRufqyRBdA8UlTfECVvHyurPDTFEwhir2sljByMdbEzotePVn
         3UZFR8GHhCH0qjrlg4n4KUXFBxV5b7jG0hURIUtwE+WXu0xcldycp9XkhLk4jTDlyf
         WdN5VNO+QrrfWCFtQq1fVKc5WymOigSV+Z/VvULPrFQ45Rb7Re1u6ts4Fw2BAfp7Ib
         Bzd8HlbZNZd/DVJY9nxnW6XkhGifYE9CPxprVFKN4mWBz89owTz4P/k+i0PrRtokTT
         dDe4dyMT5Hc8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A40E9E26887;
        Sat, 16 Sep 2023 12:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/2] net: dsa: microchip: add drive strength
 support
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169486862566.28624.11679449629469023987.git-patchwork-notify@kernel.org>
Date:   Sat, 16 Sep 2023 12:50:25 +0000
References: <20230914075107.2239886-1-o.rempel@pengutronix.de>
In-Reply-To: <20230914075107.2239886-1-o.rempel@pengutronix.de>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     davem@davemloft.net, andrew@lunn.ch, edumazet@google.com,
        f.fainelli@gmail.com, kuba@kernel.org, pabeni@redhat.com,
        olteanv@gmail.com, woojung.huh@microchip.com,
        arun.ramadoss@microchip.com, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, UNGLinuxDriver@microchip.com,
        linux@armlinux.org.uk, devicetree@vger.kernel.org
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

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 14 Sep 2023 09:51:05 +0200 you wrote:
> changes v5:
> - rename milliamp to microamp
> - do not expect negative error code on snprintf
> - set coma after last struct element
> - rename found to have_any_prop
> 
> changes v4:
> - integrate microchip feedback to the ksz9477_drive_strengths comment.
> - add Reviewed-by: Rob Herring <robh@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/2] dt-bindings: net: dsa: microchip: Update ksz device tree bindings for drive strength
    https://git.kernel.org/netdev/net-next/c/e26f40a60f17
  - [net-next,v5,2/2] net: dsa: microchip: Add drive strength configuration
    https://git.kernel.org/netdev/net-next/c/d67d7247f641

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


