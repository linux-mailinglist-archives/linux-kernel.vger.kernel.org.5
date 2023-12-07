Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E079380899C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442566AbjLGNzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442098AbjLGNzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:55:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F31C10C2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 05:55:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782AAC433C8;
        Thu,  7 Dec 2023 13:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701957324;
        bh=+M4tBRVeONvinQiPUe/26L3bNkUxaoKm0nKn0+RekqQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=S6kZrSSHYpzCqReIM3C1ykyP7P1hNS4w6ZwgZpsciCIKOBj8Yqe52bGZLRlsFL3wQ
         WwYgeNX5u8JpfZ3COQ2crDnS+0IvSYfWbpPfrAygCv44ZukWdQAG2KEnEkOt7xbf65
         ysz01BkNQp0eyQt0Z6fLqybbvEZ7qBjsUoyqYCZLqkQMJRp8wIq4FaqBLg9JxlxkdA
         apSm3gsUffz41NpJkx6LoAYYe+pQKoxIr/WvZx5kVLryf/H6xKZh/ttjgT77gA/uge
         BZPvw+Al87+cZmE9JVJok31H4nmH2TMLj4w6g2jlMJsv3yhDQyxCti6r1NmV3XMbfa
         O4UNNrkv8dIaA==
From:   Benjamin Tissoires <bentiss@kernel.org>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Benjamin Tissoires <bentiss@kernel.org>
Cc:     Jiri Kosina <jkosina@suse.com>, linux-input@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231207-b4-wip-selftests-v1-1-c4e13fe04a70@kernel.org>
References: <20231207-b4-wip-selftests-v1-1-c4e13fe04a70@kernel.org>
Subject: Re: [PATCH] selftests/hid: fix failing tablet button tests
Message-Id: <170195732222.272144.9548310511759947709.b4-ty@kernel.org>
Date:   Thu, 07 Dec 2023 14:55:22 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Dec 2023 13:22:39 +0100, Benjamin Tissoires wrote:
> An overlook from commit 74452d6329be ("selftests/hid: tablets: add
> variants of states with buttons"), where I don't use the Enum...
> 
> 

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-6.8/selftests), thanks!

[1/1] selftests/hid: fix failing tablet button tests
      https://git.kernel.org/hid/hid/c/da2c1b861065

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

