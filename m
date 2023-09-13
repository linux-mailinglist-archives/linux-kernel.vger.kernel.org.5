Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C22179F251
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 21:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjIMTor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 15:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjIMTon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:44:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6087C19AD;
        Wed, 13 Sep 2023 12:44:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F15A2C433C9;
        Wed, 13 Sep 2023 19:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694634279;
        bh=23sSVXWQGY9fXgKPYCywRNM4XWQ6GNPRtWbJvOjOdlI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=V7e8/YrVZu3N7o7a0FmpkvNLxzdjjjhokihX7r++VPuXywgArrcyDZQVRqOQZJfpi
         9lVJwid2CHgyn71iB3d5R9b8QlFEk1hn0KRTdkhDJKf48l3XCderzHr1Hyfbxw4Qt8
         /3ilDjLioMymFLN3JxJmFgGd2j7M3JvlS7VeD+XxeDJVdSC7YDydi4tQxesTpWIwmz
         t1D6CCx9cU36wGAeAClwIJCilKkSTjY2xDXMV+fAi1DJToTBkCG3+q9Y/oNCWSLxX+
         nCxHFW+AQNnx/SW3rm4kPz4/UVgiAXo2IWKxAjhPakQr+jYIyArwKIEuMd8soeInqf
         Cs52V4DfVBoyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D33D6E1C281;
        Wed, 13 Sep 2023 19:44:38 +0000 (UTC)
Subject: Re: [GIT PULL] tpmdd changes for v6.6-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230912201102.1012306-1-jarkko@kernel.org>
References: <20230912201102.1012306-1-jarkko@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230912201102.1012306-1-jarkko@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-v6.6-rc2
X-PR-Tracked-Commit-Id: ea72883a3bf11fb09dd1ad4f8328cc040263881a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 23f108dc9ed26100b1489f6a9e99088d4064f56b
Message-Id: <169463427886.14198.1728996739411085710.pr-tracker-bot@kernel.org>
Date:   Wed, 13 Sep 2023 19:44:38 +0000
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Justin M . Forbes" <jforbes@fedoraproject.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 12 Sep 2023 23:11:01 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-v6.6-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/23f108dc9ed26100b1489f6a9e99088d4064f56b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
