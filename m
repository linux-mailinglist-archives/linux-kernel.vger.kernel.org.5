Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB897FD968
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbjK2O3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234587AbjK2O3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:29:39 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DA5173F;
        Wed, 29 Nov 2023 06:29:37 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 50CE037A;
        Wed, 29 Nov 2023 14:29:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 50CE037A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1701268176; bh=nBZchssDZ6Eyz0mpW9mYTJOi1nU2SQQKig5pHaps0S4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=abXxMwtJ4WQmFsjUs9w2OqJqBmXQXtHaXEwDpPw4zHeilK/RIY7ULPtzPZrFKkeEX
         jtXuLmScg1feFawPT9cyxzbiGoI8vlk8ksSq1hd3p7Pl/oUZv9Am2vv/MtFHU7MR/i
         0NgB5zMJXCUvbpC9GNmFW/prrdtM5BcIA6rJhr8Z228EY7kGD2TKDrWJMg8u74k2pR
         mBZdWgZ0cWd+4U3p0e1ARIsoIgdWngglDLQjI4pdX2HM4pZIqR/nJKLrMEkAkfl+Tw
         EMoBmbnM8Y8VAFPJ1fpUFw0W1JjNHNT+oA4Yasw18qMJ3v7JXeEW0YVxGNpEmJqtT/
         gbP13Nec8th8Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Livepatching <live-patching@vger.kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Attreyee Mukherjee <tintinm2017@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH 0/2] Minor grammatical fixup for livepatch docs
In-Reply-To: <20231129132527.8078-1-bagasdotme@gmail.com>
References: <20231129132527.8078-1-bagasdotme@gmail.com>
Date:   Wed, 29 Nov 2023 07:29:35 -0700
Message-ID: <874jh4pr8w.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> I was prompted to write this little grammar fix series when reading
> the fix from Attreyee [1], with review comments requesting changes
> to that fix. So here's my version of the fix, with reviews from [1]
> addressed (and distinct grammar fixes splitted).

How is this helpful?  Why are you trying to push aside somebody who is
working toward a first contribution to the kernel?  This is not the way
to help somebody learn to work with the kernel community.

Attreyee, I would like to encourage you to redo your patch set based on
the feedback you have received so that we can apply it.

Thanks,

jon
