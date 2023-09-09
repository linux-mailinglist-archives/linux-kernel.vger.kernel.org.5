Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A86799A79
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 20:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240426AbjIISxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 14:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240760AbjIISxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 14:53:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4147180
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 11:53:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60289C433C7;
        Sat,  9 Sep 2023 18:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694285618;
        bh=cCV8o8RZexR54ir2GzMaNx/SEO2Z+AihK2w/aA88Z7c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=X6V5TGJq3w1GGm4TYcbOl/eVbJArlqv/bD3oHtzK/6uk7y5IXkSoNL0yfekhhwKds
         euV0vkVyQSC7/N0qKAI7KVyA/0XONwQOpEX4+UiI2DJsv3WNyUySxfo2pughqD/HpT
         fw+Gs6AGXtyoePxThYDcT5yZLOWRdrtJI7vcLuw/Nok2OPYdjhSS9wAJmfCcyNLxU6
         FSbK/35w9tmbi/vWPyYrob+wNQBQjp4JYLauBtwpAC+pgrg7aIZmVWaY3JXz3gsasP
         Z9hdPWsUUlFglkik+vkWdPBu6U50TsKMq6GgFJ1MQ93xKbTgkOqzfJqKrsfg8cWudy
         lm1tlqisOsrmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5008FE22AFC;
        Sat,  9 Sep 2023 18:53:38 +0000 (UTC)
Subject: Re: [GIT PULL] NTB bug fixes for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZPvOgFe6+hUx9SUC@athena.kudzu.us>
References: <ZPvOgFe6+hUx9SUC@athena.kudzu.us>
X-PR-Tracked-List-Id: <ntb.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZPvOgFe6+hUx9SUC@athena.kudzu.us>
X-PR-Tracked-Remote: https://github.com/jonmason/ntb tags/ntb-6.6
X-PR-Tracked-Commit-Id: 643982232860887fed493144957ea5794b6557d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa9d4bf5b738a7fa852bbeabfd8889b127ca3193
Message-Id: <169428561831.13340.2444899037468848459.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Sep 2023 18:53:38 +0000
To:     Jon Mason <jdmason@kudzu.us>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        ntb@lists.linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 8 Sep 2023 21:46:40 -0400:

> https://github.com/jonmason/ntb tags/ntb-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa9d4bf5b738a7fa852bbeabfd8889b127ca3193

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
