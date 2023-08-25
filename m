Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95B278831F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 11:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244106AbjHYJKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 05:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244113AbjHYJKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 05:10:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658231BDB
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 02:10:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 041E867812
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 09:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A4DDC43395;
        Fri, 25 Aug 2023 09:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692954622;
        bh=ayQFeULtvaJ26zGbRRHB3ZHj4umKdAVnrBX2etc2KMg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oLZ2Zc2SF1Yl0cap4gb1Rd2G8PkxwSUBgO3IxRiSP7JNZntxLn1TWVGP+8bfU7Z/P
         X7OoV02RqkRfYTiQ3LoCNsoOcdTJhXScoFPKtBpSUfk2fVqbK/LRZF2LSxW5xO3FpD
         nJgxrfVMutC3HJid7uE+Kxk9TnQkVJnTVYCTdufYIm5GGNqLDPs8CwTEMNnNiTcB4i
         vitL8CsVXiRKIfBXZM1HUbISogVBae3kcV8JuN0mc+PaNgMSZHxGnGNdzXFtCst87d
         bV7TlfpvnL6RHM9feBNpm+tS7GQqHsYhbyhy5S8h18YuOAHq0ZL5mh5c/h3SmxuOAL
         zci0+cyTAbNXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41205E33083;
        Fri, 25 Aug 2023 09:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: fec: add statistics for XDP_TX
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169295462226.4538.9021625369477551979.git-patchwork-notify@kernel.org>
Date:   Fri, 25 Aug 2023 09:10:22 +0000
References: <20230824061150.638251-1-wei.fang@nxp.com>
In-Reply-To: <20230824061150.638251-1-wei.fang@nxp.com>
To:     Wei Fang <wei.fang@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
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
by David S. Miller <davem@davemloft.net>:

On Thu, 24 Aug 2023 14:11:50 +0800 you wrote:
> The FEC driver supports the statistics for XDP actions except for
> XDP_TX before, because the XDP_TX was not supported when adding
> the statistics for XDP. Now the FEC driver has supported XDP_TX
> since commit f601899e4321 ("net: fec: add XDP_TX feature support").
> So it's reasonable and necessary to add statistics for XDP_TX.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: fec: add statistics for XDP_TX
    https://git.kernel.org/netdev/net-next/c/9540329452b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


