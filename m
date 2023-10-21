Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413C57D1ECC
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 19:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjJUR5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 13:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjJUR5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 13:57:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E0DD53;
        Sat, 21 Oct 2023 10:57:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6CDDC433C7;
        Sat, 21 Oct 2023 17:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697911031;
        bh=OmgMcFjdxprGL7OxqmevuJxN+ECdOrcXjUP9GHKMq5M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DM5G1XPdzUsu7NFr8CdBg9IdqdisKKjlJpLtceNsVHrRKEt2MWAyydPrXxyrGiqbN
         Yr3X+U2ajCvxj4A7LxBZPLDawesso22i6cwf5TzNpTj+sqnRMTqyggW9LLofiZdgX0
         XO1JsZ2Nx29TZsI/QriTCqJakmv7UQQUAvEv+QxsW/sZsWBpiNRV2hqOSaN+FGvaH1
         NY5K6Swr9aBvx5+Y0XuZtBNe/94dIxZtAZaCSl9lrsiJC/eDW2X4U9tDWSGebYB8Iv
         VwsqMcluZO4gXC72OtKjBvuX/zTulPu+eNZXZdrSfoRNz2tSf0iPrO9AbA+g9FrOqv
         Iw/eqFJf+EiMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3946C595D7;
        Sat, 21 Oct 2023 17:57:11 +0000 (UTC)
Subject: Re: [GIT PULL] s390 fixes for 6.6-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <your-ad-here.call-01697881440-ext-2458@work.hours>
References: <your-ad-here.call-01697881440-ext-2458@work.hours>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <your-ad-here.call-01697881440-ext-2458@work.hours>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.6-4
X-PR-Tracked-Commit-Id: c1ae1c59c8c6e0b66a718308c623e0cb394dab6b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4d7b04c0cda365f190c4a8f7fddc535b93aae9f9
Message-Id: <169791103173.24251.6435220449877275146.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Oct 2023 17:57:11 +0000
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Oct 2023 11:44:00 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.6-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4d7b04c0cda365f190c4a8f7fddc535b93aae9f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
