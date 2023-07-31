Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E0A76A35A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 23:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjGaVug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 17:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjGaVu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:50:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4CC10FA
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 14:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F02A612FD
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 21:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92C3DC433D9;
        Mon, 31 Jul 2023 21:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690840222;
        bh=x9PcK620o3Zzuv3B5CDGPiuKOCsyD5bfN04/wXzLiig=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=dj6CV6SOapIGYfK032JrpqCoMjTjRNNyzX1Necig0+hmee7Cw7lBTDYn2jDZBaTT9
         qXQBEkvW/+JV08cREQz+M35XKJ7MRbZUeiFQ0iYp6pb8lWZy5vd2I2dMUJ4+vtY3+b
         w0pKkzeBevBDqzq4Uvp//l/4fesoqTyU5WXzzK8PEAQcs3qKnKLd60Tcvmf8ekFEDU
         +MLq4OhCpLOiC7cAHIJNZeQLsQZyauSNF65yj7uMGJnF+txBp9CxkHI/+AP+L3SmM9
         LUlFfgvpefEmpEf+0aLMw/Sg0qP4cbwQ1Rmq1jkgnziLgJv7CvQl2ImVHI1n1b22/n
         PdktmxmUiJ1gw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78CC3C691D8;
        Mon, 31 Jul 2023 21:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: bcmgenet: Remove TX ring full logging
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169084022248.13504.15633874443409502466.git-patchwork-notify@kernel.org>
Date:   Mon, 31 Jul 2023 21:50:22 +0000
References: <20230728183945.760531-1-florian.fainelli@broadcom.com>
In-Reply-To: <20230728183945.760531-1-florian.fainelli@broadcom.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     netdev@vger.kernel.org, opendmb@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-kernel@vger.kernel.org
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

On Fri, 28 Jul 2023 11:39:45 -0700 you wrote:
> There is no need to spam the kernel log with such an indication, remove
> this message.
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/genet/bcmgenet.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Here is the summary with links:
  - [net-next] net: bcmgenet: Remove TX ring full logging
    https://git.kernel.org/netdev/net-next/c/df41fa677d9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


