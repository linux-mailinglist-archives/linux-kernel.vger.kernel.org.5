Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC01792FB0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243357AbjIEUOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243285AbjIEUNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:13:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E98170D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 13:13:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63CF1C4AF6B;
        Tue,  5 Sep 2023 19:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693942937;
        bh=clf9ihjTryZpSG0WkXCr6rYxhHfwNqZRhGkbPC/6m2A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RLLNQnlAYGyA5uuk5IRWGf91BvKrJZSAxixpUmHkK+oAk5/qqGNNiS4KQFKHobj04
         0VjnrOYOm5TE/TddgdPwD3f/hU9tUFQITPLGIwDJFYQ+6NggzxdOM+G+6SjxaLa/8j
         XysUwJG6bZqAdhMG+Fm91j5V8Zrhdi8quUysw67znlApQochFu4vKlP6pJzMiTOYAX
         D0rpayTk0B0MokEoOWePrFU7+p6gZKT1U/Ti8Oro1kMUA9pSe7yBKnR1SOMNqQiWHn
         MAN900UC6H6XowAbBvPEMllrD82sgfOWmuFHzFGf+rGem+nYmKHJw4M0Fz3oDRM9kn
         rxgK6khif2ZEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 504CCC04E24;
        Tue,  5 Sep 2023 19:42:17 +0000 (UTC)
Subject: Re: [GIT PULL] Mailbox changes for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CABb+yY1SbO_reb0kd9oyq8NZ89iZgVG4ab8etQMQOaNQAnsQ4g@mail.gmail.com>
References: <CABb+yY1SbO_reb0kd9oyq8NZ89iZgVG4ab8etQMQOaNQAnsQ4g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <CABb+yY1SbO_reb0kd9oyq8NZ89iZgVG4ab8etQMQOaNQAnsQ4g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v6.6
X-PR-Tracked-Commit-Id: a493208079e299aefdc15169dc80e3da3ebb718a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7733171926cc336ddf0c8f847eefaff569dbff86
Message-Id: <169394293724.11207.4142295662294370847.pr-tracker-bot@kernel.org>
Date:   Tue, 05 Sep 2023 19:42:17 +0000
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 5 Sep 2023 11:02:40 -0500:

> git://git.linaro.org/landing-teams/working/fujitsu/integration.git tags/mailbox-v6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7733171926cc336ddf0c8f847eefaff569dbff86

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
