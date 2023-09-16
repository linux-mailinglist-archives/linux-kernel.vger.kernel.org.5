Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91C47A3219
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 21:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239490AbjIPTAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 15:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239357AbjIPTAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 15:00:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8A9CEC
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 12:00:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6D22C433C9;
        Sat, 16 Sep 2023 19:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694890815;
        bh=YvrybEqyD1OBbFwpUPEUPjOMbcMA7gJNxHtCwUoXJWI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bhw1A5iV8NbG7trkh3Eh0Vra9ThriDFo0XtJG7sc7V0paV/kuHMZ/d/0rP90wK7so
         TYtAn6Qhh8Lmf59x3wZ6Lc+zFj/Ef+F+5t+TzfsTnzouHQVAvOS7B9nzy8Di+Rp0Rp
         AH2/M0aNZWnx+GDu1tdX91zeAT9CjowTXQCPKn79UUQ7WbSvZeKEdO8GP+KVP1QBNV
         VW1vBV9emBNYgXW45yYiDkIjG+cFdmyWvSIWiE6KIKhweh72YjTwnbdlG5qqCHwwVQ
         QmR3+peQcWHEK6ug7jMy5xvUEZ+pUYipuTXDwh7zUUrD6TRUjiDgfSUBMFxQt/sawE
         iIGD1gmXTstgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF01CE26886;
        Sat, 16 Sep 2023 19:00:15 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fix for 6.6-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZQWYhSxtU3PRwKys@kroah.com>
References: <ZQWYhSxtU3PRwKys@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZQWYhSxtU3PRwKys@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.6-rc2
X-PR-Tracked-Commit-Id: 98a15816636044f25be4644db2a3e09fad68aaf7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd455e77a67690aab2aae885fa0e2e2a9b98bd2b
Message-Id: <169489081584.3998.3322348745889254612.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Sep 2023 19:00:15 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 16 Sep 2023 13:59:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.6-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd455e77a67690aab2aae885fa0e2e2a9b98bd2b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
