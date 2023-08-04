Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D39A7708A1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjHDTHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjHDTHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:07:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F304C31;
        Fri,  4 Aug 2023 12:07:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90EF862117;
        Fri,  4 Aug 2023 19:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4EC0C433CB;
        Fri,  4 Aug 2023 19:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691176019;
        bh=Si8mKMmU+2S51Ei+wPkD9B0dk1cGjcd7B1DMlcpvunE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KWkk/41UXqDzIw0GlElzvkchvPYoBLV8wZjdRabvrHEPCzs2It+oXnG0YeE63hys7
         0p7ef2f6dU+IDnldBx1Qj4Xc6MCEa9ka2uSL0QgBmCjXlpSk0hsZoZhND86cosTGmh
         LKlD+qYLt0YhF3J7nEDcsUZNRUQFqIcdin6oYccXAtpLJbj8ueuss/nYaI5C4pKP4/
         HJcKP4XaHdqZ+RzhRdFohG/gbhjjNCu1piqNJDsu5CshN25bNJBBuWANyBfzx09xkY
         ZPvEqexf6206CqJQ0QPfhdr+PgFb4Meom+Aa+qjeHRjx3mFCP0+Heubzraz4qIkU51
         rce958jP0XEMg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE991C43168;
        Fri,  4 Aug 2023 19:06:59 +0000 (UTC)
Subject: Re: [GIT PULL] Ceph fixes for 6.5-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230804151059.712246-1-idryomov@gmail.com>
References: <20230804151059.712246-1-idryomov@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230804151059.712246-1-idryomov@gmail.com>
X-PR-Tracked-Remote: https://github.com/ceph/ceph-client.git tags/ceph-for-6.5-rc5
X-PR-Tracked-Commit-Id: e6e2843230799230fc5deb8279728a7218b0d63c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4593f3c2c62c1bcdf274038ef87b08a057531692
Message-Id: <169117601984.19359.3541665549791862013.pr-tracker-bot@kernel.org>
Date:   Fri, 04 Aug 2023 19:06:59 +0000
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  4 Aug 2023 17:10:58 +0200:

> https://github.com/ceph/ceph-client.git tags/ceph-for-6.5-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4593f3c2c62c1bcdf274038ef87b08a057531692

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
