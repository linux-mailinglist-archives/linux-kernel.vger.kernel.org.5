Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A557DBC53
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbjJ3PEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbjJ3PEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:04:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73F7DA
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 08:04:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59E3C433C7;
        Mon, 30 Oct 2023 15:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698678245;
        bh=0d3/+GxGMdfOff0/hkwfnIJbNqj8qgEyQZNmJtkQDYA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mJdyCBVbD3Ow1xcl0bn96Gny34+Y0wRnViaDVV9tU9XqjRT4ZAqRr/dXVuU5w4bMn
         8zxuF6ZjskjGvpzcRGNwyhPYz+Et0/Zl7F/jaq1kYtI9ksHwGpNv/lHtDBMqwPifCx
         P/NZPic9P3Q4Chmxj/zrp04OWpIBxQLXoWZQy920m2Lo1yxaAbxH6OHNuD97DnYtXf
         cb5Qw6vd2sAQUwaSbWpMfmmcPMdr/PGG8Qy8t/J6gKgnk5D1h7UMeHsOZbi+MnUD1b
         /cLdbi1qyLsMFePON0KSbilKtsgIyFUTMByb9daofg39FthHsKPtoJ0DLGDqXg8dqT
         b2X3IcOHHbN4A==
Message-ID: <a415467d-01a1-500e-130c-e240ffbbb00b@kernel.org>
Date:   Mon, 30 Oct 2023 23:04:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] erofs: tidy up redundant includes
Content-Language: en-US
To:     Ferry Meng <mengferry@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20231026021627.23284-1-mengferry@linux.alibaba.com>
 <20231026021627.23284-2-mengferry@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20231026021627.23284-2-mengferry@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/26 10:16, Ferry Meng wrote:
> - Remove unused includes like <linux/parser.h> and <linux/prefetch.h>;
> 
> - Move common includes into "internal.h".
> 
> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>
