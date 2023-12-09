Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBFC80B66F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 22:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjLIVLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 16:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbjLIVLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 16:11:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC7210D
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 13:11:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1AD68C433C9;
        Sat,  9 Dec 2023 21:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702156277;
        bh=o5cnQLbIn7gCoU4KyY5lfptQg3sQ6pDCVQRZ6btaU+0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tIwrUP+7k51xJfTbBe5fiEbRbs+eJ6j4owfTdImpnhFYQ4oSr2r5gB+uR8BhCyJtG
         XvNa2MyiPBONN/3UQWPLMjjdQnuaVf4QMk7Cv7SIrTlykDxnhG2yDSHHMWlQXTkuRh
         CN3WrWKHEFJEGDtwMpTLrjX9fPnFHwhGmUkCFjK3n33UuHlPb0lBxfbDcjNA61gBOi
         N83/AOGye6OLKjLwKRvEw4Oi6Grirc62FSQl4o15y6FR/F3V6atzjiEZhOKkjcdzc7
         GLyKGb/TADBGA9pJiDuQJxZuyw22YlaA+jiDEjegVqvCuv4l+29QA6PE91gs0bddJ+
         Edc7I3iUO7oCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0412DC595C5;
        Sat,  9 Dec 2023 21:11:17 +0000 (UTC)
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 6.7-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZXRxWubSRJ4lGC1N@kroah.com>
References: <ZXRxWubSRJ4lGC1N@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZXRxWubSRJ4lGC1N@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.7-rc4
X-PR-Tracked-Commit-Id: e92fad024929c79460403acf946bc9c09ce5c3a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0b5260904b7d2f55e8c4a6ac9f32e7387dc55a75
Message-Id: <170215627701.20711.2690821596404624329.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Dec 2023 21:11:17 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 9 Dec 2023 14:53:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.7-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0b5260904b7d2f55e8c4a6ac9f32e7387dc55a75

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
