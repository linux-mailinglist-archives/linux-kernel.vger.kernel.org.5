Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA720792FBA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbjIEUPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243538AbjIEUOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:14:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FA6E46;
        Tue,  5 Sep 2023 13:14:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3D23C4AF6C;
        Tue,  5 Sep 2023 19:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693942940;
        bh=nIzKaF/CNk5JMmJ8WeUpkpxPU3HklCwe5WbXILsfdD8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tZTDF4oqrJAxROfothlWevOPnQXFjbjBWCj+Mjr68AcmMJ9B/B3lrh3deU+eqczBf
         7ZdAybHHhKTSninu2jOonYVYVfrMSxy6VuKnUSksZC9YrSISM/1Mq7YV+XjwbUf9Mc
         RcdDl81ueOwLLZaaBnXwiRITGtjCntBNfUix7PmY/CP27bGOwSpshY3hRnAkVizs+S
         6Ep/eNkmvxs22GQYJWVnu/7JbI5HmWXb/TFaSHQ1pH5vth8nduSlu94bLUDdnL/84X
         cAV5oUN8Y3FMIWYVgc76o/fk/USIKIQlwg1dCETQAOFjmuJAO8ccPpbdvPCMA2QJFV
         lxtbxk1L3nrqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E38ABC04E24;
        Tue,  5 Sep 2023 19:42:19 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230905115619.0df37e92cd7384252d1aa4ee@linux-foundation.org>
References: <20230905115619.0df37e92cd7384252d1aa4ee@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20230905115619.0df37e92cd7384252d1aa4ee@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-09-05-11-51
X-PR-Tracked-Commit-Id: f4b4f3ec1a310c3de9797271a9c06b7499470d69
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3c5c9b7cfd7d2a2b1e32c2284c82164c1aaa919f
Message-Id: <169394293992.11207.6414439255547966148.pr-tracker-bot@kernel.org>
Date:   Tue, 05 Sep 2023 19:42:19 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        mm-commits@vger.kernel.org, linux-mm@kvack.org,
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

The pull request you sent on Tue, 5 Sep 2023 11:56:19 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-09-05-11-51

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3c5c9b7cfd7d2a2b1e32c2284c82164c1aaa919f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
