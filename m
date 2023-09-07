Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0854797B27
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343593AbjIGSFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343573AbjIGSFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:05:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87A61704;
        Thu,  7 Sep 2023 11:04:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 530C9C116A0;
        Thu,  7 Sep 2023 18:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694109813;
        bh=GW82k23pYrerK4S2EKqWZjOJqHenALf5989xb3G239E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MClBKh3aK++VeTtfep6auCy1Ju471OufmIwUfCfXyskBdvOqCw74L/hw8/5xX4WJD
         fpEPaoac61zuC3EcmUz/TLYp/7Cxij+5+h32YZL8AbEF1idKtnM/wm3WsjGaB0U/WJ
         BXIqrUuWEgCE9UzxGmWdUqQXN5Arc8Ci6umZYizJVX6AhpYNmqvsE2eJxDESz6d9E1
         F9cnUF5DVE/AUw4W2rX+s0kmJZ2MNP/ewoenaWHbFsEDThFO9EMUraGy3BMvWaIdFE
         n8dEmZc7cfqkQCOHpPlv6Doi5qF2i+1uI1ovlV9+EFsdYxvbBH7gald6bPGq0HFYJe
         Lbzaitm63Okgg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3ED6EE22AFB;
        Thu,  7 Sep 2023 18:03:33 +0000 (UTC)
Subject: Re: [GIT PULL] more s390 updates for 6.6 merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230907112743.6134-E-hca@linux.ibm.com>
References: <20230907112743.6134-E-hca@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-s390.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230907112743.6134-E-hca@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.6-2
X-PR-Tracked-Commit-Id: 06fc3b0d2251b550f530a1c42e0f9c5d022476dd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4a0fc73da97efd23a383ca839e6fe86410268f6b
Message-Id: <169410981324.20847.13981854728636533628.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Sep 2023 18:03:33 +0000
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 7 Sep 2023 13:27:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.6-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4a0fc73da97efd23a383ca839e6fe86410268f6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
