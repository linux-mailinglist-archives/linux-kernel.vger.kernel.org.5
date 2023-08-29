Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3EC78CF64
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 00:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbjH2WK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 18:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234396AbjH2WKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 18:10:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16074194
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 15:10:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4E5261631
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 22:10:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2C33C433C9;
        Tue, 29 Aug 2023 22:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693347000;
        bh=xdJ9aMrAZsdzzeCAz7f0+38zdnn41Drubx0ekQNnTMQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UrpsIYlKwr7qQum0vm+aV6KYVdbNvEkfORVsrW8XDz5P9aoPfvNJ4P156W2Le56nb
         rz7EHbIG1tqrLUXOLsKMvu6OhRXazR9/ZLAsSH9dJCA6SFbD4id9xoF61nKO9yuvK8
         7SWpiTGe1wJ/PS4Y/YHq9ubgiBYMEJNVyNYsnmckEQI9sqhT/egQXo4uILhPkxDx5K
         M6OKRlk9wpIdoVi9/pFw+/74KjoFUB2mzwlciJg6izwTSVV1SMTrjZaJFddQgB1J7T
         K2k4x96PbNvlESt15FuLN+JGnXKDzGbvTr9JwIJiPAgCEdCSt/UL5MXP4yu5DE+jAn
         HcHywVFDYqwKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D059DE29F3B;
        Tue, 29 Aug 2023 22:09:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] Networking for 6.6
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169334699983.14546.13884124780527405842.git-patchwork-notify@kernel.org>
Date:   Tue, 29 Aug 2023 22:09:59 +0000
References: <20230829125950.39432-1-pabeni@redhat.com>
In-Reply-To: <20230829125950.39432-1-pabeni@redhat.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Tue, 29 Aug 2023 14:59:50 +0200 you wrote:
> Hi Linus!
> 
> The following changes since commit b5cc3833f13ace75e26e3f7b51cd7b6da5e9cf17:
> 
>   Merge tag 'net-6.5-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-08-24 08:23:13 -0700)
> 
> are available in the Git repository at:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] Networking for 6.6
    https://git.kernel.org/netdev/net/c/bd6c11bc43c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


