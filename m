Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F9B7CB7A4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 02:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234304AbjJQAu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 20:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbjJQAuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 20:50:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6ACAB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 17:50:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FD67C433D9;
        Tue, 17 Oct 2023 00:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697503823;
        bh=DkNe+sb1qUUikjfjSJQCv2um+u5XrcIqH6/wRieL4Ws=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WNQbMYagesudh6J8PS717CMWggbrz0rO4CqqE2EK5NXJMWYcOG06teQtaiFiSDK8H
         byG71NeB1Vf4thcnkdo/5i7ggpqNhtJxygIYSCufAybPe89hg7Unli1ES9LNAdwMFF
         RlOmJb+Nnw1V8C/WG/rYQ0vYZsnMIoycfH+5plC3fRCrt3ww16eAhLZC9aHgp2Lw24
         zJ/YfKIV/lcXbOSMT1AL8/Tub8QMBtSbag35EjvXY11IqxcDZWXn/ZdEYXmh2Cloob
         cHleFDbLjy25E37fLXVTXKmj2MZt+bt2dnNOEkZ5T/HN4wTs5FOr5yTp0JVoE+DhAm
         dfsVI54GrV2ng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B76DE4E9B6;
        Tue, 17 Oct 2023 00:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] drivers: net: wwan: wwan_core.c: resolved spelling mistake
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169750382310.30000.96151039538434099.git-patchwork-notify@kernel.org>
Date:   Tue, 17 Oct 2023 00:50:23 +0000
References: <20231013042304.7881-1-m.muzzammilashraf@gmail.com>
In-Reply-To: <20231013042304.7881-1-m.muzzammilashraf@gmail.com>
To:     Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Cc:     horms@kernel.org, loic.poulain@linaro.org, ryazanov.s.a@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Oct 2023 09:23:04 +0500 you wrote:
> resolved typing mistake from devce to device
> 
> Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
> 
> changes since v1:
> 	- resolved another typing mistake from concurent to
> 	  concurrent
> 
> [...]

Here is the summary with links:
  - [v2] drivers: net: wwan: wwan_core.c: resolved spelling mistake
    https://git.kernel.org/netdev/net-next/c/97ddc25a368c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


