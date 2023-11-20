Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD337F0AF1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 04:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjKTDZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 22:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjKTDZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 22:25:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B8AC1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 19:25:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0D9C433C7;
        Mon, 20 Nov 2023 03:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700450705;
        bh=SNahtbYOT42GOgyX4yJZ4HZNK3VBMBuf+Ch+EnYue34=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Cncp8Lx8ZmMohGUop5OY3ghiPxwwTCAjKT5wPUb8Vo/1wwlrBMv8B4tEOYVkjD0uW
         8o+CJ+tul9aVXqPCZE+bNd2lCNjpakYTrvyumu8pECBEgkVSVwfGfb90Nwq2EJeTeE
         UvKatNVQfSc10X9bm9KnWHXq/0c5BONNWPiFpiKOJpnpu/i3hmdT9vmG3eHdA1Upx3
         4AAqhK6ijyk65IJCiWeozwwfl24CDZdPa5QxnAbmmwS+EV2UHRqI91vJ+SI7yul9Lq
         GpR47WL6B9lCX5jNL0WcynwE/KJ2vQB+4qIq35GcsVHjXs1M9R3WO0lg+1XSJ2Vmgv
         QwLdxtoQwWJyA==
Message-ID: <ea0b14ff-2198-ac42-b61e-653eefce0b25@kernel.org>
Date:   Mon, 20 Nov 2023 11:25:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: adjust nat and block release logic
Content-Language: en-US
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
References: <20231117203855.3415891-1-daeho43@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20231117203855.3415891-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/18 4:38, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Fixes: 0f503e443ccb ("f2fs-tools: do not reuse corrupted quota inodes")
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
