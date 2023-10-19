Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BB47D0434
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 23:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346621AbjJSVuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 17:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346618AbjJSVug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 17:50:36 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E18C119
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 14:50:32 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5DBA760A;
        Thu, 19 Oct 2023 21:50:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5DBA760A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1697752231; bh=mXfhAVCJpui3eQidkwCrSu1QcqtRZcYfG2YRU1eXa+4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mqOxPFlBjVO5PFLgnibpCFan00FIstq7J0Vq7QYIVkK82ngCTAHCRanrVY9uPOJ2J
         KtgGrMMC1QRATIMFw2gJl77WtmOOhfH6xdq4jSKDX+GfaAj41AV9e9elz/tEYDMfjI
         unQ/hLAXSjYBny5ZTBPcFDm7uRnyo7ZvCqXshDBKQjaa/JsluRSG7q85bW6UjkUIn6
         vu/3XK0gxDa8lGQEjkYXv6skf9+V3AS9ySo8x+/hqbN41XekZ4mxgdEKfJtkZM09pb
         tJN0MMXJppJQTdywhMDWEZnkTAHukPGDznbacb6ndWj9xyIusMb/f17eg7wuUy+qtp
         +TRRM7NCKAYJw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Dual licensing [was: [PATCH 2/5] misc: mlx5ctl: Add mlx5ctl misc
 driver]
In-Reply-To: <2023101913-owl-showman-5858@gregkh>
References: <20231018081941.475277-1-saeed@kernel.org>
 <20231018081941.475277-3-saeed@kernel.org>
 <2023101835-trapdoor-unicycle-788a@gregkh>
 <20231018180128.GA719006@nvidia.com>
 <2023101808-quicksand-roman-0da7@gregkh>
 <20231018185629.GD3952@nvidia.com> <2023101913-owl-showman-5858@gregkh>
Date:   Thu, 19 Oct 2023 15:50:30 -0600
Message-ID: <87r0lq8eop.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> For your new files, please make them single license.  If you insist on
> dual licensing them, I will insist on have a lawyer sign off on them so
> that they understand the issues involved with dual licenses, and just
> how much I hate them in the kernel tree as they are a pain over time.

Out of curiosity, is there somewhere people can look for a description
of these issues and the pain they cause?  I've seen this go by enough
times to think that it would be good to set down in Documentation/
somewhere for future reference.

Thanks,

jon
