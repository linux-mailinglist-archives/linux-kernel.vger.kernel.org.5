Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9BE752C4E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 23:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbjGMVld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 17:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbjGMVlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 17:41:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2451FC0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 14:41:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EBC261B36
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 21:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77B0FC433C7;
        Thu, 13 Jul 2023 21:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689284489;
        bh=IcII+NxPvhFSzsqRXI7pfW26hOmMapasS2oE0JpvGtg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bV8OqkQRk6ppgmron+FMhynSM+5IcDZ5ZB7/egtm8TVMSCL+vl+TPpxEhtHkFhxE0
         Ja5R55b631rKOxuq986Kse7Ys8aO9dQJiJWx73a4Bo9GJMmH9zFU6h9nsK6MevLcfK
         w1LAmTmMu0OZ87NR5LGV1k1bf/P7N3dTurwCvvHwGNhtTnrr6xN9Xxb9boySK+jqkB
         p9RA2C3WmcMMJtSQQm+AEFsMlCV9XQVaB/0vI7ZX7rzbQmfD54me7YcTUKjRG3pqT2
         Ao+WCoekbNXInOHq973eI6PHhMAjHulyJRhEyKNznPYBc4+lz0JOxCeW9qnK9TkZvR
         GuqZYkMtOk0OQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6510CE29F42;
        Thu, 13 Jul 2023 21:41:29 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for 6.5-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230713110415.38918-1-pabeni@redhat.com>
References: <20230713110415.38918-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230713110415.38918-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.5-rc2
X-PR-Tracked-Commit-Id: 9d23aac8a85f69239e585c8656c6fdb21be65695
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b1983d427a53911ea71ba621d4bf994ae22b1536
Message-Id: <168928448940.12038.6513241835374231625.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Jul 2023 21:41:29 +0000
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 13 Jul 2023 13:04:15 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.5-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b1983d427a53911ea71ba621d4bf994ae22b1536

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
