Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0B8797B21
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343569AbjIGSFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343514AbjIGSE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:04:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A979CE7;
        Thu,  7 Sep 2023 11:04:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D131C116A2;
        Thu,  7 Sep 2023 18:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694109819;
        bh=PkJrGNosxNonTMud4l92BUtKxeaLkMXMssFWdpDkhjU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ubB4rTJL91tgPKAWQQjwzsX83U4Xu54q+4YHABd46niC4DJj1xPGggvSk8JVkknaG
         5jf5j/QkDrcxNjykFTRQpzOH1YG0xxKA2qG3csEYKbKXSebzTQat/RQdlBns0nAMG4
         YNrzaWSKuuITICktMlsfmuyCzXujttQoDx8f336LklK1Mb1Q/Hz+LY7NWqyON0V87W
         Exock+ddrXsxqBVlYL537F0twlMVAaTmifJSrpM+A/BEE9PonmVo4BtfLNZNd2DVWC
         Rtc6IhO7feaa/fVKZA0GG4chuJPq6ycfAEuQJ2cRJpM6RmqPND1HUZiGsd2QT2gUNg
         OLknXupG8oWiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C82EE22AFB;
        Thu,  7 Sep 2023 18:03:39 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS changes for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZPjnFLtq9OK+UxZ2@alpha.franken.de>
References: <ZPjnFLtq9OK+UxZ2@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZPjnFLtq9OK+UxZ2@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.6
X-PR-Tracked-Commit-Id: e7513eccb7d7f82e28f4730210b42da71edaa6a6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ac2224a467b499730057525924f6be3f4fdb0da5
Message-Id: <169410981924.20847.11216314988911628772.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Sep 2023 18:03:39 +0000
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 6 Sep 2023 22:54:44 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ac2224a467b499730057525924f6be3f4fdb0da5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
