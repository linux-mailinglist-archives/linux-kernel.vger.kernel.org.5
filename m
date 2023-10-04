Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34CFE7B8F58
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 23:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243986AbjJDVac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 17:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbjJDVaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 17:30:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E559E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 14:30:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74238C433C9;
        Wed,  4 Oct 2023 21:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696455027;
        bh=hcaKpy52lF9OHAvmzHXLI5o1ZV1i1ANvqrPW4EAWj3E=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=S/YHDHZ0dcDKjf4y6yyE0nuHSv2Juch7RKAzoYW7UyabSsEwAfZltNDA+QaJ/bVpL
         wYqkwhdE1RZIY7d0oT5CpK5FzCoA7NniqUKZ7Iy8PHSLyuw3YPl0rzCo5G5L4tBT2B
         GQ9vhx+7GtG+QCiREM3XyU6zijIhr3YTGo1/jWkMVq3KzviCAvxu2O7fQf/IZNMHfY
         MD+2o1cW7oEiljGQ7k2XQy8IOUnxf0d0FergsG8wVNQWA8b/tj7OEJFgqr4ED27Y/u
         84xKC+4ueA5fjanjNObM6tJjms0EB2oj5SE+A3Dv7rpDl7aiIZgzbLaf2fqwHiB1Zm
         uy0AwUJkomZ1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5907FE632D8;
        Wed,  4 Oct 2023 21:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] page_pool: fix documentation typos
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169645502736.6604.7880065311843633422.git-patchwork-notify@kernel.org>
Date:   Wed, 04 Oct 2023 21:30:27 +0000
References: <20231001003846.29541-1-rdunlap@infradead.org>
In-Reply-To: <20231001003846.29541-1-rdunlap@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, hawk@kernel.org,
        ilias.apalodimas@linaro.org, netdev@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 30 Sep 2023 17:38:45 -0700 you wrote:
> Correct grammar for better readability.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: netdev@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> 
> [...]

Here is the summary with links:
  - page_pool: fix documentation typos
    https://git.kernel.org/netdev/net/c/513dbc10cfc1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


