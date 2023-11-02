Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA7F7DFA07
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377302AbjKBShp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 14:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377294AbjKBShn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 14:37:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D57C134;
        Thu,  2 Nov 2023 11:37:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 18F05C433C7;
        Thu,  2 Nov 2023 18:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698950259;
        bh=c5sjHJ7Yugzt9/JWX6Zj3Sxx9sLa/cYwLMk7my8R0r8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kfSSYx4qV6JSHhUQUG1lv6mlcjiNjHr22kuLzI5Gn8UkhT17lcoeR3wwB7iOJhnzO
         Ia313FuaPlboKQC96az7QnLpiqLOp7g62luHI1OX72KmJpsAeykGzVQPxXHAtmPgzj
         GJNdz5BmcDe33AozfggSmYR1sxsXz7y9gHaxeEvqn70k3cCFnoNQEsDlOIEMhABxbF
         zoMO8wdmaabdqQYkrOe9vMg5CEBcIFCN1nYHcVfIuDIcA33anXwpJj7gqnFAmi2QBE
         2hyb080fZknek2MDfEcB96VwHtyl/bVecm96WW0xSVS08nwNmS3QZINLHr94G35Lhu
         sRxxonRnwV3ew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 08382C4316B;
        Thu,  2 Nov 2023 18:37:39 +0000 (UTC)
Subject: Re: [GIT PULL] integrity: susbystem updates for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <205e07e901e695f4986bf0e4071168302fbf59bc.camel@linux.ibm.com>
References: <205e07e901e695f4986bf0e4071168302fbf59bc.camel@linux.ibm.com>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <205e07e901e695f4986bf0e4071168302fbf59bc.camel@linux.ibm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.7
X-PR-Tracked-Commit-Id: b836c4d29f2744200b2af41e14bf50758dddc818
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca219be012786654d5c802ee892433aaa0016d10
Message-Id: <169895025902.19486.14552524056728187729.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Nov 2023 18:37:39 +0000
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 31 Oct 2023 10:38:46 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git tags/integrity-v6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca219be012786654d5c802ee892433aaa0016d10

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
