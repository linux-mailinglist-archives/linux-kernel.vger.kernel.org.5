Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621B477DA48
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 08:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242043AbjHPGK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 02:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242042AbjHPGKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 02:10:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD8810C0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 23:10:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 279E064945
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 06:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85F26C433C8;
        Wed, 16 Aug 2023 06:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692166221;
        bh=V3LPKpZctepa52hVoRo6EPdhn4r96Y++524j4evK/1Q=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AxMkGng91KqdDiSPifnQBwuD8IJBtEMcyE+LvblbPNZSDdXmxQ4bPSdbaSdHzFjDA
         vij2LnGWiu6/jsOwX8cJNOeM9Rml387gaSjIoOsjYXEUWMyS4JmcjotaDYqcs2Mze/
         S7ndDodXNxv6GJaftqZuQrLP2foiM/feDMJPlw01QZHaYCutTTVuBEYRc36ZZCeJZm
         dZJnPnx5Vnc01RNSTmxxTNm7WYE7hEbmweazwvR+O3GlYFuKePmbyorRJI3OMOYWBm
         6QWP19+KTGvo5JEgWfeokyrw0dyYqk+V+G+DaQzHHloQrIx/ZIA7/zqVsUJy7it+gt
         gw8yk/4LQZ09g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67479E93B34;
        Wed, 16 Aug 2023 06:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] broadcom: b44: Use b44_writephy() return value
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169216622141.7878.1672210323175964763.git-patchwork-notify@kernel.org>
Date:   Wed, 16 Aug 2023 06:10:21 +0000
References: <20230814210030.332859-1-artem.chernyshev@red-soft.ru>
In-Reply-To: <20230814210030.332859-1-artem.chernyshev@red-soft.ru>
To:     Artem Chernyshev <artem.chernyshev@red-soft.ru>
Cc:     michael.chan@broadcom.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 15 Aug 2023 00:00:30 +0300 you wrote:
> Return result of b44_writephy() instead of zero to
> deal with possible error.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
> 
> [...]

Here is the summary with links:
  - broadcom: b44: Use b44_writephy() return value
    https://git.kernel.org/netdev/net/c/9944d203fa63

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


