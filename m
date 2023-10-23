Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E186B7D375C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjJWNCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjJWNCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:02:19 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4DA102;
        Mon, 23 Oct 2023 06:02:16 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6A463490;
        Mon, 23 Oct 2023 13:02:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6A463490
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1698066136; bh=gaeQEn/BNoqbIo1EelOZC9oVdf03Fmx8/aWuQgb7BVk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=U9KNfo2t+Ycc8KQVDkSt9Qtvk5/cwwf4pcuL9okWRiz4vb+RR3BfATj0XAkI7c522
         V+AU3sTA4cw3A7rqEU5SFmDQz3X/G8PVLRuDjf9sFCVi9MGEvJYX/3shNHlz7P++u1
         wRJhLl5jUylGN+JMxc7gpK9vf3aWq6ebniWpDmyxWxwQ3rVbZwIxS4Sh80HP5npx9Y
         fhJdPuJZ6bkfqIPmePOPoZCpaOxlwT2BvOhvKtJrNeRFkyHost9CMYOU4XDSx9KFyG
         vmbLe0X8DVZ0IB35OIUSNJoa1upUNp4tSfL2VV1GrNHdn4Y2HeilSqQg/mXKc32lk5
         dGP/fdqKO4BXg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Hu Haowen <2023002089@link.tyut.edu.cn>
Cc:     Hu Haowen <2023002089@link.tyut.edu.cn>, src.res.211@gmail.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs/zh_TW: replace my email address
In-Reply-To: <871qdld3ge.fsf@intel.com>
References: <20231012130008.102174-1-2023002089@link.tyut.edu.cn>
 <87lebukrs2.fsf@meer.lwn.net> <87cyx6krb2.fsf@meer.lwn.net>
 <871qdld3ge.fsf@intel.com>
Date:   Mon, 23 Oct 2023 07:02:15 -0600
Message-ID: <87a5s9jxuw.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jani Nikula <jani.nikula@linux.intel.com> writes:

> On Sun, 22 Oct 2023, Jonathan Corbet <corbet@lwn.net> wrote:
>> Jonathan Corbet <corbet@lwn.net> writes:
>>
>>> Hu Haowen <2023002089@link.tyut.edu.cn> writes:
>>>
>>>> The Gmail address will not be used often from now on, and replace it
>>>> with the email which is more frequently accessed by myself.
>>>>
>>>> Signed-off-by: Hu Haowen <2023002089@link.tyut.edu.cn>
>>>
>>> Applied.
>>
>> Actually, no:
>>
>> Documentation/translations/zh_TW/dev-tools/sparse.rst:10: WARNING: Title underline too short.
>>
>> Traditional Chinese maintainer: Hu Haowen <2023002089@link.tyut.edu.cn>
>> ---------------------------------------------------------------------
>
> My question is, why do the documents have inline
> author/maintainer/translator information in them?
>
> We have git log and MAINTAINERS for all of that?

Yeah, I've wondered about that too...especially since this person last
changed all of those email addresses ... in July.  I chose not to start
that particular discussion, but simply removing those lines would be a
better change, IMO.

Thanks,

jon
