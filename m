Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FC47BA943
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjJESjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjJESjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:39:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E509790;
        Thu,  5 Oct 2023 11:39:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85911C433C7;
        Thu,  5 Oct 2023 18:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696531175;
        bh=LpfOYGc2Ux9Hp1qTff57llGXpA3isfqJznKBsCrgP/4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YT7eH3AzkFqW7c6hDuXqSLlwsj0Zs47q/wCDm1YymuXGa+fuRspMFs3H5rDP5F05b
         GvU4kOas9i9SIhG6i6azSuO3khgs1ze62u8bB68OL4UpqAenoA8BNTW2o5ABmUt7yO
         /iMtu3PMsp4M9s1/OnJvcZrTvr9+IdbU6hVO8Gi0nE8utBCmbXotAUjWyrMH0FoQWH
         PLdlLVK6Yf/on3Nw5m2rKAXIlwZG7Ff1FVBq4eAF4Ioq74aORdkPKasWuQiKANE7CI
         +NbRP8ZCr20ek3CdUNg4GGQEmJKtxFzKOqRfhC/tD5j31PIo5ci3vW5AOBBcOr9u7X
         ncjUOctORp8PA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74E9FE632D2;
        Thu,  5 Oct 2023 18:39:35 +0000 (UTC)
Subject: Re: [GIT PULL] integrity: susbystem fixes for v6.6 (take 2)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <d213722924c7942bc60fc6b7acf934c8bf6f74e0.camel@linux.ibm.com>
References: <d213722924c7942bc60fc6b7acf934c8bf6f74e0.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <d213722924c7942bc60fc6b7acf934c8bf6f74e0.camel@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.6-fix
X-PR-Tracked-Commit-Id: 91e326563ee34509c35267808a4b1b3ea3db62a8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cb84fb87f325ecd46be586b62623db5b2c0a792e
Message-Id: <169653117547.4044.15970699493171924740.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Oct 2023 18:39:35 +0000
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 05 Oct 2023 11:53:30 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.6-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cb84fb87f325ecd46be586b62623db5b2c0a792e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
