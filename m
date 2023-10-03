Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9357B65E3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239786AbjJCJu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239789AbjJCJu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:50:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AB9A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 02:50:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D36CC433C7;
        Tue,  3 Oct 2023 09:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696326624;
        bh=XiFGqaj5iaBiPzlCZL8MSPSaOR/Bu9GxFKivnqk5qO8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kDy8qhfcGGw7HlEs0ya5ZWH8ScaIk0A65wtXDSCJfquGwZA/XDTU4A2x6lsqGWqG8
         bufwfMLKGyxJUkMNxMNhOx+FmM7uIdlk3jZabjBQ7GvSiKz5S2KNv4zhwcCmfn7fhT
         SjMq/pKBwo/YikgblH8Z6j/WjDRA+ZC9oX8/1BScWxWd0QkJ0Di+gTmLEkfXwaRoBE
         4FMdOZe8aIhCM1wwTve4/9PrIxMmo/pkRoxaCFBynazx5ERKYzLue+VTPSu6X0CgiF
         MKZIl/F7FnGk6UAY2xmMAo4aWbYsIJuAfK96s/pmstQaInJ/x/5EYePzlAu1Q/TvR/
         35vBkWOS/oZUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1C7D4E270EF;
        Tue,  3 Oct 2023 09:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: amd: Support the Altima AMI101L
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169632662410.31348.9736191366632838999.git-patchwork-notify@kernel.org>
Date:   Tue, 03 Oct 2023 09:50:24 +0000
References: <20230924-ac101l-phy-v1-1-5e6349e28aa4@linaro.org>
In-Reply-To: <20230924-ac101l-phy-v1-1-5e6349e28aa4@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 24 Sep 2023 10:19:02 +0200 you wrote:
> The Altima AC101L is obviously compatible with the AMD PHY,
> as seen by reading the datasheet.
> 
> Datasheet: https://docs.broadcom.com/doc/AC101L-DS05-405-RDS.pdf
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: amd: Support the Altima AMI101L
    https://git.kernel.org/netdev/net-next/c/32030345297e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


