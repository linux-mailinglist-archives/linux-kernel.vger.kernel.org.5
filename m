Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F657D5C9B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 22:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344272AbjJXUu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 16:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjJXUuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 16:50:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A7C10D5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 13:50:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0CA5CC433C7;
        Tue, 24 Oct 2023 20:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698180623;
        bh=MQxUGg4WZh0GcHoAJTOTGgL6noaomPLGUE6jIUxFnpY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=k/Fd3NjFUs8eR8lMB10IHGZnIOJr02axBdxw1hwxAaXI6QKq5h9x505fO/lWgt4WJ
         ISQvP7UnmwQaEUNlrIiMTOeC0E8fODzT1yHY+D45d6WHHnlUqmkPDccMlLwrbzjSER
         IewNT0ga3mUztl1oeI2xmjT+oa0NQEqmqL+97nLVmGNDGKRRnoFmRWgs2PAGSDa+4H
         MButw4raRHeZwvoQTPuVpa3jGVq5HzXePEWIvtKesqrf7Acq+6jxcQ5vvbVDP/zX1b
         SK7lsUZIFicAMxjhxoqDMGOJ1OBlb0mt8LsfFF1P9D/vBtllgAx4IFsLEw4AjCegpg
         VUpWavIhrOzNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB6CDC00446;
        Tue, 24 Oct 2023 20:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 0/2] Switch DSA to inclusive terminology
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169818062289.18293.8593528479742060215.git-patchwork-notify@kernel.org>
Date:   Tue, 24 Oct 2023 20:50:22 +0000
References: <20231023181729.1191071-1-florian.fainelli@broadcom.com>
In-Reply-To: <20231023181729.1191071-1-florian.fainelli@broadcom.com>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
        olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Oct 2023 11:17:27 -0700 you wrote:
> One of the action items following Netconf'23 is to switch subsystems to
> use inclusive terminology. DSA has been making extensive use of the
> "master" and "slave" words which are now replaced by "conduit" and
> "user" respectively.
> 
> Changes in v7:
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/2] net: dsa: Use conduit and user terms
    https://git.kernel.org/netdev/net-next/c/6ca80638b90c
  - [net-next,v7,2/2] net: dsa: Rename IFLA_DSA_MASTER to IFLA_DSA_CONDUIT
    https://git.kernel.org/netdev/net-next/c/87cd83714f30

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


