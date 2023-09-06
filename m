Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10844794482
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 22:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244477AbjIFU2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 16:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244416AbjIFU2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 16:28:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1286019A4;
        Wed,  6 Sep 2023 13:28:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE4EBC433C8;
        Wed,  6 Sep 2023 20:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694032110;
        bh=IgiAoxtKQz2xxU7qn0OyC1D8zaG7GjYwxLGuCMTgUUg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RFf47k8L68EPypyJqcHpI03yKMUi099zB7QtDSmGWaoTIrzQnmEg6p61MFjbWHLiS
         VtSqrm4y1nsYInnHYLn8eMIC6T3LjQXj10fwIr28Av2r3rIC4U0GTy/RN3c02dfd0u
         sXHKNx66837U8tBPtEoIXzDQpogTfOUdP9JyW6nnxyh0iEVctVbdb8ceN/7SkSk3+i
         NoHdjfMIbj0GMcLScJoXoGlvvg3o99cfmh2s10NP0Och4AbJBQiVoRitIK0knRABDl
         UW6prlioj6lC40zKahT3/Bdze4JFvZk41otRoGe6VVrvfi95h4azpA/UDvcbt+Nq1Y
         9bYDTQjVvaH9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9B7CEC04D3F;
        Wed,  6 Sep 2023 20:28:30 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph updates for 6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230906162538.1234699-1-idryomov@gmail.com>
References: <20230906162538.1234699-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230906162538.1234699-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-6.6-rc1
X-PR-Tracked-Commit-Id: ce0d5bd3a6c176f9a3bf867624a07119dd4d0878
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ba2090ca64ea1aa435744884124387db1fac70f
Message-Id: <169403211062.32268.7336522343049661277.pr-tracker-bot@kernel.org>
Date:   Wed, 06 Sep 2023 20:28:30 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  6 Sep 2023 18:24:56 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ba2090ca64ea1aa435744884124387db1fac70f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
