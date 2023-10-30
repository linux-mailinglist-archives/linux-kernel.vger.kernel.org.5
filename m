Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3D57DC359
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 01:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbjJ3Xu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 19:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236014AbjJ3XuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 19:50:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF4710F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 16:50:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 446ECC433D9;
        Mon, 30 Oct 2023 23:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698709807;
        bh=Kym+QbR4/7BWzvMvmUDF1yOE0dFXk3T6Sk6oSDIVNDU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eoU9m/vdFmV/3nMIkVlmWSwqNz6CFcsNzpiyxSOuADfwpP9dMpY3Rhee9Mu+oyduy
         FxCwUEN3S885OAM0nNZNJ/FR6AX57j/HjR7PwvuYs08hSQ9dAcYj/RZEgZwaDBO2UG
         cIcV9Z7rjA47ZsF7pQ0jLfTXrY0QaFdYmJVyZSWzvnOPfH341HZDdSjFFo04TDEkqW
         6Ed+IVw78gQ0ZJtD5ZYtiFU7HNPiGlB143ddnxN4TZIML+GqGAJt3pl+wYB8f8mBPl
         vcobGYH8bdtznWXZwQkCoio1O6pQiANKv12AglUhYQ4iI30Msb+clBMvSzYL44M1AX
         uFnGlYY1fU/Yg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E420C595D7;
        Mon, 30 Oct 2023 23:50:07 +0000 (UTC)
Subject: Re: [GIT PULL] RAS updates for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231027103552.GBZTuSiMcrT5zPb3Z1@fat_crate.local>
References: <20231027103552.GBZTuSiMcrT5zPb3Z1@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231027103552.GBZTuSiMcrT5zPb3Z1@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras_core_for_6.7_rc1
X-PR-Tracked-Commit-Id: 1bae0cfe4a171ccc5f731426296e45beafa096b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 01ae815c5021532aecf8c5e280cf50cdaa72a9d6
Message-Id: <169870980718.17163.14483227844374272206.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Oct 2023 23:50:07 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Oct 2023 12:35:52 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras_core_for_6.7_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/01ae815c5021532aecf8c5e280cf50cdaa72a9d6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
