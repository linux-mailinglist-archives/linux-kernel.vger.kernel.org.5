Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537217C81D6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 11:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjJMJUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 05:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjJMJU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 05:20:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F428B7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 02:20:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92DCBC433CA;
        Fri, 13 Oct 2023 09:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697188827;
        bh=UgvGFrvWG4EJprTnN8d19E/uI6Vkq4RefazGkehLIWU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=q2W9lLMVtOVcqbMsbF8jk+vr25MO3lrqlXEeuMhX7bFiI7WxK2wMAavUHE23J3JVO
         zbKObods08x3lK9+A+UjZujicpGh+HdJsPK95ZvMrvCX1PcFAmE/eYvq9HRRETIc7l
         oAPabgG+0+2hvCnUPVPdTDTAkMblxYhcyLbyDvHk0eB/9P2cyGuGvgv5Mfsy1kBMkb
         6a2Rt4b8U1Oej+p9UXAOnNBXlOU0cYdQNAxi9NLvx3AMqDDZ5TRtFzy7dKDP4Gi2bD
         5sKBo1kEqbmy7To8L6jCIpQonfO5LJHHhP6zcDdAzFbTyyJvD0e/xnZqX9d/Pl54qM
         RE1ZiIW/upcJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79990E1F669;
        Fri, 13 Oct 2023 09:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mdio: xgene: Use device_get_match_data()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169718882749.6212.17155020342550479874.git-patchwork-notify@kernel.org>
Date:   Fri, 13 Oct 2023 09:20:27 +0000
References: <20231009172923.2457844-9-robh@kernel.org>
In-Reply-To: <20231009172923.2457844-9-robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     iyappan@os.amperecomputing.com, keyur@os.amperecomputing.com,
        quan@os.amperecomputing.com, andrew@lunn.ch, hkallweit1@gmail.com,
        linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
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

On Mon,  9 Oct 2023 12:29:04 -0500 you wrote:
> Use preferred device_get_match_data() instead of of_match_device() and
> acpi_match_device() to get the driver match data. With this, adjust the
> includes to explicitly include the correct headers.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/net/mdio/mdio-xgene.c | 19 ++++---------------
>  1 file changed, 4 insertions(+), 15 deletions(-)

Here is the summary with links:
  - [net-next] net: mdio: xgene: Use device_get_match_data()
    https://git.kernel.org/netdev/net-next/c/a243ecc323b9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


