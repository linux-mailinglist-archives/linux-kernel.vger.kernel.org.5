Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBDF7E10AF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 20:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjKDTBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Nov 2023 15:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjKDTBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Nov 2023 15:01:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47411BC;
        Sat,  4 Nov 2023 12:01:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4150BC433C9;
        Sat,  4 Nov 2023 19:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699124497;
        bh=0iBF8JNDUQG9e7wyjbb5dNN0bHGD9z3rewSMcWFt9DU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=coVpa7rOYwcj2cFWzOUC4N6wtPhHI3vjtTKlqwwBsj3lv4id57H6QHXMhV/6J3QaV
         RAFKV68BNc6U4dG0I/ZDUvuyg4C/QbLkT4rd8QEwd3OGt01xR7XXyNlLT4+TG+1B7H
         YowDnk7AgmYwU/HeBQ+bbQDWz7+UwbfwnI8+wn4kUXpbOW5CxJQFtqQFNrBu03Nfx+
         45Ty4ONgPXHZtInWMXgvpB3rBEMulj7PIE3LtMta8iatlu7L+nnGMB8VfmiT6Cmu/9
         w1/dFMOxfyeMkRci5JBN4LRZasvmnzKNbkwfkRvSW5awz5ejo0UZcCqBiu/lssQJ4M
         ZiFWlYs54m+Ng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2EE75C4316B;
        Sat,  4 Nov 2023 19:01:37 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild updates for v6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNATanSD3N_dmwKAGEqEkCLUb7TL2cp67pP-WBWFOWBxG1g@mail.gmail.com>
References: <CAK7LNATanSD3N_dmwKAGEqEkCLUb7TL2cp67pP-WBWFOWBxG1g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNATanSD3N_dmwKAGEqEkCLUb7TL2cp67pP-WBWFOWBxG1g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v6.7
X-PR-Tracked-Commit-Id: 5f56cb030e4bcf14be2233332d5cd83fff62a376
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5c5e048b2417a56b7b52bdbb66d4fc99d0c20dd2
Message-Id: <169912449718.2096.143697306992727298.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Nov 2023 19:01:37 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 4 Nov 2023 01:52:44 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-v6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5c5e048b2417a56b7b52bdbb66d4fc99d0c20dd2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
