Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B705792FAE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243157AbjIEUOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243345AbjIEUNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:13:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D471717
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 13:13:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F2CEC4AF70;
        Tue,  5 Sep 2023 19:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693942953;
        bh=D9ofkmqCwPl7QxfdPiszmo9My3htazP1h/9czH0Pr8I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GaBKC5u1rftfXEsfaFhM/VBRLLTM5YKDWlOISEF1hSeb0VYORjABFeMhbW+sgixPX
         +gnfTvsH5m3ryYYhcn/QPP7U7fecx3R/Fbe0EowbPIU7aIc+L2+0ul2Jo2fJNpWOFO
         ILJodU0TLPH8zVDKVhI4UcXD4ZamWABSK4+28HNKnjkr2f/EsNpm8uBfEib9WjSGJp
         LS0e300DEtdCtxfZN0hzVlrBWWoXvu0WuetC8j0kq8nlh97Y7giuhaiuU9YUFd+DhM
         otGXofNXjy8aNt/bxyCO/7NRwblTs5zHHWIcJ7efjLMzv0DnsPQk7lKg1O08aFuQqy
         XwAIveiA7oJ5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E2E5C2BBF6;
        Tue,  5 Sep 2023 19:42:33 +0000 (UTC)
Subject: Re: [GIT PULL] arch/microblaze patches for 6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <6d8d829b-0ca5-8f8c-8b62-a9736b26b586@monstr.eu>
References: <6d8d829b-0ca5-8f8c-8b62-a9736b26b586@monstr.eu>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6d8d829b-0ca5-8f8c-8b62-a9736b26b586@monstr.eu>
X-PR-Tracked-Remote: git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v6.6
X-PR-Tracked-Commit-Id: 0d2b49479bf91c857d83608da7b64328e556dff7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 893a259caa6f08477bff2bccf1df0cdff38271ac
Message-Id: <169394295338.11207.3801147091607133953.pr-tracker-bot@kernel.org>
Date:   Tue, 05 Sep 2023 19:42:33 +0000
To:     Michal Simek <monstr@monstr.eu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 5 Sep 2023 16:59:43 +0200:

> git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/893a259caa6f08477bff2bccf1df0cdff38271ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
