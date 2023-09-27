Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55017B042C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjI0Mai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjI0Mag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:30:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01FEE6;
        Wed, 27 Sep 2023 05:30:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E15B0C433C7;
        Wed, 27 Sep 2023 12:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695817834;
        bh=unuz/ZkoOU/fFz50dgZgbKbNNxMqoaxZaY2nWVd7Lzo=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=oo7sfn3i5ZQq9Ou63bFiW5jNRtEYLc1iwIfxZuUOH8ku0F1Q8eftqP8iOQmo30VkT
         6caTFGtFe2gckMnrxUUR/KKRXyN9NUI9vMIhIcShdAQVoZ9kRZuSEHuQtsMRUPrYH/
         rc2f4o114sMtHbLktCjtAqsfj2SO+38V6U60PMPh3fEOeG4x3iTQai3B4fZfQam7Ji
         RBGBYnYZ541JP95C3xxEFTnvCc362enn9UCfBLt+3ufdIOD95Fc3wZTl9+unLMaQiX
         NNXm28Jx74nppwaXO9cEcn8NKKkNk2GJKTZDz2OdEJ9LCIeJ4EKUpenBVbTdpdJmT4
         b6lSGIRfPZZLg==
References: <20230918071905.296081-1-hanchunchao@inspur.com>
 <ZQoMqI/QGPWEpkEi@rh> <ZQoPaXNAwtu4wl02@casper.infradead.org>
User-agent: mu4e 1.8.10; emacs 27.1
From:   Chandan Babu R <chandanbabu@kernel.org>
To:     corbet@lwn.net
Cc:     Dave Chinner <dchinner@redhat.com>,
        Charles Han <hanchunchao@inspur.com>, djwong@kernel.org,
        allison.henderson@oracle.com, bhelgaas@google.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] Documentation: xfs: Remove repeated word in comments
Date:   Wed, 27 Sep 2023 17:57:01 +0530
In-reply-to: <ZQoPaXNAwtu4wl02@casper.infradead.org>
Message-ID: <8734yz3ijc.fsf@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 10:15:21 PM +0100, Matthew Wilcox wrote:
> On Wed, Sep 20, 2023 at 07:03:36AM +1000, Dave Chinner wrote:
>> [cc linux-xfs@vger.kernel.org]
>> 
>> Hi Charles,
>> 
>> For future reference, can you CC the XFS list on XFS documentation
>> changes please?  That's much preferable to sending patches to random
>> developers and hoping they notice it....
>> 
>> On Mon, Sep 18, 2023 at 03:19:05PM +0800, Charles Han wrote:
>> > Remove the repeated word "the" in comments.
>> > 
>> > Signed-off-by: Charles Han <hanchunchao@inspur.com>
>> > ---
>> >  Documentation/filesystems/xfs-online-fsck-design.rst | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > 
>> > diff --git a/Documentation/filesystems/xfs-online-fsck-design.rst b/Documentation/filesystems/xfs-online-fsck-design.rst
>
> To be fair, this new file isn't listed in MAINTAINERS, so
> scripts/get_maintainer.pl doesn't know about it.  May I
> suggest the attached patch?
>
> [2. text/plain; 0001-XFS-Update-MAINTAINERS-to-catch-all-XFS-documentatio.patch]...

Hi Jonathan,

I am planning to apply these two patches to xfs-linux's for-next branch and
later send them to Linus. Please let me know if you have any objections.

-- 
Chandan
