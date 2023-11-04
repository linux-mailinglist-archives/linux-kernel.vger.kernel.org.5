Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF257E0D3A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 03:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbjKDCKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 22:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345145AbjKDCK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 22:10:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D87D60
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 19:10:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B05AC433CD;
        Sat,  4 Nov 2023 02:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699063826;
        bh=zp0QQKoCv25uWPcKHfYtVfeRCAtdEKdh1INVkCito4o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eEBSRE0e9NbCC2FCR921VVZWZ0qoK+QP53ZSeeWudWvQebM4L3mR/ND88WY6Usfso
         U2oEzB3T9XwZ062JrTQe0pr7o2wRgI0+uohcqbN/b93NapCDuba/IdV/8XusdDNyP/
         G9R3nmdpr1LCoiHXg9g9dKcT/ktjEGswwnO4bPRyEk3I8e5SI1PO3vxBdHRP3uY89t
         22ex06oTFuhhVfxkUo1jA+ypTeYkxy4d6LrJfQlM1EV2ni+V4p3/BysIXwhgykw5bo
         8LQzozeIyi1fjSfqLT3kziHnypg2FIhaATlTkQRF9TiO1XZbDdqpmorffGhoqpgSDB
         nFQx5a3h36dew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09B7AC04DD9;
        Sat,  4 Nov 2023 02:10:26 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core changes for 6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZUTiFDLKDO4piYuZ@kroah.com>
References: <ZUTiFDLKDO4piYuZ@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZUTiFDLKDO4piYuZ@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.7-rc1
X-PR-Tracked-Commit-Id: effd7c70eaa0440688b60b9d419243695ede3c45
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b06f58ad8e8c4154bc88d83b4fd70f74ede50193
Message-Id: <169906382603.26291.8616047584099082272.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Nov 2023 02:10:26 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Nov 2023 13:05:40 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b06f58ad8e8c4154bc88d83b4fd70f74ede50193

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
