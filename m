Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D15801A57
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 05:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjLBEAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 23:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBEAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 23:00:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA84A10EF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 20:00:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F341C433C9;
        Sat,  2 Dec 2023 04:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701489628;
        bh=dmTVe7Jfk5XVaQr11+fG5u2ls/Otpzli4MRTijejyj4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fZtqaapIqszXORqal74nOxtsifAPTl1E24zpUzeiY5QgC7x9LqlAdDgw+Jl8KLggr
         WbID3pVP2kOg9PXHRUBo3ZYbNyrG4Y73rjfC8IfPGRqryqOCwXjSSAksRNE2Gq+6X4
         bAGa+7dG1qOYmVtLMDmwUqIRn+4f5leZPFPi4/9AFiprUFQLo6kLxyaZk9YIjo2IbS
         PpG+KaOHehA2grjZYkbLkVnVpQEJzpDVkOsVjvzu8BcVgsyGFdlKjUTAx0EAu1v629
         Fi3JktkLqIf5oWzTI6fmK2iVTShkdEhLjelsKnL55QAwuoTJ9Og4Ngw9mmB0KrZmzj
         zJnME/YRUpsmw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1FE3EDFAA84;
        Sat,  2 Dec 2023 04:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] Documentation: networking: add missing PLCA messages
 from the message list
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170148962811.21400.18267093303639323876.git-patchwork-notify@kernel.org>
Date:   Sat, 02 Dec 2023 04:00:28 +0000
References: <20231130191400.817948-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20231130191400.817948-1-maxime.chevallier@bootlin.com>
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     davem@davemloft.net, corbet@lwn.net, piergiorgio.beruto@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, linux-doc@vger.kernel.org
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

On Thu, 30 Nov 2023 20:13:59 +0100 you wrote:
> Physical Layer Collision Avoidance messages are correctly documented but
> were left-out of the global list of ethnl messages, add them to the
> list.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  Documentation/networking/ethtool-netlink.rst | 6 ++++++
>  1 file changed, 6 insertions(+)

Here is the summary with links:
  - [net-next] Documentation: networking: add missing PLCA messages from the message list
    https://git.kernel.org/netdev/net-next/c/cc124ad39288

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


