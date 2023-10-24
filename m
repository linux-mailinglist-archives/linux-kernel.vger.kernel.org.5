Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112EC7D5C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 22:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344266AbjJXUHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 16:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbjJXUHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 16:07:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6588E10C9;
        Tue, 24 Oct 2023 13:07:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08DBDC433C7;
        Tue, 24 Oct 2023 20:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698178059;
        bh=YEn5x0peCWFcUn6I82jAeTej9d5c+CXwzLKfCeKJWC4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=K2ebvd3GqVNFY0qlQj9TTbD30PrJAYfGVawklagNuvFjVpw078+XkB5LdZVfWzqWJ
         VfUrebYh9yxtNYIGrmf+xfVzRwFyG3go+hoUhA7oE0qjaE258qLXduIpyNglCcVfKD
         ErmNNST581bEBb15XHoYsseE+X4+pMcZLEZQTBIpCvC8McK5tnbVSKiagTZyv+r2SF
         hmXznDjz8FSIG29hr1hKyBvNfRpoQNDJVXGjU6kK1ohLlDd1fsOZr80B3f4YKoC/mh
         CeVowElDXgroxaWjJINaztAJnEL4aQfKHubRVzj9VPLjZbaqpMT1/4M57nsZ2hwCB+
         3ikC8KI0zatGw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E90EEC00446;
        Tue, 24 Oct 2023 20:07:38 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231024094608.f2dc0ca5ed2619d411a31df5@linux-foundation.org>
References: <20231024094608.f2dc0ca5ed2619d411a31df5@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20231024094608.f2dc0ca5ed2619d411a31df5@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-10-24-09-40
X-PR-Tracked-Commit-Id: 099d7439ce03d0e7bc8f0c3d7878b562f3a48d3d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4f82870119a46b0d04d91ef4697ac4977a255a9d
Message-Id: <169817805893.26557.15339488130354424058.pr-tracker-bot@kernel.org>
Date:   Tue, 24 Oct 2023 20:07:38 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 24 Oct 2023 09:46:08 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-10-24-09-40

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4f82870119a46b0d04d91ef4697ac4977a255a9d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
