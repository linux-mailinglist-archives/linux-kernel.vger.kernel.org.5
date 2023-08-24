Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9951A787583
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242608AbjHXQhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242631AbjHXQge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:36:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D92E6A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:36:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91A826666F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 16:36:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC358C433C7;
        Thu, 24 Aug 2023 16:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692894992;
        bh=zojQnKMPjWgB6L+bB1U1uTZbs+PF3pLzI07QWXtDWlI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=W7W6kWy1jbkvL9Jm4GuXRiYtQ1VFxu4zpW8W2i6ypd3sg+Y9fq7ojxZPAFO4DZ95v
         qjEM60Paefq9nbz1aFMJ0wELxNgEnUIZffHtAUSJyU/OTiES5sEp7FHUK2E+N2Myz3
         ruuvhhKj5N906xS4OPDqOW6/2JlfWWdzWIwOc0iZUFFKSTYIc6kQ2oNnLwUuJ8dw2s
         A9AoieoUpGeKn4Jo00BmQBNAGN6AyFOO6KzwQggeS39cJfLUrjoi1T9wn+57zBx1d9
         hvVymuJxlIv/AhbeSs7eFY0qt7hImOKbO473ZfWwH0BsuOTQN5riTzBt29UwVoesmA
         WdrpUtnUce+Xg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8832E21EDF;
        Thu, 24 Aug 2023 16:36:31 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for 6.5-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230824110037.31215-1-pabeni@redhat.com>
References: <20230824110037.31215-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230824110037.31215-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.5-rc8
X-PR-Tracked-Commit-Id: 8938fc0c7e16e0868a1083deadc91b95b72ca0da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b5cc3833f13ace75e26e3f7b51cd7b6da5e9cf17
Message-Id: <169289499187.20770.4238949788785682159.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Aug 2023 16:36:31 +0000
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 24 Aug 2023 13:00:37 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.5-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b5cc3833f13ace75e26e3f7b51cd7b6da5e9cf17

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
