Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAD07DEAFA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 03:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346866AbjKBCwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 22:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347248AbjKBCwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 22:52:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3000C13E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 19:52:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FB5AC433CA;
        Thu,  2 Nov 2023 02:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698893506;
        bh=pfwQNW5exqv5kUaRtPyKXOVkOeUexlFHg0tTzhr6dbs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ad6wzNfQk0kCM9PdhVAGwnGYZTYkxaaqpD2yk1zAYrIlTjMSzYcF4Osgx6zkadIVD
         bdRTeevdYuBeNlvnl2YzYNsHa/3KY/e8Q4mDy7rsiwG8K2441IN+DxYrcKe4mppC58
         b2Yxd5vBgQW0r7nsaIS7tR6REvuciJ+5bx3Hdf7bhSkKJ3fOWXhqHvp/dEnmd7ZRDy
         mgWCF2GWj9V3nYUVltSPWSyoU/YmLFSOJmhwgf6jtL2YlTMojLr7S+rvQO/iP3qBik
         7Tpx+6oXBkG4co0PHN1UFCxCUbPN7MRSCl7Mh7vooZ+D1p/6IFbkdAs0YD0k6RKvA8
         e3dogOisUedgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F6FDC4316B;
        Thu,  2 Nov 2023 02:51:46 +0000 (UTC)
Subject: Re: [GIT PULL v2] Networking for 6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231031210948.2651866-1-kuba@kernel.org>
References: <20231028011741.2400327-1-kuba@kernel.org> <20231031210948.2651866-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231031210948.2651866-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.7-v2
X-PR-Tracked-Commit-Id: f2fbb908112311423b09cd0d2b4978f174b99585
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff269e2cd5adce4ae14f883fc9c8803bc43ee1e9
Message-Id: <169889350612.17707.1762821092621079778.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Nov 2023 02:51:46 +0000
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Oct 2023 14:09:48 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git tags/net-next-6.7-v2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff269e2cd5adce4ae14f883fc9c8803bc43ee1e9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
