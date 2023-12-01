Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81145800938
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378440AbjLALAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378359AbjLALAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:00:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09809197
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 03:00:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2BE5C433CA;
        Fri,  1 Dec 2023 11:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701428425;
        bh=lDz8O3kEJRuixW9zKX5JW7qIlAHXaOgJ6uYeYOFOs58=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jFIl4xpGaY0jY17aAExWUdyHLl1BkrPFLilm8AFqAAJSmgoFqM9dYGWkHmx+IKkVg
         xeNZKHTZIZiH9XiRWAPJ2rDr27WtjMF49+iRdhhJh7cRQe1hgMRw2DHrtuqfLV2wxD
         5WUCZXHVDAEQNvPaMUVQicMOIVemeXFRPm3dRpwSZYPU0tLE0xG8S+d16Cc5G+V7R9
         I4RMtOs2NSQxNJ+nUYJk6EjR2OShXspACMq4PxOLGZQsOP/S2jww91SSghLfV6d07g
         H3yEQ6SSod/J7+R/1JfOV+PVfv6pgTmlBlJpzYTMl6D0WBCQwfGBP+bOXXha5ruEfH
         Y+ksQl2GLWR6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83F03C59A4C;
        Fri,  1 Dec 2023 11:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] octeon_ep: Fix error code in probe()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170142842553.7076.7768114131648140649.git-patchwork-notify@kernel.org>
Date:   Fri, 01 Dec 2023 11:00:25 +0000
References: <cd2c5d69-b515-4933-9443-0a8f1b7fc599@moroto.mountain>
In-Reply-To: <cd2c5d69-b515-4933-9443-0a8f1b7fc599@moroto.mountain>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     srasheed@marvell.com, vburru@marvell.com, sedara@marvell.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
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
by David S. Miller <davem@davemloft.net>:

On Tue, 28 Nov 2023 16:13:19 +0300 you wrote:
> Set the error code if octep_ctrl_net_get_mtu() fails.  Currently the code
> returns success.
> 
> Fixes: 0a5f8534e398 ("octeon_ep: get max rx packet length from firmware")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/net/ethernet/marvell/octeon_ep/octep_main.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net-next] octeon_ep: Fix error code in probe()
    https://git.kernel.org/netdev/net-next/c/0cd523ee8642

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


