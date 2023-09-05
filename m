Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA98792FBD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237863AbjIEUPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243503AbjIEUOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:14:50 -0400
X-Greylist: delayed 340 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 13:14:19 PDT
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D6DCFE;
        Tue,  5 Sep 2023 13:14:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD9FBC4AF6A;
        Tue,  5 Sep 2023 19:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693942952;
        bh=MSwLaPpyN9AMAcUJ3mW8fzs8JAEXiZHfnUW3sLBFxvQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ciCK9Dy/pphS1kDtlkDYdmWdn9eS7vbriktpG6okvjvd6Ed/vE2aHixt8r80I3+gV
         kTXEzQknjNbF0xiW4+s3FlPPV7VeiuF6paBOvFelDtqLRIn2ED71CoZm/T9iMF+P0l
         NQXWlmSwi0Xs3zjvy7RNzJp0vFct7sYaqMzRJcMW3rFFpVNaUEfv4hwba9gDVg1Qhf
         us6Wio9DUtuaSMgtOr+bLNsxSyoAo0jWh3gBn2jon87dOiuwmcPdX9xr0QV9+qDyjn
         NlBkrjbcYQAjFRs+Zus382QtIhtPM4cn2HMbjKgIW8wbKvWS71Y7NOR1n709JLqIHg
         OIdsH4lwV8/Zg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA5BEC2BBF6;
        Tue,  5 Sep 2023 19:42:32 +0000 (UTC)
Subject: Re: [GIT PULL] tpmdd changes for v6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230904202512.29825-1-jarkko@kernel.org>
References: <20230904202512.29825-1-jarkko@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230904202512.29825-1-jarkko@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-v6.6-rc1
X-PR-Tracked-Commit-Id: 8f7f35e5aa6f2182eabcfa3abef4d898a48e9aa8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6155a3b88573757de2649197af30f0e71a12aafe
Message-Id: <169394295269.11207.360579312412141083.pr-tracker-bot@kernel.org>
Date:   Tue, 05 Sep 2023 19:42:32 +0000
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon,  4 Sep 2023 23:25:12 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-v6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6155a3b88573757de2649197af30f0e71a12aafe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
