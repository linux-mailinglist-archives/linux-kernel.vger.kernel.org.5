Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2201B7EEB38
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 03:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345637AbjKQCu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 21:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQCu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 21:50:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F10D4A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 18:50:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94A58C433D9;
        Fri, 17 Nov 2023 02:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700189423;
        bh=XkytwE5OeOaF3AHN/WW2vcDjb88B6z5uDTCuZBrPtdE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Ay0jfgFbO1/r/ctHswf54erTI/d/qKftw8Jcf25hrPT38L8NU6EcbSevRFP4D6iRy
         KcHnJJ85G2vbkrw7CFU9sbRMXlOjR4CXaRnNeoeVARFbEIR3ii+ULkW0XfwH2zNLVp
         fPOI/D2jhu2EhX/aB7HTK6JN4n1rNBRjxEJCAoFlpdyaRfdTxsiuUohB4ZV1iprYXa
         0y7b2bOvsXaGBLQEWw9mAs6hH0/DZ5MxCWVKP+9REzdTLsjMKBjuvgRiWLUrruezJh
         AqnUE8qeIOX+uZBa9mOTl58jQ3GW8V1fDN8a00HYQenKwOmzkGsDlLQXi+Q09n4QZw
         5umLgDuRivgKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C87BE1F662;
        Fri, 17 Nov 2023 02:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: phy: broadcom: Wire suspend/resume for
 BCM54612E
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170018942350.29552.13239182407636546748.git-patchwork-notify@kernel.org>
Date:   Fri, 17 Nov 2023 02:50:23 +0000
References: <20231116193231.7513-1-marcovr@selfnet.de>
In-Reply-To: <20231116193231.7513-1-marcovr@selfnet.de>
To:     Marco von Rosenberg <marcovr@selfnet.de>
Cc:     florian.fainelli@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Thu, 16 Nov 2023 20:32:31 +0100 you wrote:
> The BCM54612E ethernet PHY supports IDDQ-SR.
> Therefore wire-up the suspend and resume callbacks
> to point to bcm54xx_suspend() and bcm54xx_resume().
> 
> Signed-off-by: Marco von Rosenberg <marcovr@selfnet.de>
> ---
> Changes in v2:
> - Changed commit message
> - Rebased on commit 3753c18ad5cf
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: broadcom: Wire suspend/resume for BCM54612E
    https://git.kernel.org/netdev/net-next/c/380b50ae3a04

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


