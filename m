Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A913D7DA858
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 20:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjJ1SBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 14:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjJ1SAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 14:00:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E44BED;
        Sat, 28 Oct 2023 11:00:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7172C433C9;
        Sat, 28 Oct 2023 18:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698516051;
        bh=qD8iJQQJqrbF6kWZtw2oMxR5JfGak0u1Q7qm2fFi4dc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CspNf02fah6vC7aoJhPPIcyWtyeEn8U2FZjgJ8I+AUwfyW7t3UQpCx2D9a4DYS7Bo
         npihPRVB6JhNNGxbeH+UxuV6CASL9sfZRsXD+dGvXFEwi95liTDAgRHf5S0llLsUo0
         8xRR2DLdmEi2nkPvAtiBs1C1ksZtnTktoz3uKtO1vn5b1edhFlXuE/WCRao9IYUlku
         d1XBP1ZZCwhxHvOvW4HJzjicCwXhEnDsFSgS/6LQp2VejXHbSX9ihu4kgzm4c10PQr
         NcHCJf/Qw8qZvgsfI+dWqlYxq7JFExcwD3UgcPGVq+3YTdj5Ysfol0PZgdrZEaBn2x
         6+Ui8ZbhEF0Hw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1B6DC4316B;
        Sat, 28 Oct 2023 18:00:50 +0000 (UTC)
Subject: Re: [GIT PULL] clk fixes for v6.6-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231028021559.138544-1-sboyd@kernel.org>
References: <20231028021559.138544-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231028021559.138544-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 790437bbe0ef7e5cb5d091dd711c0d61d03945a5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 67d4c87945b2d9678347eaa4567d62dd56dc9713
Message-Id: <169851605085.21060.11865410608873778803.pr-tracker-bot@kernel.org>
Date:   Sat, 28 Oct 2023 18:00:50 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Oct 2023 19:15:58 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/67d4c87945b2d9678347eaa4567d62dd56dc9713

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
