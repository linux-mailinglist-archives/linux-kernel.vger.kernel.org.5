Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AEC7C5ED1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjJKU6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbjJKU6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:58:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ACB9E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 13:58:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B48CCC433C8;
        Wed, 11 Oct 2023 20:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697057924;
        bh=oNDToCYuLHT3n5LDZIUhRC754yizh4PluWsKDcS0fsY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fADUVKNIbf2jyPjq8YvGwMeyRSPauXddIS8LA1Fx1ptjka1K7gUJ0GSAOO+6sPTRw
         k9r98mEB8peG8FZ+1qH23D3OFQncklkcHP3jSQJoqJAaRe8C2dJ//XNhSq+jozgdA4
         KXYArOF7NkpvCquUqsSnOaOVD6nda0+dQDqrfV+ty/9okd4uUJjAR7sqeaeO4PdmRY
         3aZuVWRFvrZ4rb9YWyMIvn1gw/cStHCKooOd5dsss77K5rEpuOhC8p/RRylXCjRYtT
         MdUjYhdefqkdVoPymRcuCp2Hqoe/Ml8WozrlKrUqoR8nQJI1+hQz4cgq79MRO0sbhb
         FrQpvG76JfdiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 999F5E000BB;
        Wed, 11 Oct 2023 20:58:44 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4wjxfhlg6z5kjfmazfkjfgnsdwrsrzg4muxv7pzts4kojopsfu@wwfmx6547462>
References: <4wjxfhlg6z5kjfmazfkjfgnsdwrsrzg4muxv7pzts4kojopsfu@wwfmx6547462>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <4wjxfhlg6z5kjfmazfkjfgnsdwrsrzg4muxv7pzts4kojopsfu@wwfmx6547462>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023101101
X-PR-Tracked-Commit-Id: dac501397b9d81e4782232c39f94f4307b137452
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bab19d1b21547046b0a38dde948086f6cbcaefaa
Message-Id: <169705792461.2785.10293167895537215870.pr-tracker-bot@kernel.org>
Date:   Wed, 11 Oct 2023 20:58:44 +0000
To:     Benjamin Tissoires <bentiss@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 11 Oct 2023 14:00:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023101101

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bab19d1b21547046b0a38dde948086f6cbcaefaa

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
