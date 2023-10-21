Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2408F7D1ECA
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 19:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbjJUR5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 13:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbjJUR5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 13:57:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671EE1A4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 10:57:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40669C433C7;
        Sat, 21 Oct 2023 17:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697911028;
        bh=T97bqFs+IuRhOxSDdeYpE85IBYBtHlXC3rl28pbzsLI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mavmawqifxHakA5eE22aXf3KJ7h3L9OritxDJ5JeUPSf+mwJ2SbXbv7CNP7uHRazs
         2toxqCl3ESQv+EvW8iotuTYO5wmczA0NiscSTFzhtVfGdK755WPODPJu5dhlyWesiG
         Lz1mOMf0iyGKTWdWoTCw6MwdEqSZ5bG77rBq9Y4JSCppxYk25Y4ZkAfedggNC4KBcm
         jKY/CPN776/D9bt9vqauJA7LSvycczNnzU5qh9QoKCGZotDVmYbrW1ny+Lqv5FRlg2
         dbJYfZmM/VlEnZaZK8Np/FjgSlX0BqH5daXJrLyRd7gP5slRriVK9R9PxfM6ioBBOO
         YQqNuL98O+AMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E6A8C04DD9;
        Sat, 21 Oct 2023 17:57:08 +0000 (UTC)
Subject: Re: [GIT PULL] USB/Thunderbolt fixes for 6.6-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZTOpf59MXETPspHM@kroah.com>
References: <ZTOpf59MXETPspHM@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZTOpf59MXETPspHM@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.6-rc7
X-PR-Tracked-Commit-Id: 21a68b69f7c16f026bd2e51884520aaf594977cb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bfd4704c82d9041cdd611d5c577f1e57ebf91537
Message-Id: <169791102817.24251.15767400601247092722.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Oct 2023 17:57:08 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 21 Oct 2023 12:35:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.6-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bfd4704c82d9041cdd611d5c577f1e57ebf91537

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
