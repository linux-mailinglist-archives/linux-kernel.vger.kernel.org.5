Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BEC7C9A03
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 18:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjJOQYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 12:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjJOQYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 12:24:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4D3AB;
        Sun, 15 Oct 2023 09:24:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87A6BC433C7;
        Sun, 15 Oct 2023 16:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697387060;
        bh=WytT5pfC98xJJquM2oSI1iFERWjAqnbzHoPGm0nuJG0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BCSKYXxBnrZpiGnn+cK6dnqfNzF0VK19OPAlo/nX3EQDuggHh0uraa9SoGXR048Hu
         PgdOLvI8Vv28K9QG/XbYtZ+Z2oY0wpVWYB7s1fkQJeX5zuxzrQgOHye2bvPn89s2Mt
         mgXGh7+MuG6TU4CXeZoL1GzKmevr9g+7FeNRE6g3Ts2MxC40ez8PnXEDK5tw/ze9FF
         kjv9vbY5WNNBBwkUN6aJJ9Qt/KBz1xC4ok1aZap5gcr7q3TzqgK6kjat88D1FAuZ1U
         gOSOMl6McYIFP0eqK05ys0k9fHCkk3RXF1pR6swfnkewfOitp6OlybhBDBl1VqW1O4
         Gs6TqKJtlkpXQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 766B0C39563;
        Sun, 15 Oct 2023 16:24:20 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 6.6-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZSwEIUTAuRP2TsiP@kroah.com>
References: <ZSwEIUTAuRP2TsiP@kroah.com>
X-PR-Tracked-List-Id: <linux-serial.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZSwEIUTAuRP2TsiP@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.6-rc6
X-PR-Tracked-Commit-Id: b3fa3cf02e3ce92d32bfdeedd5a6bd0825f55a14
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 41226a360d8f51c13935bbc2ac8925c0fe8d41f7
Message-Id: <169738706048.6658.6035733260087444685.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Oct 2023 16:24:20 +0000
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

The pull request you sent on Sun, 15 Oct 2023 17:24:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.6-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/41226a360d8f51c13935bbc2ac8925c0fe8d41f7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
