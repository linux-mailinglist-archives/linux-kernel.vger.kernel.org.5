Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538AA7DA857
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 20:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjJ1SA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 14:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjJ1SAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 14:00:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527C7F1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 11:00:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2589C433CC;
        Sat, 28 Oct 2023 18:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698516051;
        bh=cWO9C9wMfJ4Z4CMdnOYedt2bMzalEmeDMpqBFYLcCkI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OrM64524Ch2wa+dMdzCng28AOpFz40TM+n9G9V/N1JJ2tPqDWl6RPk2Ud2Zdb9Om8
         JJNfWnvkvIKWXGPNQYdT8rMODmni15pZiyPIw70B5SUQMt2i1jEx8Tvpk+cB9Mq1dk
         XrX5hQnpL/aKm+ItviLbyBxdLVdj+tHC20VhIePrjcWJl2aEG8D+bRPHfVi7yn6Qdi
         AJ9ydqXY0LuTZn/Q+WE2u+cFqQPgRGXWQkL6gjC83xAoMzfz5NzbWlD0vseJuueyPQ
         +TBQT6NDKDn++mM1i6wDC2lghf0Yxt03PXPb9PN/eWiFI3cPRT+vT6MSOTwJofQLyG
         wC9Mo2VWvI1Aw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DDC9BC41620;
        Sat, 28 Oct 2023 18:00:50 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 6.6-final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZTy2I5Y4EnVLIvod@kroah.com>
References: <ZTy2I5Y4EnVLIvod@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZTy2I5Y4EnVLIvod@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.6-final
X-PR-Tracked-Commit-Id: 28926daf731f72d0537767fdbab2a3e06e31190a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db5cda7fd46881f88eee52f3960b7856ddf051fb
Message-Id: <169851605090.21060.9977530625221226893.pr-tracker-bot@kernel.org>
Date:   Sat, 28 Oct 2023 18:00:50 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 Oct 2023 09:20:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.6-final

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db5cda7fd46881f88eee52f3960b7856ddf051fb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
