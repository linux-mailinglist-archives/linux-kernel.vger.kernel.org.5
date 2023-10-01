Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BD77B497E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 21:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbjJATxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 15:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235365AbjJATxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 15:53:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E8BD9;
        Sun,  1 Oct 2023 12:53:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FA4BC433C8;
        Sun,  1 Oct 2023 19:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696190000;
        bh=RiPuoSqcoQm2ztW8jjvjCxTXY+lfp3+ZLb2gFKslP3Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gJRLtfP2pvxR6H7BsjdAfVqiL5av0SSJkBG9DIL1kCOZ13m4PR2TbEINfSQQ/urmT
         n7uXsahByqcMvAVUE0uHebhk/Pr6ujkSQSQzy/o772ZPTZS5d8g0S3RqB9PnLlPmtK
         yjEcFGNLtoDr6885CXWW95AH5f+7CV02mhywe7zlzZIMsCE4MFzcsYZuZDy+UM/5Bw
         jvejEn5tYzbzoTlQn2YN0ibkTZ/gkCA7w1fa1bJWXLFED/25IzEfY9+H8OyRGE+SeC
         GRIwjPmXCclAb/f6qLfd4Slk9Z0iohlSYYtX211Cjg3up+Q4blx2Tce9QXD0auzTLK
         B8QGvlpcPGPyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 195BFE29AFE;
        Sun,  1 Oct 2023 19:53:20 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 6.6-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZRllLjvypvT34qFa@kroah.com>
References: <ZRllLjvypvT34qFa@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZRllLjvypvT34qFa@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.6-rc4
X-PR-Tracked-Commit-Id: 29346e217b8ab8a52889b88f00b268278d6b7668
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3abd15e25f4d089f7c557685f067ab024b38d641
Message-Id: <169619000009.19173.7293397559349184349.pr-tracker-bot@kernel.org>
Date:   Sun, 01 Oct 2023 19:53:20 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 1 Oct 2023 14:25:18 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.6-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3abd15e25f4d089f7c557685f067ab024b38d641

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
