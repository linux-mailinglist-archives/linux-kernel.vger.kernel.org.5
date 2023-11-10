Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010CB7E81A0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346373AbjKJSas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:30:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346064AbjKJS17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:27:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83202AD35;
        Fri, 10 Nov 2023 03:00:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4EF4CC433C7;
        Fri, 10 Nov 2023 11:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699614024;
        bh=5al1T1jdDu+2lAGbHeFM/Y4l/1eJyWvVGIt5NoilUG8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OowxffQfbiB/ixXfRru7AMA7och/GvMwqYBHuWWYSmNUdT7f1Z1XlD4zXC8MrEDSl
         WRQyi0XDZ/FFMqf667ZCLzIGLyH3GqNLqYiPoZSwAx1PJV3MC6wBPstAAY84Mv6qDh
         3EUvVinlUVdJ+qeJhgrLMwmb64IJoGguh/sddQ1AR551axmbRKnBebtj3XpiliLTQ2
         /K9ZQxj5kaTeC2MkcYrsS5Zy5HxemwVu38yLqNBux6UlUrRziyeSkHYVtSkWK//bwb
         PdydxFO5f++VEwFGJgLn2qRIfMUM14CyqtElmAKIacuYMOwlMjg+bAxswCBkZ6VfKo
         lhRynBQAMhIFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29593C43158;
        Fri, 10 Nov 2023 11:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] MAINTAINERS: net: Update reviewers for TI's Ethernet
 drivers
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169961402416.16509.13586966017660246315.git-patchwork-notify@kernel.org>
Date:   Fri, 10 Nov 2023 11:00:24 +0000
References: <20231110092749.3618-1-r-gunasekaran@ti.com>
In-Reply-To: <20231110092749.3618-1-r-gunasekaran@ti.com>
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>
Cc:     netdev@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, s-vadapalli@ti.com, nm@ti.com,
        srk@ti.com, rogerq@kernel.org
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

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 10 Nov 2023 14:57:49 +0530 you wrote:
> Grygorii is no longer associated with TI and messages addressed to
> him bounce.
> 
> Add Siddharth, Roger and myself as reviewers.
> 
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> 
> [...]

Here is the summary with links:
  - [v2] MAINTAINERS: net: Update reviewers for TI's Ethernet drivers
    https://git.kernel.org/netdev/net/c/cbe9e68e1e0f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


