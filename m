Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41AF37A9DE5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjIUTu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjIUTuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:50:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF453114EF3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:33:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D8DEC433AB;
        Thu, 21 Sep 2023 19:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695324796;
        bh=nX03GEiuuu+hp0P0Zdt7Pg36vckFVqsI3O2RACOz7P8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=K2EEn/0ibQwRfHtFcrVDaLmnBF6WiiPlREB7/8L7Ca2e6LWZWqN3dct3KUjmXxvZU
         ZfCOseM3+GPIi1VEnu0Hf10gp9NTyBn7WnQVi2nfwKY81gnr+45ApJ3wEGLcvFBMQY
         aooI3r9B8LaHOElHwbFO1Jy4xN22+jkJ90hmMaXDn4fOxuNGLwRzZQ65HZVsM5BgO8
         2+pyrMS79rWVIptVL8J1DKw5aAI10vOSbeTKYpUGul4p35D/jJF37oAQ+5OR5ijK87
         wTVUnERP3qetTn/9PDrzeh0flu1lzks6rvA0Cj4NzGwgvF2XjKIWUx9Q05G0wXkMY2
         bv8tMReJ08X1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8BADBC04DD9;
        Thu, 21 Sep 2023 19:33:16 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for 6.6-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230921113117.42035-1-pabeni@redhat.com>
References: <20230921113117.42035-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230921113117.42035-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.6-rc3
X-PR-Tracked-Commit-Id: ecf4392600dd86fce54445b67a0e2995bf96ba51
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 27bbf45eae9ca98877a2d52a92a188147cd61b07
Message-Id: <169532479656.27019.15236754010448590553.pr-tracker-bot@kernel.org>
Date:   Thu, 21 Sep 2023 19:33:16 +0000
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 21 Sep 2023 13:31:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.6-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/27bbf45eae9ca98877a2d52a92a188147cd61b07

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
