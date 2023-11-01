Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1236E7DDC1C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 06:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376300AbjKAEyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 00:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347425AbjKAEy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 00:54:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CFEB9;
        Tue, 31 Oct 2023 21:54:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42076C433C7;
        Wed,  1 Nov 2023 04:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698814466;
        bh=meWhU50y7LafDrRyBWuK/9aGNKfuL+VxjOksseT7cbU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VeafnhFajMTqtvGIwN/E4c5NicRv1gXxGvNwoWJTsTcecbg2OsfOLX9E19X+vqnjA
         M/6fH9RuPFE5FjYFc5lkuF+D7wTy7BpDuHeV2ebLHkAdeLutvbsLuXbCtmXMf/aNPn
         ijfPTkMAxn6XgwcJi9M1/8OOhxx+TbbxBb4fY0jgCJVDKR42oPmKt+/93PQBWHfbPA
         IgBW82OYLv3BkQuZDa4XHONyGpD4ZjdRGabdXLL+/8A1Pt8R3n8j+UgOQv7YzyFxqh
         I6WnDHpeS/nBkNvSW5CRVOYm/lsJpjysQtFsx42vAVZF0zgyam7hpbV9Ylm+W/h91r
         cBoVa/hfTIISg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2DF0CC4166F;
        Wed,  1 Nov 2023 04:54:26 +0000 (UTC)
Subject: Re: [GIT PULL] clk changes for the merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231031213051.2294917-1-sboyd@kernel.org>
References: <20231031213051.2294917-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231031213051.2294917-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus
X-PR-Tracked-Commit-Id: 0a6d7f8275f255eda823c0f0b61d024f6f5b483d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fe4ae2fab00b4751265580c5865fdf23b62d80b3
Message-Id: <169881446618.23637.12053923496145102219.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Nov 2023 04:54:26 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Oct 2023 14:30:50 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fe4ae2fab00b4751265580c5865fdf23b62d80b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
