Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF6F75D8E2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 04:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjGVCKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 22:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjGVCKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 22:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710D930D6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 19:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03F9861DC6
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 02:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6BA91C433C7;
        Sat, 22 Jul 2023 02:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689991821;
        bh=LZMXAF3sjY0rOtOE+mG9qozWkjoC4MEsPJb4ux6Pn5M=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=D0+9xPAC3kMEMaUpnnHK/79jVdGVCezCLvQQYELPIHxbhrXJCsU4HzJm4siRe9VOa
         GROZDrn4J7UCFAtDTkW98coIwj446LMuCM3Zmvv9sqNq1s4a5GdjKCQquAcWSlTESh
         MxTAYDV6abxFQHWPLMcrbvQpiIkhrQjaUPQK7Oe5blXbH6a0FVYCLREvvlLwJXRb0a
         UKrtbOyslK+d5NCJMa4PrY6jURGbQI7eAqcd0CeOy9uPotospVbwCCb4T6jknrGqnh
         O5q9jRX/5x+Q9JBUQB7iJFLS6pyJli+reenWKf8sUdn1xOIdCWtKv1/gX3hBPfsCyY
         WaafN+ypOiADg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3DA33C595D0;
        Sat, 22 Jul 2023 02:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] MAINTAINERS: net: fix sort order
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168999182123.11383.18422705757059724914.git-patchwork-notify@kernel.org>
Date:   Sat, 22 Jul 2023 02:10:21 +0000
References: <20230720151107.679668-1-mkl@pengutronix.de>
In-Reply-To: <20230720151107.679668-1-mkl@pengutronix.de>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kernel@pengutronix.de, florian.fainelli@broadcom.com,
        justin.chen@broadcom.com
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

On Thu, 20 Jul 2023 17:11:07 +0200 you wrote:
> Linus seems to like the MAINTAINERS file sorted, see
> c192ac735768 ("MAINTAINERS 2: Electric Boogaloo").
> 
> Since this is currently not the case, restore the sort order.
> 
> Cc: Florian Fainelli <florian.fainelli@broadcom.com>
> Cc: Justin Chen <justin.chen@broadcom.com>
> Fixes: 3abf3d15ffff ("MAINTAINERS: ASP 2.0 Ethernet driver maintainers")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [net-next] MAINTAINERS: net: fix sort order
    https://git.kernel.org/netdev/net-next/c/070e8bd31b28

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


