Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82F37BCF81
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 20:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344424AbjJHSG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 14:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343667AbjJHSGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 14:06:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A53A3;
        Sun,  8 Oct 2023 11:06:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE4D2C433C8;
        Sun,  8 Oct 2023 18:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696788413;
        bh=sFe9QsicNO/sEhsjA1ebJO+7rwpvmVWdnUXggdO+3rs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cPRJDlpZ5nd0pGdYXIQnJNJXXXLJI8vF1Ib8AlOd+yMddAhJMRScR3DGlVJDR280c
         dvltkZjs/HcooqAxuLAMY+ZIcx0boQcjk97EedmPMP1xSrKNkRdOalilwe9jYgO7Q+
         Rcf/VyFbG20fRbP6VWDRfYU+ZU28K8S89VloXtYbrIm9bifguZ6kL2d6sriC1FRN9T
         xIbLDTPGXTOp+KibiJtpcvWkGXxqLrmnvYaeKwK2rJ0wUfl7WG9SrIQtKEt05bnyth
         +0u2C9Wp1OesNORS4Mc47wRRhrx4HiY7u4yX6kn8SdkNLinpVqUGJtymvEFatN0Wcc
         MzJGBoJcpudng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94558C395E0;
        Sun,  8 Oct 2023 18:06:53 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mvzuQBU4UKEHMKjSDQHiHsGAx_VPRuwkr2BVcmT81wuCw@mail.gmail.com>
References: <CAH2r5mvzuQBU4UKEHMKjSDQHiHsGAx_VPRuwkr2BVcmT81wuCw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mvzuQBU4UKEHMKjSDQHiHsGAx_VPRuwkr2BVcmT81wuCw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/6.6-rc4-ksmbd-server-fixes
X-PR-Tracked-Commit-Id: 33b235a6e6ebe0f05f3586a71e8d281d00f71e2e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 37faf07bf90ace7c8e34c6b825dcfbb587d2e701
Message-Id: <169678841349.1401.14092376672729979486.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Oct 2023 18:06:53 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 7 Oct 2023 23:27:16 -0500:

> git://git.samba.org/ksmbd.git tags/6.6-rc4-ksmbd-server-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/37faf07bf90ace7c8e34c6b825dcfbb587d2e701

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
