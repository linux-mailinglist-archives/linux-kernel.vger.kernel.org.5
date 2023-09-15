Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503347A1AE8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbjIOJlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbjIOJlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:41:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F4E271B
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 02:40:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AA1AC433AB;
        Fri, 15 Sep 2023 09:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694770829;
        bh=bFKjQpw453UYb37vmp6iGpPUutr74DV4YPGJOiP0PE0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UZus89Pi7lV8fg7dmpUO8Kpo9qbTl4+vtKgl5m4GnDY5okugbqS50yxgeY5z2284/
         QbzfW1IMq/TQSkCsRFdH1SjZG+xk0mGuXrnXmDIAlX04fGLtIbk3XaZW2NBBN5gH+m
         NGKJcEz+oMPtR8IIp6R/cclMjE7/NxWvSqVy86UbhiM1JT49p/NAvQv1dXamlyBQwh
         nR504Lyf5ViwOJxHjpVqIxBAi/NnIuzlbeqjK9UdkE51Gi7OlowY9c3H2iiqfgTLT1
         WLccVAJKytM+Ueg64lRXr5zCFbG5hdn14pYOS6UwU5HH9tIxgGJnrqK0yJ9d1Jsrhk
         RNRYFANS6GX0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4F50AE2A03F;
        Fri, 15 Sep 2023 09:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: rtl8366rb: Implement setting up link on
 CPU port
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169477082931.23365.13744641772589361828.git-patchwork-notify@kernel.org>
Date:   Fri, 15 Sep 2023 09:40:29 +0000
References: <20230912-rtl8366rb-link-v1-1-216eed63f357@linaro.org>
In-Reply-To: <20230912-rtl8366rb-link-v1-1-216eed63f357@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     alsi@bang-olufsen.dk, andrew@lunn.ch, f.fainelli@gmail.com,
        olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, 12 Sep 2023 23:24:18 +0200 you wrote:
> We auto-negotiate most ports in the RTL8366RB driver, but
> the CPU port is hard-coded to 1Gbit, full duplex, tx and
> rx pause.
> 
> This isn't very nice. People may configure speed and
> duplex differently in the device tree.
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: rtl8366rb: Implement setting up link on CPU port
    https://git.kernel.org/netdev/net-next/c/7c192ce9ff1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


