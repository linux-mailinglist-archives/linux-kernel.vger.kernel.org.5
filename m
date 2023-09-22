Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6427AB0BC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbjIVLan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233679AbjIVLak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:30:40 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2401CAF;
        Fri, 22 Sep 2023 04:30:35 -0700 (PDT)
Received: from localhost (unknown [195.89.33.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5A57D2D6;
        Fri, 22 Sep 2023 11:30:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5A57D2D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1695382234; bh=M8ePXROlueLlKm2yOIf4XihUtHyKAuFvrElWSy5QCdo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=DImpLmIKfEARs4VtYYfUCoycF+3xjXJz7fgqtt8oEzsrelHBZJljsfCxnNRTooX+i
         5rekVyMtxqBVH3Mwc/bnv3EOUzpqIaXOjXktQvNi5OtdASLZXyq6GtsQQm3k1/gK+0
         SZb5hBYaqVXILZBYdx9hJTwzVcJ3T43Vh7WsTFBocJc0AmFqS3580Hb5U6qhRj21iu
         1aPDxSVv7ovAE7Z2+EAuq6CVxR+Fifz2/IqWeq8N2mHz1QPLM2lnKHuuQw/qfAMa0h
         SfViHIr7p3XzhsoUsQGorw10u3DSdYgL1NgQktwlFAxpNw6tTWRQcecNjtXKydfh4b
         5kTp0o3qH1g6A==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Kuan-Wei Chiu <visitorckw@gmail.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: Re: [PATCH] docs: block: blk-mq.rst: correct places -> place
In-Reply-To: <20230902164121.2653109-1-visitorckw@gmail.com>
References: <20230902164121.2653109-1-visitorckw@gmail.com>
Date:   Fri, 22 Sep 2023 05:30:32 -0600
Message-ID: <878r8y78dj.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kuan-Wei Chiu <visitorckw@gmail.com> writes:

> Corrected a typo in the blk-mq.rst documentation where 'places' was
> incorrectly used instead of 'place'.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  Documentation/block/blk-mq.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

jon
